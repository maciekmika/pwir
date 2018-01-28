with RandomNumber;
with Ada.Numerics.Float_Random;          use Ada.Numerics.Float_Random;
with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Assertions;

package body CANBus  is

   -- we implement a very crude probabilistic model of a CAN Bus
   -- the folloing is the probability that any message arrives each clock tick
   NewMessageProbabilityPerTick : constant Uniformly_Distributed := 0.1;

   -- the following is the probability that a given message on the bus
   -- is a BrakePressureUpdate message
   MessageIsBrakeProbability : constant Uniformly_Distributed := 0.5;

   -- generate a random message for the Brake Controller on the CAN Bus
   function GenerateRandomMessage return CANBusMessage is
      MsgType : CANBusMessageType :=
        CANBusMessageType'Val(
            RandomNumber.UniformInteger(FIRST_TOEBS_MESSAGE_INDEX,
                                        LAST_TOEBS_MESSAGE_INDEX)
                             );
      Prin : Principal :=
        Principal'Val(
            RandomNumber.UniformInteger(Principal'Pos(Principal'First),
                                        Principal'Pos(Principal'Last))
                     );
      BrakeMessagePressure : Measures.BrakePressure :=
        Measures.LimitBrakePressure(
               RandomNumber.UniformFloat(Measures.MIN_BRAKE_PRESSURE,
                                         Measures.MAX_BRAKE_PRESSURE)
                                   );
      NewVelocityChangeThreshold : Measures.KMPH :=
        Measures.LimitKMPH(
               RandomNumber.UniformFloat(Measures.MIN_KMPH,
                                         Measures.MAX_KMPH)
                          );
      NewAverageVelocityThreshold : Measures.KMPH :=
        Measures.LimitKMPH(
               RandomNumber.UniformFloat(Measures.MIN_KMPH,
                                         Measures.MAX_KMPH)
                          );

   begin
      case MsgType is
         when BrakePressureUpdate =>
            return (MessageType => BrakePressureUpdate,
                    Pressure => BrakeMessagePressure);
         when VelocityRequest =>
            return (MessageType => VelocityRequest, VSender => Prin);
         when EngineStart =>
            return (MessageType => EngineStart);
         when ReadSettingsRequest =>
            return (MessageType => ReadSettingsRequest, RSSender => Prin);
         when ChangeSettingsRequest =>
            return (MessageType => ChangeSettingsRequest, CSSender => Prin,
                    CSVelocityChangeThreshold => NewVelocityChangeThreshold,
                    CSAverageVelocityThreshold => NewAverageVelocityThreshold);
         when others =>
            -- shouldn't get here
            raise Ada.Assertions.Assertion_Error;
      end case;
   end GenerateRandomMessage;

   -- initialise the bus by generating its first state
   procedure Init(Bus : out CANBus) is
   begin
      Bus.CurrentMessageAvailable :=
        RandomNumber.RandomBooleanWithBias(NewMessageProbabilityPerTick);
      if Bus.CurrentMessageAvailable then
         Bus.CurrentMessage := GenerateRandomMessage;
      end if;
   end Init;




   procedure Braking(Bus : out CANBus) is
      BrakeMessagePressure : Measures.BrakePressure :=
        Measures.BrakePressure(
                                         Measures.MAX_BRAKE_PRESSURE
                                   );
   begin
      Bus.CurrentMessageAvailable := True;
      Bus.CurrentMessage :=  (MessageType => BrakePressureUpdate, Pressure => BrakeMessagePressure);
   end Braking;





   procedure GetNewMessage(Bus : in out CANBus;
                           NewMessageAvailable : out Boolean;
                           Message : out CANBusMessage) is
   begin
      NewMessageAvailable := Bus.CurrentMessageAvailable;
      if Bus.CurrentMessageAvailable then
         Message := Bus.CurrentMessage;
      end if;
   end GetNewMessage;

   procedure SendMessage(Bus : in out CANBus;
                         Message : in CANBusMessage) is
   begin
      -- in this simulation, just print the message to mimic sending it
      Ada.Text_IO.Put("Sending message on CAN Bus: "); New_Line;
      DebugPrintMessage(Message);
   end SendMessage;

   procedure DebugPrintMessage(Message : in CANBusMessage) is
   begin
      case Message.MessageType is
         when BrakePressureUpdate =>
           Put("BrakePressureUpdate (Pressure: ");
           Put(Float(Message.Pressure)); Put(")"); New_Line;
         when EngineStart =>
            Put("EngineStart"); New_Line;
         when VelocityRequest =>
           Put("VelocityRequest (Sender: ");
           Put(Message.VSender'Image); Put(")"); New_Line;
         when ReadSettingsRequest =>
           Put("ReadSettingsRequest (Sender: ");
           Put(Message.RSSender'Image); Put(")"); New_Line;
         when ChangeSettingsRequest =>
           Put("ChangeSettingsRequest (Sender: ");
           Put(Message.CSSender'Image); Put("; VelocityChangeThreshold: ");
           Put(Float(Message.CSVelocityChangeThreshold));
           Put("; AverageVelocityThreshold: ");
           Put(Float(Message.CSAverageVelocityThreshold));
           Put(")"); New_Line;
         when VelocityResponse =>
           Put("VelocityResponse (Destination: ");
           Put(Message.VDestination'Image); Put("; CurrentTick: ");
           Put(Message.CurrentTick); Put("; CurrentVelocity: ");
           Put(Float(Message.CurrentVelocity)); Put(")"); New_Line;
         when ReadSettingsResponse =>
           Put("ReadSettingsResponse (Destination: ");
           Put(Message.RSDestination'Image);
           Put("; VelocityChangeThreshold: ");
           Put(Float(Message.RSVelocityChangeThreshold));
           Put("; AverageVelocityThreshold: ");
           Put(Float(Message.RSAverageVelocityThreshold));
           Put(")"); New_Line;
         when ChangeSettingsResponse =>
           Put("ChangeSettingsResponse (Destination: ");
           Put(Message.CSDestination'Image); Put(")"); New_Line;
      end case;
   end DebugPrintMessage;

   procedure Tick (Bus : in out CANBus) is
   begin
      -- since the state of the bus never depends on its history
      -- (i.e. its past states) in this crude model, we can just
      -- reinitalise the bus to generate a new state
      Init(Bus);
   end Tick;

end CANBUS;
