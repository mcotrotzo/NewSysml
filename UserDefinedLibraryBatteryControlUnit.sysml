package BatteryControlUnitLibrary{
    private import UserLibrary::*;

    
    calc def All:>CustomCalculationAction{
        in attribute bools[0..*]:TwinBoolean:>>inputs;
        return out attribute alltrue:TwinBoolean:>>outputs;

        for value:TwinBoolean in bools{
            assign alltrue := alltrue & value;
        }
    }

}