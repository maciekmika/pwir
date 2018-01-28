with ClockTick;
with Wheel; use Wheel;
with Brake;
with Measures; use Measures;
with SpeedSensor;
with CANBus; use CANBus;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

package body BrakeController is

   ----------------------  Procedures regrading to the system set up -----------------------

   -- Set attributes default value
   procedure Init(Bc :in out BrakeControllerType) is
   begin
      Bc.isOn := False;
      Bc.isLocked := False;
      Bc.isAbsActivated := False;
      Bc.currentVelocity := Measures.KMPH(0.0);
      Bc.averageVelocityThreshold := Measures.KMPH(15.0);
      Bc.velocityChangeThreshold := Measures.KMPH(10.0);
      Bc.appliedPressure := Measures.BrakePressure(0.0);
      -- Init as 1.0 before getting the adjust pressure update msg
      Bc.pressureToBeRestored := Measures.BrakePressure(1.0);
      Bc.averageVelocity := 0.0;
      Bc.velocityChange := Measures.KMPH(0.0);
      Bc.historicalVelociyArray(0..4) := (Measures.KMPH(0.0),
                       Measures.KMPH(0.0),Measures.KMPH(0.0),
                       Measures.KMPH(0.0),Measures.KMPH(0.0));
      Bc.availableHistoryVelocityCount := 0.0;
      Bc.messageAvailable := True;
      Bc.hasNewPressure := False;
   end init;

   -- Call this procedure to turn the system mode to ON
   procedure turnOn(Bc:out BrakeControllerType) is
   begin
      Bc.isOn := True;
   end turnON;

   -- Call this procedure to turn the system mode to OFF
   -- (But the system will never be turned off when the system at the on mode)
   procedure turnOff(Bc:in out BrakeControllerType;Br : in out Brake.Brake) is
   begin
      -- Set condition to prevent turning system off at the on mode
      if Bc.isOn = True then
         return;
      else
      -- If the system NOT at the On Mode.
      Bc.isOn := False;
      -- Apply the max press
      Bc.appliedPressure := Measures.BrakePressure(1.0);
      -- Instruct to the Brake
      Brake.SetPressure(Br,Bc.appliedPressure);
      end if;
   end turnOff;



   ---------------------- Procedures regrading to get and update system data -----------------------

   -- Call this procedure to get the current measured velocity
   procedure getCurrentMeasuredVelocity(Bc: in out BrakeControllerType;
                                        SS: in SpeedSensor.SpeedSensor;
                                        Wh: in out Wheel.Wheel) is
   begin
      -- Get the current measured velocity from the Sensor.
      Bc.currentVelocity := SpeedSensor.GetSpeed(SS);
      Wheel.GetVelocity(Wh,Bc.currentVelocityWheel);
   end getCurrentMeasuredVelocity;

   -- Call this procedure to get the current acceleration
   procedure getCurrentAcceleration(Bc: in out BrakeControllerType;
                                    Wh: in Wheel.Wheel) is
   begin
      -- Get the acceleration
      Bc.currentAcceleration := Wheel.GetAccel(Wh);
   end getCurrentAcceleration;

   -- Call this procedure to update the history velocity in each Tick time
   procedure updateHistroicalVelocityArray(Bc : in out BrakeControllerType) is
   begin
      Bc.historicalVelociyArray(4) := Bc.historicalVelociyArray(3);
      Bc.historicalVelociyArray(3) := Bc.historicalVelociyArray(2);
      Bc.historicalVelociyArray(2) := Bc.historicalVelociyArray(1);
      Bc.historicalVelociyArray(1) := Bc.historicalVelociyArray(0);
      Bc.historicalVelociyArray(0) := Bc.currentVelocity;
   end updateHistroicalVelocityArray;

   -- Call this procedure update the average velocity in each Tick time
   procedure updateAverageVelocity(Bc : in out BrakeControllerType) is
   begin
      -- When update the average velocity, there are three scenarios
      -- 1. There are already 4 history velocity data
      if Bc.availableHistoryVelocityCount >= 4.0 then
         Bc.averageVelocity := Measures.KMPH(
         Float((Bc.historicalVelociyArray(1) + Bc.historicalVelociyArray(2)
         + Bc.historicalVelociyArray(3)+ Bc.historicalVelociyArray(4)))/4.0);
      end if;

      -- 2. There has not history velocity data yet
      if Bc.availableHistoryVelocityCount = 0.0 then
         -- Do not update history average velocity
         --and set the count to 1 for next time updating
         Bc.availableHistoryVelocityCount := 1.0;

         return;
      end if;

      -- 3. There are 1..3 history velocity data
      if Bc.availableHistoryVelocityCount > 0.0
        and Bc.availableHistoryVelocityCount < 4.0 then
         Bc.averageVelocity := Measures.KMPH(
         Float((Bc.historicalVelociyArray(1) + Bc.historicalVelociyArray(2)
                + Bc.historicalVelociyArray(3) + Bc.historicalVelociyArray(4)))
                /Bc.availableHistoryVelocityCount);
         --Put(float(Bc.averageVelocity));
         -- Add the count for next time updating
         Bc.availableHistoryVelocityCount := Bc.availableHistoryVelocityCount
                                                                        + 1.0;
      end if;

   end updateAverageVelocity;

   -- Call this procedure to update velocity change in each Tick time
   procedure updateVelocityChange(Bc : in out BrakeControllerType) is
   begin
      Bc.velocityChange := Measures.KMPH(abs(Float(Bc.historicalVelociyArray(1)
                                         - Bc.historicalVelociyArray(0))));
   end updateVelocityChange;





   ---------------------- Procedures regrading to the Abs system ------------------------------

   -- Call this procedure to detect if the wheel is locked
   procedure lockDetection(Bc :in out BrakeControllerType;
                           Wh : in out Wheel.Wheel) is
   begin

      -- fails to meet average velocity threshold condition
      if Bc.averageVelocity < Bc.averageVelocityThreshold then
         Bc.isLocked := False;
      end if;

      -- Meets the average velocity threshold
      -- while fails to meet the velocity change condition
      if Bc.averageVelocity >= Bc.averageVelocityThreshold then
         if abs(Bc.velocityChange) < abs(Bc.velocityChangeThreshold) then
            Bc.isLocked := False;
         end if;
      end if;

      -- if the average velocity is greater than
      -- the averageVelocityThreshold setting value
      if Bc.averageVelocity >= Bc.averageVelocityThreshold then
         if abs(Bc.velocityChange) >= abs(Bc.velocityChangeThreshold) then
            -- Only when the above condition meets,
            --then if the velocity change condition meets
            Bc.isLocked := True; -- the lock happens
            activateAbs(Bc);
            --Put("Lock is Detected"); -- Show the lock is detected
            --New_Line;
         end if;
      end if;
   end lockDetection;

   -- Call this procedure to active the Abs
   procedure activateAbs(Bc :in out BrakeControllerType) is
   begin
      Bc.isAbsActivated := True;

   end activateAbs;

   -- Call this procedure to deactive the Abs
   procedure deactivateAbs(Bc: in out BrakeControllerType) is
   begin
       Bc.isAbsActivated := False;
       --Put("Abs is Deactivated");
       --New_Line;
   end deactivateAbs;

   -- Call this procedure to start abs
   procedure absProcedure(Bc: in out BrakeControllerType;
                          Br: in out Brake.Brake ;
                          Bus : in out CANBus.CANBus;
                          Wh : in out Wheel.Wheel) is
   begin
      if Bc.isAbsActivated = True then -- Check the abs's activity status


        -- Step1 Rmove all pressure right now
            Bc.appliedPressure := Measures.BrakePressure(0.0);
            Brake.SetPressure(Br,Bc.appliedPressure);
         -- Step2. If the car is accelerated, restore pressure
         if float(Bc.historicalVelociyArray(1) - Bc.currentVelocity) < 0.0 then

            Bc.appliedPressure := Bc.pressureToBeRestored;
            Brake.SetPressure(Br,Bc.appliedPressure);
         end if;

         -- Step3. If the car is decelerated, remove all pressure again
         if float(Bc.historicalVelociyArray(1) - Bc.currentVelocity) > 0.0 then
            Bc.appliedPressure := Measures.BrakePressure(0.0);
            Brake.SetPressure(Br,Bc.appliedPressure);
         end if;


      else -- If the abs is not actived, do not start abs.
         return;
      end if;
   end absProcedure;

   -- Call this procedure to adjust pressure received from canbus message
   procedure adjustPressure(Bc :in out BrakeControllerType;
                            Br : in out Brake.Brake;
                            Wh : in out Wheel.Wheel;
                            Bus : in out CANBus.CANBus) is
   begin
      -- Check Mode Condition

      if Bc.isOn = False then
         Put("Wrong Mode: Adjust Pressure can be only conducted at ON Mode");
         New_Line;
         return;
      else
         --Check if it is a zero pressure update msg
         if Bc.currentMessage.Pressure = Measures.BrakePressure(0.0) then
            -- if it is a zero pressure update msg
            -- deactive the abs
            deactivateAbs(Bc);
            -- Relase all pressure
            Brake.SetPressure(Br,Measures.BrakePressure(0.0));
         end if;

         -- It is not a zero pressure Update msg
         if Bc.currentMessage.Pressure /= Measures.BrakePressure(0.0) then
            -- Store the pressure information
            Bc.appliedPressure := Bc.currentMessage.Pressure;
            Bc.pressureToBeRestored := Bc.currentMessage.Pressure;

            if Bc.isAbsActivated = False then
               -- If not in the progress of abs, check the lock
               lockDetection(Bc,Wh);
               -- if the wheel is locked
               if Bc.isLocked = True then
                  -- Active the Abs
                  activateAbs(Bc);
                  -- Start Abs process
                  absProcedure(Bc,Br,Bus,Wh);
               else
                  -- The wheel is not locked and
                  -- the system is not in the abs progress
                  Put("Setting Brake Pressure to ");
                  Put(Float(Bc.currentMessage.Pressure));
                  New_Line;
                  -- Directly adjust pressure
                  Brake.SetPressure(Br,Bc.currentMessage.Pressure);
                  Brake.Tick(Br, Wh);
               end if;
            else
               -- the pressure will be applied in the abs progress
               Put("The system is in the progress of ABS, the pressure is stored and will be restored");
               New_Line;
               return;
            end if;
         end if;
      end if;
   end adjustPressure;



   ----------------------- Procedures regrading to get canbus message and respond -----------------------

   -- Call this procedure to receive and process Canbus messages
   procedure getCanBusMessage(Bc: in out BrakeControllerType;
                              Bus: in out CANBus.CANBus;
                              Br : in out Brake.Brake;
                              Wh : in out Wheel.Wheel) is
   begin

      CANBus.GetNewMessage(Bus,Bc.messageAvailable,Bc.currentMessage);
      -- Check if the message is available
      if Bc.messageAvailable then
         Put("---------------------------------------------------------------");
         New_line;
         Put("Got CAN Message: ");
         New_Line;
         CANBus.DebugPrintMessage(Bc.currentMessage);
         -- Apply different actions based on different msg types
         case Bc.currentMessage.MessageType is
            when EngineStart => turnOn(Bc); -- Start Engine
            when BrakePressureUpdate => adjustPressure(Bc,Br,Wh,Bus); -- Adjust Pressure
            when ReadSettingsRequest => ReadSettingsResponse(Bc,Bus); -- Response to read settings request
            when ChangeSettingsRequest => ChangeSettingsResponse(Bc,Bus); -- Response to change settings request
            when VelocityRequest => VelocityResponse(Bc,Bus); -- Response to read velocity request
            when others => return;
         end case;
         CANBus.Tick(Bus);
      else
        return;
      end if;
   end getCanBusMessage;


   procedure VelocityResponse(Bc: in out BrakeControllerType;
                              Bus : in out CANBus.CANBus) is
   begin
      -- Check Conditions (Mode ON and Principal Driver)
      if Bc.isOn = True and Bc.currentMessage.VSender = CANBus.Principal(Driver) then
         -- Modify responding message
         Bc.readVelocityResponseMsg.VDestination := Bc.currentMessage.VSender;
         Bc.readVelocityResponseMsg.CurrentVelocity := Bc.currentVelocity;
         Bc.readVelocityResponseMsg.CurrentTick :=Bc.currentTick;
         -- Send responding message
         CANBus.SendMessage(Bus,Bc.readVelocityResponseMsg);
      else
         if Bc.isOn = False then
           Put("Wrong Mode: Read Velocity Request can only be conducted at the On Mode");
           New_Line;
         end if;
         if Bc.currentMessage.VSender /= CANBus.Principal(Driver) then
            Put("Wrong Principal: Read Velocity Request can only be sent from the Driver");
            New_Line;
         end if;
       end if;
   end VelocityResponse;

   procedure ReadSettingsResponse(Bc: in out BrakeControllerType;
                                  Bus : in out CANBus.CANBus) is
   begin

      --Check conditions (Off Mode is Required)
      if Bc.isOn = False then
      -- Check Principal (Manufacturer or Mechanic is Required)
         if Bc.currentMessage.RSSender = CANBus.Principal(Manufacturer) or
            Bc.currentMessage.RSSender = CANBus.Principal(Mechanic) then
            -- Meets both conditions then modify responding msg
            Bc.readSettingsResponseMsg.RSDestination := Bc.currentMessage.RSSender;
            Bc.readSettingsResponseMsg.RSVelocityChangeThreshold := Bc.velocityChangeThreshold;
            Bc.readSettingsResponseMsg.RSAverageVelocityThreshold := Bc.averageVelocityThreshold;
            CANBus.SendMessage(Bus,Bc.readSettingsResponseMsg); -- send message
         else
            Put("Wrong Principal: Read Settings Request can only be sent from the Manufacturer or Mechanic");
            New_Line;
            return;
         end if;
      else
         Put("Wrong Mode: Read Settings Request can only be conducted at the OFF Mode");
         New_Line;
         return;
      end if;
   end ReadSettingsResponse;

   procedure ChangeSettingsResponse(Bc: in out BrakeControllerType;
                                    Bus : in out CANBus.CANBus) is
   begin
      --Check Conditions (Off Mode and Manufacturer are required)
      if Bc.isOn = False and Bc.currentMessage.CSSender = CANBus.Principal(Manufacturer) then
           -- Meets both conditions then modifyresponding message
            Bc.averageVelocityThreshold := Bc.currentMessage.CSAverageVelocityThreshold;
            Bc.velocityChangeThreshold := Bc.currentMessage.CSVelocityChangeThreshold;
            Bc.changeSettingsResponseMsg.CSDestination := Bc.currentMessage.CSSender;
            -- send responding message
            CANBus.SendMessage(Bus,Bc.changeSettingsResponseMsg);
            Put("Updated Velocity Change Threshold : ");
            put(float(Bc.velocityChangeThreshold));
            New_Line;
            Put("Updated Average Velocity Threshold : ");
            Put(float(Bc.averageVelocityThreshold));
            New_Line;
      else
         if Bc.isOn = True then
            Put("Wrong Mode: Change Settings Request can only be conducted at the OFF Mode");
            New_Line;
         end if;
         if Bc.currentMessage.CSSender /= CANBus.Principal(Manufacturer) then
            Put("Wrong Principal: Change Settings Request can only be sent from the Manufacturer");
            New_Line;
         end if;
      end if;
   end ChangeSettingsResponse;

   -- This procedure is used to provide updated data of the system continuously
   procedure printOutSystemInfo(Bc : in out BrakeControllerType) is
   begin

      Put("Current Measured Velocity: ");
      Put(float(Bc.currentVelocity));
      New_Line;
      Put("Current Wheel Velocity: ");
      Put(float(Bc.currentVelocityWheel));
      New_Line;
      Put("Current Pressure: ");
      Put(float(Bc.appliedPressure));
      New_Line;
      Put("Current Average Velocity: ");
      Put(float(Bc.averageVelocity));
      New_Line;
      Put("Velocity Change: ");
      Put(float(Bc.velocityChange));
      New_Line;
      Put("Current Acceleration: ");
      Put(float(Bc.currentAcceleration));
      New_Line;
      Put("Lock Detection: ");
      Put(Bc.isLocked'Image);
      New_Line;
      Put("Abs Working: ");
      Put(Bc.isAbsActivated'Image);
      New_Line;

   end printOutSystemInfo;




   ----------------------- Procedure regarding to Tick the system -----------------------

   procedure Tick(Bc:in out BrakeControllerType;
                  Wh : in out Wheel.Wheel;
                  Br : in out Brake.Brake;
                  Bus: in out CANBus.CANBus;
                  SS: in out SpeedSensor.SpeedSensor) is
   begin
      --init(Bc);
      getCanBusMessage(Bc,Bus,Br,Wh);

      Put("----------------------   System Information   -------------------");
      New_Line;
      Put("System Mode ");

      if(Bc.isOn = True) then
         Put("ON");
      else
         Put("OFF");
      end if;
      --New_Line;
      ---Put("Velocity Change Threshold :");
      --Put(float(Bc.velocityChangeThreshold));
      --New_Line;
     -- Put("Average Velocity Threshold :");
      --Put(float(Bc.averageVelocityThreshold));
      --New_Line;


      -- Get data only after the egine startig, reasons are: the wheel sholud
      if(Bc.isOn = True) then

         getCurrentMeasuredVelocity(Bc,SS,Wh);
         getCurrentAcceleration(Bc,Wh);
         updateHistroicalVelocityArray(Bc);
         updateAverageVelocity(Bc);
         updateVelocityChange(BC);
         lockDetection(Bc,Wh);

         if Bc.isLocked = True then
            New_Line;
            Put("Lock is Detected ");
            New_Line;
         end if;
         if Bc.isAbsActivated = True then
            Put("Abs is Activated ");
            New_Line;
         end if;
      end if;
      New_Line;

      printOutSystemInfo(Bc);

      if Bc.isAbsActivated = True then
         absProcedure(Bc,Br,Bus,Wh);
      end if;
      -- end if;
      Bc.currentTick := Bc.currentTick + 1;

   end Tick;

end BrakeController;
