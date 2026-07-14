library package PhysicalTwinLibrary {
    private import Metaobjects::SemanticMetadata;
    private import TwinDataTypeLibrary::*;
    private import TwinStateMachineLibrary::*;

    part def PhysicalTwin {
        port  sensors [0..*] : Sensor;
        part controlUnit_:CustomStateMachine;
        port  actuators [0..*] : Actuator;
        attribute constComponents[0..*] : TwinAttribute;
    }
    
    port def TwinPort{
        attribute communicationProtocol : CommunicationProtocol;
    }
    
    attribute def CommunicationProtocol {
        
    }

    attribute def HTTP_Protocol :> CommunicationProtocol {
        attribute url : ScalarValues::String;
    }
    attribute def MQTT_Protocol :> CommunicationProtocol {
        attribute broker : ScalarValues::String;
        attribute topic : ScalarValues::String;
    }

    attribute def Payload {
        attribute jsonPath_ : ScalarValues::String;
        attribute measurements[0..*] : TwinAttribute;
    }

    port def Sensor :> TwinPort {
        out attribute payloads[0..*]:Payload;
    }

    attribute payload_:Payload[0..*];

    port def Actuator :> TwinPort {
        in attribute payloads[0..*]:Payload;
    }

    
}


