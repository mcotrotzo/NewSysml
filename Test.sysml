package Test {

    private import PhysicalTwinLibrary::*;
    private import TwinStateMachineLibrary::*;
    private import TwinDataTypeLibrary::*;
    private import ShadowLibrary::*;
    private import DescriptiveModelLibrary::*;
    private import PredicitiveLibrary::*;
    private import PrescriptiveModelLibrary::*;


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
        
        :>> x = new IntegerCalc(left = l.x, right = r.x, operator = ArithmeticOperator::ADD);
        :>> y = new IntegerCalc(left = l.y, right = r.y, operator = ArithmeticOperator::ADD);
        :>> z = new IntegerCalc(left = l.z, right = r.z, operator = ArithmeticOperator::ADD);
    }

    attribute def IsGreaterPosition :> LogicalCalc {
        in attribute posx : Position;
        in attribute posy : Position;
        in attribute posz : Position;
        
        in attribute :>> operator = LogicalOperator::AND;

        in :>> left = new LogicalCalc(
            operator = LogicalOperator::AND,
            left = new ComparisonCalc(left = posx.x, right = posy.x, operator = ComparisonOperator::GREATER_THAN),
            right = new ComparisonCalc(left = posx.y, right = new AddPosition(l=posx, r=posy).y, operator = ComparisonOperator::GREATER_THAN)
        );

        in :>> right = new ComparisonCalc(left = posx.z, right = posy.z, operator = ComparisonOperator::GREATER_THAN);
    }

    part def Battery:>PhysicalTwin{
        port p11:>sensors{
            attribute temp:TwinAttributeReal:>measurements;
            attribute voltage:TwinAttributeReal:>measurements;
            attribute positionList:PositionList:>measurements;
            attribute position2:Position:>measurements;
            attribute position3:Position:>measurements;
            
            attribute position4:Position:>measurements = new AddPosition(
                l = new Position(x = new TwinAttributeInteger(value = 1), y = new TwinAttributeInteger(value = 2), z = new TwinAttributeInteger(value = 3)),
                r = new Position(x = new TwinAttributeInteger(value = 4), y = new TwinAttributeInteger(value = 5), z = new TwinAttributeInteger(value = 6))
            );
        }
        
        port coolingSystem:>actuators{
            attribute fanSpeed:TwinAttributeInteger:>commands;
            attribute coolantFlow:TwinAttributeReal:>commands;
        }

        port chargingSystem[2]:>actuators{
            attribute chargeCurrent:TwinAttributeReal:>commands;
            attribute chargeVoltage:TwinAttributeReal:>commands;
        }

        port chargingSystem1:>chargingSystem{}
        port chargingSystem2:>chargingSystem{}
        

        attribute batteryID:TwinAttributeString:>constAttributes = new TwinAttributeString(value = "BATTERY_001");
        attribute batteryCapacity:TwinAttributeReal:>constAttributes = new TwinAttributeReal(value = 100.0);
        

        attribute batteryPosition:Position:>constAttributes = new Position(x = new TwinAttributeInteger(value = 0), y = new TwinAttributeInteger(value = 0), z = new TwinAttributeInteger(value = 0));

        part cm1:>controlUnit{
            part charge :>states{
                
                assign1:>assignActions_ = new ASSIGN(target = batteryPosition, source = new Position(x = new TwinAttributeInteger(value = 100), y = new TwinAttributeInteger(value = 200), z = new TwinAttributeInteger(value = 300)));
            }

            part idle :>states{}
            part state2 :>states{}

            connection t1:>transitions{
                end :>>fromState ::> idle;
                end :>>toState ::> charge;

                part guard1:>guardCondition_{
                    :>> triggerCondition_ = new IsGreaterPosition(
                        posx = batteryPosition,
                        posy = batteryPosition,
                        posz = batteryPosition
                    );
                }
            }
            connection t2:>transitions{
                end :>>fromState ::> charge;
                end :>>toState ::> state2;
            }
        }
    }

    part def Shadow1:>ShadowLibrary::Shadow{
        part db1:>databases:RelationalDatabase{
            :>> durationInDays = 2;
        }
        part db2:>databases:RelationalDatabase{
            :>> durationInDays = 10;
        }
    }

    part def DescriptiveModel1:>DescriptiveModel{
        attribute temp30:TwinAttributeReal :>queries_ = new SingleNumberQuery(
            twinAttribute_ = Battery::p11.temp,
            selector = ValueSelector::LAST,
            since = 10,
            since_unit = TimeUnit::SECONDS,
            order_by = ORDER_BY::DESCENDING,
            limit = 30,
            filter_expressions = new ComparisonCalc(left = Battery::p11.temp));


        cm2:>descriptiveStateMachine_{
            localTemp:TwinAttributeReal :>local_Attributes;
            part state1:>states{
                assign1:>assignActions_ = new ASSIGN(target=localTemp, source = new Position(x = new TwinAttributeInteger(value = 10), y = new TwinAttributeInteger(value = 20), z = new TwinAttributeInteger(value = 30)));
            }
            part state2:>states{
            }

            connection t1:>transitions{
                end :>>fromState ::> state1;
                end :>>toState ::> state2;

                part guard1:>guardCondition_{
                    :>> triggerCondition_ = new ComparisonCalc(
                        left = temp30,
                        right = temp30
                    );
                }
            }
        }

    }

    part def P1:>PredictiveModel{
        s1:>strategies{
            temp :>inputAttributes = DescriptiveModel1::temp30;
            cm2State:>inputAttributes = DescriptiveModel1::cm2.currentState;
            :>lambdaPath = "path/to/lambda/function";
            tempPredicition:>outputAttributes;
        }

    }

    part def PrescriptiveModel1:>PrescriptiveModel{
        :>strategies:CustomPrescriptiveStrategy{
            :>>condition_ = new ComparisonCalc(
                left = DescriptiveModel1::temp30,
                right = new TwinAttributeReal(value = 50.0)
            );
            tempPrediction :>inputAttributes = P1::s1.tempPredicition;
            cm2State:>inputAttributes = DescriptiveModel1::cm2.currentState;
            :>lambdaPath = "path/to/lambda/function";
        }
        :>strategies:SendToActuatorStrategy{
            :>>condition_ = new ComparisonCalc(
                left = DescriptiveModel1::temp30,
                right = new TwinAttributeReal(value = 50.0)
            );
            :>actuatorTarget = Battery::coolingSystem.fanSpeed;
            :>commandValue = new TwinAttributeInteger(value = 100);
            
        }
    }


}
