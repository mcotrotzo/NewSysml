library package TwinTriggerConfigurationLibrary{

    private import TwinLibraryPackage::*;
    private import TwinTypeSystem::*;
    private import TwinEnumLibrary::*;



    part def TriggerConfiguration:>TwinLibraryElement {
    }

    part def TimeBasedConfiguration :> TriggerConfiguration {
        attribute triggerInterval_ : TwinInteger[1];
        attribute triggerIntervalUnit_ : TimeUnit[1];
    }

    part def EventBasedConfiguration :> TriggerConfiguration {
        attribute triggeringAtributes_ : TwinAttribute[0..*];
        attribute onChange_ : TwinBoolean[1];
    }
}