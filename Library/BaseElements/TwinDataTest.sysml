package Test2{
    private import TwinTypeSystem::*;
    private import TwinImp::*;
    attribute def Position:>TwinCustomType{
        attribute x:>fields:TwinReal;
        attribute y:>fields:TwinReal;
        attribute z:>fields:TwinReal;
    }

    attribute def Entry:>TwinCustomType{
        attribute key:>fields:TwinString;
        attribute value:>fields:TwinAttribute;
    }

    attribute def Map:>TwinCustomType{
        attribute entries[0..*]:>fields:Entry;
    }

    
    calc def GetByKey:>CustomCalculationAction{
        in attribute map:>>inputs:Map;
        in attribute key:>>inputs:TwinString;
        return value:>>outputs:TwinAttribute;
        
        for entry_:Entry in map.entries {
          
            if EQ_str(entry_.key, key) {
                assign value := entry_.value;
            }
        }
    }

    calc def putKeyValue:>CustomCalculationAction{
        in attribute map:>>inputs:Map;
        in attribute key:>>inputs:TwinString;
        in attribute value:>>inputs:TwinAttribute;
        return newMap:>>outputs:Map;
    

        attribute newEntry:>local_Attributes:Entry;
        assign newEntry := new Entry(key = key, value = value);
        then assign newMap := new Map(entries = INCLUDING_seq(map.entries, newEntry));
        new Map(entries = INCLUDING_seq(map.entries, newEntry))
    }

    calc def EQ_Position:>CustomCalculationAction{
        in attribute pos_a:>>inputs:Position;
        in attribute pos_b:>>inputs:Position;
        return isEq:TwinBoolean:>>outputs = AND_bool(EQ_real(pos_a.x, pos_b.x), AND_bool(EQ_real(pos_a.y, pos_b.y), EQ_real(pos_a.z, pos_b.z)));  
    }

   

    part def TwinSensor{
        attribute temperature : TwinAttribute;
        attribute position[4] : Position;
    }

    part def P11:>TwinSensor{
        attribute :>>temperature : TwinReal = PLUS_real(1.0, 2);
        attribute pos1:>position;
        attribute eqa:TwinBoolean = EQ_Position(pos_a = pos1, pos_b = pos2);
        attribute pos2:>position;
        attribute pos3:>position;
        attribute pos4:>position;
        attribute pos5:>position; /*<- this will lead to an error in my new rtool*/

       
    }



}