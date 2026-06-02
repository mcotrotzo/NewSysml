library package PhysicalTwinLibrary {
    private import ScalarValues::*;

    part def PhysicalTwin {
        port sensors [0..*] : Sensor;
        port actuators [0..*] : Actuator;
        attribute attributes [0..*] : ScalarValues::ScalarValue;
    }
    
    port def Sensor :> TwinPort {
        out attribute measurements : ScalarValues::ScalarValue [1..*];
    }
    
    port def Actuator :> TwinPort {
        in attribute commandAttributes : ScalarValues::ScalarValue [1..*];
    }
    
    
    interface def Communication {
        end source : TwinPort;
        end target : ~TwinPort;
    }
    
    port def TwinPort;
    
    interface def MQTT :> Communication {
        attribute broker : String;
        attribute topic : String;
    }
    
    interface def CustomCommunication :> Communication {
        attribute pathToLambdaCode : String;
    }

}