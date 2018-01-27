with ClockTick;
with Wheel;
with Brake;
with Measures;
with SpeedSensor;
with CANBus; use CANBus;
with BrakeController;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

Package ClosedLoop is
   type ClosedLoopType is
      record
         Bus: CANBus.CANBus;
         Wh : Wheel.Wheel;
         Br : Brake.Brake;
         SS : SpeedSensor.SpeedSensor;
         Bc : BrakeController.BrakeControllerType;
      end record;

   procedure Init; -- Init the whole system
   procedure Tick; -- Tick the whole system

end ClosedLoop;
