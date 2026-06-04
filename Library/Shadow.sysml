library package ShadowLibrary {
    private import PhysicalTwinLibrary::*;
    private import ScalarValues::*;
    private import NumericalFunctions::*;
    private import SequenceFunctions::*;
    private import SI::*;
    private import USCustomaryUnits::*;
    part def Database {
        out port data_out[1]: DbPort;
        in port data_in[1]: DbPort;
        
    }

    port def DbPort {
    }

    connection def dbConnections{
        abstract attribute durationInDays_[2] : ScalarValues::Real;
        end port db1:DbPort;
        end port db2:DbPort;
    }


    part def Shadow {
        in port sensor_ [0..*] : ~PhysicalTwinLibrary::Sensor;
        part relationalDatabases : RelationalDatabase[0..*];
        part keyValueDatabases : KeyValueDatabase[0..*];
        abstract connection dbconnections[0..*]:dbConnections;
    }

    part shadow_:Shadow;

    part def RelationalDatabase specializes Database {
        
    }

    part def KeyValueDatabase specializes Database {
        
    }

    
    
    
    
}