library package TwinDataTypeLibrary {

    private import ScalarValues::*;


    abstract attribute def TwinAttribute {
        abstract attribute value[0..*];
    }

    abstract attribute def TwinPrimitiveAttribute :> TwinAttribute {
    }

    abstract attribute twinAttributes[0..*] : TwinAttribute;


    attribute def TwinAttributeBoolean :> TwinPrimitiveAttribute {
        :>> value[0..1] : ScalarValues::Boolean;
    }

    abstract attribute def TwinNumberAttribute :> TwinPrimitiveAttribute {
        :>> value[0..1] : ScalarValues::Number;
    }

    attribute def TwinAttributeInteger :> TwinNumberAttribute {
        :>> value : ScalarValues::Integer;
    }

    attribute def TwinAttributeReal :> TwinNumberAttribute {
        :>> value : ScalarValues::Real;
    }

    attribute def TwinAttributeString :> TwinPrimitiveAttribute {
        :>> value[0..1] : ScalarValues::String;
    }

    attribute def TwinAttributeTimestamp :> TwinAttributeInteger {
    }

    attribute def TwinAttributeBit :> TwinAttributeBoolean {
    }


    attribute def TwinAttributeEnum :> TwinAttribute {
        attribute enumOptions[0..*] : TwinAttributeString;
        :>> value[1] : TwinAttributeString default new TwinAttributeString(value = "");
    }

    attribute def CustomAttribute_ :> TwinAttribute {
        :>> value[0..*] : TwinAttribute;
    }
    attribute def CustomAttributeList_ :> TwinAttributeList {
        :>> elements[0..*] : CustomAttribute_;
        
    }

    abstract attribute def TwinAttributeList :> TwinAttribute {
        abstract attribute elements[0..*] : TwinAttribute;
        attribute size[0..1] : ScalarValues::Integer;
    }

    abstract attribute def TwinPrimitiveAttributeList :> TwinAttributeList {
        :>> elements : TwinPrimitiveAttribute;
    }

    abstract attribute def TwinNumberList :> TwinPrimitiveAttributeList {
        :>> elements : TwinNumberAttribute;
    }

    attribute def TwinRealList :> TwinNumberList {
        :>> elements : TwinAttributeReal;
    }

    attribute def TwinIntegerList :> TwinNumberList {
        :>> elements : TwinAttributeInteger;
    }

    attribute def TwinBooleanList :> TwinPrimitiveAttributeList {
        :>> elements : TwinAttributeBoolean;
    }

    attribute def TwinStringList :> TwinPrimitiveAttributeList {
        :>> elements : TwinAttributeString;
    }

    

   
    enum def ArithmeticOperator {
        ADD; SUBTRACT; MULTIPLY; DIVIDE; MODULO;
    }

    enum def BooleanAggregationOperator {
        ANY; ALL;
    }
    enum def ArithmeticAggregationOperator {
        SUM; AVERAGE; MIN; MAX; STDDEV; VARIANCE;
    }
    enum def StringAggregationOperator {
        DISTINCT_COUNT;
    }


    enum def ComparisonOperator {
        GREATER_THAN; GREATER_EQUAL; LESS_THAN; LESS_EQUAL;
    }

   
    enum def EqualityOperator {
        EQUAL; NOT_EQUAL;
    }

    enum def LogicalOperator {
        AND; OR; XOR; NOT;
    }

    enum def StringOperator {
        CONCAT;
    }

    enum def StringPredicateOperator {
        CONTAINS; STARTS_WITH; ENDS_WITH;
    }

    enum def TimeUnit {
        SECONDS; MINUTES; HOURS; DAYS; YEARS;
    }

    enum def ORDER_BY {
        ASCENDING; DESCENDING;
    }

    

    attribute def NumericCalc :> TwinNumberAttribute {
        in attribute left     : TwinNumberAttribute[1];
        in attribute right    : TwinNumberAttribute[1];
        in attribute operator : ArithmeticOperator[1];

    }

    attribute def ComparisonCalc :> TwinAttributeBoolean {
        in attribute left     : TwinNumberAttribute[1];
        in attribute right    : TwinNumberAttribute[1];
        in attribute operator : ComparisonOperator[1];
    }

    attribute def EqualityCalc :> TwinAttributeBoolean {
        in attribute left     : TwinPrimitiveAttribute[1];
        in attribute right    : TwinPrimitiveAttribute[1];
        in attribute operator : EqualityOperator[1];
    }

    attribute def LogicalCalc :> TwinAttributeBoolean {
        in attribute left     : TwinAttributeBoolean[1];
        in attribute right    : TwinAttributeBoolean[0..1];
        in attribute operator : LogicalOperator[1];
    }

    attribute def StringCalc :> TwinAttributeString {
        in attribute left     : TwinAttributeString[1];
        in attribute right    : TwinAttributeString[1];
        in attribute operator : StringOperator[1];
    }

    attribute def StringPredicateCalc :> TwinAttributeBoolean {
        in attribute left     : TwinAttributeString[1];
        in attribute right    : TwinAttributeString[1];
        in attribute operator : StringPredicateOperator[1];
    }


    attribute def ListArithmeticCalc :> TwinNumberList {
        in attribute left     : TwinNumberList[1];
        in attribute right    : TwinNumberList[1];
        in attribute operator : ArithmeticOperator[1];
    }

    attribute def ListEqualityCalc :> TwinBooleanList {
        in attribute left     : TwinPrimitiveAttributeList[1];
        in attribute right    : TwinPrimitiveAttributeList[1];
        in attribute operator : EqualityOperator[1];
    }

    attribute def ListComparisonCalc :> TwinBooleanList {
        in attribute left     : TwinNumberList[1];
        in attribute right    : TwinNumberList[1];
        in attribute operator : ComparisonOperator[1];
    }

    attribute def ListAggregationCalc :> TwinNumberAttribute {
        in attribute list     : TwinNumberList[1];
        in attribute operator : ArithmeticAggregationOperator[1];
    }

    attribute def ListBooleanAggregationCalc :> TwinAttributeBoolean {
        in attribute list     : TwinBooleanList[1];
        in attribute operator : BooleanAggregationOperator[1];
    }
    attribute def ListStringAggregationCalc :> TwinAttributeString {
        in attribute list     : TwinStringList[1];
        in attribute operator : StringAggregationOperator[1];
    }
    attribute def ListCountCalc :> TwinAttributeInteger {
        in attribute list     : TwinAttributeList[1];
    }

    action def ASSIGN{
        in ref target:TwinAttribute;
        in ref source:TwinAttribute;

        assign target := source;
    
    }

}