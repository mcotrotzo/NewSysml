package Test{

    private import TwinLibrary::*;
    private import PhysicalTwinLibrary::*;
    
    
    state def ControlUnit{
        in attribute temp:TwinReal = battery.physical.p11.temp;    
    }

     part battery:Twin{

          part physical :>>physicalTwin{
            port p11:Sensor:>sensors{
                attribute temp:TwinReal :>measurements;

            }

            state cm1:>controlUnit{
                
            }

           
        }

        part :>>shadow{
            part db1:KeyValueDatabase:>databases{
                attribute :>>durationInDays = 30;
            }
        }


    }
    

    part pv:Twin{
        part :>>physicalTwin{
            port p21:>sensors{
                attribute temp:TwinReal :>measurements;

            }

            state cm2:>controlUnit{
                attribute temp2[1]:TwinReal:>local_Attributes = battery.physical.p11.temp;
            }
        }



        part :>>shadow{
            part db2:KeyValueDatabase:>databases{
                attribute :>>durationInDays = 30;
            }
        }
    }

    
}