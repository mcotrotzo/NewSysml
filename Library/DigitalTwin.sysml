library package DigitalTwinLibrary {
    private import PhysicalTwinLibrary::*;
    private import ShadowLibrary::*;
    
    part def DigitalTwin {
        part physicalTwin : PhysicalTwin;
        part shadow_ : Shadow;

        

    }
    
    
}