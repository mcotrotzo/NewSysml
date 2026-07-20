library package Test{

    private import PhysicalTwinLibrary::*;
    private import TwinTypeSystem::*;
    private import PositionLibrary::*;
    private import TwinStateMachineLibrary::*;



    part def Battery:>PhysicalTwin{
        port p11 :>sensors{
            attribute temp:TwinReal :>measurements;
            attribute voltage:TwinReal :>measurements;
            attribute position:Position :>measurements;
        }
        
        port coolingSystem:>actuators{
            in attribute coolingCommand:TwinBoolean :>commands;
        }
        attribute maxTemp:TwinReal :>constAttributes = 50.0;

        part cm1:>controlUnit{
            :>>triggerConfig_:TimeBasedConfiguration{
                :>>triggerInterval_ = 10;
                :>>triggerIntervalUnit_ = TimeUnit::SECOND;
            }
            part idle:>states;
            part overheating:>states{
                action :>>entryAction_{
                    assign coolingSystem.coolingCommand := true;
                }
                action :>>exitAction_{
                    assign coolingSystem.coolingCommand := false;
                }

            }
            

            connection t1:>transitions{
                end :>>fromState ::> idle;
                end :>>toState ::> overheating;
            
                :>>guardCondition_{
                    :>>triggerCondition_ = p11.temp > maxTemp;
                }
            }

            connection t4:>transitions{
                end :>>fromState ::> idle;
                end :>>toState ::> idle;
            
                :>>guardCondition_{
                    :>>triggerCondition_ = p11.temp <= maxTemp;
                }
            }

            connection t2:>transitions{
                end :>>fromState ::> overheating;
                end :>>toState ::> idle;
            
                :>>guardCondition_{
                    :>>triggerCondition_ = p11.temp <= maxTemp;
                }
            }
            connection t3:>transitions{
                end :>>fromState ::> overheating;
                end :>>toState ::> overheating;
            
                :>>guardCondition_{
                    :>>triggerCondition_ = p11.temp > maxTemp;
                }
            }
        }
    }
}