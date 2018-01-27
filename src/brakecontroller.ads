with ClockTick;
with Wheel;
with Brake;
with Measures;
with SpeedSensor;
with CANBus; use CANBus;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

package BrakeController is
   -- Decalre a type of array to store and update the historical veloctiy
   type historicalVelocityArray is array(Integer range 0..4) of Measures.KMPH;

   type BrakeControllerType is record

         -- Set up some attributes that aim to identify the system's status
         isOn : Boolean; -- System Current Working Mode
         isLocked : Boolean; -- Indicates that if the wheel is locked now
         isAbsActivated : Boolean; -- Indicates that if the ABS is actived now
         currentTick : Natural; -- Current System Tick

         -- Set up attributes to store the two threashold seetings
         averageVelocityThreshold : Measures.KMPH; -- Average velocity threshold set value
         velocityChangeThreshold  : Measures.KMPH; -- Velocity change threshold set value

         -- Set up attribuets to store measured data, including histoical and current data
         currentVelocity : Measures.KMPH; -- Current measured velocity
         averageVelocity : Measures.KMPH; -- Average velocity calculated by averaging the past 4 historical velocity
         historicalVelociyArray : historicalVelocityArray; -- An array used to store and update historical velocity
         velocityChange : Measures.KMPH; -- velocityChange is the value of ( the (Now-1) velocity - current velocity)
         pressureToBeRestored: Measures.BrakePressure; -- To store the pressure that will be restored in Abs's step2
         availableHistoryVelocityCount : Float; -- To count how many avialable history velocity data stored in the array before having 4 hisotrical velocity.
         currentAcceleration : Measures.MPS2; -- current acceleration value
         appliedPressure : Measures.BrakePressure; -- pressure to be applied to brake
         hasNewPressure : Boolean;
         currentVelocityWheel : Measures.KMPH;



         -- Set up attributes to recieve Canbus messages and respond
         currentMessage : CANBus.CANBusMessage; -- The message recieved in the current tick; It will be processed based on its type
         readVelocityResponseMsg : CANBusMessage(VelocityResponse); -- A specified message type used to response read velocity request
         readSettingsResponseMsg : CANBusMessage(ReadSettingsResponse); -- A specified message type used to response read settings request
         changeSettingsResponseMsg : CANBusMessage(ChangeSettingsResponse); -- A specified message type used to response change settings request
         messageAvailable : Boolean; -- Indicates that if the canbus message is available

   end record;

   -- Procedures regrading to the system set up
   procedure Init(Bc : in out BrakeControllerType);  -- Initalise the Brake Controller
   procedure turnOn(Bc : out BrakeControllerType); -- Turn the system to the ON Mode
   procedure turnOff(Bc : in out BrakeControllerType;Br : in out Brake.Brake); -- Turn the system to the Off Mode
   procedure Tick(Bc:in out BrakeControllerType;
                  Wh : in out Wheel.Wheel;
                  Br : in out Brake.Brake;
                  Bus: in out CANBus.CANBus;
                  SS: in out SpeedSensor.SpeedSensor);

   -- Procedures regarding to get and update system data
   procedure getCurrentMeasuredVelocity(Bc: in out BrakeControllerType;
                                        SS : in SpeedSensor.SpeedSensor;
                                        Wh : in out Wheel.Wheel);
   procedure getCurrentAcceleration(Bc: in out BrakeControllerType;
                                    Wh : in Wheel.Wheel); -- get current acceleration
   procedure updateHistroicalVelocityArray(Bc : in out BrakeControllerType); -- Update the history velocity data
   procedure updateAverageVelocity(Bc : in out BrakeControllerType); -- Update current system average velocity
   procedure updateVelocityChange(Bc : in out BrakeControllerType); -- Update current system velocity change
   procedure printOutSystemInfo(Bc : in out BrakeControllerType); -- print updated system info continuously

   -- Procedures regarding to the Abs system
   procedure lockDetection(Bc :in out BrakeControllerType;
                           Wh : in out Wheel.Wheel); -- Detect if the wheel is locked
   procedure activateAbs(Bc :in out BrakeControllerType); -- Active Abs progress
   procedure deactivateAbs(Bc :in out BrakeControllerType); -- Deactive Abs progress
   procedure absProcedure (Bc: in out BrakeControllerType;
                           Br: in out Brake.Brake;
                           Bus : in out CANBus.CANBus;
                           Wh: in out Wheel.Wheel); -- Abs workflow
   procedure adjustPressure(Bc :in out BrakeControllerType;
                            Br: in out Brake.Brake;
                            Wh : in out Wheel.Wheel;
                            Bus : in out CANBus.CANBus); -- Adjust pressure

   -- Procedures regarding to get canbus message and respond
   procedure getCanBusMessage(Bc: in out BrakeControllerType;
                              Bus: in out CANBus.CANBus;
                              Br : in out Brake.Brake;
                              Wh : in out Wheel.Wheel); -- Receive messages from canbus
   procedure VelocityResponse(Bc: in out BrakeControllerType;
                              Bus : in out CANBus.CANBus); -- Response to read velocity request
   procedure ReadSettingsResponse(Bc: in out BrakeControllerType;
                                  Bus : in out CANBus.CANBus); -- Response to read settings request
   procedure ChangeSettingsResponse(Bc: in out BrakeControllerType;
                                    Bus : in out CANBus.CANBus); -- Response to change settings request

 end BrakeController;
