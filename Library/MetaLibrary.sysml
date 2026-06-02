package MetaLibrary {
    private import Metaobjects::SemanticMetadata;
    private import DigitalTwinLibrary::*;
    private import ShadowLibrary::*;

    metadata def <DigitalTwin> DigitalTwinMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::DigitalTwin meta SysML::PartDefinition;
    }
    
    metadata def <twin> TwinMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::DigitalTwin::physicalTwin meta SysML::PartUsage;
    }
    
    metadata def <sensor> SensorMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::DigitalTwin::physicalTwin::sensors meta SysML::PortUsage;
    }
    
    metadata def <actuator> ActuatorMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::DigitalTwin::physicalTwin::actuators meta SysML::PortUsage;
    }
    
    metadata def <constAttribute> ConstAttributeMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::DigitalTwin::physicalTwin::attributes meta SysML::AttributeUsage;
    }
    metadata def <measureAttribute> MeasureAttributeMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::DigitalTwin::physicalTwin::sensors::measurements meta SysML::AttributeUsage;
    }
    metadata def <commandAttribute> CommandAttributeMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::DigitalTwin::physicalTwin::actuators::commandAttributes meta SysML::AttributeUsage;
    }

    /*
    metadata def <mqtt> MQTTMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::MQTT meta SysML::InterfaceDefinition;
    }*/

    metadata def <shadow> ShadowMetadata :> SemanticMetadata {
        :>> baseType default DigitalTwinLibrary::DigitalTwin::shadow_ meta SysML::PartUsage;
    }
    metadata def <relationalDatabase> RelationalDatabaseMetadata :> SemanticMetadata {
        :>> baseType default ShadowLibrary::Shadow::relationalDatabases meta SysML::PartUsage;
    }
    metadata def <keyValueDatabase> KeyValueDatabaseMetadata :> SemanticMetadata {
        :>> baseType default ShadowLibrary::Shadow::keyValueDatabases meta SysML::PartUsage;
    }

    metadata def <durationInDays> DurationInDaysMetadata :> SemanticMetadata {
        :>> baseType default ShadowLibrary::dbConnections::durationInDays_ meta SysML::AttributeUsage;
    }

    metadata def <dbconnection> DbConnectionMetadata :> SemanticMetadata {
    :>> baseType default ShadowLibrary::Shadow::dbconnections meta SysML::ConnectionUsage;
    }
    

}
