library package PredicitiveLibrary {

    private import TwinDataTypeLibrary::*;
    private import TwinStateMachineLibrary::*;


    part def PredicitiveStrategy{
        part triggerConfig_:TriggerConfiguration[1];
        attribute inputAttributes[0..*]:TwinAttribute;
        attribute lambdaPath : ScalarValues::String;
        attribute outputAttributes[0..*]:TwinAttribute;
    }

    part def PredictiveModel {
        
        part strategies : PredicitiveStrategy[0..*];
    }

}