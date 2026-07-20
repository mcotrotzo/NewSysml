package PositionLibrary{

    private import TwinTypeSystem::*;
    private import TwinImp::*;
    attribute def Position:>TwinAttribute{
        attribute x:TwinReal;
        attribute y:TwinReal;
        attribute z:TwinReal;
    }

    calc def AddPosition:>CustomCalculationAction{
        in attribute pos_a:>>inputs:Position;
        in attribute pos_b:>>inputs:Position;
        return pos_c:>>outputs:Position;
        assign pos_c := new Position(x = PLUS_real(pos_a.x, pos_b.x), y = PLUS_real(pos_a.y, pos_b.y), z = PLUS_real(pos_a.z, pos_b.z));
    }

    calc def CrossProduct:>CustomCalculationAction{
        in attribute pos_a:>>inputs:Position;
        in attribute pos_b:>>inputs:Position;
        return pos_c:>>outputs:Position;
        assign pos_c := new Position(x = MINUS_real(MULT_real(pos_a.y, pos_b.z), MULT_real(pos_a.z, pos_b.y)), y = MINUS_real(MULT_real(pos_a.z, pos_b.x), MULT_real(pos_a.x, pos_b.z)), z = MINUS_real(MULT_real(pos_a.x, pos_b.y), MULT_real(pos_a.y, pos_b.x)));
    }
}