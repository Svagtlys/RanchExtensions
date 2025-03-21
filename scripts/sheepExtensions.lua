local RanchExtensions = ...

-- Register shearing shed asset
RanchExtensions:registerAssetId("models/ShearingShed.fbx/Prefab/TestBuilding", "PREFAB_SHEARING_SHED")

-- Override the sheep farm part to remove the function
RanchExtensions:overrideAsset({
    Id = "BUILDING_PART_SHEEP_FARM",
    AssetBuildingFunction = "BUILDING_FUNCTION_NIL"
})



-- Override sheep farm to allow extensions
RanchExtensions:overrideAsset({
    Id = "BUILDING_SHEEP_FARM",
    AssetCoreBuildingPart = "BUILDING_PART_SHEEP_FARM",
    AssetBuildingPartList = {
        "BUILDING_PART_SHEEP_FARM_SHEARING_SHED"
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_SHEEP_FARM"
})

-- Register shearing shed building function
RanchExtensions:registerAsset({
    DataType = "BUILDING_FUNCTION_WORKER_CAPACITY_EXTENDER",
    Id = "BUILDING_FUNCTION_SHEEP_FARM_SHEARING_SHED",
    -- BUILDING_FUNCTION base values
    Name = "BUILDING_FUNCTION_SHEARING_SHED_NAME",
    Description = "BUILDING_FUNCTION_SHEARING_SHED_DESC",
    -- WORKER_CAPACITY_EXTENDER values
    WorkerCapacity = 1
})


-- Register dairy barn as a dairy farm extension
RanchExtensions:registerAsset({
    DataType = "BUILDING_PART",
    -- BUILDING_PART base values
    Id = "BUILDING_PART_SHEEP_FARM_SHEARING_SHED",
    Name = "SHEARING_SHED_NAME",
    Description = "SHEARING_SHED_DESC",
    -- Affects the tab the part is under
    Category = BUILDING_PART_TYPE.IMPROVEMENT,
    -- Only allow 2 per farm
    HasMaximumInstancePerBuilding = true,
    MaximumInstancePerBuilding = 2,
    -- Constructor
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_SHEARING_SHED"
    },
    -- Assign the building function
    AssetBuildingFunction = "BUILDING_FUNCTION_SHEEP_FARM_SHEARING_SHED",
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
                { Resource = "GOLD_COINS", Quantity = 2 },
            }
        },
        ResourceNeededList = {
            Collection = {
                { Resource = "TOOL", Quantity = 1 },
                { Resource = "WOOD", Quantity = 10 },
            }
        }
    },
    -- Capacity is like the size value in the manor house
    -- Compare to sheep farm core in game
    UndesirabilityValue = 1.5

})

-- Create the unlock option
RanchExtensions:registerAsset({
    DataType = "UNLOCKABLE_TECHNOLOGY",
    Id = "UNLOCKABLE_SHEEP_FARMING_IMPROVEMENT",
    Name = "SHEEP_FARMING_IMPROVEMENT_NAME",
    Description = "SHEEP_FARMING_IMPROVEMENT_DESC",
    DataCost = {
        ResourceCollection = {
            { Resource = "GOLD_COINS", Quantity = 100 },
        }
    },
    PrerequisiteUnlockableList = {
        "UNLOCKABLE_COMMON_CLOTHING_PRODUCTION"
    },
    ActionList = {
        {
            DataType = "GAME_ACTION_UNLOCK_BUILDING_LIST",
            BuildingProgressData = {
                AdditionalBuildingUnlockList = {
                    {
                        OwnerBuilding = "BUILDING_SHEEP_FARM",
                        AssetBuildingPartList = {
                            "BUILDING_PART_SHEEP_FARM_SHEARING_SHED",
                        }
                    }
                }
            }
        }
    },
    UnlockableImage = "ICON_RESOURCE_WOOL"
})

-- Add the unlock option to the common path in tier 5
RanchExtensions:overrideAsset({
    Id = "PROGRESS_TIER_COMMON_T3",
    UnlockableList = {
        Action = "APPEND",
        "UNLOCKABLE_SHEEP_FARMING_IMPROVEMENT"
    }
})