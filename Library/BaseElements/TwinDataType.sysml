library package TwinDataTypeLibrary {

    private import ScalarValues::*;
    private import ScalarFunctions::*;

    abstract attribute def TwinAttribute {
        attribute value : ScalarValues::ScalarValue;
    }

    abstract attribute def TwinNumber :> TwinAttribute {
        attribute :>> value : ScalarValues::NumericalValue;
    }

    attribute def TwinInteger :> TwinNumber {
        attribute :>> value : ScalarValues::Integer;
    }
    attribute def TwinReal :> TwinNumber {
        attribute :>> value : ScalarValues::Real;
    }
    attribute def TwinBoolean :> TwinAttribute {
        attribute :>> value : ScalarValues::Boolean;
    }
    attribute def TwinString :> TwinAttribute {
        attribute :>> value : ScalarValues::String;
    }

    abstract calc def TwinCalcs;

    calc def PLUS_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinInteger; new TwinInteger(value = x.value + y.value) }
    calc def MINUS_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinInteger; new TwinInteger(value = x.value - y.value) }
    calc def MULTIPLY_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinInteger; new TwinInteger(value = x.value * y.value) }
    calc def DIVIDE_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinInteger; CAST_TO_INT(new TwinReal(value = x.value / y.value))}

    calc def PLUS_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinReal; new TwinReal(value = x.value + y.value) }
    calc def MINUS_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinReal; new TwinReal(value = x.value - y.value) }
    calc def MULTIPLY_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinReal; new TwinReal(value = x.value * y.value) }
    calc def DIVIDE_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinReal; new TwinReal(value = x.value / y.value) }

    calc def NEGATE_INT:>TwinCalcs { in x: TwinInteger; return result: TwinInteger; new TwinInteger(value = -x.value) }
    calc def NEGATE_REAL:>TwinCalcs { in x: TwinReal; return result: TwinReal; new TwinReal(value = -x.value) }

    calc def EQUAL_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinBoolean; new TwinBoolean(value = x.value == y.value) }
    calc def NOT_EQUAL_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinBoolean; new TwinBoolean(value = x.value != y.value) }
    calc def LESS_THAN_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinBoolean; new TwinBoolean(value = x.value < y.value) }
    calc def GREATER_THAN_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinBoolean; new TwinBoolean(value = x.value > y.value) }
    calc def LESS_THAN_EQUAL_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinBoolean; new TwinBoolean(value = x.value <= y.value) }
    calc def GREATER_THAN_EQUAL_INT:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinBoolean; new TwinBoolean(value = x.value >= y.value) }

    calc def EQUAL_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinBoolean; new TwinBoolean(value = x.value == y.value) }
    calc def NOT_EQUAL_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinBoolean; new TwinBoolean(value = x.value != y.value) }
    calc def LESS_THAN_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinBoolean; new TwinBoolean(value = x.value < y.value) }
    calc def GREATER_THAN_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinBoolean; new TwinBoolean(value = x.value > y.value) }
    calc def LESS_THAN_EQUAL_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinBoolean; new TwinBoolean(value = x.value <= y.value) }
    calc def GREATER_THAN_EQUAL_REAL:>TwinCalcs { in x: TwinReal; in y: TwinReal; return result: TwinBoolean; new TwinBoolean(value = x.value >= y.value) }

    calc def MOD:>TwinCalcs { in x: TwinInteger; in y: TwinInteger; return result: TwinInteger; new TwinInteger(value = x.value % y.value) }
    calc def INC:>TwinCalcs { in x: TwinInteger; return result: TwinInteger; new TwinInteger(value = x.value + 1) }
    calc def DEC:>TwinCalcs { in x: TwinInteger; return result: TwinInteger; new TwinInteger(value = x.value - 1) }

    calc def AND:>TwinCalcs { in x: TwinBoolean; in y: TwinBoolean; return result: TwinBoolean; new TwinBoolean(value = x.value and y.value) }
    calc def OR:>TwinCalcs { in x: TwinBoolean; in y: TwinBoolean; return result: TwinBoolean; new TwinBoolean(value = x.value or y.value) }
    calc def NOT:>TwinCalcs { in x: TwinBoolean; return result: TwinBoolean; new TwinBoolean(value = not x.value) }

    calc def STRING_CONCAT:>TwinCalcs { in x: TwinString; in y: TwinString; return result: TwinString; new TwinString(value = x.value + y.value) }
    calc def STRING_EQUAL:>TwinCalcs { in x: TwinString; in y: TwinString; return result: TwinBoolean; new TwinBoolean(value = x.value == y.value) }
    calc def STRING_NOT_EQUAL:>TwinCalcs { in x: TwinString; in y: TwinString; return result: TwinBoolean; new TwinBoolean(value = x.value != y.value) }
    calc def STRING_LESS_THAN:>TwinCalcs { in x: TwinString; in y: TwinString; return result: TwinBoolean; new TwinBoolean(value = x.value < y.value) }
    calc def STRING_GREATER_THAN:>TwinCalcs { in x: TwinString; in y: TwinString; return result: TwinBoolean; new TwinBoolean(value = x.value > y.value) }

    calc def CAST_TO_INT:>TwinCalcs { in x: TwinReal; return result: TwinInteger; new TwinInteger(value = x.value as ScalarValues::Integer) }
    calc def CAST_TO_REAL:>TwinCalcs { in x: TwinInteger; return result: TwinReal; new TwinReal(value = x.value as ScalarValues::Real) }
    calc def CAST_NUMBER_TO_BOOL:>TwinCalcs { in x: TwinNumber; return result: TwinBoolean; new TwinBoolean(value = x.value != 0) }
    calc def CAST_STRING_TO_BOOL:>TwinCalcs { in x: TwinString; return result: TwinBoolean; new TwinBoolean(value = x.value == "true" or x.value == "TRUE") }

    action def GET_AT { in ref array: TwinAttribute[0..*] ordered; in index: TwinInteger; out result: TwinAttribute; }
    action def SET_AT { inout ref array: TwinAttribute[0..*] ordered; in index: TwinInteger; in value: TwinAttribute; }
    action def APPEND  { inout ref array: TwinAttribute[0..*] ordered; in value: TwinAttribute; }
    action def LENGTH  { in array: TwinAttribute[0..*] ordered; out result: TwinInteger; }

    
    public abstract action def STATEMENT;

    public action def ASSIGN :> STATEMENT { 
        inout ref target: TwinAttribute; 
        in source: TwinAttribute; 
        assign target := source; 
    }

    public action def SEQ :> STATEMENT { 
        action cs: STATEMENT[1..*]; 
    }

    public action def LOCAL_VAR :> STATEMENT {
        attribute variable: TwinAttribute[1];
    }

    public action def WHILE_LOOP :> STATEMENT {
        in condition: TwinBoolean;
        action body: STATEMENT;
    }

    public action def IF_ELSE :> STATEMENT {
        in condition: TwinBoolean;
        action thenBlock: STATEMENT;
        action elseBlock: STATEMENT;
    }

}
