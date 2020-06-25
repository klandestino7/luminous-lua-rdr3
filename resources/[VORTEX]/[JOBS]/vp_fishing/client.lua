local fishing_minigame_struct = {}

local fishing_lure_cooldown = 0

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            GET_TASK_FISHING_DATA()

            for i = 0, 22 do
                local k = "f_" .. i
                local v = fishing_minigame_struct[k]

                if v ~= nil then
                    DrawTxt(k, 0.65, 0.05 + (i * 0.025), 0.4, 0.4, true, 247, 88, 20, 255, false)
                    DrawTxt("" .. v, 0.75, 0.05 + (i * 0.025), 0.4, 0.4, true, 247, 88, 20, 255, false)
                end
            end
            if hasMinigameOn then
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

                    -- if FISHING_GET_LINE_DISTANCE() < 4.0 then
                    --     FISHING_SET_F_14(1.0)
                    -- else
                    --     FISHING_SET_F_14(0.4)
                    -- end

                    -- FISHING_SET_TRANSITION_FLAG(FISHING_GET_TRANSITION_FLAG() | 2048)

                    for _, fishHandle in pairs(GetNearbyFishs(hookPosition, 10.0)) do
                        local fishPosition = GetEntityCoords(fishHandle)

                        Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, fishPosition, fishPosition + vec3(0, 0, 2.0), 255, 255, 0, 255)

                        if fishing_lure_cooldown <= GetGameTimer() then
                            local dist = #(hookPosition - fishPosition)
                            if dist <= 1.0 then
                                -- Citizen.InvokeNative(0x978AA2323ED32209, bobberHandle, 0.0)
                                -- Citizen.InvokeNative(0x978AA2323ED32209, hookHandle, 0.0)
                                ClearPedTasksImmediately(fishHandle)
                                Citizen.InvokeNative(0x1A52076D26E09004, playerPed, fishHandle)

                                FISHING_SET_FISH_HANDLE(fishHandle)
                                -- FISHING_SET_TRANSITION_FLAG(4) -- 8196

                                -- FISHING_SET_TRANSITION_FLAG(FISHING_GET_TRANSITION_FLAG() | 8196)

                                FISHING_SET_TRANSITION_FLAG(4)

                                local bobberHandle = FISHING_GET_BOBBER_HANDLE()
                                break
                            else
                                -- end
                                -- if GetScriptTaskStatus(fishHandle, 1227113341, true) ~= 1 and GetScriptTaskStatus(fishHandle, 1227113341, true) ~= 0 then
                                TaskGoToEntity(fishHandle, hookHandle, 1000, 0.5, 2.0, 2.0, 0)
                            end

                            if lured == false then
                                print("lured")
                                lured = true
                            end
                        end
                    end

                    if lured then
                        fishing_lure_cooldown = GetGameTimer() + (1 * 1000)
                    end
                end

                if FISHING_GET_MINIGAME_STATE() == 7 then
                    local fishHandle = FISHING_GET_FISH_HANDLE()

                    -- if FISHING_GET_F_5() & 2 then
                    --     SetPedResetFlag(fishHandle, 167, true)
                    -- end

                    -- if FISHING_GET_LINE_DISTANCE() < 4.0 then
                    --     FISHING_SET_F_14(1.0)
                    -- else
                    --     FISHING_SET_F_14(1.0)
                    -- end

                    FISHING_SET_F_14(1.0)

                    -- FISHING_SET_TRANSITION_FLAG(FISHING_GET_TRANSITION_FLAG() | 2048)

                    local fishHeading = GetEntityHeading(fishHandle)
                    local playerHeading = GetEntityHeading(playerPed)

                    local diff = (fishHeading - playerHeading)

                    if diff < 0.0 then
                        diff = diff + 360.0
                    end
                    if diff > 180.0 then
                    end

                    -- FISHING_SET_TRANSITION_FLAG(16)

                    -- if FISHING_GET_F_18() == 4 then
                    --     ClearPedTasks(fishHandle)
                    --     TaskGoToEntity(fishHandle, playerPed, -1, 0.5, 2.0, 2.0, 0)
                    -- end

                    if not IsPedFleeing(fishHandle) then
                        print('flee')
                        -- ClearPedTasks(fishHandle, 1, 0)
                        TaskSmartFleePed(fishHandle, playerPed, 40.0, 20000, 8, 1077936128)
                    end

                    if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                        -- RETRAIR A LINHA TODA
                        -- FISHING_SET_TRANSITION_FLAG(8)

                        ClearPedTasks(fishHandle)
                        TaskGoToEntity(fishHandle, playerPed, -1, 0.1, 1.0, 0.1, 1)

                        -- 124 : VER PEIXE LADO ESQUERDO
                        FISHING_SET_F_18(4)
                    end

                    if IsControlJustReleased(0, GetHashKey("INPUT_ATTACK")) then
                        FISHING_SET_F_18(2)
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
        f_21 = outAsFloat["42"]
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

function FISHING_GET_MINIGAME_STATE()
    return fishing_minigame_struct.f_0
end

function FISHING_GET_MAX_THROWING_DISTANCE()
    return fishing_minigame_struct.f_1
end

function FISHING_GET_LINE_DISTANCE()
    return fishing_minigame_struct.f_2
end

function FISHING_GET_F_3()
    return fishing_minigame_struct.f_3
end
function FISHING_GET_F_4()
    return fishing_minigame_struct.f_4
end

function FISHING_IS_TRYING_TO_HOOK()
    return fishing_minigame_struct.f_5
end

function FISHING_GET_TRANSITION_FLAG()
    return fishing_minigame_struct.f_6
end

function FISHING_GET_FISH_HANDLE()
    return fishing_minigame_struct.f_7
end

function FISHING_GET_CALCULATED_FISH_WEIGHT()
    return fishing_minigame_struct.f_8
end

-- Fish current power?
function FISHING_GET_F_9()
    return fishing_minigame_struct.f_9
end

function FISHING_GET_SCRIPT_TIMER()
    return fishing_minigame_struct.f_10
end

function FISHING_GET_BOBBER_HANDLE()
    return fishing_minigame_struct.f_11
end

function FISHING_GET_HOOK_HANDLE()
    return fishing_minigame_struct.f_12
end

function FISHING_GET_F_18()
    return fishing_minigame_struct.f_18
end

function FISHING_SET_LINE_DISTANCE(distance)
    fishing_minigame_struct.f_2 = distance
    SET_TASK_FISHING_DATA()
end

function FISHING_SET_FISH_HANDLE(handle)
    fishing_minigame_struct.f_7 = handle
    SET_TASK_FISHING_DATA()
end

function FISHING_SET_TRANSITION_FLAG(flag)
    fishing_minigame_struct.f_6 = flag
    SET_TASK_FISHING_DATA()
end

function FISHING_SET_F_14(v)
    fishing_minigame_struct.f_14 = v
    SET_TASK_FISHING_DATA()
end

function FISHING_SET_F_18(v)
    fishing_minigame_struct.f_18 = v
    SET_TASK_FISHING_DATA()
end

RegisterCommand(
    "bait",
    function(source, args, raw)
        Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "P_FINISHDCRAWDLEGENDARY01X", 0, 1)
        fishing_minigame_struct.f_0 = 1
        SET_TASK_FISHING_DATA()
    end,
    false
)

RegisterCommand(
    "setf",
    function(source, args, raw)
        -- if not hasMinigameOn then
        --     return
        -- end

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
    f_5 = Is picking. / Is trying to hook
    f_6 = Transition flag (4 if for 6 -> 7, 512 is unknown for now).
    f_7 = Fish entity handle.
    f_8 = Calculated fish weight (value / 54.25).
    f_9 = Fish current power?
    f_10 = Script timer.
    f_11 = Bobber Entity
    f_12 = Hook Entity
    f_13 = Rod shaking float.
    f_14 = float
    f_15 = float
    f_16 = Unk int. (Some state?)
    f_17 = Going to fight shake? (float)
    f_18 = Fish size index. (0 - 4 or so). / REEL (4) WHEN ON STATE 7
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
