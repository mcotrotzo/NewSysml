private import Metaobjects::SemanticMetadata;
part def Vehicle{
    attribute test;
}

metadata def <car> CarMetadata :> SemanticMetadata {
    :>> baseType default Vehicle meta SysML::PartDefinition;
    :>> annotatedElement : SysML::PartDefinition;
}

#car part def SUV { }
// implizit: part def SUV :> Vehicle { }

part myFleetVehicle : Vehicle;   // baseType, eine Usage, typisiert als Vehicle

metadata def <fleetCar> FleetCarMetadata :> SemanticMetadata {
    :>> baseType default myFleetVehicle meta SysML::PartUsage;
    :>> annotatedElement : SysML::PartDefinition;
}

#fleetCar part def Ambulance { }

part hh:Ambulance{
    :>>test = "test";
}