local pop = {}

local numPopOnCooldown = 0

local minRadius = 50

local popSpawns = {
    ["COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF"] = {
        onGround = true,
        vec3(1812.889,-1141.925,41.396)
    },
    ["COMPOSITE_LOOTABLE_ORCHID_VANILLA_DEF"] = {
        vec3(1788.356,-1046.161,42.064),
    }
}

local pop = {}

--[[
     ['COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF'] = {
         [1] = 51561,
     }
]]
Citizen.CreateThread(
    function()
        -- while true do
            Citizen.Wait(1000)

            for compositeHashAsString, v in pairs(popSpawns) do
                local compositeHash = GetHashKey(compositeHashAsString)
                local onGround = v.onGround or true

                if not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) then
                    Citizen.InvokeNative(0x73F0D0327BFA0812, compositeHash)

                    while not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) do
                        Citizen.Wait(10)
                    end
                end

                for index, vect in pairs(v) do
                    if type(vect) == "vector3" then
                        local x, y, z = table.unpack(vect)
                        local composite = exports["vp_herb_population"]:NativeCreateComposite(compositeHash, x, y, z, onGround)

                        if pop[compositeHashAsString] == nil then
                            pop[compositeHashAsString] = {}
                        end

                        table.insert(pop[compositeHashAsString], composite)
                    end
                end
            end
        -- end
    end
)

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)

--             local pPosition = GetEntityCoords(PlayerPedId())

--             for _, scenario in pairs(pop) do
--                 Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFF, pPosition,  NativeGetScenarioCoords(scenario),255, 0, 0, 255)
--             end
--         end
--     end
-- )

function DestroyHerbs()
    for _, v in pairs(pop) do
        for index, composite in pairs(v) do
            NativeDeleteComposite(composite)
        end
    end
    pop = {}
end

function NativeDeleteScenarioPoint(scenario)
    Citizen.InvokeNative(0x81948DFE4F5A0283, scenario)
end

function NativeGetScenarioCoords(scenario)
    return Citizen.InvokeNative(0xA8452DD321607029, scenario, true, Citizen.ResultAsVector())
end

function NativeDeleteComposite(composite)
    Citizen.InvokeNative(0x5758B1EE0C3FD4AC, composite, 0)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            DestroyHerbs()
        end
    end
)

function indexOf(v)
    for i, s in pairs(sessionQueue) do
        if s == v then
            return i
        end
    end
end

RegisterCommand(
    "eagleeye",
    function()
        Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, PlayerId(), 1) -- ENABLE_EAGLE_EYE(PLayer player, BOOL, enable)
        Citizen.InvokeNative(0x28A13BF6B05C3D83, PlayerId(), 1) -- SETS DEADEYE/EAGLEEYE INFINITE
    end,
    false
)

-- COMPOSITE_LOOTABLE_AGARITA_DEF, 106
-- COMPOSITE_LOOTABLE_ALASKAN_GINSENG_ROOT_DEF, 104
-- COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF, 104
-- COMPOSITE_LOOTABLE_BAY_BOLETE_DEF, 104
-- COMPOSITE_LOOTABLE_BITTERWEED_DEF, 106
-- COMPOSITE_LOOTABLE_BITTERWEED_INTERACTABLE_DEF, 2
-- COMPOSITE_LOOTABLE_BLACK_BERRY_DEF, 104
-- COMPOSITE_LOOTABLE_BLACK_CURRANT_DEF, 104
-- COMPOSITE_LOOTABLE_BLOODFLOWER_DEF, 106
-- COMPOSITE_LOOTABLE_BLOODFLOWER_INTERACTABLE_DEF, 2
-- COMPOSITE_LOOTABLE_BURDOCK_ROOT_DEF, 106
-- COMPOSITE_LOOTABLE_CARDINAL_FLOWER_DEF, 106
-- COMPOSITE_LOOTABLE_CARDINAL_FLOWER_INTERACTABLE_DEF, 2
-- COMPOSITE_LOOTABLE_CHANTERELLES_DEF, 104
-- COMPOSITE_LOOTABLE_CHOC_DAISY_DEF, 106
-- COMPOSITE_LOOTABLE_CHOC_DAISY_INTERACTABLE_DEF, 2
-- COMPOSITE_LOOTABLE_COMMON_BULRUSH_DEF, 104
-- COMPOSITE_LOOTABLE_CREEKPLUM_DEF, 106
-- COMPOSITE_LOOTABLE_CREEPING_THYME_DEF, 104
-- COMPOSITE_LOOTABLE_DESERT_SAGE_DEF, 104
-- COMPOSITE_LOOTABLE_DUCK_EGG_5_DEF, 4
-- COMPOSITE_LOOTABLE_ENGLISH_MACE_DEF, 106
-- COMPOSITE_LOOTABLE_EVERGREEN_HUCKLEBERRY_DEF, 104
-- COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF, 104
-- COMPOSITE_LOOTABLE_GOOSE_EGG_4_DEF, 4
-- COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF, 104
-- COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF, 104
-- COMPOSITE_LOOTABLE_LOON_EGG_3_DEF, 4
-- COMPOSITE_LOOTABLE_MILKWEED_DEF, 106
-- COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF, 106
-- COMPOSITE_LOOTABLE_ORCHID_ACUNA_STAR_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_CIGAR_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_CLAM_SHELL_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_DRAGONS_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_GHOST_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_LADY_NIGHT_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_LADY_SLIPPER_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_MOCCASIN_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_NIGHT_SCENTED_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_QUEENS_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_RAT_TAIL_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_SPARROWS_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_SPIDER_DEF, 104
-- COMPOSITE_LOOTABLE_ORCHID_VANILLA_DEF, 104
-- COMPOSITE_LOOTABLE_OREGANO_DEF, 104
-- COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF, 104
-- COMPOSITE_LOOTABLE_PRAIRIE_POPPY_DEF, 104
-- COMPOSITE_LOOTABLE_RAMS_HEAD_DEF, 104
-- COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF, 104
-- COMPOSITE_LOOTABLE_RED_SAGE_DEF, 104
-- COMPOSITE_LOOTABLE_TEXAS_BONNET_DEF, 106
-- COMPOSITE_LOOTABLE_TEXAS_BONNET_INTERACTABLE_DEF, 2
-- COMPOSITE_LOOTABLE_VIOLET_SNOWDROP_DEF, 104
-- COMPOSITE_LOOTABLE_VULTURE_EGG_DEF, 2
-- COMPOSITE_LOOTABLE_WILD_CARROT_DEF, 104
-- COMPOSITE_LOOTABLE_WILD_FEVERFEW_DEF, 104
-- COMPOSITE_LOOTABLE_WILD_MINT_DEF, 104
-- COMPOSITE_LOOTABLE_WILD_RHUBARB_DEF, 106
-- COMPOSITE_LOOTABLE_WILD_RHUBARB_INTERACTABLE_DEF, 2
-- COMPOSITE_LOOTABLE_WINTERGREEN_BERRY_DEF, 104
-- COMPOSITE_LOOTABLE_WISTERIA_DEF, 106
-- COMPOSITE_LOOTABLE_YARROW_DEF, 106
