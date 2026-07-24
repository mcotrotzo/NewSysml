library package PrescriptiveModelLibrary {

    private import TwinTypeSystem::*;
    private import TwinStateMachineLibrary::*;
    private import PredicitiveLibrary::*;
    private import TwinLibraryPackage::*;
    private import TwinTriggerConfigurationLibrary::*;
    private import TwinImp::*;
    part def startegyCondition {
        attribute condition : TwinBoolean[1];
    }

    part def PrescriptiveStrategy {
        part triggerConfig_ : TriggerConfiguration[1];
        attribute condition_[0..1] : TwinBoolean;
        attribute inputs[0..*] : TwinAttribute;
        attribute outputs[0..*] : TwinAttribute;


    }

    part def CustomPrescriptiveStrategy :> PrescriptiveStrategy {
        in attribute lambdaPath[1] : TwinString;
        
    }


   

}