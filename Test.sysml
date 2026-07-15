package Test {

    private import PhysicalTwinLibrary::*;
    private import TwinStateMachineLibrary::*;
    private import TwinDataTypeLibrary::*;
  
  

    attribute def Position:>CustomAttribute_{
        attribute x:TwinAttributeInteger;
        attribute y:TwinAttributeInteger;
        attribute z:TwinAttributeInteger;
        

    }

    attribute def PositionList:>CustomAttributeList_{
        :>> elements : Position;
    }

    attribute def AddPosition:>Position{
        in attribute l:Position;
        in attribute r:Position;
        :>> x : NumericCalc {
            :> left = l.x;
            :> right = r.x;
            :> operator = ArithmeticOperator::ADD;
        }
        :>> y : NumericCalc {
            :> left = l.y;
            :> right = r.y;
            :> operator = ArithmeticOperator::ADD;
        }
        :>> z : NumericCalc {
            :> left = l.z;
            :> right = r.z;
            :> operator = ArithmeticOperator::ADD;
        }
    }

    
    part def Battery:>PhysicalTwin{
        port p11:>sensors{
            attribute temp:TwinAttributeReal:>measurements;
            attribute voltage:TwinAttributeReal:>measurements;
            attribute positionList:PositionList:>measurements;
            attribute position2:Position:>measurements;
            attribute position3:Position:>measurements;
            attribute position4:AddPosition:>measurements{
                :>l = position2;
                :>r = position3;
            }

        }
        port coolingSystem:>actuators{
            attribute fanSpeed:TwinAttributeInteger:>commands;
            attribute coolantFlow:TwinAttributeReal:>commands;
        }

        port chargingSystem[2]:>actuators{
            attribute chargeCurrent:TwinAttributeReal:>commands;
            attribute chargeVoltage:TwinAttributeReal:>commands;
        }

        port chargingSystem1:>chargingSystem{
        }
        port chargingSystem2:>chargingSystem{
        }
        

        attribute batteryID:TwinAttributeString:>constAttributes{
            :>value = "BATTERY_001";
        }
        attribute batteryCapacity:TwinAttributeReal:>constAttributes{
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

            connection t1:>transitions{
                end :>>fromState ::> idle;
                end :>>toState ::> charge;

                part guard1:>guardCondition_{
                    :>triggerCondition_:ComparisonCalc{
                        :>left = p11.temp;
                        :>right{
                            :>>value = 30.0;
                        }
                        :>operator = ComparisonOperator::GREATER_THAN;
                    }
                }
            }
            connection t2:>transitions{
                end :>>fromState ::> charge;
                end :>>toState ::> state2;
            }
        }

    }
}