library package PredicitiveLibrary {

    private import TwinTypeSystem::*;
    private import TwinStateMachineLibrary::*;
    private import TwinTriggerConfigurationLibrary::*;
    private import TwinImp::*;
    part def PredictiveStrategy {
        part triggerConfiguration : TriggerConfiguration[1];
        in attribute lambdaPath : TwinString;
        attribute inputs[0..*] : TwinAttribute;
        attribute outputs[0..*] : TwinAttribute;
    }
    part def PredictiveModel {
        
        calc strategies : PredictiveStrategy[0..*];
    }

}