library package CustomLibrary{
    private import TwinDataTypeLibrary::*;

    attribute def CustomAttribute :> TwinAttribute{
        attribute members:TwinAttribute[0..*];
        
    }

    action def CustomFunction:>STATEMENT {
        in attribute inputs:TwinAttribute[0..*];
        out attribute outputs:TwinAttribute[0..*];
        action body:STATEMENT[1];
    }


}