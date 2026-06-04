library package PhysicalTwinLibrary {
    private import ScalarValues::*;
    private import Metaobjects::SemanticMetadata;
    
    
    
    part def PhysicalTwin {
        port sensors [0..*] : Sensor; 
        state controlUnit_:ControlUnit;
        port actuators [0..*] : Actuator;
        part constComponents [0..*]: ConstAttributes;
    
    }



    part def ConstAttributes{
        attribute attributes [0..*] : ScalarValues::ScalarValue;
    }

    port def Sensor :> TwinPort {
        out attribute measurements : ScalarValues::ScalarValue [1..*];

    }
    
    port def Actuator :> TwinPort {
        in attribute commandAttributes : ScalarValues::ScalarValue [1..*];

       
    }
     port def TwinPort;

    state def ControlUnit :>AbstractState{
        state actions:ControlUnitState[0..*];
    }

    abstract state def AbstractState{
        attribute attributes:ScalarValues::ScalarValue[0..*];
    }

    state def ControlUnitState:> AbstractState {

    }


    
    interface def Communication {
        end source : TwinPort;
        end target : ~TwinPort;
    }

    abstract interface communication_:Communication;
    


}