library package PhysicalTwinLibrary {
    private import TwinTypeSystem::*;
    private import TwinStateMachineLibrary::*;
    private import TwinLibraryPackage::*;

    part def PhysicalTwin:>TwinLibraryElement {
        port sensors [0..*] : Sensor;
        part controlUnit:CustomStateMachine;
        port actuators [0..*] : Actuator;
        attribute constAttributes [0..*]: TwinAttribute;
    }

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
        out attribute measurements[0..*] : TwinAttribute;
    }

    port def Actuator :> TwinPort {
        in attribute commands[0..*] : TwinAttribute;
    }

}