library package TwinLibrary{

   
    
    
    
    private import DescriptiveModelLibrary::DescriptiveModel;    
    private import PredicitiveLibrary::PredictiveModel;
    private import ShadowLibrary::Shadow;
    private import PhysicalTwinLibrary::PhysicalTwin;
    private import PrescriptiveModelLibrary::PrescriptiveModel;

    private import Metaobjects::SemanticMetadata;
    public import TwinStateMachineLibrary::*;
    public import TwinTypeSystem::*;
    public import TwinImp::*;
    public import DescriptiveModelLibrary::QueryHistory;
    public import DescriptiveModelLibrary::ORDER_BY;
    public import DescriptiveModelLibrary::QueryHistoryReal;
    public import DescriptiveModelLibrary::QueryHistoryBoolean;
    public import DescriptiveModelLibrary::QueryHistoryInteger;
    public import DescriptiveModelLibrary::QueryHistoryString;
    public import PredicitiveLibrary::PredicitiveStrategy;
    public import PrescriptiveModelLibrary::PrescriptiveStrategy;
    public import ShadowLibrary::RelationalDatabase;
    public import ShadowLibrary::KeyValueDatabase;
    public import PhysicalTwinLibrary::HTTP_Protocol;
    public import PhysicalTwinLibrary::MQTT_Protocol;
    


    part def Twin{
        part physicalTwin:PhysicalTwin[1];
        part shadow[1]:Shadow;
        part descriptiveModel:DescriptiveModel[1];
        part predictiveModel:PredictiveModel[1];
        part prescriptiveModel:PrescriptiveModel[1];
    }

 
   
}