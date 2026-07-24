package Test{

    private import TwinLibrary::*;
    private import PositionThings::*;
    private import BatteryControlUnitLibrary::*;
    private import TwinTypeSystem::TwinReal;
    private import TwinTypeSystem::*;
    private import UserLibrary::*;
    private import BatteryControlUnitLibrary::*;
    attribute def Position:>TwinCustomType{
        attribute x[1]:TwinInteger:>fields;
        attribute y[1]:TwinInteger:>fields;
        attribute z[1]:TwinInteger:>fields;
    }

    calc def AddPosition:>CustomCalculationAction{
        in attribute pos_a[1]:>>inputs:Position;
        in attribute pos_b[1]:>>inputs:Position;
        return pos_c[1]:>>outputs:Position;
        assign pos_c := new Position(x = PLUS_int(pos_a.x, pos_b.x), y = PLUS_int(pos_a.y, pos_b.y), z = PLUS_int(pos_a.z, pos_b.z));
        
    }

    calc def Avg:>CustomCalculationAction{
        in attribute reals[0..*]:TwinReal:>>inputs;
        return out attribute avg:TwinReal:>>outputs;
        

        for value:TwinReal in reals{
            assign avg := PLUS_real(avg, value);
        }
        assign avg := DIV_real(avg, SIZE_seq(reals));
    }

    part def Battery :> Twin {

        port p11 :> sensors {
            attribute temp    : TwinReal    :> measurements;
            attribute voltage : TwinReal    :> measurements;
            attribute current : TwinReal    :> measurements;
            attribute plug    : TwinBoolean :> measurements;
            attribute pos     : Position    :> measurements;
        }

        port p12 :> actuators {
            attribute charge : TwinReal :> commands;
        }

        attribute maxCharge        : TwinReal :> constAttributes = 100;
        attribute nominalVoltage   : TwinReal :> constAttributes = 48;
        attribute defaultNetDemand : TwinReal :> constAttributes = 0;

        state cm1 :> controlUnit {
            attribute current   :> sensorAttributes   = p11.current;
            attribute plug:TwinBoolean      :> sensorAttributes   = p11.plug;
            attribute charge    :> actuatorAttributes = p12.charge;
            attribute maxCharge :> constAttributes    = maxCharge;

            state idle;
            state charging {
                do assign charge := 100;
            }
            entry; then idle;
            transition
            first idle
            if plug
            then charging;

            
            transition
            first idle
            if NOT_bool(plug)
            then idle;

            
            transition
            first charging
            if NOT_bool(plug)
            then idle;

            
        }


        attribute soc : TwinReal :> derivedAttributes =
            MULT_real(DIV_real(p11.voltage, nominalVoltage), 100);
        
        calc temp30  :>>query{
            in attribute :>>twinAttribute = p11.temp;
            in attribute :>>since = 30;
            in attribute :>>sinceUnit = TimeUnit::HOUR;
            return attribute :>>result:TwinReal[30];

        }
        attribute avgTemp : TwinReal :> derivedAttributes = Avg(temp30.result);
    

        part consForecast :> predictiveStrategies {
            in attribute :>> lambdaPath = "battery/consForecast";
            in attribute avgTemperature :> inputs default avgTemp;
            in attribute current :> inputs default p11.current;
            in attribute TESTTEST;
            attribute predicted : TwinReal :> outputs;
        }

        
            part chargeStrategy :> prescriptiveStrategies {
                in attribute :>> lambdaPath default "battery/chargeStrategy";
            
                attribute :>> condition_ default LT_real(consForecast.predicted, maxCharge);
                attribute chargeCmd : TwinReal :> outputs = p12.charge;
            }

        

        
    }

    

    part def Charger:>Twin{



    }

}