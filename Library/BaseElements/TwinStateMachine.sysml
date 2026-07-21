library package TwinStateMachineLibrary {
    private import TwinTypeSystem::*;
    private import TwinLibraryPackage::*;
    
    private abstract state def State:>TwinLibraryElementStateDef {
        attribute local_Attributes : TwinAttribute[0..*];
        abstract state states:State[0..*];
    }

    private part def TriggerConfiguration:>TwinLibraryElement {
    }

    public part def TimeBasedConfiguration :> TriggerConfiguration {
        attribute triggerInterval_ : TwinInteger[1];
        attribute triggerIntervalUnit_ : TimeUnit[1];
    }

    public part def EventBasedConfiguration :> TriggerConfiguration {
        attribute triggeringAtributes_ : TwinAttribute[0..*];
        attribute onChange_ : TwinBoolean[1];
    }

    public enum def TimeUnit{
        MICROSECOND;
        MILLISECOND;
        HOUR;
        SECOND;
        MINUTE;
        DAY;
        YEAR;
    }

}


