package Test {
    private import SystemMeta::*;
    private import TwinDataTypeLibrary::*;
    private import TwinStateMachineLibrary::*;
    private import DescriptiveModelLibrary::*;

    #CustomAttribute attribute def Position{
        #twinAttribute attribute x : TwinAttributeReal; 
        #twinAttribute attribute y : TwinAttributeReal;
        #twinAttribute attribute z : TwinAttributeReal;
    }

    #CustomAttributeList attribute def PositionList{
        :>> elements : Position;
    }

    #TwinEnum attribute def ChargeState{
        #enumType attribute charging = new TwinAttributeString(value = "CHARGING");
        #enumType attribute discharging = new TwinAttributeString(value = "DISCHARGING");
        #enumType attribute full = new TwinAttributeString(value = "FULL");
    }

     
     
    #system part Battery {
        #physicalTwin part physicalBattery {
            #sensor port p11 {
                
                #http_protocol attribute {
                    #http_url attribute = "http://localhost:8080/Battery/Temperature";
                }

                #payload attribute data{
                    
                    #jsonPath attribute = "data.data";
                    #field attribute temperature:TwinAttributeReal;
                    #field attribute power:TwinAttributeReal;
                    #field attribute pluggedIn:TwinAttributeBoolean;
                    #field attribute position : Position;
                    #field attribute rainflowCounting : TwinAttributeInteger[0..*];
                    
                    
                    #field attribute chargeState : ChargeState = new ChargeState(value = new TwinAttributeString(value = "CHARGING"));
                }
            }
            #http_protocol attribute {
                    #http_url attribute = "http://localhost:8080/Battery/Temperature";
                }
            
            #actuator port coolingSystem {
                #mqtt_protocol attribute {
                    #mqtt_broker attribute = "localhost";
                    #mqtt_topic attribute = "Battery/CoolingSystem";
                }
                #payload attribute data{
                    #field attribute decreasePower:TwinAttributeBoolean;
                    #field attribute increasePower:TwinAttributeReal;
                    #field attribute plug:TwinAttributeBoolean;
                    
                }
                
            }
            
            #constComponent attribute max_capacity:TwinAttributeReal = new TwinAttributeReal(value = 100.0);
            #constComponent attribute min_capacity:TwinAttributeReal = new TwinAttributeReal(value = 0.0);
            #constComponent attribute step:TwinAttributeInteger = new TwinAttributeInteger(value = 20);
            #constComponent attribute position:TwinAttributeList = new PositionList(elements = (new Position(x = new TwinAttributeReal(value = 0.0), y = new TwinAttributeReal(value = 0.0), z = new TwinAttributeReal(value = 0.0)),
                new Position(x = new TwinAttributeReal(value = 1.0), y = new TwinAttributeReal(value = 1.0), z = new TwinAttributeReal(value = 1.0)),
                new Position(x = new TwinAttributeReal(value = 2.0), y = new TwinAttributeReal(value = 2.0), z = new TwinAttributeReal(value = 2.0))
            ));
            
            #constComponent attribute limit_temp:TwinAttributeReal = new TwinAttributeReal(value = 50.0);
            #constComponent attribute bitAttr:TwinAttributeBit = new TwinAttributeBit(value = false);
            #constComponent attribute enumAttr:TwinAttributeTimestamp = new TwinAttributeTimestamp(value = 1680000000);

            #controlUnit part tempLogic {
                #c_eventTriggerConfig part{
                    #triggeringAttribute attribute = physicalBattery.p11.data.temperature;
                    #onChange attribute = new TwinAttributeBoolean(value = true);
                }
                #c_state part idle {
                    #c_assignAction action {
                        
                        #c_assign assign coolingSystem.data.decreasePower := new TwinAttributeBoolean(value = false);
                    }
                }
                #c_state part cooldown {
                    #c_assignAction action {
                        #c_assign assign coolingSystem.data.decreasePower := new TwinAttributeBoolean(value = true);
                    }
                }
                
                #c_transition connection {
                    end :>> fromState ::> idle;
                    end :>> toState ::> cooldown;
                    #guardCondition part {
                        #triggerCondition attribute = new ComparisonCalc(
                            left = physicalBattery.p11.data.temperature,
                            right = physicalBattery.limit_temp,
                            operator = ComparisonOperator::GREATER_THAN
                        );
                    }
                }
                #c_transition connection {
                    end :>> fromState ::> cooldown;
                    end :>> toState ::> idle;
                    #guardCondition part {
                        #triggerCondition attribute = new ComparisonCalc(
                            left = physicalBattery.p11.data.temperature,
                            right = physicalBattery.limit_temp,
                            operator = ComparisonOperator::LESS_THAN
                        );
                    }
                }
                
            }
        }
        
        #digitalShadow part BatteryShadow {
            #relationalDatabase part db1 {
                #retentionDays attribute = 30;
            }
            #keyValueDatabase part db2 {
                #retentionDays attribute = 70;
            } 
        }
        

        #descriptiveModel part BatteryDescriptiveModel {
            #query attribute avgTemp10 = new ArithmeticAggregationQuery(
                twinAttribute_=physicalBattery.p11.data.temperature,
                since=10,
                since_unit=TimeUnit::SECONDS,
                limit=100,
                order_by=ORDER_BY::DESCENDING,
                aggregation=ArithmeticAggregationOperator::AVERAGE
            );

            #query attribute lastTemp = new SingleNumberQuery(
                twinAttribute_=physicalBattery.p11.data.temperature,
                since=10,
                since_unit=TimeUnit::SECONDS,
                limit=100,
                order_by=ORDER_BY::DESCENDING,
                selector=ValueSelector::LAST
            );
            
            #c_timeTriggerConfig part{
                    #triggerInterval attribute = new TwinAttributeInteger(value = 1000);
                    #triggerIntervalUnit attribute = TimeUnit::SECONDS;
                }
            #descriptiveStateMachine part BatteryDescriptiveStateMachine {
                #c_timeTriggerConfig part{
                    #triggerInterval attribute = new TwinAttributeInteger(value = 1000);
                    #triggerIntervalUnit attribute = TimeUnit::SECONDS;
                }

                #d_machine_attribute attribute counter = new TwinAttributeInteger(value = 0);
                #d_state part idle {
                }
                #d_state part cooldown {
                    #d_assignAction action {
                        #d_assign assign counter := new NumericCalc(
                            left = counter,
                            right = new TwinAttributeInteger(value = 1),
                            operator = ArithmeticOperator::ADD
                        );
                    } 
                }

                #d_transition connection {
                    end :>> fromState ::> idle;
                    end :>> toState ::> cooldown;
                    #guardCondition part {
                        #triggerCondition attribute = new ComparisonCalc(
                            left = avgTemp10,
                            right = physicalBattery.limit_temp,
                            operator = ComparisonOperator::GREATER_THAN
                        );
                    }
                }

            }
            
        }
        #predictiveModel part BatteryPredictiveModel {
            #p_strategy part tempPrediction{
                
                #c_timeTriggerConfig part{
                    #triggerInterval attribute = new TwinAttributeInteger(value = 1000);
                    #triggerIntervalUnit attribute = TimeUnit::SECONDS;
                }


                #p_inputAttribute attribute =physicalBattery.p11.data.temperature;
                #p_lambdaPath attribute = "path/to/lambda/function";
                #p_outputAttribute attribute tempPrediction:TwinAttributeReal;


            }
        }

        #prescriptiveModel part {
            #pr_lambdaStrategy part {
                #c_timeTriggerConfig part{
                    #triggerInterval attribute = new TwinAttributeInteger(value = 1000);
                    #triggerIntervalUnit attribute = TimeUnit::SECONDS;
                }


                #pr_inputAttribute attribute tempPrediction = BatteryPredictiveModel.tempPrediction.tempPrediction;
                #pr_inputAttribute attribute lastTemp = BatteryDescriptiveModel.lastTemp;
                #pr_inputAttribute attribute chargeState = BatteryDescriptiveModel.BatteryDescriptiveStateMachine.currentState;

                #pr_condition attribute = new ComparisonCalc(
                    left = BatteryPredictiveModel.tempPrediction.tempPrediction,
                    right = physicalBattery.limit_temp,
                    operator = ComparisonOperator::GREATER_THAN
                );

                #pr_lambdaPath attribute = "path/to/lambda/function";
                #pr_outputAttribute attribute cooling:TwinAttributeReal;
            }

            #pr_sendToActuatorStrategy part {
                #c_timeTriggerConfig part{
                    #triggerInterval attribute = new TwinAttributeInteger(value = 1000);
                    #triggerIntervalUnit attribute = TimeUnit::SECONDS;
                }

                #pr_sendTarget attribute = physicalBattery.coolingSystem.data.increasePower;
                #pr_commandValue attribute = BatteryDescriptiveModel.lastTemp;
            }
        }
    }
}