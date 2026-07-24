library package FederationSysml{

    private import TwinDefLibrary::*;
    private import Test::*;
    private import TwinTypeSystem::*;


    part def FedTwin:>CloudTwin{
        part twins[0..*] : Twin;

        part fedSubTwin[0..*] : FedTwin;
    }
    part def Federation{
        part twins[0..*] : Twin;
        part fedSubTwin[0..*] : FedTwin;
        
       
    }
    calc def FedBinding_PULL {
        in attribute attr : TwinAttribute;
        return result : TwinAttribute = attr;
    }

    calc def FedBinding_PUSH :> FedBinding_PULL { }
    calc def FedBinding_PUB_SUB :> FedBinding_PULL { }
    calc def FedBinding_SharedMemory :> FedBinding_PULL { }


    part def Fes:>Federation{
        part battery1:Battery:>twins;
        part battery2:Battery:>twins;


        part Coffec:>fedSubTwin{

            attribute maxCharge:>derivedAttributes : TwinReal = 50;

            attribute socMicroGrid:>derivedAttributes : TwinReal = 50;

            part battery1:Battery subsets battery1{
                part awareStrategy redefines chargeStrategy{
                    :>> condition_ = LT_real(FedBinding_PULL(battery2.soc), FedBinding_PUSH(maxCharge))
                    
                }

                part test :>consForecast{
                    in :>>soc = FedBinding_PUSH(socMicroGrid);
                    in :>>TESTTEST = FedBinding_PULL(battery2.soc);
                }   
            }
            part battery2:Battery :> battery2;

            part mGridStrategy :>predictiveStrategies{
                attribute soc:TwinReal:>inputs;
                atttribute :>>lambdaPath default "battery/mGridStrategy";
            }

            attribute socMax:>derivedAttributes : TwinReal = 50;
    
            
        }
        part MicroGrid2:>fedSubTwin{
            attribute maxCharge:>derivedAttributes : TwinReal = 50;

            part battery1:Battery :> battery1{
                part awareStrategy redefines chargeStrategy{
                    :>> condition_ = LT_real(FedBinding_PULL(battery2.soc), FedBinding_PUSH(maxCharge));
                }
            }
            part battery2:Battery :> battery2;
        }
    }
}