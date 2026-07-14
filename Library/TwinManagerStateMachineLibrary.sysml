library package TwinStateMachineLibrary {
    private import TwinDataTypeLibrary::*;


    abstract part def StatePart {
        action assignActions[0..*];
    }

    part def TransitionConstraint {
        attribute triggerCondition_ : TwinAttributeBoolean[1];
    }

    connection def TransitionConnection {
        end part fromState : StatePart;
        end part toState : StatePart;
        
        part guardCondition_ : TransitionConstraint[0..*]; 
    }

    abstract part def TriggerConfiguration {
    }

    part def TimeBasedConfiguration :> TriggerConfiguration {
        attribute triggerInterval_ : TwinAttributeInteger[1];
        attribute triggerIntervalUnit_ : TimeUnit[1];
    }

    part def EventBasedConfiguration :> TriggerConfiguration {
        attribute triggeringAtributes_ : TwinAttribute[0..*];
        attribute onChange_ : TwinAttributeBoolean[1] default new TwinAttributeBoolean(value = true);
    }

    part def CustomStateMachine {
        constant attribute currentState : TwinAttributeString[1];
        part states : StatePart[1..*];
        abstract connection transitions : TransitionConnection[0..*];
        part triggerConfig_ : TriggerConfiguration[0..1] default 
            new TimeBasedConfiguration(triggerInterval_ = new TwinAttributeInteger(value = 1000), 
                                        triggerIntervalUnit_ = TimeUnit::SECONDS);
        
    }

    part eventBasedTriggerConfig[0..*] :EventBasedConfiguration;
    part timeBasedTriggerConfig[0..*] :TimeBasedConfiguration;
    
}