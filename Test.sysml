package Test {

    private import PhysicalTwinLibrary::*;
    private import TwinStateMachineLibrary::*;
    private import TwinDataTypeLibrary::*;
    private import CustomLibrary::*;
  

    attribute def Position:>CustomAttribute{
        attribute x:TwinInteger:>members;
        attribute y:TwinInteger:>members;
        attribute z:TwinInteger:>members;
        attribute test:ScalarValues::Integer;
    }

    action def GreaterPosition :> TransitionGuardFunction {
        attribute posx : Position :> inputs;
        attribute posy : Position :> inputs;
        attribute isGreater : TwinBoolean :> bOutput;

        :>> body : SEQ {
            step1 :> cs : LOCAL_VAR { attribute x_greater : TwinBoolean { :>> value = false; } }
            step2 :> cs : LOCAL_VAR { attribute y_greater : TwinBoolean { :>> value = false; } }
            step3 :> cs : LOCAL_VAR { attribute z_greater : TwinBoolean { :>> value = false; } }
            step4 :> cs : LOCAL_VAR { attribute xy_or : TwinBoolean; }

            step5 :> cs : ASSIGN {
                :> target = step1.x_greater;
                :> source = GREATER_THAN_INT(posx.x, posy.x);
            }
            step6 :> cs : ASSIGN {
                :> target = step2.y_greater;
                :> source = GREATER_THAN_INT(posx.y, posy.y);
            }
            step7 :> cs : ASSIGN {
                :> target = step3.z_greater;
                :> source = GREATER_THAN_INT(posx.z, posy.z);
            }

            step8 :> cs : ASSIGN {
                :> target = step4.xy_or;
                :> source = OR(step1.x_greater, step2.y_greater);
            }

            step9 :> cs : ASSIGN {
                :> target = isGreater;
                :> source = OR(step4.xy_or, step3.z_greater);
            }
        }
    }
    
    part def Battery:>PhysicalTwin{
        port p11:>sensors{
            attribute temp:TwinReal:>measurements;
            attribute voltage:TwinReal:>measurements;

        }
        port coolingSystem:>actuators{
            attribute fanSpeed:TwinInteger:>commands;
            attribute coolantFlow:TwinReal:>commands;
        }

        port chargingSystem[2]:>actuators{
            attribute chargeCurrent:TwinReal:>commands;
            attribute chargeVoltage:TwinReal:>commands;
        }

        port chargingSystem1:>chargingSystem{
        }
        port chargingSystem2:>chargingSystem{
        }
        

        attribute batteryID:TwinString:>constAttributes{
            :>value = "BATTERY_001";
        }
        attribute batteryCapacity:TwinReal:>constAttributes{
            :>value = 100.0;
        }

        attribute batteryPosition:Position:>constAttributes{
            :>x.value = 10;
            :>y.value = 20;
            :>z.value = 30;
        }

        part cm1:>controlUnit{
            part charge :>states{
                assign1:>assignActions_{
                    :>target = chargingSystem1.chargeCurrent;
                    :>source{
                        :>>value = 50.0;
                    }
                }
            }

            part idle :>states{
                
            }

            part state2 :>states{
                
            }

            flow t1:>transitions{
                end :>>fromState ::> idle;
                end :>>toState ::> charge;

                part guard1:>guardCondition_{
                    :>statements:GreaterPosition{
                        :>posx = batteryPosition;
                        :>posy {
                            :>x.value = 5;
                            :>y.value = 15;
                            :>z.value = 25;
                        }
                    }
                }
            }
            flow t2:>transitions{
                end :>>fromState ::> charge;
                end :>>toState ::> state2;
            }
        }

    }
}