with ClockTick;
with Wheel;
with Brake;
with Measures;
with SpeedSensor;
with CANBus; use CANBus;
With BrakeController;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

Package body ClosedLoop is

    Wh : Wheel.Wheel;
    Br : Brake.Brake;
    SS : SpeedSensor.SpeedSensor;
    Bc : BrakeController.BrakeControllerType;
    Bus: CANBus.CANBus;

   procedure Init is
   begin

      Wheel.Init(Wh); -- Initalise the Wheel component
      Brake.Init(Br); -- Initalise the Brake component
      SpeedSensor.Init(SS); -- Initalise the Sensor component
      CANBus.Init(Bus); -- Initalise the Canbus component
      BrakeController.Init(Bc); -- Initalise the Brakecontroller component
      Brake.SetPressure(Br,Measures.BrakePressure(1.0)); -- Apply the initial Max pressure to the Brake at first
      SpeedSensor.Tick(SS,Wh); -- Tick the Speed sensor to work


   end Init;

   procedure Tick is
   begin

      CANBus.Tick(Bus); -- Tick the CAN bus to have it update its state
      BrakeController.Tick(Bc,Wh,Br,Bus,SS); --Tick the BrakeController to work
      if(Bc.isOn = True) then --The Brake, Wheel, SpeedSensor should be Ticked after Starting Engine
      Brake.Tick(Br,Wh); -- Tick the brake to apply pressure to the wheel
      Wheel.Tick(Wh); -- Tick the wheel to have it update its velocity
      SpeedSensor.Tick(SS,Wh); -- Tick the Speed sensor to update data
      end if;

   end Tick;

end ClosedLoop;
