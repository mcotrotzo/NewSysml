library package ShadowLibrary {
    private import PhysicalTwinLibrary::*;
    private import ScalarValues::*;
    private import NumericalFunctions::*;
    private import SequenceFunctions::*;
    private import SI::*;
    private import USCustomaryUnits::*;
    part def Database {
        port data_out[0..*] : DbPort;
        
    }

    port def DbPort {
    }

    connection def dbConnections{
        abstract attribute durationInDays_[2] : ScalarValues::Real;
        assert constraint{
            1==0
        }
        end port db1:DbPort;
        end port db2:DbPort;
    }


    part def Shadow {
        port sensor_ [0..*] : ~PhysicalTwinLibrary::Sensor;
        part relationalDatabases : RelationalDatabase[0..*];
        part keyValueDatabases : KeyValueDatabase[0..*];
        abstract connection dbconnections[0..*]:dbConnections;
    }

    part def RelationalDatabase specializes Database {
        
    }

    part def KeyValueDatabase specializes Database {
        
    }
    
    
    
}