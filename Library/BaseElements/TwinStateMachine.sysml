library package TwinStateMachineLibrary {
    private import TwinDataTypeLibrary::*;
    
    abstract part def State {
        attribute local_Attributes : TwinAttribute[0..*];
        perform action assignActions_:ASSIGN[0..*];
    }

    part def TransitionConstraint {
        attribute triggerCondition_ : TwinAttributeBoolean[1];
    }

    connection def TransitionConnection {
        end part fromState : State;
        end part toState : State;
        attribute local_Attributes : TwinAttribute[0..*];
        part guardCondition_ : TransitionConstraint[1]; 
    }


    part def TriggerConfiguration {
        
    }


    part def TimeBasedConfiguration :> TriggerConfiguration {
        attribute triggerInterval_ : ScalarValues::Integer[1];
        attribute triggerIntervalUnit_ : TimeUnit[1];
    }

    part def EventBasedConfiguration :> TriggerConfiguration {
        attribute triggeringAtributes_ : TwinAttribute[0..*];
        attribute onChange_ : ScalarValues::Boolean[1];
    }

    part def CustomStateMachine {
        constant attribute currentState : TwinAttributeString[1];
        part states : State[1..*];
        abstract connection transitions : TransitionConnection[0..*];
        part triggerConfig_ : TriggerConfiguration[0..1];
        attribute local_Attributes : TwinAttribute[0..*];
    }

}


