library package PhysicalTwinLibrary {
    private import TwinTypeSystem::*;
    private import TwinStateMachineLibrary::*;
    private import TwinLibraryPackage::*;
    private import TwinTriggerConfigurationLibrary::*;


    abstract attribute def CommunicationProtocol:>TwinLibraryElementAttributeDef {
        
    }

    attribute def HTTP_Protocol :> CommunicationProtocol {
        attribute url[1] : TwinString;
    }
    attribute def MQTT_Protocol :> CommunicationProtocol {
        attribute broker[1] : TwinString;
        attribute topic[1] : TwinString;
    }





    abstract port def TwinPort:>TwinLibraryElementPortDef{
        abstract attribute communicationProtocol : CommunicationProtocol;
    }

    port def Sensor :> TwinPort {
        attribute measurements[0..*] : TwinAttribute;
    }

    port def Actuator :> TwinPort {
        attribute commands[0..*] : TwinAttribute;
    }

  


    state def ControlUnit:>State  {
        attribute sensorAttributes:>>readAttributes[0..*]:TwinAttribute;
        attribute constAttributes:>>readAttributes[0..*]:TwinAttribute;
        attribute actuatorAttributes:>>writeAttributes[0..*]:TwinAttribute; 
        part triggerConfiguration : TriggerConfiguration[0..1];
        state states:ControlUnitState[0..*]:>>states;
    }

    state def ControlUnitState:>State {
        state states:ControlUnitState[0..*]:>>states;
    }



}