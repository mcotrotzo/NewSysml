library package TwinStateMachineLibrary {
    private import TwinTypeSystem::*;
    private import TwinLibraryPackage::*;
    
    state def State:>TwinLibraryElementStateDef {
        attribute readAttributes[0..*]:TwinAttribute;
        attribute writeAttributes[0..*]:TwinAttribute; 
        attribute local_Attributes :TwinAttribute[0..*]:>readAttributes,writeAttributes;
        state states:State[0..*];
    }

}


