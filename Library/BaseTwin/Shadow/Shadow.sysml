library package ShadowLibrary {
    private import PhysicalTwinLibrary::*;
    private import TwinTypeSystem::*;
    private import TwinLibraryPackage::*;
    part def Database:>TwinLibraryElement {
    
        attribute durationInDays : TwinInteger default -1;
    }

    part def Shadow:>TwinLibraryElement {
        part databases : Database[0..*];
    }

    

    part def RelationalDatabase specializes Database {
        
    }

    part def KeyValueDatabase specializes Database {
    }

    
    
    
    
}