library package DescriptiveModelLibrary {
    private import ShadowLibrary::*;
    private import PhysicalTwinLibrary::*;
    private import TwinDataTypeLibrary::*;
    private import TwinStateMachineLibrary::*; 


    attribute def filterExpression {
       
        attribute value[1] : TwinAttributeBoolean;
    }

    enum def DeltaMode {
        ABSOLUTE; PER_TIME_UNIT;
    }

    enum def ValueSelector {
        FIRST; LAST;
    }

    
    
    abstract attribute def QueryHistory :> TwinAttribute {
        in attribute twinAttribute_[1]        : TwinAttribute;
        in attribute since[0..1]              : ScalarValues::Integer;
        in attribute since_unit[0..1]         : TimeUnit;
        in attribute limit[0..1]              : ScalarValues::Integer;
        in attribute filter_expressions[0..*] : filterExpression;
        in attribute order_by[0..1]           : ORDER_BY;
    }

    attribute def ArithmeticAggregationQuery :> QueryHistory, TwinNumberAttribute {
        in attribute aggregation[1] : ArithmeticAggregationOperator;
    }

    attribute def DeltaQuery :> QueryHistory, TwinNumberAttribute {
        in attribute mode[1] : DeltaMode;
    }
    attribute def PercentileQuery :> QueryHistory, TwinNumberAttribute {
        in attribute percentile[1] : ScalarValues::Real;
    }

    attribute def BooleanAggregationQuery :> QueryHistory, TwinAttributeBoolean {
        in attribute aggregation[1] : BooleanAggregationOperator;
    }
    attribute def StringAggregationQuery :> QueryHistory, TwinAttributeString {
        in attribute aggregation[1] : StringAggregationOperator;
    }

    attribute def CountQuery :> QueryHistory, TwinAttributeInteger {
    }
    attribute def HasDataQuery :> QueryHistory, TwinAttributeBoolean {
    }

    attribute def ChangeCountQuery :> QueryHistory, TwinAttributeInteger {
    }

    abstract attribute def SingleValueQuery :> QueryHistory {
        in attribute selector[1] : ValueSelector;
    }
    attribute def SingleNumberQuery  :> SingleValueQuery, TwinNumberAttribute { }
    attribute def SingleBooleanQuery :> SingleValueQuery, TwinAttributeBoolean { }
    attribute def SingleStringQuery  :> SingleValueQuery, TwinAttributeString { }
    attribute def SingleTimestampQuery :> SingleValueQuery, TwinAttributeTimestamp { }

    abstract attribute def RawHistoryQuery :> QueryHistory, TwinAttributeList {}
    attribute def RawNumberQuery  :> RawHistoryQuery, TwinNumberList { }
    attribute def RawBooleanQuery :> RawHistoryQuery, TwinBooleanList { }
    attribute def RawStringQuery  :> RawHistoryQuery, TwinStringList { }

    part def D_TransitionConstraint :> TransitionConstraint {
        
    }

    connection def D_TransitionConnection :> TransitionConnection {
    }

    part def D_StateMachine :> CustomStateMachine {
        abstract connection d_transitions_ :>> transitions : D_TransitionConnection[0..*];
        part d_states_ :>> states : D_State[1..*];
        attribute machineAttributes_[0..*] : TwinAttribute;
    }
  
     part def D_State :> StatePart {
        action d_assignActions :>> assignActions[0..*];
    }

    
    part def DescriptiveModel {
        attribute queries_[0..*] : QueryHistory;
        part descriptiveStateMachine_ : D_StateMachine;

    }
}