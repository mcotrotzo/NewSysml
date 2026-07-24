library package TwinImp{

    private import TwinTypeSystem::*;
    private import TwinLibraryPackage::*;
    
    calc def CustomCalculationAction :> TwinLibraryElementCalcDef {
        in attribute inputs[0..*] : TwinAttribute;
        return attribute outputs[0..*]:TwinAttribute;
        attribute local_Attributes : TwinAttribute[0..*];
        
    }

}