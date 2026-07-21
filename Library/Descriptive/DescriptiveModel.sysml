library package DescriptiveModelLibrary {
    private import ShadowLibrary::*;
    private import PhysicalTwinLibrary::*;
    private import TwinTypeSystem::*;
    private import TwinStateMachineLibrary::*; 
    private import TwinLibraryPackage::*;
    private import TwinImp::*;


    public enum def ORDER_BY {
        enum ASCENDING; 
        enum DESCENDING;
    }

    public abstract calc def QueryHistory {
        in attribute twinAttribute : TwinAttribute;
        in attribute since : TwinInteger;
        in attribute sinceUnit : TimeUnit;
        in attribute orderBy : ORDER_BY;
        in attribute limit:TwinInteger;
        in attribute filterExpression : TwinBoolean;
        return attribute result : TwinAttribute[0..*];       
    }

    public calc def QueryHistoryReal:>QueryHistory {
        return attribute :>>result : TwinReal[0..*];       
    }

    public calc def QueryHistoryBoolean:>QueryHistory {
        in attribute twinAttribute : TwinAttribute;
        in attribute since : TwinInteger;
        in attribute sinceUnit : TimeUnit;
        in attribute orderBy : ORDER_BY;
        in attribute limit:TwinInteger;
        in attribute filterExpression : TwinBoolean;
        return attribute result : TwinBoolean[0..*];       
    }

    public calc def QueryHistoryInteger:>QueryHistory {
        in attribute twinAttribute : TwinAttribute;
        in attribute since : TwinInteger;
        in attribute sinceUnit : TimeUnit;
        in attribute orderBy : ORDER_BY;
        in attribute limit:TwinInteger;
        in attribute filterExpression : TwinBoolean;
        return attribute result : TwinInteger[0..*];       
    }

    public calc def QueryHistoryString:>QueryHistory {
        in attribute twinAttribute : TwinAttribute;
        in attribute since : TwinInteger;
        in attribute sinceUnit : TimeUnit;
        in attribute orderBy : ORDER_BY;
        in attribute limit:TwinInteger;
        in attribute filterExpression : TwinBoolean;
        return attribute result : TwinString[0..*];       
    }

   
    abstract part def DescriptiveModel {
        attribute derivedAttributes_ : TwinAttribute[0..*];
        abstract state descriptiveStateMachine_ : State[0..1]{
            part triggerConfig_ : TriggerConfiguration[0..1];
        }
    }

}
