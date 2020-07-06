local fishing_minigame_struct = {}

local fishing_lure_cooldown = 0

local fishing_data = {
    fish = {
        weight,
        rodweight
    },
    prompts = {
        prompt_reset_cast,
        prompt_hook,
        prompt_reel_in,
        prompt_control,
        prompt_throw_back,
        prompt_keep
    }
}

Citizen.CreateThread(
    function()
        Citizen.InvokeNative(0x1096603B519C905F, "MMFSH")

        local sleep = 100

        while true do


            GET_TASK_FISHING_DATA()

            if IsControlJustPressed(0, GetHashKey("INPUT_MINIGAME_FISHING_MANUAL_REEL_IN")) then
                print("reel in")
            end

            for i = 0, 27 do
                local k = "f_" .. i
                local v = fishing_minigame_struct[k]

                if v ~= nil then
                    DrawTxt(k, 0.65, 0.05 + (i * 0.025), 0.4, 0.4, true, 247, 88, 20, 255, false)
                    DrawTxt("" .. v, 0.75, 0.05 + (i * 0.025), 0.4, 0.4, true, 247, 88, 20, 255, false)
                end
            end

            if hasMinigameOn then

                sleep = 0

                local playerPed = PlayerPedId()

                if FISHING_GET_MINIGAME_STATE() == 1 then
                end

                if FISHING_GET_MINIGAME_STATE() == 2 then
                -- FISHING_GET_MAX_THROWING_DISTANCE(math.random(25.0, 30.0))
                -- print(0 - (0 & 2048), 0 | 1024)
                -- FISHING_SET_TRANSITION_FLAG(FISHING_GET_TRANSITION_FLAG() | 1024)
                end

                if FISHING_GET_MINIGAME_STATE() == 6 then
                    local bobberPosition = FISHING_GET_BOBBER_HANDLE()

                    local hookHandle = FISHING_GET_HOOK_HANDLE()
                    local hookPosition = GetEntityCoords(hookHandle)

                    local lured = false

                    if FISHING_GET_LINE_DISTANCE() < 4.0 then
                        FISHING_SET_F_(14, 1.0)
                    else
                        FISHING_SET_F_(14, 0.4)
                    end

                    local fishHandle

                    for _, f in pairs(GetNearbyFishs(hookPosition, 10.0)) do
                        local fishPosition = GetEntityCoords(f)

                        Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, fishPosition, fishPosition + vec3(0, 0, 2.0), 255, 255, 0, 255)

                        if fishing_lure_cooldown <= GetGameTimer() then
                            local dist = #(hookPosition - fishPosition)
                            if dist <= 1.0 then
                                fishHandle = f
                            else
                                TaskGoToEntity(f, hookHandle, 500, 0.5, 2.0, 2.0, 0)
                            end

                            if lured == false then
                                lured = true
                            end
                        end
                    end

                    if lured then
                        fishing_lure_cooldown = GetGameTimer() + (1 * 1000)
                    end

                    if fishHandle then
                        -- if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                        if FISHING_GET_F_(5) == 1 then
                            print("next")

                            Citizen.InvokeNative(0xF0FBF193F1F5C0EA, fishHandle)

                            SetPedConfigFlag(fishHandle, 17, true)

                            Citizen.InvokeNative(0x1F298C7BD30D1240, playerPed)

                            ClearPedTasksImmediately(fishHandle, false, true)

                            Citizen.InvokeNative(0x1A52076D26E09004, playerPed, fishHandle)
                            -- SET_FISHINGROD_HOOKED_ENTITY

                            FISHING_SET_FISH_HANDLE(fishHandle)

                            FISHING_SET_TRANSITION_FLAG(4)
                        end
                    end
                end

                if FISHING_GET_MINIGAME_STATE() == 7 then
                    local fishHandle = FISHING_GET_FISH_HANDLE()

                    -- if FISHING_GET_F_(5) & 2 then
                    --     SetPedResetFlag(fishHandle, 167, true)
                    -- end

                    -- Unused?
                    if FISHING_GET_LINE_DISTANCE() < 4.0 then
                        FISHING_SET_F_(14, 1.0)
                    else
                        FISHING_SET_F_(14, 1.0)
                    end

                    local fishHeading = GetEntityHeading(fishHandle)
                    local playerHeading = GetEntityHeading(playerPed)

                    local diff = (fishHeading - playerHeading)

                    local unk0 = 0

                    if diff < 0.0 then
                        diff = diff + 360.0
                    end

                    if diff >= 180.0 then
                        unk0 = 4
                    else
                        unk0 = 3
                    end

                    local controlNormal = GetControlNormal(0, 0xD6C4ECDC) -- * 127.0

                    -- ->f_470 -- 57.42
                    -- func_247 fishweight

                    -- print(controlNormal)

                    FISHING_SET_ROD_POSITION_LR(1.0 - controlNormal)

                    local unk1 = GetGameTimer() / 1000.0

                    if unk0 == 4 then
                        if controlNormal < -25.0 then
                            -- print("unk1", unk1)

                            TaskGoToEntity(fishHandle, playerPed, unk1, 0.5, 2.0, 2.0, 0)
                        else
                        end
                    else
                        if controlNormal > 25.0 then
                            -- print("unk1-2", unk1)
                            TaskGoToEntity(fishHandle, playerPed, unk1, 0.5, 2.0, 2.0, 0)
                        else
                        end
                    end

                    if GetGameTimer() % 100 == 0 then
                        print("oi")


                        local chance_flee = 0.8
                        local chance_go_to = 0.2

                        if FISHING_GET_F_(18) == 4 then
                            chance_flee = 0.2
                            chance_go_to = 0.8
                        end

                        local r = math.random()

                        if r <= chance_go_to then
                            print("go to")

                            -- SetBlockingOfNonTemporaryEvents(fishHandle, true)
                            -- ClearPedTasks(fishHandle)
                            TaskGoToEntity(fishHandle, playerPed, 2000, 0.1, 1.0, 0.1, 1)
                        else
                            print("flee")

                            -- SetBlockingOfNonTemporaryEvents(fishHandle, true)
                            -- ClearPedTasks(fishHandle, 1, 0)

                            TaskSmartFleeCoord(fishHandle, GetEntityCoords(playerPed), 40.0, 2000, 8, 1077936128)
                        end
                    end

                    -- if GetScriptTaskStatus(fishHandle, 1139527981) == 8 and GetScriptTaskStatus(fishHandle, -773337285) == 8 and not IsPedFleeing(fishHandle) then
                    --     SetBlockingOfNonTemporaryEvents(fishHandle, true)
                    --     ClearPedTasks(fishHandle, 1, 0)

                    --     TaskSmartFleeCoord(fishHandle, GetEntityCoords(playerPed), 40.0, 20000, 8, 1077936128)
                    -- end

                    if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                        -- ClearPedTasks(fishHandle)
                        -- TaskGoToEntity(fishHandle, playerPed, -1, 0.1, 1.0, 0.1, 1)

                        FISHING_SET_ROD_WEIGHT(4)

                        FISHING_SET_ROD_POSITION_UD(1.0)
                    end

                    if IsControlJustReleased(0, GetHashKey("INPUT_ATTACK")) then
                        FISHING_SET_ROD_WEIGHT(fishing_data.fish.rodweight or 2)

                        FISHING_SET_ROD_POSITION_UD(-1.0)
                    end
                end

                if FISHING_GET_MINIGAME_STATE() == 12 then
                    -- FICAR COM O PEIXE
                    if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                        -- FISHING_SET_TRANSITION_FLAG(FISHING_GET_TRANSITION_FLAG() | 32)
                        FISHING_SET_TRANSITION_FLAG(32)
                    end

                    -- JOGAR O PEIXE DE VOLTA
                    if IsControlJustPressed(0, GetHashKey("INPUT_AIM")) then
                        -- FISHING_SET_TRANSITION_FLAG(FISHING_GET_TRANSITION_FLAG() | 64)
                        FISHING_SET_TRANSITION_FLAG(64)
                    end
                end

                if IsControlJustPressed(0, GetHashKey("INPUT_TOGGLE_HOLSTER")) then
                    -- FISHING_SET_TRANSITION_FLAG(32768)
                    FISHING_SET_TRANSITION_FLAG(8)
                end
            end

            Citizen.Wait(sleep)
        end
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 4)
    DisplayText(str, x, y)
end

RegisterCommand(
    "garmas",
    function()
        RemoveAllPedWeapons(PlayerPedId(), true, true)
    end,
    false
)

function GET_TASK_FISHING_DATA()
    local r = exports["research"]:GET_TASK_FISHING_DATA()

    hasMinigameOn = r[1]
    local outAsInt = r[2]
    local outAsFloat = r[3]

    fishing_minigame_struct = {}

    fishing_minigame_struct = {
        f_0 = outAsInt["0"],
        f_1 = outAsFloat["2"],
        f_2 = outAsFloat["4"],
        f_3 = outAsFloat["6"],
        f_4 = outAsFloat["8"],
        f_5 = outAsInt["10"],
        f_6 = outAsInt["12"],
        f_7 = outAsInt["14"],
        f_8 = outAsFloat["16"],
        f_9 = outAsFloat["18"],
        f_10 = outAsInt["20"],
        f_11 = outAsInt["22"],
        f_12 = outAsInt["24"],
        f_13 = outAsFloat["26"],
        f_14 = outAsFloat["28"],
        f_15 = outAsFloat["30"],
        f_16 = outAsInt["32"],
        f_17 = outAsFloat["34"],
        f_18 = outAsInt["36"],
        f_19 = outAsInt["38"],
        f_20 = outAsFloat["40"],
        f_21 = outAsFloat["42"],
        f_22 = outAsFloat["44"], -- Rod position [LEFT-RIGHT] -1.0: Center, 0.0: Right, 1.0: Left
        f_23 = outAsFloat["46"], -- Rod position [UP-DOWN] -1.0: Center, 0.0: Down, 1.0: Up
        f_24 = outAsFloat["48"], -- 7.0 - 15.0
        f_25 = outAsFloat["50"], -- 10.0 - 20.0
        f_26 = outAsFloat["52"],
        f_27 = outAsFloat["54"] -- Radians/Degrees
    }
end

function SET_TASK_FISHING_DATA()
    if fishing_minigame_struct.f_0 ~= nil then
        exports["research"]:SET_TASK_FISHING_DATA(fishing_minigame_struct)
    end
end

function FISHING_HAS_MINIGAME_ON()
    return hasMinigameOn
end

function FISHING_GET_F_(f)
    return fishing_minigame_struct["f_" .. f]
end

function FISHING_GET_MINIGAME_STATE()
    return FISHING_GET_F_(0)
end

function FISHING_GET_MAX_THROWING_DISTANCE()
    return FISHING_GET_F_(1)
end

function FISHING_GET_LINE_DISTANCE()
    return FISHING_GET_F_(2)
end

function FISHING_GET_TRANSITION_FLAG()
    return FISHING_GET_F_(6)
end

function FISHING_GET_FISH_HANDLE()
    return FISHING_GET_F_(7)
end

function FISHING_GET_CALCULATED_FISH_WEIGHT()
    return FISHING_GET_F_(8)
end

-- Fish current power?
function FISHING_GET_F_9()
    return FISHING_GET_F_(9)
end

function FISHING_GET_SCRIPT_TIMER()
    return FISHING_GET_F_(10)
end

function FISHING_GET_BOBBER_HANDLE()
    return FISHING_GET_F_(11)
end

function FISHING_GET_HOOK_HANDLE()
    return FISHING_GET_F_(12)
end

function FISHING_SET_F_(f, v)
    fishing_minigame_struct["f_" .. f] = v
    SET_TASK_FISHING_DATA()
end

function FISHING_SET_LINE_DISTANCE(v)
    FISHING_SET_F_(2, v)
end

function FISHING_SET_TRANSITION_FLAG(v)
    FISHING_SET_F_(6, v)
end

function FISHING_SET_FISH_HANDLE(v)
    FISHING_SET_F_(7, v)

    local weight_index = FishModelToSomeSortOfWeightIndex(GetEntityModel(v))

    FISHING_SET_CALCULATED_FISH_WEIGHT(GetRandomFishWeightForWeightIndex(weight_index) / 54.25)

    fishing_data.fish.rodweight = 2
    FISHING_SET_ROD_WEIGHT(fishing_data.fish.rodweight)
end

function FISHING_SET_CALCULATED_FISH_WEIGHT(v)
    fishing_data.fish.weight = v * 54.25

    FISHING_SET_F_(8, v)
end

function FISHING_SET_ROD_WEIGHT(v)
    FISHING_SET_F_(18, v)
end

--[[
    [LEFT-RIGHT] -1.0: Center, 0.0: Right, 1.0: Left
]]
function FISHING_SET_ROD_POSITION_LR(v)
    FISHING_SET_F_(22, v)
end

--[[
    [UP-DOWN] -1.0: Center, 0.0: Down, 1.0: Up
]]
function FISHING_SET_ROD_POSITION_UD(v)
    FISHING_SET_F_(23, v)
end

RegisterCommand(
    "bait",
    function(source, args, raw)
        Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "P_FINISHDCRAWDLEGENDARY01X", 0, 1)
    end,
    false
)

RegisterCommand(
    "fset",
    function(source, args, raw)
        if tonumber(args[2]) then
            args[2] = tonumber(args[2])
        end

        fishing_minigame_struct["f_" .. args[1]] = args[2]
        SET_TASK_FISHING_DATA()
    end,
    false
)

RegisterCommand(
    "hook",
    function(source, args, rawCommand)
        Citizen.InvokeNative(0x1A52076D26E09004, PlayerPedId(), tonumber(args[1]))
    end
)

RegisterCommand(
    "fish",
    function(source, args, rawCommand)
        local r = {
            "A_C_FISHBLUEGIL_01_SM",
            "A_C_FISHBULLHEADCAT_01_SM",
            "A_C_FISHCHAINPICKEREL_01_SM",
            "A_C_FISHCHANNELCATFISH_01_LG",
            "A_C_FISHLAKESTURGEON_01_LG",
            "A_C_FISHLARGEMOUTHBASS_01_MS",
            "A_C_FISHLONGNOSEGAR_01_LG",
            "A_C_FISHMUSKIE_01_LG",
            "A_C_FISHNORTHERNPIKE_01_LG",
            "A_C_FISHPERCH_01_SM",
            "A_C_FISHREDFINPICKEREL_01_SM",
            "A_C_FISHROCKBASS_01_SM",
            "A_C_FISHSMALLMOUTHBASS_01_MS",
            "A_C_FISHSALMONSOCKEYE_01_MS",
            "A_C_FISHRAINBOWTROUT_01_MS"
        }

        local pedModel = r[math.random(1, #r)]

        local pedModelHash = GetHashKey(pedModel)
        if not IsModelValid(pedModelHash) then
            print("model is not valid")
            return
        end

        if not HasModelLoaded(pedModelHash) then
            RequestModel(pedModelHash)
            while not HasModelLoaded(pedModelHash) do
                Citizen.Wait(10)
            end
        end

        local plped = PlayerPedId()
        local forward = GetEntityForwardVector(plped)
        local c = GetEntityCoords(plped) + (forward * 10.0)

        local ped = CreatePed(pedModelHash, c, GetEntityHeading(plped), 1, 0)
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
        print(ped)
    end
)

function GetNearbyFishs(coords, radius)
    local r = {}

    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, coords, radius, itemSet, 1, Citizen.ResultAsInteger())
    -- number xPos, number yPox, number zPos, float distance, int itemSet, int entityType

    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            if GetEntityPopulationType(entity) == 6 and not IsPedDeadOrDying(entity, 0) then
                table.insert(r, entity)
            end
        end
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end

    return r
end

function FishModelToSomeSortOfWeightIndex(fishModel)
    if fishModel == GetHashKey("A_C_FISHBLUEGIL_01_SM") or fishModel == GetHashKey("A_C_FISHBLUEGIL_01_MS") then
        return 0
    elseif fishModel == GetHashKey("A_C_FISHBULLHEADCAT_01_MS") or fishModel == GetHashKey("A_C_FISHBULLHEADCAT_01_SM") then
        return 1
    elseif fishModel == GetHashKey("A_C_FISHCHAINPICKEREL_01_MS") or fishModel == GetHashKey("A_C_FISHCHAINPICKEREL_01_SM") then
        return 2
    elseif fishModel == GetHashKey("A_C_FISHCHANNELCATFISH_01_XL") or fishModel == GetHashKey("A_C_FISHCHANNELCATFISH_01_LG") then
        return 3
    elseif fishModel == GetHashKey("A_C_FISHLAKESTURGEON_01_LG") then
        return 4
    elseif fishModel == GetHashKey("A_C_FISHLARGEMOUTHBASS_01_MS") or fishModel == GetHashKey("A_C_FISHLARGEMOUTHBASS_01_LG") then
        return 5
    elseif fishModel == GetHashKey("A_C_FISHLONGNOSEGAR_01_LG") then
        return 6
    elseif fishModel == GetHashKey("A_C_FISHMUSKIE_01_LG") then
        return 7
    elseif fishModel == GetHashKey("A_C_FISHNORTHERNPIKE_01_LG") then
        return 8
    elseif fishModel == GetHashKey("A_C_FISHPERCH_01_MS") or fishModel == GetHashKey("A_C_FISHPERCH_01_SM") then
        return 9
    elseif fishModel == GetHashKey("A_C_FISHREDFINPICKEREL_01_MS") or fishModel == GetHashKey("A_C_FISHREDFINPICKEREL_01_SM") then
        return 10
    elseif fishModel == GetHashKey("A_C_FISHROCKBASS_01_MS") or fishModel == GetHashKey("A_C_FISHROCKBASS_01_SM") then
        return 11
    elseif fishModel == GetHashKey("A_C_FISHSMALLMOUTHBASS_01_LG") or fishModel == GetHashKey("A_C_FISHSMALLMOUTHBASS_01_MS") then
        return 12
    elseif fishModel == GetHashKey("A_C_FISHSALMONSOCKEYE_01_MS") or fishModel == GetHashKey("A_C_FISHSALMONSOCKEYE_01_LG") then
        return 13
    elseif fishModel == GetHashKey("A_C_FISHRAINBOWTROUT_01_LG") or fishModel == GetHashKey("A_C_FISHRAINBOWTROUT_01_MS") then
        return 14
    end
end

function GetMinWeightForWeightIndex(index)
    local w = 0.0

    if index == 0 or index == 1 or index == 3 or index == 9 or index == 10 or index == 11 then
        w = 0.5
    elseif index == 3 or index == 4 or index == 6 or index == 7 or index == 8 then
        w = 14.0
    elseif index == 5 or index == 12 or index == 13 or index == 14 then
        w = 4.0
    end

    w = w * 0.25

    -- w = w + (w * 0.5)

    return w
end

function GetMaxWeightForWeightIndex(index)
    local w = 0.0

    if index == 0 or index == 1 or index == 3 or index == 9 or index == 10 or index == 11 then
        w = 2.0
    elseif index == 3 or index == 4 or index == 6 or index == 7 or index == 8 then
        w = 20.0
    elseif index == 5 or index == 12 or index == 13 or index == 14 then
        w = 6.0
    end

    w = w * 0.25

    -- w = w + (w * 0.5)

    return w
end

function GetRandomFishWeightForWeightIndex(index)
    local min = GetMinWeightForWeightIndex(index)
    local max = GetMaxWeightForWeightIndex(index)

    local weight = math.random() * (max - min) + min

    -- implement fishing_core:func_377 ?

    return weight
end

-- uParam0->f_18 = GRAPHICS::START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_mg_fishing_drips", Global_1902942->f_5.f_7, 0f, 0f, 0f, 0f, 0f, 0f, ENTITY::GET_ENTITY_BONE_INDEX_BY_NAME(Global_1902942->f_5.f_7, "SKEL_Tail5"), 1065353216, 0, 0, 0);
-- 	GRAPHICS::SET_PARTICLE_FX_LOOPED_EVOLUTION(uParam0->f_18, "fade", uParam0->f_19, false);
-- GRAPHICS::START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_mg_fish_struggle", vVar0, 0f, 0f, MISC::GET_RANDOM_FLOAT_IN_RANGE(0f, 360f), fVar3, 0, 0, 0);

-- if (!ENTITY::_0x0C9DBF48C6BA6E4C(PLAYER::PLAYER_PED_ID(),VCETOR3 vVar0, 1))

-- 0x53187E563F938E76
-- FISH MODEL SIZE??

-- ENTITY::_0x978AA2323ED32209(Local_5.f_5, 0f);

-- Global_1902942->f_5
-- Global_1902942->f_5.f_7

-- Global_1902942->f_5 == 7

--[[
    CURVATURE: FUNC_158
]]

--[[
// 0xF3735ACD11ACD500
Any _GET_TASK_FISHING_DATA(Ped ped, Any* structData);
/*
  STATES:
    0 = Not in fishing at all.
    1 = Idle (no aim).
    2 = Aiming.
    3 = Going to throw.
    4 = Throwing.
    5 = ??? (never seen, unused in scripts).
    6 = Fishing idle.
    7 = Fight with a fish (after the bait).
    8 = ??? (never seen). Removes prompts it seems.
    9 = Removes the float.
    10 = ??? (never seen).
    11 = ...
    12 = Holding fish in hand(s).
    13 = Changing bait.
  STRUCT:
    f_0 = Minigame state.
    f_1 = Throwing target distance (< 10 = close range, too small = you will not be able to throw).
    f_2 = Float distance (?). Always 0.2 when not throwed.
    f_3 = Float something. / Fishing line curvature
    f_4 = Unk float.
    f_5 = Is picking. / Flag
    f_6 = Transition flag (4 if for 6 -> 7, 512 is unknown for now).
    f_7 = Fish entity handle.
    f_8 = Calculated fish weight (value / 54.25).
    f_9 = Fish current power? / Heading?
    f_10 = Script timer.
    f_11 = Bobber Entity
    f_12 = Hook Entity
    f_13 = Rod shaking float.
    f_14 = float
    f_15 = float
    f_16 = Unk int. (Some state?)
    f_17 = Going to fight shake? (float)
    f_18 = Fish size index. (0 - 4 or so). / Setting to 4 when on state 7, will make you reel slowly
    f_19 = Unk.
    f_20 = Unk float.
    f_21 = Line break apart float.
  FLAGS:
    2: LINE_SNAP_BUG
    4: HOOKED_TURN_RIGHT
    8: CANCEL_FISHING
    128: REEL_IN11

    GODD:
    5: GOOD HOOK FISH STRUGGLE RIGHT
    12: GOOD FAST REEL IN
*/
--]]

-- Global_1902942->f_5.f_16
