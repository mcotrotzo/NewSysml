library package SystemMeta {

    private import PhysicalTwinLibrary::*;
    private import ShadowLibrary::*;

    private import Metaobjects::SemanticMetadata;
    private import DescriptiveModelLibrary::*;
    private import TwinStateMachineLibrary::*;
    private import PredicitiveLibrary::*;
    private import PrescriptiveModelLibrary::*;
   


    private part def System {
        part physicalTwin_ : PhysicalTwin[1];
        part digitalShadow_: Shadow[1];
        part descriptiveModel_: DescriptiveModel[1];
        part predictiveModel_: PredictiveModel[1];
        part prescriptiveModel_: PrescriptiveModel[1];
      

    }

    private part system_: System;



    metadata def <system> SystemMetadata :> SemanticMetadata {
        :>> baseType default system_ meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    metadata def physicalTwin:>SemanticMetadata {
        :>> baseType default system_::physicalTwin_ meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    metadata def digitalShadow:>SemanticMetadata {
        :>> baseType default system_::digitalShadow_ meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    metadata def descriptiveModel:>SemanticMetadata {
        :>> baseType default system_::descriptiveModel_ meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }


    //PhysicalTwin ------------------------------

    metadata def sensor:>SemanticMetadata{
        :>> baseType default system_::physicalTwin_::sensors meta SysML::PortUsage;
        :>> annotatedElement:SysML::PortUsage;
    }

    metadata def actuator:>SemanticMetadata{
        :>> baseType default system_::physicalTwin_::actuators meta SysML::PortUsage;
        :>> annotatedElement:SysML::PortUsage;
    }


    metadata def <http_protocol> HTTP_ProtocolMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwinLibrary::TwinPort::communicationProtocol meta SysML::AttributeUsage{
            :>>annotatedElement;
        }
        :>> annotatedElement:SysML::AttributeUsage;
    }
    metadata def <mqtt_protocol> MQTT_ProtocolMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwinLibrary::MQTT_Protocol meta SysML::AttributeDefinition;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def http_url:>SemanticMetadata{
        :>> baseType default PhysicalTwinLibrary::HTTP_Protocol::url meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def mqtt_broker:>SemanticMetadata{
        :>> baseType default PhysicalTwinLibrary::MQTT_Protocol::broker meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
    metadata def mqtt_topic:>SemanticMetadata{
        :>> baseType default PhysicalTwinLibrary::MQTT_Protocol::topic meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def <constComponent>:>SemanticMetadata{
        :>> baseType default PhysicalTwinLibrary::PhysicalTwin::constComponents meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def <field>:>SemanticMetadata{
        :>> baseType default PhysicalTwinLibrary::Payload::measurements meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }


    metadata def <payload> PayloadMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwinLibrary::payload_ meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def <jsonPath> JsonPathMetadata :> SemanticMetadata {
        :>> baseType default PhysicalTwinLibrary::Payload::jsonPath_ meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def controlUnit:>SemanticMetadata{
        :>> baseType default PhysicalTwinLibrary::PhysicalTwin::controlUnit_ meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    metadata def c_state :>SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::CustomStateMachine::states meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    metadata def <c_transition> TransitionMetadata :> SemanticMetadata {
        :>> baseType default system_::physicalTwin_::controlUnit_::transitions meta SysML::ConnectionUsage;
        :>> annotatedElement:SysML::ConnectionUsage;
    }

    metadata def c_assignAction:>SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::StatePart::assignActions meta SysML::ActionUsage;
        :>> annotatedElement:SysML::ActionUsage;
    }

    metadata def c_assign:>SysML::AssignmentActionUsage{
        :>>annotatedElement:SysML::AssignmentActionUsage;
    }

    metadata def guardCondition:>SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::TransitionConnection::guardCondition_ meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    metadata def triggerCondition:>SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::TransitionConstraint::triggerCondition_ meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def <c_eventTriggerConfig>TriggerConfigMetadata :> SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::eventBasedTriggerConfig meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    metadata def <c_timeTriggerConfig> TimeTriggerConfigMetadata :> SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::timeBasedTriggerConfig meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    metadata def <triggerInterval> TriggerIntervalMetadata :> SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::TimeBasedConfiguration::triggerInterval_ meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
    metadata def <triggerIntervalUnit> TriggerIntervalUnitMetadata :> SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::TimeBasedConfiguration::triggerIntervalUnit_ meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
    metadata def <triggeringAttribute> TriggeringAttributesMetadata :> SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::EventBasedConfiguration::triggeringAtributes_ meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
    metadata def <onChange> OnChangeMetadata :> SemanticMetadata{
        :>> baseType default TwinStateMachineLibrary::EventBasedConfiguration::onChange_ meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
    

    // Shadow -------------------------

    metadata def <relationalDatabase> RelationalDatabaseMetadata :> SemanticMetadata {
        :>> baseType default System::digitalShadow_::relationalDatabases meta SysML::PartUsage;
        :>>annotatedElement:SysML::PartUsage;
    }
    metadata def <keyValueDatabase> KeyValueDatabaseMetadata :> SemanticMetadata {
        :>> baseType default System::digitalShadow_::keyValueDatabases meta SysML::PartUsage;
        :>>annotatedElement:SysML::PartUsage;
    }

    metadata def <retentionDays> DurationInDaysMetadata :> SemanticMetadata {
        :>> baseType default ShadowLibrary::Database::durationInDays meta SysML::AttributeUsage;
        :>>annotatedElement:SysML::AttributeUsage;
    }
    
    // TwinDataType -------------------------
    metadata def CustomAttribute:>SemanticMetadata{
        :>> baseType default TwinDataTypeLibrary::CustomAttribute_ meta SysML::AttributeDefinition;
        :>> annotatedElement:SysML::AttributeDefinition;
    }

    metadata def CustomAttributeList:>SemanticMetadata{
        :>> baseType default TwinDataTypeLibrary::CustomAttributeList_ meta SysML::AttributeDefinition;
        :>> annotatedElement:SysML::AttributeDefinition;
    }

    metadata def twinAttribute :>SemanticMetadata{
        :>> baseType default TwinDataTypeLibrary::twinAttributes meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }


    metadata def <TwinEnum> CustomEnumMetadata :> SemanticMetadata {
        :>> baseType default TwinDataTypeLibrary::TwinAttributeEnum meta SysML::AttributeDefinition;
        :>>annotatedElement:SysML::AttributeDefinition;
    }

    metadata def <enumType> TwinEnumMetadata :> SemanticMetadata {
        :>> baseType default TwinDataTypeLibrary::TwinAttributeEnum::enumOptions meta SysML::AttributeUsage;
        :>>annotatedElement:SysML::AttributeUsage;
    }

    // DescriptiveModel -------------------------

    metadata def <descriptiveStateMachine> DescriptiveStateMachineMetadata :> SemanticMetadata {
        :>> baseType default System::descriptiveModel_::descriptiveStateMachine_ meta SysML::PartUsage;
        :>>annotatedElement:SysML::PartUsage;
    }

    metadata def <d_state> DescriptiveStatePartMetadata :> SemanticMetadata {
        :>> baseType default System::descriptiveModel_::descriptiveStateMachine_::d_states_ meta SysML::PartUsage;
        :>>annotatedElement:SysML::PartUsage;
    }
    metadata def <d_transition> DescriptiveTransitionMetadata :> SemanticMetadata {
        :>> baseType default System::descriptiveModel_::descriptiveStateMachine_::d_transitions_ meta SysML::ConnectionUsage;
        :>>annotatedElement:SysML::ConnectionUsage;
    }

    metadata def <query> QueryHistoryMetadata :> SemanticMetadata {
        :>> baseType default DescriptiveModelLibrary::DescriptiveModel::queries_ meta SysML::AttributeUsage;
        :>>annotatedElement:SysML::AttributeUsage;
    }
    metadata def <d_machine_attribute>MachineAttributesMetadata:>SemanticMetadata{
        :>>baseType default DescriptiveModelLibrary::DescriptiveModel::descriptiveStateMachine_::machineAttributes_ meta SysML::AttributeUsage;
        :>>annotatedElement:SysML::AttributeUsage;
    }
    metadata def d_assign:>SysML::AssignmentActionUsage{
        :>>annotatedElement:SysML::AssignmentActionUsage;
    }
    metadata def <d_assignAction> AssignMetadata :> SemanticMetadata {
        :>> baseType default DescriptiveModelLibrary::DescriptiveModel::descriptiveStateMachine_::d_states_::assignActions meta SysML::ActionUsage;
        :>> annotatedElement:SysML::ActionUsage;
    }


    //PredictiveModel -------------------------

    metadata def <predictiveModel> PredictiveModelMetadata :> SemanticMetadata {
        :>> baseType default system_::predictiveModel_ meta SysML::PartUsage;
        :>>annotatedElement:SysML::PartUsage;
    }
    metadata def p_strategy:>SemanticMetadata{
        :>> baseType default PredicitiveLibrary::PredictiveModel::strategies meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }
    metadata def p_inputAttribute:>SemanticMetadata{
        :>> baseType default PredicitiveLibrary::PredictiveModel::strategies::inputAttributes meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def p_lambdaPath:>SemanticMetadata{
        :>> baseType default PredicitiveLibrary::PredictiveModel::strategies::lambdaPath meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }
    
    metadata def p_outputAttribute:>SemanticMetadata{
        :>> baseType default PredicitiveLibrary::PredictiveModel::strategies::outputAttributes meta SysML::AttributeUsage;
        :>> annotatedElement:SysML::AttributeUsage;
    }

    metadata def <p_triggerConfig>P_TriggerConfigMetadata :> SemanticMetadata{
        :>> baseType default PredicitiveLibrary::PredictiveModel::strategies::triggerConfig_ meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }

    //PrescriptiveModel -------------------------

    metadata def <prescriptiveModel> PrescriptiveModelMetadata :> SemanticMetadata {
    :>> baseType default system_::prescriptiveModel_ meta SysML::PartUsage;
    :>> annotatedElement : SysML::PartUsage;
    }

    metadata def <pr_sendToActuatorStrategy> PrescriptiveStrategyMetadata :> SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::sendToActuatorStrategies meta SysML::PartUsage;
        :>> annotatedElement : SysML::PartUsage;
    }

    metadata def <pr_triggerConfig> PR_TriggerConfigMetadata :> SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::PrescriptiveStrategy::triggerConfig_ meta SysML::PartUsage;
        :>> annotatedElement : SysML::PartUsage;
    }

    metadata def <pr_condition> PR_ConditionMetadata :> SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::PrescriptiveStrategy::condition_ meta SysML::AttributeUsage;
        :>> annotatedElement : SysML::AttributeUsage;
    }

    metadata def pr_conditionExpression :> SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::startegyCondition::condition meta SysML::AttributeUsage;
        :>> annotatedElement : SysML::AttributeUsage;
    }

    metadata def pr_inputAttribute :> SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::PrescriptiveStrategy::inputAttributes meta SysML::AttributeUsage;
        :>> annotatedElement : SysML::AttributeUsage;
    }

    metadata def <pr_sendTarget> :>SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::SendToActuatorStrategy::actuatorTarget meta SysML::AttributeUsage;
        :>> annotatedElement : SysML::AttributeUsage;
    }

    metadata def <pr_commandValue> :>SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::SendToActuatorStrategy::commandValue meta SysML::AttributeUsage;
        :>> annotatedElement : SysML::AttributeUsage;
    }


    // CustomPrescriptiveStrategy -----------------

    metadata def pr_lambdaPath :> SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::CustomPrescriptiveStrategy::lambdaPath meta SysML::AttributeUsage;
        :>> annotatedElement : SysML::AttributeUsage;
    }

    metadata def pr_outputAttribute :> SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::CustomPrescriptiveStrategy::outputAttributes meta SysML::AttributeUsage;
        :>> annotatedElement : SysML::AttributeUsage;
    }

    metadata def pr_lambdaStrategy :> SemanticMetadata {
        :>> baseType default PrescriptiveModelLibrary::lambdaStrategies meta SysML::PartUsage;
        :>> annotatedElement : SysML::PartUsage;
    }

    

}