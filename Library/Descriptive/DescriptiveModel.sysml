library package DescriptiveModelLibrary {
    private import ShadowLibrary::*;
    private import PhysicalTwinLibrary::*;
    private import TwinDataTypeLibrary::*;
    private import TwinStateMachineLibrary::*; 

    enum def DeltaMode {
        enum ABSOLUTE; 
        enum PER_TIME_UNIT;
    }

    enum def ValueSelector {
        enum FIRST; 
        enum LAST;
    }

    abstract attribute def QueryHistory :> TwinAttribute {
        in attribute twinAttribute_        : TwinAttribute;
        in attribute since                 : ScalarValues::Integer[0..1];
        in attribute since_unit            : TimeUnit[0..1];
        in attribute limit                 : ScalarValues::Integer[0..1];
        in attribute filter_expressions    : TwinAttributeBoolean[0..*];
        in attribute order_by              : ORDER_BY[0..1];
    }

    attribute def ArithmeticAggregationQuery :> QueryHistory, TwinNumberAttribute {
        in attribute aggregation : ArithmeticAggregationOperator;
    }

    attribute def DeltaQuery :> QueryHistory, TwinNumberAttribute {
        in attribute mode : DeltaMode;
    }

    attribute def PercentileQuery :> QueryHistory, TwinNumberAttribute {
        in attribute percentile : ScalarValues::Real;
    }

    attribute def BooleanAggregationQuery :> QueryHistory, TwinAttributeBoolean {
        in attribute aggregation : BooleanAggregationOperator;
    }

    attribute def StringAggregationQuery :> QueryHistory, TwinAttributeString {
        in attribute aggregation : StringAggregationOperator;
    }

    attribute def CountQuery :> QueryHistory, TwinAttributeInteger {}
    
    attribute def HasDataQuery :> QueryHistory, TwinAttributeBoolean {}

    attribute def ChangeCountQuery :> QueryHistory, TwinAttributeInteger {}

    abstract attribute def SingleValueQuery :> QueryHistory {
        in attribute selector : ValueSelector;
    }

    attribute def SingleNumberQuery :> SingleValueQuery, TwinAttributeReal {}

    attribute def SingleIntegerQuery :> SingleValueQuery, TwinAttributeInteger {}

    attribute def SingleBooleanQuery :> SingleValueQuery, TwinAttributeBoolean {}

    attribute def SingleStringQuery :> SingleValueQuery, TwinAttributeString {}

    abstract part def DescriptiveModel {
        attribute queries_ : QueryHistory[0..*];
        attribute derivedAttributes_ : TwinAttribute[0..*];
        part descriptiveStateMachine_ : DescriptiveStateMachine[0..1];
    }

    part def DescriptiveStateMachine :> CustomStateMachine {}
}
