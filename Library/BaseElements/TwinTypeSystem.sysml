library package TwinTypeSystem {

    
    private import ScalarValues::*;
    
    public import IntegerFunctions::*;
    public import RealFunctions::*;
    public import StringFunctions::*;
    public import BooleanFunctions::*;
    public import DataFunctions::*;
    public import NumericalFunctions::*;

    public import SequenceFunctions::equals;
    public import SequenceFunctions::size;
    public import SequenceFunctions::isEmpty;
    public import SequenceFunctions::'#';
    public import SequenceFunctions::add;
    public import SequenceFunctions::remove;
    public import SequenceFunctions::addAt;
    public import SequenceFunctions::removeAt;

    // ==========================================
    // Type Aliases
    // ==========================================
    
    alias TwinAttribute for Base::DataValue;

    alias TwinScalar for ScalarValues::ScalarValue;
    
    alias TwinReal for Real;
    alias TwinInteger for Integer;
    alias TwinString for String;
    alias TwinBoolean for Boolean;




    // ==========================================
    // IntegerFunctions Aliases
    // ==========================================
    alias PLUS_int for IntegerFunctions::'+';
    alias MINUS_int for IntegerFunctions::'-';
    alias MULT_int for IntegerFunctions::'*';
    alias DIV_int for IntegerFunctions::'/';
    alias POW_int for IntegerFunctions::'**';
    alias CARET_int for IntegerFunctions::'^';
    alias MOD_int for IntegerFunctions::'%';
    
    alias LT_int for IntegerFunctions::'<';
    alias GT_int for IntegerFunctions::'>';
    alias LE_int for IntegerFunctions::'<=';
    alias GE_int for IntegerFunctions::'>=';
    alias EQ_int for IntegerFunctions::'==';
    
    alias ABS_int for IntegerFunctions::abs;
    alias MAX_int for IntegerFunctions::max;
    alias MIN_int for IntegerFunctions::min;
    alias RANGE_int for IntegerFunctions::'..';
    
    alias TO_STRING_int for IntegerFunctions::ToString;
    alias TO_NATURAL_int for IntegerFunctions::ToNatural;
    alias TO_INTEGER_int for IntegerFunctions::ToInteger;
    alias SUM_int for IntegerFunctions::sum;
    alias PRODUCT_int for IntegerFunctions::product;

    // ==========================================
    // RealFunctions Aliases
    // ==========================================
    alias PLUS_real for RealFunctions::'+';
    alias MINUS_real for RealFunctions::'-';
    alias MULT_real for RealFunctions::'*';
    alias DIV_real for RealFunctions::'/';
    alias POW_real for RealFunctions::'**';
    alias CARET_real for RealFunctions::'^';
    
    alias LT_real for RealFunctions::'<';
    alias GT_real for RealFunctions::'>';
    alias LE_real for RealFunctions::'<=';
    alias GE_real for RealFunctions::'>=';
    alias EQ_real for RealFunctions::'==';
    
    alias RE_real for RealFunctions::re;
    alias IM_real for RealFunctions::im;
    alias ABS_real for RealFunctions::abs;
    alias ARG_real for RealFunctions::arg;
    alias MAX_real for RealFunctions::max;
    alias MIN_real for RealFunctions::min;
    alias SQRT_real for RealFunctions::sqrt;
    alias FLOOR_real for RealFunctions::floor;
    alias ROUND_real for RealFunctions::round;
    
    alias TO_STRING_real for RealFunctions::ToString;
    alias TO_INTEGER_real for RealFunctions::ToInteger;
    alias TO_RATIONAL_real for RealFunctions::ToRational;
    alias TO_REAL_real for RealFunctions::ToReal;
    alias SUM_real for RealFunctions::sum;
    alias PRODUCT_real for RealFunctions::product;

    // ==========================================
    // StringFunctions Aliases
    // ==========================================
    alias PLUS_str for StringFunctions::'+';
    alias LENGTH_str for StringFunctions::Length;
    alias SUBSTRING_str for StringFunctions::Substring;
    
    alias LT_str for StringFunctions::'<';
    alias GT_str for StringFunctions::'>';
    alias LE_str for StringFunctions::'<=';
    alias GE_str for StringFunctions::'>=';
    alias EQ_str for StringFunctions::'==';
    alias TO_STRING_str for StringFunctions::ToString;

    // ==========================================
    // BoolFunctions Aliases
    // ==========================================
    alias AND_bool for BooleanFunctions::'&';
    alias OR_bool for BooleanFunctions::'|';
    alias NOT_bool for BooleanFunctions::'not';
    alias EQ_bool for BooleanFunctions::'==';
    alias TO_STRING_bool for BooleanFunctions::ToString;
    alias TO_BOOLEAN_bool for BooleanFunctions::ToBoolean;
   

    // ==========================================
    // Sequence/Collection Aliases
    // ==========================================
    alias EQ_seq for SequenceFunctions::equals;
    alias SIZE_seq for SequenceFunctions::size;
    alias IS_EMPTY_seq for SequenceFunctions::isEmpty;
    alias INDEX_seq for SequenceFunctions::'#';
    alias INCLUDING_seq for SequenceFunctions::including;
    alias EXCLUDING_seq for SequenceFunctions::excluding;
    alias INCLUDING_AT_seq for SequenceFunctions::includingAt;
    alias EXCLUDING_AT_seq for SequenceFunctions::excludingAt;


    attribute def TwinCustomType{
        attribute fields[0..*] : TwinAttribute;
    }
}