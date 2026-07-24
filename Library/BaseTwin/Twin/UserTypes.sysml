library package UserLibrary{
    public import PublicDescriptiveElements::*;
    public import PrescriptivePublicElements::*;
    public import PredictivePublicElements::*;
    public import ShadowPublicElements::*;
    public import PhysicalElementsLibrary::*;
    public import TwinTypeSystem::*;
    public import TwinImp::*;
    public import TwinTriggerConfigurationLibrary::*;
    public import TwinEnumLibrary::*;


    

    private import TwinTypeSystem::TwinAttribute;
    
    public attribute def TwinCustomType:>TwinAttribute{
        attribute fields[0..*] : TwinAttribute;
    }

    


}