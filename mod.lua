local RanchExtensions = foundation.createMod();

-- Register nil building function
RanchExtensions:registerAsset({
    DataType = "BUILDING_FUNCTION",
    Id = "BUILDING_FUNCTION_NIL",
    -- BUILDING_FUNCTION base values
    Name = "BUILDING_FUNCTION_NIL_NAME",
    Description = "BUILDING_FUNCTION_NIL_DESC"
})


RanchExtensions:dofile("scripts/cowExtensions.lua")
RanchExtensions:dofile("scripts/SheepExtensions.lua")