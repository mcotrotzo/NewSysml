package PositionThings{
    private import UserLibrary::*;
    private import BatteryControlUnitLibrary::*;

    attribute def Position :> TwinCustomType{
        attribute x[1] : TwinInteger :>fields;
        attribute y[1] : TwinInteger :>fields;
        attribute z[1] : TwinInteger :>fields;
    }

    calc def AddPosition:>CustomCalculationAction{
        in attribute pos_a[1]:>>inputs:Position;
        in attribute pos_b[1]:>>inputs:Position;
        return pos_c[1]:>>outputs:Position;
        assign pos_c := new Position(x = PLUS_int(pos_a.x, pos_b.x), y = PLUS_int(pos_a.y, pos_b.y), z = PLUS_int(pos_a.z, pos_b.z));
    }

    calc def QueryPosition:>QueryHistory{
        in attribute position:>>twinAttribute:Position;
        in attribute since[0..1]:>>since;
        in attribute sinceUnit[0..1]:>>sinceUnit;
        in attribute orderBy[0..1]:>>orderBy;
        in attribute limit[0..1]:>>limit;
        in attribute filterExpression[0..1]:>>filterExpression;
        return attribute result:>>result:Position;
    }

    part def Battery:>PhysicalTwin{
        port p11:>sensors{
            attribute pos :>>measurements:Position;
            attribute temp :>>measurements:TwinReal;
        }

        state coolingSystem:>controlUnit:BatteryControlUnit{
            attribute :>>temp = p11.temp;           
        }
    }
    
    part def PV:>PhysicalTwin{
        port p12:>sensors{
            attribute temp :>>measurements:TwinReal;
        }
    }




}