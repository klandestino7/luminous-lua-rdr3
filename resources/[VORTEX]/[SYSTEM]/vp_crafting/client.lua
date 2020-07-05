local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local prompt_group

local prompt_craft
local prompt_cancel

local craftingNuiIsOpen = false
local shouldShowPrompt = false
local isCrafting = false
local craftingEndGameTimer
local selected_cGroup
local selected_cIndex
local selected_name
local selected_time

local _tempParsedConfig

RegisterNetEvent("VP:CRAFT:ShouldClose")
AddEventHandler(
    "VP:CRAFT:ShouldClose",
    function(clearTasks)
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        SendNUIMessage(
            {
                shouldClose = true
            }
        )

        craftingNuiIsOpen = false
        shouldShowPrompt = false

        if clearTasks == nil or clearTasks ~= false then
            ClearPosCrafting()
        end
    end
)

RegisterNUICallback(
    "shouldClose",
    function()
        TriggerEvent("VP:CRAFT:ShouldClose")
    end
)

RegisterNUICallback(
    "getRecipe",
    function(cb)
        if not _tempParsedConfig then
            return
        end

        local cGroup = cb.cGroup
        local cIndex = cb.cIndex

        local inputlist = deepcopy(_tempParsedConfig[cGroup].craftings[cIndex].input)

        shouldShowPrompt = true

        for _, d in pairs(inputlist) do
            if d.isActive == false then
                shouldShowPrompt = false
                break
            end
        end

        inputlist.time = _tempParsedConfig[cGroup].craftings[cIndex].time

        SendNUIMessage(
            {
                recipes = true,
                data = inputlist
            }
        )

        if shouldShowPrompt then
            PromptSetVisible(prompt_craft, true)
            PromptSetVisible(prompt_cancel, false)

            selected_cGroup = cGroup
            selected_cIndex = cIndex
            selected_name = _tempParsedConfig[cGroup].craftings[cIndex].output[1].name
            selected_time = inputlist.time
        end
    end
)

Citizen.CreateThread(
    function()
        prompt_group = GetRandomIntInRange(0, 0xffffff)

        prompt_craft = PromptRegisterBegin()
        PromptSetControlAction(prompt_craft, 0xDFF812F9)
        PromptSetText(prompt_craft, CreateVarString(10, "LITERAL_STRING", "Produzir"))
        PromptSetEnabled(prompt_craft, true)
        PromptSetVisible(prompt_craft, true)
        PromptSetHoldMode(prompt_craft, true)
        PromptSetGroup(prompt_craft, prompt_group)
        PromptRegisterEnd(prompt_craft)

        prompt_cancel = PromptRegisterBegin()
        -- 0x05CA7C52
        PromptSetControlAction(prompt_cancel, 0x05CA7C52)
        PromptSetText(prompt_cancel, CreateVarString(10, "LITERAL_STRING", "Cancelar"))
        PromptSetEnabled(prompt_cancel, true)
        PromptSetVisible(prompt_cancel, true)
        PromptSetHoldMode(prompt_cancel, true)
        PromptSetGroup(prompt_cancel, prompt_group)
        PromptRegisterEnd(prompt_cancel)

        while true do
            Citizen.Wait(0)

            local playerPed = PlayerPedId()

            if not craftingNuiIsOpen then
                if not isCrafting then
                    if IsControlJustPressed(0, 0x5966D52A) then
                        if not Citizen.InvokeNative(0x1BE19185B8AFE299, 0x5966D52A) then
                            local scenarioTypeHash = GetHashKey("WORLD_PLAYER_CAMP_FIRE_KNEEL4")
                            -- WORLD_PLAYER_DYNAMIC_KNEEL

                            local typePedIsUsing = Citizen.InvokeNative(0x2D0571BB55879DA2, playerPed)
                            if typePedIsUsing ~= scenarioTypeHash then
                                local playerPedPosition = GetEntityCoords(playerPed)

                                local retval, groundZ, normal = GetGroundZAndNormalFor_3dCoord(playerPedPosition.x, playerPedPosition.y, playerPedPosition.z)

                                local scenarioPosition = vec3(playerPedPosition.xy, groundZ)

                                local campfireModels = {
                                    "s_cookfire01x",
                                    "p_campfirecombined03x"
                                }

                                local campfireEntity = 0

                                for _, cmodel in pairs(campfireModels) do
                                    local e = GetClosestObjectOfType(playerPedPosition, 1.0, GetHashKey(cmodel), 0, 0, 0)
                                    if e ~= 0 then
                                        campfireEntity = e
                                        break
                                    end
                                end

                                local isNearCampfire = campfireEntity ~= 0

                                local scenario_heading = GetEntityHeading(playerPed)

                                local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, scenarioTypeHash, scenarioPosition, scenario_heading, 0, 0, 0)

                                local scenarioTransition = ""

                                -- if IsPedMale(playerPed) then
                                --     scenarioTransition = "WORLD_PLAYER_DYNAMIC_KNEEL_COOK_KNIFE_ARTHUR"
                                -- else
                                --     scenarioTransition = "WORLD_PLAYER_DYNAMIC_KNEEL_COOK_KNIFE_MP_FEMALE_A"
                                -- end

                                TaskUseScenarioPoint(playerPed, scenario, scenarioTransition, -1.0, true, false, 0, false, -1.0, true)

                                local craftingGroups = {}

                                for cGroup, d in pairs(Config) do
                                    local position = d.position
                                    if position == nil then
                                        if d.campfire then
                                            if isNearCampfire then
                                                table.insert(craftingGroups, cGroup)
                                            end
                                        else
                                            table.insert(craftingGroups, cGroup)
                                        end
                                    else
                                        local dist = #(playerPedPosition - position)

                                        if (dist <= (d.distance or 1.0)) then
                                            table.insert(craftingGroups, cGroup)
                                        end
                                    end
                                end

                                TriggerServerEvent("VP:CRAFTING:TryToOpenCrafting", craftingGroups)
                            end
                        end
                    end
                else
                    local typePedIsUsing = Citizen.InvokeNative(0x2D0571BB55879DA2, playerPed)

                    if typePedIsUsing ~= 0 then
                        DisableAllControlActions(0)
                        DisableAllControlActions(1)
                        DisableAllControlActions(2)

                        EnableControlAction(0, 0x05CA7C52, true)

                        PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", selected_name), 0, 0, 0, 0)

                        if craftingEndGameTimer <= GetGameTimer() then
                            TriggerServerEvent("VP:CRAFTING:FinishedCrafting", selected_cGroup, selected_cIndex)

                            ClearPosCrafting()
                        elseif PromptHasHoldModeCompleted(prompt_cancel) then
                            ClearPosCrafting()
                        else
                            PlayCraftingAnimation(playerPed)
                        end
                    else
                        ClearPosCrafting()
                    end
                end
            else
                DisableAllControlActions(0)
                DisableAllControlActions(1)
                DisableAllControlActions(2)

                SetGameplayCamRelativeHeading(0.0, 1.0)
                SetGameplayCamRelativePitch(0.0, 1.0)

                if shouldShowPrompt then
                    EnableControlAction(0, 0xDFF812F9, true)

                    PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", selected_name), 0, 0, 0, 0)

                    if PromptHasHoldModeCompleted(prompt_craft) then
                        isCrafting = true

                        PromptSetVisible(prompt_craft, false)
                        PromptSetVisible(prompt_cancel, true)

                        craftingEndGameTimer = GetGameTimer() + (selected_time * 1000)

                        TriggerEvent("VP:CRAFT:ShouldClose", false)

                    -- Citizen.InvokeNative(0x6FB1DA3CA9DA7D90, "cook_meat_sizzle_loop", playerPed, "Player_Campfire_Sounds", false, 0, 0)
                    -- Citizen.InvokeNative(0x9821B68CD3E05F2B, "distanceToFlame", 1.0, "cook_meat_sizzle_loop", "Player_Campfire_Sounds")

                    -- Animate_meatChunks()
                    end
                end
            end
        end
    end
)

--[[
function Animate_meatChunks()
    -- P_WHITEFISHFILET01XB
    -- P_REDFISHFILET01XB
    -- P_WHITEFLESHYMEAT01XB
    -- P_REDBIRDBREAST01XB
    -- P_REDEFLESHYMEAT01XB

    local modelHash = GetHashKey("p_meatChunks01x")

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
        end
    end

    local playerPed = PlayerPedId()

    local object = CreateObject(modelHash, GetEntityCoords(playerPed), false, false, false, false, true)
    local r = Citizen.InvokeNative(0x3BBDD6143FF16F98, playerPed, object, "p_meatChunks01x_PH_L_HAND", 0, 0, 1)
end
-]]
function PlayCraftingAnimation(playerPed)
    local animDict = "MECH_INVENTORY@CRAFTING@FALLBACKS@IN_HAND@MALE_A"

    if not IsPedMale(playerPed) then
        animDict = "MP_AMB_PLAYER@CRAFTING@FALLBACKS@IN_HAND@FEMALE_A"
    end

    if not IsEntityPlayingAnim(playerPed, animDict, "craft_trans_stow", 3) then
        if not HasAnimDictLoaded(animDict) then
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(0)
            end
        end

        -- TaskPlayAnim(playerPed, animDict, "craft_trans_stow", 8.0, -8.0, -1, 67108880, 0.0, false, 4096, false, "Satchel_Only_filter", false)
        TaskPlayAnimAdvanced(playerPed, animDict, "craft_trans_stow", GetEntityCoords(playerPed), GetEntityRotation(playerPed), 8.0, -8.0, -1, 67108880, 0.0, false, 4096, false, "Satchel_Only_filter", false)
    else
        local animCurrentTime = Citizen.InvokeNative(0x627520389E288A73, playerPed, animDict, "craft_trans_stow", Citizen.ResultAsFloat())

        if animCurrentTime >= 0.6 then
            TaskPlayAnimAdvanced(playerPed, animDict, "craft_trans_stow", GetEntityCoords(playerPed), GetEntityRotation(playerPed), 4.0, -2.0, -1, 67108880, 0.39, false, 4096, false, "Satchel_Only_filter", false)
        end
    end
end

function ClearPosCrafting()
    isCrafting = false
    ClearPedTasks(PlayerPedId())

    selected_cGroup = nil
    selected_cIndex = nil
    selected_name = nil
    selected_time = nil

    craftingEndGameTimer = nil
end

RegisterNetEvent("VP:CRAFTING:OpenCrafting")
AddEventHandler(
    "VP:CRAFTING:OpenCrafting",
    function(r)
        local f = deepcopy(Config)

        for cGroup, l in pairs(r) do
            for cIndex, inputList in pairs(l) do
                for cInputIndex, active in pairs(inputList) do
                    f[cGroup].craftings[cIndex].input[cInputIndex].isActive = active
                end
            end
        end

        for cGroup, x in pairs(f) do
            if not r[cGroup] then
                f[cGroup] = nil
            else
                for a, b in pairs(x) do
                    if a ~= "craftings" then
                        x[a] = nil
                    end
                end

                for cIndex, y in pairs(x.craftings) do
                    local output = y.output

                    -- ? 1 Porque a gente só usa o primeiro output, já que não pode fazer mais de um item
                    output = output[1]

                    if f[cGroup].craftings[cIndex].output[1].name == nil then
                        local item = output.item

                        local name = ItemList[item] and ItemList[item].name or item

                        -- ? 1 Porque a gente só usa o primeiro output, já que não pode fazer mais de um item
                        f[cGroup].craftings[cIndex].output[1].name = name
                    end
                end
            end
        end

        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
        SendNUIMessage(
            {
                shouldOpen = true,
                data = f
            }
        )

        craftingNuiIsOpen = true

        _tempParsedConfig = f

        SetGameplayCamRelativeHeading(0.0, 1.0)
        SetGameplayCamRelativePitch(0.0, 1.0)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() == resourceName) then
            -- PromptDelete(prompt)
            TriggerEvent("VP:CRAFT:ShouldClose")

            PromptDelete(prompt_craft)
            PromptDelete(prompt_cancel)
        end
    end
)

-- * Set ped scenario transition
-- PED::_0xD65FDC686A031C83(Global_34, joaat("DYNAMIC_KNEEL_SLOW_EXIT"), 2f);
-- PED::_0x6D07B371E9439019(Global_34);

-- * Ped has scenario transition
-- PED::_0x68821369A2CEADD5(Global_34, joaat("KNEEL1_TRANS_KNIFE1")))

-- * Get ped scenario transition
-- PED::_0xC22AA08A8ADB87D4(Global_34);
