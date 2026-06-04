library package PhysicalTwinMetaLibrary {
    private import Metaobjects::SemanticMetadata;
    private import PhysicalTwinLibrary::*;
    

    private part twin_:PhysicalTwin;
    metadata def <twin> TwinMetadata :> SemanticMetadata {
        :>> baseType default twin_ meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }
    
    metadata def <sensor> SensorMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwin::sensors meta SysML::PortUsage;
        :>> annotatedElement:SysML::PortUsage;
    }
    
    metadata def <actuator> ActuatorMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwin::actuators meta SysML::PortUsage;
        :>> annotatedElement:SysML::PortUsage;
    }

    metadata def <constAttribute> ConstAttributeMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwin::constComponents::attributes meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def <constComponent> ConstComponentMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwin::constComponents meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }
    metadata def <measureAttribute> MeasureAttributeMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwin::sensors::measurements meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
    metadata def <commandAttribute> CommandAttributeMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwin::actuators::commandAttributes meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
    metadata def <assign_v> AssignValueMetadata :> SysML::AssignmentActionUsage {
        :>> annotatedElement:SysML::AssignmentActionUsage;
    }


    metadata def <controlUnit> ControlUnitMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwin::controlUnit_ meta SysML::StateUsage;
        :>> annotatedElement:SysML::StateUsage;
    }

    metadata def <controlUnitState> ControlUnitStateMetadata :> SemanticMetadata {
        :>> baseType default ControlUnit::actions meta SysML::StateUsage;
        :>> annotatedElement:SysML::StateUsage;
    }


    metadata def <doactionassign> DoActionAssignMetadata :> SysML::ActionUsage {
        :>> annotatedElement:SysML::ActionUsage;
    }



    
}