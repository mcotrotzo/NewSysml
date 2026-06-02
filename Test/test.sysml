package Test {
    private import MetaLibrary::*;
    

    #DigitalTwin gg{
        #twin Battery{
            #sensor p11{
                #measureAttribute temperature:ScalarValues::Real;
                #measureAttribute power:ScalarValues::Real;
            }
            #actuator coolingSystem {
                #commandAttribute reduceTemperature:ScalarValues::Real;
                #commandAttribute increasePower:ScalarValues::Real;
            }

            #constAttribute maxCapacity = 100.0;
        }
        #shadow shadow1{
            #relationalDatabase db1;
            #relationalDatabase db2;
            #keyValueDatabase kvdb1;
            #dbconnection connect db1.data_out to db2.data_out;
           
        }
        
        

    
    }
}


/*
   #twin Battery {
        #sensor p11{
            #measureAttribute temperature:ScalarValues::Real;
            #measureAttribute power:ScalarValues::Real;
        }
        #actuator coolingSystem {
            #commandAttribute reduceTemperature:ScalarValues::Real;
            #commandAttribute increasePower:ScalarValues::Real;
        }

        #constAttribute maxCapacity = 100.0;
    
    }
    }

    #Shadow shadow{

    }*/