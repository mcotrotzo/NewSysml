library package TwinStateMachineLibrary {
    private import TwinTypeSystem::*;
    private import TwinLibraryPackage::*;
    
    abstract part def State:>TwinLibraryElement {
        attribute local_Attributes : TwinAttribute[0..*];
        action entryAction_;
        action doAction_;
        action exitAction_;
       
    }

    abstract part def TransitionConstraint:>TwinLibraryElement {
        attribute triggerCondition_ : TwinBoolean[1];
    }

    connection def TransitionConnection {
        end part fromState : State;
        end part toState : State;
        attribute local_Attributes : TwinAttribute[0..*];
        part guardCondition_ : TransitionConstraint[1]; 
    }


    abstract part def TriggerConfiguration:>TwinLibraryElement {
        
    }


    part def TimeBasedConfiguration :> TriggerConfiguration {
        attribute triggerInterval_ : ScalarValues::Integer[1];
        attribute triggerIntervalUnit_ : TimeUnit[1];
    }

    part def EventBasedConfiguration :> TriggerConfiguration {
        attribute triggeringAtributes_ : TwinAttribute[0..*];
        attribute onChange_ : ScalarValues::Boolean[1];
    }

    part def CustomStateMachine:>TwinLibraryElement {
        constant attribute currentState : TwinString[1];
        part states : State[1..*];
        abstract connection transitions : TransitionConnection[0..*];
        part triggerConfig_ : TriggerConfiguration[0..1];
        attribute local_Attributes : TwinAttribute[0..*];
    }



    enum def TimeUnit{
        MICROSECOND;
        MILLISECOND;
        HOUR;
        SECOND;
        MINUTE;
        DAY;
        YEAR;
    }

}


