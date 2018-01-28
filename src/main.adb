with ClockTick;
with Wheel;
with Brake;
with Measures;
with SpeedSensor;
with BrakeController; use BrakeController;
with CANBus; use CANBus;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar;  use Ada.Calendar;

procedure Main is

   Wh : Wheel.Wheel;
   Br : Brake.Brake;
   SS : SpeedSensor.SpeedSensor;
   Bus : CANBus.CANBus;
   BC : BrakeController.BrakeControllerType;

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
     Measures.BrakePressure(0.8);

   -- zero (minimum) brake pressure, given to the Brake to
   -- release all of its pressure from the wheel
   ZERO_BRAKE_PRESSURE : constant Measures.BrakePressure :=
     Measures.BrakePressure(Measures.MIN_BRAKE_PRESSURE);

   -- run for some number of seconds
   NUM_TICKS_TO_RUN_FOR : constant Natural := 20 * ClockTick.TicksPerSecond;

   task type Writing;
   task type SpinningWheel;
   task type SpeedSensorLive;
   task type BrakeEvent is
      entry Braking;
   end BrakeEvent;
   task type BrakeControllerLive;
   task type CANBusLive is
      entry Braking;
   end CANBusLive;

   task body SpinningWheel is
      Next : Ada.Calendar.Time;
      Period : constant Duration := 1.0;
   begin
      Next := Ada.Calendar.Clock;
      Wheel.Init(Wh);
      loop
         delay until Next;
         Wheel.Tick(Wh);
         Next := Next + Period;
      end loop;
   end SpinningWheel;


   task body SpeedSensorLive is
      Next : Ada.Calendar.Time;
      Period : constant Duration := 1.0;
   begin
      Next := Ada.Calendar.Clock;
      SpeedSensor.Init(SS);
      SpeedSensor.Tick(SS,Wh);
      loop
         delay until Next;
         SpeedSensor.Tick(SS,Wh);
         MeasuredVel := SpeedSensor.GetSpeed(SS);
         Next := Next + Period;
      end loop;
   end SpeedSensorLive;

   task body BrakeEvent is

   begin
      accept Braking  do
         Brake.SetPressure(Br,Measures.BrakePressure(0.8));
         Brake.Tick(Br,Wh);
--         Brake.DebugPrint(Br);
      end Braking;

   end BrakeEvent;

   task body Writing is
   Next : Ada.Calendar.Time;
      Period : constant Duration := 1.0;
   begin
      Next := Ada.Calendar.Clock;
      loop
         delay until Next;
         Wheel.DebugPrint(Wh); New_Line;
         --delay 0.1;
         --Put("Measured Velocity: "); Put(Float(MeasuredVel)); New_Line;
         Next := Next + Period;
      end loop;

   end Writing;

   task body BrakeControllerLive is
      Next : Ada.Calendar.Time;
      Period : constant Duration := 1.0;
   begin
      --CANBus.Init(Bus);
      Next := Ada.Calendar.Clock;
      BrakeController.Init(BC);
      BrakeController.turnOn(BC);
      BrakeController.Tick(BC, Wh, Br, Bus, SS);
      loop
         delay until Next;
         BrakeController.getCanBusMessage(Bc, Bus, Br, Wh);
         BrakeController.Tick(BC, Wh, Br, Bus, SS);
         Next := Next + Period;
      end loop;
   end BrakeControllerLive;

   task body CANBusLive is
   begin
      CANBus.Init(Bus);
      accept Braking  do
         CANBus.Braking(Bus);

      end Braking;

   end CANBusLive;


   NiceWheel : SpinningWheel;
   NiceSS : SpeedSensorLive;
   NiceBrake : BrakeEvent;
   --PrintInConsole : Writing;
   NiceBrakeController : BrakeControllerLive;
   NiceCANBus : CANBusLive;
begin
   delay 1.0;
   NiceCANBus.Braking;
end Main;
