private import CollectionFunctions::size;
private import Collections::Array;
attribute p12:ScalarValues::Integer  = (2,3,5,7);

attribute test:Array{
    :>>dimensions = (3);
    :>>elements:ScalarValues::Integer;
}


assert constraint gggIsThree{
    size(test) == 3
    
}





    