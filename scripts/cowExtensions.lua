local RanchExtensions = ...


-- Register dairy barn asset
RanchExtensions:registerAssetId("models/dairy.fbx/Prefab/Milking_Barn", "PREFAB_MILKING_BARN")

-- Override the dairy farm part to remove the function
RanchExtensions:overrideAsset({
    Id = "BUILDING_PART_DAIRY_FARM",
    AssetBuildingFunction = "BUILDING_FUNCTION_NIL"
})

-- Override dairy farm to allow extensions and add the building function (function is on the part in base game, preventing extensions from functioning)
RanchExtensions:overrideAsset({
    Id = "BUILDING_DAIRY_FARM",
    AssetCoreBuildingPart = "BUILDING_PART_DAIRY_FARM",
    AssetBuildingPartList = {
        "BUILDING_PART_DAIRY_FARM_MILKING_BARN"
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_DAIRY_FARM"
})

-- Register dairy barn building function
RanchExtensions:registerAsset({
    DataType = "BUILDING_FUNCTION_WORKER_CAPACITY_EXTENDER",
    Id = "BUILDING_FUNCTION_DAIRY_FARM_MILKING_BARN",
    -- BUILDING_FUNCTION base values
    Name = "BUILDING_FUNCTION_MILKING_BARN_NAME",
    Description = "BUILDING_FUNCTION_MILKING_BARN_DESC",
    -- WORKER_CAPACITY_EXTENDER values
    WorkerCapacity = 2
})


-- Register dairy barn as a dairy farm extension
RanchExtensions:registerAsset({
    DataType = "BUILDING_PART",
    -- BUILDING_PART base values
    Id = "BUILDING_PART_DAIRY_FARM_MILKING_BARN",
    Name = "MILKING_BARN_NAME",
    Description = "MILKING_BARN_DESC",
    -- Affects the tab the part is under
    Category = BUILDING_PART_TYPE.IMPROVEMENT,
    -- Only allow 2 per farm
    HasMaximumInstancePerBuilding = true,
    MaximumInstancePerBuilding = 2,
    -- Constructor
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_MILKING_BARN"
    },
    -- Assign the building function
    AssetBuildingFunction = "BUILDING_FUNCTION_DAIRY_FARM_MILKING_BARN",
    -- Set building zone aka how the building takes up space in the game
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( {8, 12} ),
                Type = {
                    DEFAULT = true,
                    NAVIGABLE = false,
                    GRASS_CLEAR = true
                }
            }
        }
    },
    -- ConstructionVisual (add this if doing construction visuals)
    -- Set building initial and upkeep cost
    Cost = {
        UpkeepCost = {
            Collection = {
                { Resource = "GOLD_COINS", Quantity = 6 },
            }
        },
        ResourceNeededList = {
            Collection = {
                { Resource = "TOOL", Quantity = 10 },
                { Resource = "WOOD", Quantity = 20 },
            }
        }
    },
    -- Capacity is like the size value in the manor house
    -- Capacity = 10,
    -- Dunno, like 1 undesirable? Compare to dairy farm core in game
    UndesirabilityValue = 1.5

})

-- Create the unlock option
RanchExtensions:registerAsset({
    DataType = "UNLOCKABLE_TECHNOLOGY",
    Id = "UNLOCKABLE_DAIRY_FARMING_IMPROVEMENT",
    Name = "DAIRY_FARMING_IMPROVEMENT_NAME",
    Description = "DAIRY_FARMING_IMPROVEMENT_DESC",
    DataCost = {
        ResourceCollection = {
            { Resource = "GOLD_COINS", Quantity = 300 },
        }
    },
    PrerequisiteUnlockableList = {
        "UNLOCKABLE_COMMON_CHEESE_PRODUCTION"
    },
    ActionList = {
        {
            DataType = "GAME_ACTION_UNLOCK_BUILDING_LIST",
            BuildingProgressData = {
                AdditionalBuildingUnlockList = {
                    {
                        OwnerBuilding = "BUILDING_DAIRY_FARM",
                        AssetBuildingPartList = {
                            "BUILDING_PART_DAIRY_FARM_MILKING_BARN",
                        }
                    }
                }
            }
        }
    },
    UnlockableImage = "ICON_RESOURCE_MILK"
})

-- Add the unlock option to the common path in tier 5
RanchExtensions:overrideAsset({
    Id = "PROGRESS_TIER_COMMON_T5",
    UnlockableList = {
        Action = "APPEND",
        "UNLOCKABLE_DAIRY_FARMING_IMPROVEMENT"
    }
})