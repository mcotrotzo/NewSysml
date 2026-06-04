library package FinalMetaLibrary {

    public import PhysicalTwinMetaLibrary::*;
    public import ShadowMetaLibrary::*;
    private import Metaobjects::SemanticMetadata;
    


    metadata def <communication> CommunicationMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwinLibrary::communication_ meta SysML::InterfaceUsage;
        :>> annotatedElement:SysML::InterfaceUsage;

        metadata connectionType:ComType;
    }

    metadata def <comType> ComType {        
    }
    metadata def MQTT:>ComType,SemanticMetadata {
       :>> baseType default CommunicationMetadata meta SysML::MetadataDefinition;
        attribute broker : ScalarValues::String;
        attribute topic : ScalarValues::String;
    }
    metadata def CustomCommunication:>ComType,SemanticMetadata{
        :>> baseType default CommunicationMetadata meta SysML::MetadataDefinition;
        attribute pathToLambdaCode : ScalarValues::String;
    }
}