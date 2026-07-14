library package ShadowLibrary {
    private import PhysicalTwinLibrary::*;
    private import ScalarValues::*;
    part def Database {
    
        attribute durationInDays : ScalarValues::Integer default -1;
    }

    part def Shadow {
        part relationalDatabases : RelationalDatabase[0..*];
        part keyValueDatabases : KeyValueDatabase[0..*];
    }

    

    part def RelationalDatabase specializes Database {


        
    }

    part def KeyValueDatabase specializes Database {
        
    }

    
    
    
    
}