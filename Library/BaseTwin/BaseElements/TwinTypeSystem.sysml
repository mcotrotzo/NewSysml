library package TwinTypeSystem {

    
    private import ScalarValues::*;
    
    private import IntegerFunctions::*;
    private import RealFunctions::*;
    private import StringFunctions::*;
    private import BooleanFunctions::*;
    private import DataFunctions::*;
    private import NumericalFunctions::*;
    private import CollectionFunctions::*;
    private import BaseFunctions::*;
   
    private import SequenceFunctions::equals;
    private import SequenceFunctions::size;
    private import SequenceFunctions::isEmpty;
    private import SequenceFunctions::'#';
    private import SequenceFunctions::add;
    private import SequenceFunctions::remove;
    private import SequenceFunctions::addAt;
    private import SequenceFunctions::removeAt;

    // ==========================================
    // Type Aliases
    // ==========================================
    
    public alias TwinAttribute for Base::DataValue;
    public alias TwinScalar for ScalarValues::ScalarValue;
    public alias TwinReal for Real;
    public alias TwinInteger for Integer;
    public alias TwinString for String;
    public alias TwinBoolean for Boolean;




    // ==========================================
    // IntegerFunctions Aliases
    // ==========================================
    public alias PLUS_int for IntegerFunctions::'+';
    public alias MINUS_int for IntegerFunctions::'-';
    public alias MULT_int for IntegerFunctions::'*';
    public alias DIV_int for IntegerFunctions::'/';
    public alias POW_int for IntegerFunctions::'**';
    public alias CARET_int for IntegerFunctions::'^';
    public alias MOD_int for IntegerFunctions::'%';
    
    public alias LT_int for IntegerFunctions::'<';
    public alias GT_int for IntegerFunctions::'>';
    public alias LE_int for IntegerFunctions::'<=';
    public alias GE_int for IntegerFunctions::'>=';
    public alias EQ_int for IntegerFunctions::'==';
    
    public alias ABS_int for IntegerFunctions::abs;
    public alias MAX_int for IntegerFunctions::max;
    public alias MIN_int for IntegerFunctions::min;
    public alias RANGE_int for IntegerFunctions::'..';
    
    public alias TO_STRING_int for IntegerFunctions::ToString;
    public alias TO_NATURAL_int for IntegerFunctions::ToNatural;
    public alias TO_INTEGER_int for IntegerFunctions::ToInteger;
    public alias SUM_int for IntegerFunctions::sum;
    public alias PRODUCT_int for IntegerFunctions::product;

    // ==========================================
    // RealFunctions Aliases
    // ==========================================
    public alias PLUS_real for RealFunctions::'+';
    public alias MINUS_real for RealFunctions::'-';
    public alias MULT_real for RealFunctions::'*';
    public alias DIV_real for RealFunctions::'/';
    public alias POW_real for RealFunctions::'**';
    public alias CARET_real for RealFunctions::'^';
    
    public alias LT_real for RealFunctions::'<';
    public alias GT_real for RealFunctions::'>';
    public alias LE_real for RealFunctions::'<=';
    public alias GE_real for RealFunctions::'>=';
    public alias EQ_real for RealFunctions::'==';
    
    public alias RE_real for RealFunctions::re;
    public alias IM_real for RealFunctions::im;
    public alias ABS_real for RealFunctions::abs;
    public alias ARG_real for RealFunctions::arg;
    public alias MAX_real for RealFunctions::max;
    public alias MIN_real for RealFunctions::min;
    public alias SQRT_real for RealFunctions::sqrt;
    public alias FLOOR_real for RealFunctions::floor;
    public alias ROUND_real for RealFunctions::round;
    
    public alias TO_STRING_real for RealFunctions::ToString;
    public alias TO_INTEGER_real for RealFunctions::ToInteger;
    public alias TO_RATIONAL_real for RealFunctions::ToRational;
    public alias TO_REAL_real for RealFunctions::ToReal;
    public alias SUM_real for RealFunctions::sum;
    public alias PRODUCT_real for RealFunctions::product;

    // ==========================================
    // StringFunctions Aliases
    // ==========================================
    public alias PLUS_str for StringFunctions::'+';
    public alias LENGTH_str for StringFunctions::Length;
    public alias SUBSTRING_str for StringFunctions::Substring;
    
    public alias LT_str for StringFunctions::'<';
    public alias GT_str for StringFunctions::'>';
    public alias LE_str for StringFunctions::'<=';
    public alias GE_str for StringFunctions::'>=';
    public alias EQ_str for StringFunctions::'==';
    public alias TO_STRING_str for StringFunctions::ToString;

    // ==========================================
    // BoolFunctions Aliases
    // ==========================================
    public alias AND_bool for BooleanFunctions::'&';
    public alias OR_bool for BooleanFunctions::'|';
    public alias NOT_bool for BooleanFunctions::'not';
    public alias EQ_bool for BooleanFunctions::'==';
    public alias TO_STRING_bool for BooleanFunctions::ToString;
    public alias TO_BOOLEAN_bool for BooleanFunctions::ToBoolean;
   

    // ==========================================
    // Sequence/Collection Aliases
    // ==========================================
    public alias EQ_seq for SequenceFunctions::equals;
    public alias SIZE_seq for SequenceFunctions::size;
    public alias IS_EMPTY_seq for SequenceFunctions::isEmpty;
    public alias INDEX_seq for SequenceFunctions::'#';
    public alias INCLUDING_seq for SequenceFunctions::including;
    public alias EXCLUDING_seq for SequenceFunctions::excluding;
    public alias INCLUDING_AT_seq for SequenceFunctions::includingAt;
    public alias EXCLUDING_AT_seq for SequenceFunctions::excludingAt;


    attribute def TwinSuperAttribute{
        attribute value:Base::DataValue;
    }

    attribute test1:TwinSuperAttribute{
        attribute:>>value:Real = 1.0;
    }
    attribute test2:TwinSuperAttribute{
        attribute:>>value:Boolean = true;
    }


    attribute testEval:TwinSuperAttribute = Plus_Real(test1,test1);
    
    attribute testEval2:TwinSuperAttribute = Plus_Real(test1,test1);
    calc def Plus_Real{
        in attribute a:TwinSuperAttribute[1];
        in attribute b:TwinSuperAttribute[1];
        assert constraint {
            return result = a.value istype Real & b.value istype Real;
        }
        return result:TwinSuperAttribute{
            attribute:>>value:Real = PLUS_real(a.value as Real,b.value as Real);
        }
    }

}