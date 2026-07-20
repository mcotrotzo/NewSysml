library package DescriptiveModelLibrary {
    private import ShadowLibrary::*;
    private import PhysicalTwinLibrary::*;
    private import TwinTypeSystem::*;
    private import TwinStateMachineLibrary::*; 

    enum def DeltaMode {
        enum ABSOLUTE; 
        enum PER_TIME_UNIT;
    }

    enum def ValueSelector {
        enum FIRST; 
        enum LAST;
    }

    enum def ORDER_BY {
        enum ASCENDING; 
        enum DESCENDING;
    }

    abstract attribute def QueryHistory :> TwinAttribute {
        in attribute twinAttribute_        : TwinAttribute;
        in attribute since                 : ScalarValues::Integer[0..1];
        in attribute since_unit            : TimeUnit[0..1];
        in attribute limit                 : ScalarValues::Integer[0..1];
        in attribute filter_expressions    : TwinBoolean[0..*];
        in attribute order_by              : ORDER_BY[0..1];
    }

   
    abstract part def DescriptiveModel {
        attribute queries_ : QueryHistory[0..*];
        attribute derivedAttributes_ : TwinAttribute[0..*];
        part descriptiveStateMachine_ : DescriptiveStateMachine[0..1];
    }

    part def DescriptiveStateMachine :> CustomStateMachine {}
}
