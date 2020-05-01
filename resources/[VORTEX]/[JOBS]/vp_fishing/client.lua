keys = {
    ["G"] = 0x760A9C6F,
    ["S"] = 0xD27782E3,
    ["W"] = 0x8FD015D8,
    ["H"] = 0x24978A28,
    ["G"] = 0x5415BE48,
    ["E"] = 0xDFF812F9
}

local active = false
local procent
local fishShop = vector3(2998.792, 477.8959, 42.0)
local vanhorn = vector3(3003.880, 693.011, 41.629)
local selling = false
local bait = nil
local group
local FishingPrompt
local prompts = {}

Citizen.CreateThread(
    function()
        Wait(100)
        Wait(0)
        local blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, fishShop)
        SetBlipSprite(blip, 1106719664)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Fish Market")
    end
)

Citizen.CreateThread(
    function()
        local fishingrod_hash = GetHashKey("WEAPON_FISHINGROD")

        local cor = {
            {255, 0, 0},
            {0, 255, 0},
            {0, 0, 255},
            {255, 255, 0},
            {0, 255, 255}
        }

        local rope_entity
        local attached_fish

        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()

            if DoesEntityExist(ped) then
                if HasPedGotWeapon(ped, fishingrod_hash, 0, 0) then
                    if IsControlJustPressed(0, 0xE30CD707) then --[R]
                        TaskSwapFishingBait(ped, "p_baitWorm01x", 1)
                    end
                end
            end

            local _, currentWeapon = GetCurrentPedWeapon(PlayerPedId())
            if currentWeapon == fishingrod_hash then
                if rope_entity == nil then
                    rope_entity = GetClosestObjectOfType(GetEntityCoords(ped), 25.0, -950558374, 0, 0, 0)
                end
            else
                rope_entity = nil
            end

            if rope_entity ~= nil and attached_fish == nil then
                if DoesEntityExist(rope_entity) then
                    -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, GetEntityCoords(ped), GetEntityCoords(rope_entity), 255, 0, 0, 255)

                    local itemSet = CreateItemset(true)
                    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, GetEntityCoords(rope_entity), 10.0, itemSet, 1)

                    local rope_coords = GetEntityCoords(rope_entity)

                    if size ~= false and size > 0 then
                        for index = 0, size - 1 do
                            local entity = GetIndexedItemInItemset(index, itemSet)

                            -- print(entity, IsEntityInWater(entity))
                            if entity ~= PlayerPedId() then -- and IsEntityInWater(entity) then
                                -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, GetEntityCoords(ped), GetEntityCoords(entity), 255, 0, 0, 255)

                                local fish_coords = GetEntityCoords(entity)

                                if #(rope_coords - fish_coords) <= 5.0 then
                                    attached_fish = entity
                                    AttachEntityToEntity(entity, rope_entity, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0)
                                    -- AttachEntityToEntityPhysically(entity, rope_entity, GetEntityBoneIndexByName(entity, "SKEL_Tail5"), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0)
                                    break
                                end
                            end
                        end
                    end

                    if IsItemsetValid(itemSet) then
                        DestroyItemset(itemSet)
                    end
                else
                    rope_entity = nil
                end
            end

            -- print(IsEntityInWater(PlayerPedId()))

            if attached_fish ~= nil and (not DoesEntityExist(attached_fish) or rope_entity == nil or not DoesEntityExist(rope_entity) or not IsEntityAttachedToEntity(attached_fish, rope_entity)) then
                -- if not IsEntityInWater(attached_fish) then
                print("updated")
                ForceEntityAiAndAnimationUpdate(attached_fish)
                DetachEntity(attached_fish, true, true)
                ApplyForceToEntityCenterOfMass(attached_fish, 1, 0, 0, 0, 0, 1, 1, 1)
                attached_fish = nil
            -- end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            local playerPed2 = PlayerPedId()
            local ret, currweapon = GetCurrentPedWeapon(playerPed2)
            local coords2 = GetEntityCoords(playerPed2)
            --	print(currweapon)
            if Vdist(coords2, vanhorn) < 1000.0 then
                --	print("Ma wędkę i jest w wodzie")
                if currweapon == tonumber(-1415022764) then
                    local FishingPrompt = PromptRegisterBegin()
                    PromptSetControlAction(FishingPrompt, 0xDFF812F9)
                    PromptSetText(FishingPrompt, CreateVarString(10, "LITERAL_STRING", "Começar Pesca"))
                    PromptSetEnabled(FishingPrompt, 1)
                    PromptSetVisible(FishingPrompt, 1)
                    PromptSetHoldMode(FishingPrompt, 1)
                    N_0x0c718001b77ca468(FishingPrompt, 3.0)
                    -- PrompContextSetSize(prompt, 3.0)
                    PromptRegisterEnd(FishingPrompt)
                    table.insert(prompts, FishingPrompt)
                    -- print("Ma wędkę i jest w wodzie")
                    --group = PromptGetGroupIdForTargetEntity(target)
                    if active == false then
                        local FishingPrompt = PromptRegisterBegin()
                        PromptSetControlAction(FishingPrompt, 0xDFF812F9)
                        PromptSetText(FishingPrompt, CreateVarString(10, "LITERAL_STRING", "Começar Pesca"))
                        PromptSetEnabled(FishingPrompt, 1)
                        PromptSetVisible(FishingPrompt, 1)
                        PromptSetHoldMode(FishingPrompt, 1)
                        N_0x0c718001b77ca468(FishingPrompt, 3.0)
                        -- PrompContextSetSize(prompt, 3.0)
                        PromptRegisterEnd(FishingPrompt)
                        table.insert(prompts, FishingPrompt)
                        active = true
                    end
                    if PromptHasHoldModeCompleted(FishingPrompt) then
                        if bait ~= nil then
                            --  StartMinigame()
                            print("Go Fishing")
                            PromptDelete(FishingPrompt)
                            TaskStartScenarioInPlace(playerPed2, GetHashKey("WORLD_HUMAN_STAND_FISHING"), -1, true, true, true, 2.0, true)
                            Wait(6000)
                        else
                            --  TriggerEvent("frp_notify2:start", "You don't have the bait", 2, "error")
                            PromptDelete(FishingPrompt)
                        end
                    end
                elseif active == true then
                    PromptDelete(FishingPrompt)
                    active = false
                end
            elseif active == true then
                PromptDelete(FishingPrompt)
                active = false
            end
        end
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end
function StartMinigame()
    local value = 1000
    local value2 = 10
    math.randomseed(GetGameTimer())
    while true do
        Wait(10)
        print(value)
        local t = value2 / 10000
        local m = value / 11000
        print(value2)
        --DrawTxt("Tension: "..t.." Meters: "..m, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
        if t > 0.07 then
            DrawSprite("generic_textures", "hud_menu_4a", 0.2, 0.8, 0.01, t, 0.2, 255, 81, 0, 190, 0)
        else
            DrawSprite("generic_textures", "hud_menu_4a", 0.2, 0.8, 0.01, t, 0.2, 191, 143, 0, 190, 0)
        end
        DrawSprite("generic_textures", "hud_menu_4a", 0.2, 0.8, 0.02, 0.11, 0.8, 0, 0, 0, 190, 0)
        -- DrawSprite("generic_textures", "hud_menu_4a", 0.25, 0.8, 0.01, m, 0.8,0, 255, 21, 156, 11)
        DrawSprite("generic_textures", "hud_menu_4a", 0.25, 0.8, 0.02, 0.11, 0.8, 0, 0, 0, 190, 0)
        if IsControlPressed(0, 0x07CE1E61) then
            print("działa klawisz")
            value = value - 2
            value2 = value2 + 2.5
        else
            if value < 1000 then
                value = value + 1
            end
            if value2 > 4 then
                value2 = value2 - 2
            end
        end
        if value2 > 1000 then
            --  TriggerEvent("frp_notify2:start", "The fish has escaped", 2, "error")
            bait = nil
            ClearPedTasksImmediately(PlayerPedId())
            break
        elseif value2 < 1000 and value < 10 then
            procent = math.random(1, 100)
            if bait == "bread_bait" then
                if procent > 1 and procent <= 10 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Epic Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 4)
                elseif procent > 10 and procent <= 25 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Large Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 3)
                elseif procent > 25 and procent <= 50 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Medium Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 2)
                elseif procent > 50 and procent <= 100 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Small Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 1)
                else
                    --  TriggerEvent("frp_notify2:start", "The fish has escaped", 2, "error")
                end
            elseif bait == "corn_bait" then
                if procent > 0 and procent <= 1 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Legendary Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 5)
                elseif procent > 1 and procent <= 12 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Epic Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 4)
                elseif procent > 10 and procent <= 35 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Large Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 3)
                elseif procent > 20 and procent <= 50 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Medium Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 2)
                elseif procent > 60 and procent <= 100 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Small Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 1)
                else
                    --  TriggerEvent("frp_notify2:start", "The fish has escaped", 2, "error")
                end
            elseif bait == "worms_bait" then
                if procent > 0 and procent <= 3 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Legendary Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 5)
                elseif procent > 1 and procent <= 15 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Epic Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 4)
                elseif procent > 10 and procent <= 25 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Large Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 3)
                elseif procent > 25 and procent <= 50 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Medium Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 2)
                elseif procent > 70 and procent <= 100 then
                    --  TriggerEvent("frp_notify2:start", "You caught 1x Small Fish", 2, "success")
                    TriggerServerEvent("tor_fishing:AddFish", 1)
                else
                    --  TriggerEvent("frp_notify2:start", "The fish has escaped", 2, "error")
                end
            end
            bait = nil
            ClearPedTasksImmediately(PlayerPedId())
            break
        end
        local random = math.random(1, 100)
        if random > 10 and random < 11 then
            value2 = value2 + 10
        end
    end
end

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            if Vdist(coords, fishShop) < 2 and not selling then
                DrawTxt("Press E key to sell fish", 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
                if IsControlJustReleased(0, keys["E"]) then
                    selling = true
                    FreezeEntityPosition(playerPed, true)
                    -- exports.progressBars:startUI(5000, 'Selling in progress...')
                    Wait(5000)
                    selling = false
                    FreezeEntityPosition(playerPed, false)
                --  TriggerServerEvent('tor_fishing:SellFish', source)
                end
            end
        end
    end
)

-- RegisterNetEvent('tor_fishing:selled')
-- AddEventHandler('tor_fishing:selled', function(ilosc, cena)
--    --  TriggerEvent("frp_notify2:start", "You selled x" .. ilosc .. " fish for " .. cena .. '$', 2, "success")
-- end)

-- RegisterNetEvent('tor_fishing:useBait')
-- AddEventHandler('tor_fishing:useBait', function(sbait)
--    --  TriggerEvent("frp_notify2:start", "Bait used", 2, "success")
--     bait = sbait
-- end)
