library package example{

    private import ScalarValues::*;
    private import Metaobjects::SemanticMetadata;
    part def MQTT_CREDS{

        attribute broker:ScalarValues::String;
        attribute url:ScalarValues::String; 
    }


    part def Communication{
        part mqtt_creds:MQTT_CREDS;
    }

    
    
    
    metadata def <mqqtcred> MData :> SemanticMetadata {
        :>> baseType default Communication::mqtt_creds meta SysML::PartUsage;
        :>> annotatedElement:SysML::PartUsage;
    }


    metadata def <comm> CommData :> SemanticMetadata {
        :>> baseType default Communication meta SysML::PartDefinition;
        :>> annotatedElement:SysML::PartDefinition;
    }


   
    #comm part def {
        #mqqtcred part example{
            :>>broker = "testbroker";
            :>>url = "testurl";
        } 
    }

    // but the user still can place multiple mqqtcreds
    #comm part def {
        
        #mqqtcred part example2{
            :>>broker = "testbroker";
            :>>url = "testurl";
        } 
    }
    

    
}