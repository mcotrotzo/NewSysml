library package TwinDefLibrary {
    
    private import PublicDescriptiveElements::*;
    private import PrescriptivePublicElements::*;
    private import PredictivePublicElements::*;
    private import ShadowPublicElements::*;
    private import PhysicalElementsLibrary::*;
    private import TwinTypeSystem::*;
    
    part def Twin:>CloudTwin{
        //PhysicalTwin
        out port sensors [0..*] : Sensor;
        state controlUnit:ControlUnit[0..*];
        in port actuators [0..*] : Actuator;
        attribute constAttributes [0..*]: TwinAttribute;
        
    }

    part def CloudTwin{ 
        //Shadow
        part databases : Database[0..*];

        //Descriptive
        calc query[0..*] : QueryHistory;
        attribute derivedAttributes[0..*] : TwinAttribute;
        state descriptiveStateMachine_ : DescriptiveStateMachine[0..*];

        //Prescriptive
        part prescriptiveStrategies : CustomPrescriptiveStrategy[0..*];

        //Predictive
        part predictiveStrategies : PredictiveStrategy[0..*];
    }
    
}