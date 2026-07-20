library package PrescriptiveModelLibrary {

    private import TwinTypeSystem::*;
    private import TwinStateMachineLibrary::*;
    private import PredicitiveLibrary::*;
    private import TwinLibraryPackage::*;

    part def startegyCondition {
        attribute condition : TwinBoolean[1];
    }
    part def PrescriptiveStrategy {
        part triggerConfig_ : TriggerConfiguration[1];
        attribute condition_[0..1] : TwinBoolean;
        attribute inputAttributes[0..*] : TwinAttribute;
    }

    part def CustomPrescriptiveStrategy :> PrescriptiveStrategy {
        attribute lambdaPath : ScalarValues::String;
        attribute outputAttributes[0..*]:TwinAttribute;
    }
    part def SendToActuatorStrategy :> PrescriptiveStrategy {
        attribute actuatorTarget : TwinAttribute[1];
        attribute commandValue   : TwinAttribute[1];
    }

    part def PrescriptiveModel {
        
        part strategies : PrescriptiveStrategy[0..*];
    }

   

}