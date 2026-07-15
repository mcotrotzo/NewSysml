library package PhysicalTwinLibrary {
    private import TwinDataTypeLibrary::*;
    private import TwinStateMachineLibrary::*;
    part def PhysicalTwin {
        port sensors [0..*] : Sensor;
        part controlUnit:CustomStateMachine;
        port actuators [0..*] : Actuator;
        attribute constAttributes [0..*]: TwinAttribute;
    }

    attribute def CommunicationProtocol {
        
    }

    attribute def HTTP_Protocol :> CommunicationProtocol {
        attribute url : TwinString;
    }
    attribute def MQTT_Protocol :> CommunicationProtocol {
        attribute broker : TwinString;
        attribute topic : TwinString;
    }

    port def TwinPort{
        attribute communicationProtocol : CommunicationProtocol;
    }

    port def Sensor :> TwinPort {
        out attribute measurements[0..*] : TwinAttribute;
    }

    port def Actuator :> TwinPort {
        in attribute commands[0..*] : TwinAttribute;
    }

}