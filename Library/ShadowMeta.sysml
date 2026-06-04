library package ShadowMetaLibrary {
    private import Metaobjects::SemanticMetadata;
    private import ShadowLibrary::*;

    metadata def <shadow> ShadowMetadata :> SemanticMetadata {
        :>> baseType default shadow_ meta SysML::PartUsage;
        :>>annotatedElement:SysML::PartUsage;
    }

    metadata def <relationalDatabase> RelationalDatabaseMetadata :> SemanticMetadata {
        :>> baseType default ShadowLibrary::Shadow::relationalDatabases meta SysML::PartUsage;
        :>>annotatedElement:SysML::PartUsage;
    }
    metadata def <keyValueDatabase> KeyValueDatabaseMetadata :> SemanticMetadata {
        :>> baseType default ShadowLibrary::Shadow::keyValueDatabases meta SysML::PartUsage;
        :>>annotatedElement:SysML::PartUsage;
    }

    metadata def <durationInDays> DurationInDaysMetadata :> SemanticMetadata {
        :>> baseType default ShadowLibrary::dbConnections::durationInDays_ meta SysML::AttributeUsage;
        :>>annotatedElement:SysML::AttributeUsage;
    }

    metadata def <dbconnection> DbConnectionMetadata :> SemanticMetadata {
    :>> baseType default ShadowLibrary::Shadow::dbconnections meta SysML::ConnectionUsage;
    :>>annotatedElement:SysML::ConnectionUsage;
    }

    

}
