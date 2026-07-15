library package TwinStateMachineLibrary {
    private import TwinDataTypeLibrary::*;
    private import CustomLibrary::*;
    
    abstract part def State {
        perform action assignActions_:ASSIGN[0..*];
    }

    part def TransitionConstraint {
        private attribute triggerCondition_ : TwinBoolean[1];
        action statements:TransitionGuardFunction[1]{
            private out attribute :>>bOutput = triggerCondition_;
        }
    }

    action def TransitionGuardFunction:>CustomFunction {
        in attribute :>> inputs:TwinAttribute[0..*];
        out attribute bOutput:>> outputs:TwinBoolean[1];
    }

    connection def TransitionConnection {
        end part fromState : State;
        end part toState : State;
        part guardCondition_ : TransitionConstraint[1]; 
    }


    part def TriggerConfiguration {
        
    }

    enum def TimeUnit {
        enum SECONDS;
        enum MILLISECONDS;
        enum MINUTES;
        enum HOURS;
        enum DAYS;
        enum WEEKS;
        enum MONTHS;
        enum YEARS;
    }

    part def TimeBasedConfiguration :> TriggerConfiguration {
        attribute triggerInterval_ : TwinInteger[1];
        attribute triggerIntervalUnit_ : TimeUnit[1];
    }

    part def EventBasedConfiguration :> TriggerConfiguration {
        attribute triggeringAtributes_ : TwinAttribute[0..*];
        attribute onChange_ : TwinBoolean[1];
    }

    part def CustomStateMachine {
        constant attribute currentState : TwinString[1];
        part states : State[1..*];
        abstract connection transitions : TransitionConnection[0..*];
        part triggerConfig_ : TriggerConfiguration[0..1];
    }

}


