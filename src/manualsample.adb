with ClockTick;
with Wheel;
with Brake;
with Measures;
with SpeedSensor;
with CANBus; use CANBus;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

-- an example showing a little bit how to use each of the provided
-- components, although not in a proper control loop
procedure Manualsample is

   -- the Wheel
   Wh : Wheel.Wheel;
   -- the Brake
   Br : Brake.Brake;
   -- the Speed Sensor
   SS : SpeedSensor.SpeedSensor;
   -- the CAN Bus
   Bus : CANBus.CANBus;
   -- counts the number of clock ticks that have elapsed
   TickCount : Natural := 0;
   -- tracks the Wheel's Measured Velocity
   MeasuredVel : Measures.KMPH := Measures.KMPH(0.0);

   -- stores the last message read (if any) from the CAN Bus
   CurrentMessage : CANBus.CANBusMessage;
   -- stores whether we managed to read a message from the CAN Bus
   MessageAvailable : Boolean;

   -- some value we choose out of thin air to use for an initial
   -- brake pressure to apply to the Brake
   INITIAL_BRAKE_PRESSURE : constant Measures.BrakePressure :=
     Measures.BrakePressure(0.5);

   -- zero (minimum) brake pressure, given to the Brake to
   -- release all of its pressure from the wheel
   ZERO_BRAKE_PRESSURE : constant Measures.BrakePressure :=
     Measures.BrakePressure(Measures.MIN_BRAKE_PRESSURE);

   -- run for some number of seconds
   NUM_TICKS_TO_RUN_FOR : constant Natural := 10 * ClockTick.TicksPerSecond;
begin
   -- initialise components
   Wheel.Init(Wh);
   Brake.Init(Br);
   SpeedSensor.Init(SS);
   CANBus.Init(Bus);

   -- Tick the speed sensor to give it a meaningful initial
   -- reading for Measured Velocity from the Wheel
   SpeedSensor.Tick(SS,Wh);

   -- set initial brake pressure
   Brake.SetPressure(Br,INITIAL_BRAKE_PRESSURE);

   -- run for the required number of ticks
   while (TickCount < NUM_TICKS_TO_RUN_FOR) loop
      TickCount := TickCount + 1;

      -- debug printing to watch the state of Wheel and Brake evolve
      Brake.DebugPrint(Br);
      Wheel.DebugPrint(Wh);

      -- query the CAN bus and adjust brakes based on BrakePressureUpdates
      CANBus.GetNewMessage(Bus,MessageAvailable,CurrentMessage);
      if MessageAvailable then
         Put("Got CAN Message: "); New_Line;
         CANBus.DebugPrintMessage(CurrentMessage);

         if CurrentMessage.MessageType = CANBus.BrakePressureUpdate then
            Put("Setting Brake Pressure to ");
            Put(Float(CurrentMessage.Pressure));
            New_Line;
            -- engage brake with the given pressure
            Brake.SetPressure(Br,CurrentMessage.Pressure);
         end if;
      end if;

      -- every second release the brake entirely
      if TickCount mod ClockTick.TicksPerSecond = 0 then
         Put("Second passed"); New_Line;

         Put("Releasing Brake"); New_Line;
         Brake.SetPressure(Br,ZERO_BRAKE_PRESSURE);
      end if;

      -- tick each of the components on each clock tick
      CANBus.Tick(Bus); -- tick the CAN bus to have it update its state
      Brake.Tick(Br,Wh); -- tick the brake to apply pressure to the wheel
      Wheel.Tick(Wh); -- tick the wheel to have it update its velocity
      SpeedSensor.Tick(SS,Wh); -- tick the speed sensor to update it

      -- print out the measured velocity reported by the speed sensor
      MeasuredVel := SpeedSensor.GetSpeed(SS);
      Put("Measured Velocity: "); Put(Float(MeasuredVel)); New_Line;

   end loop;

   Put("Seconds elapsed: ");
   Put(Float(TickCount) / Float(ClockTick.TicksPerSecond));
   New_Line;


end;

