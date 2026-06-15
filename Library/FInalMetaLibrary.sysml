library package FinalMetaLibrary {

    public import PhysicalTwinMetaLibrary::*;
    public import ShadowMetaLibrary::*;
    private import Metaobjects::SemanticMetadata;
    


    metadata def <communication> CommunicationMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwinLibrary::communication_ meta SysML::ConnectionUsage;
        :>> annotatedElement:SysML::ConnectionUsage;
    }

    metadata def MQTT:>SemanticMetadata {
       :>> baseType default PhysicalTwinLibrary::Communication::mqtt_ meta SysML::PartUsage;
        
       :>> annotatedElement:SysML::PartUsage;
    }

    metadata def broker:>SemanticMetadata {
       :>> baseType default PhysicalTwinLibrary::Communication::mqtt_::broker meta SysML::AttributeUsage;
       :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def topic:>SemanticMetadata {
       :>> baseType default PhysicalTwinLibrary::Communication::mqtt_::topic meta SysML::AttributeUsage;
       :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def HTTP:>SemanticMetadata{
        :>> baseType default PhysicalTwinLibrary::Communication::http_ meta SysML::PartUsage;
        attribute pathToLambdaCode : ScalarValues::String;
        :>> annotatedElement:SysML::PartUsage;
    }
    metadata def url:>SemanticMetadata {
        :>> baseType default PhysicalTwinLibrary::Communication::http_::url meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
}