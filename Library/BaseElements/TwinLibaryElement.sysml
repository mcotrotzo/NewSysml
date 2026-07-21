library package TwinLibraryPackage{
    abstract part def TwinLibraryElement{
        attribute kind:ScalarValues::String = "KIND";
    }

    abstract connection def TwinLibraryElementConnection{
        attribute kind:ScalarValues::String = "KIND";
    }

    abstract calc def TwinLibraryElementCalcDef{
        attribute kind:ScalarValues::String = "KIND";
    }

    abstract action def TwinLibraryElementActionDef{
        attribute kind:ScalarValues::String = "KIND";
    }
    abstract attribute def TwinLibraryElementAttributeDef{
        attribute kind:ScalarValues::String = "KIND";
    }

    abstract port def TwinLibraryElementPortDef{
        attribute kind:ScalarValues::String = "KIND";
    }

    abstract state def TwinLibraryElementStateDef{
        attribute kind:ScalarValues::String = "KIND";
    }

   
}