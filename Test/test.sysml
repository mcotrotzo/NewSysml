package Test {

    private import FinalMetaLibrary::*;

    part def Project{
        #twin part Battery{
            #sensor port p11{
                #measureAttribute attribute temperature:ScalarValues::Real;
                #measureAttribute attribute power:ScalarValues::Real;
                #measureAttribute attribute pluggedIn:ScalarValues::Boolean;
            }
            #actuator port coolingSystem {
                #commandAttribute attribute decreasePower:ScalarValues::Real;
                #commandAttribute attribute increasePower:ScalarValues::Real;
                #commandAttribute attribute plug:ScalarValues::Boolean;
            }

            #controlUnit state controlUnitOne{
                #controlUnitState state tempLogic {
                    #controlUnitState state overheating {
                        #doactionassign action{
                            #assign_v assign coolingSystem.decreasePower := p11.power * 0.5;
                            #assign_v assign coolingSystem.plug := false;
                        }
                        entry;
                    }
                    #controlUnitState state startState;
                    entry; then startState;
                    
                    transition first startState
                        if p11.temperature > chargerPugDetails.maxCapacity
                        then overheating;
                    transition first startState
                        if p11.temperature <= chargerPugDetails.maxCapacity
                        then startState;
                    transition overheating
                        then startState;
                }

                #controlUnitState state chargingLogic {
                    #controlUnitState state charging {
                        #doactionassign action{
                            #assign_v assign coolingSystem.increasePower := p11.power * 0.1;
                        }
                    }
                    #controlUnitState state discharging {
                        #doactionassign action{
                            #assign_v assign coolingSystem.decreasePower := p11.power * 0.1;
                        }
                    }
                    #controlUnitState state startState;

                    entry; then startState;
                    
                
                    transition first startState
                        if p11.pluggedIn == true
                        then charging;
                    transition first startState
                        if p11.pluggedIn == false
                        then discharging;

                    transition first charging
                        then startState;
                    transition first discharging
                        then startState;
                }
            
        }
        #constComponent part chargerPugDetails{
            #constAttribute attribute maxCapacity:ScalarValues::Real = 100.0;

        }
     
    }

    #shadow part shadowBattery{
        #relationalDatabase part batteryHotDB;
        #keyValueDatabase part batteryColdDB;

        #dbconnection connect batteryHotDB.data_in to batteryColdDB.data_out;
    }

    #communication interface connect Battery.p11 to shadowBattery.sensor_ {
        @MQTT{
            broker = "mqtt://broker.hivemq.com:1883";
            topic = "battery/updates";
        }
        

    }
    
    }
}
