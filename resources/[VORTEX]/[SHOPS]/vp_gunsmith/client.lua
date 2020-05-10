local promptDatas = {}
local props = {}
local props_ammo = {}
local hasPropsLoaded = false

local aimMaxDistance = 3.0
local requestedComponents = {}

function load(interiorId)
    local weapons = {
        -- price_dollar, price_gold, amount
        {"revolver_lemat", 317, 13, 1, "w_revolver_lemat01"},
        {"revolver_cattleman", 50, 2, 1, "w_revolver_cattleman01"},
        -- {"revolver_navy", 257, 11, 1, "w_revolver_schofield01"}, -- ERA PRA SER O NAVY
        {"pistol_volcanic", 300, 14, 1, "w_pistol_volcanic01"},
        {"shotgun_sawedoff", 65, 15, 1, "w_shotgun_sawed01"},
        {"repeater_carbine", 90, 4, 1, "w_repeater_carbine01"},
        {"repeater_henry", 234, 10, 1, "w_repeater_henry01"},
        {"sniperrifle_rollingblock", 500, 20, 1, "w_rifle_rollingblock01"},
        {"rifle_varmint", 72, 3, 1, "w_repeater_pumpaction01"}, -- NÃO ESTÁ CARREGANDO
        {"rifle_boltaction", 216, 9, 1, "w_rifle_boltaction01"}
        -- {"thrown_throwing_knives", 250, 50, 1, "w_melee_tomahawk03"},
        -- {"melee_cleaver", 8, 1, 1, "p_cleaver01x"},
        -- {"melee_knife", 5, 1, 1, "w_melee_knife02"},
    }

    local gunsmith_data = Config.Gunsmith_datas[interiorId]

    local a = vec3(table.unpack(gunsmith_data.point1))
    local b = vec3(table.unpack(gunsmith_data.point2))

    local pitch, roll, yaw = table.unpack(gunsmith_data.rotation_1)

    local d = math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)) / (#weapons - 1)
    local fi = math.atan2(b.y - a.y, b.x - a.x)

    for i = 0, #weapons do
        local x = a.x + i * d * math.cos(fi)
        local y = a.y + i * d * math.sin(fi)
        local z = a.z
        -- local _, z, _ = GetGroundZAndNormalFor_3dCoord(x, y, a.z)

        if weapons[i + 1] then
            local d = weapons[i + 1]
            createPrompt(d[4] .. "x " .. ItemList[d[1]].name, d[1], tonumber(string.format("%.2f", d[2] / 100)), tonumber(string.format("%.2f", d[3] / 100)), createProp(d[5], x, y, z, pitch, roll, yaw, "weapon_" .. d[1]))
        end
    end

    local ammos = {
        {"ammo_revolver", 10, 2, 20, "s_inv_revolverammo01x"},
        {"ammo_pistol", 10, 2, 20, "s_inv_pistolammo01x"},
        {"ammo_repeater", 10, 2, 20, "s_inv_repeat_rifleammo01x"},
        {"ammo_rifle", 10, 2, 20, "s_inv_rifleammo01x"},
        {"ammo_shotgun", 10, 2, 20, "s_inv_shotgunammo01x"}
    }

    -- a = vec3(table.unpack(gunsmith_data.point3))
    -- b = vec3(table.unpack(gunsmith_data.point4))

    if gunsmith_data.rotation_2 then
        local pitch, roll, yaw = table.unpack(gunsmith_data.rotation_2)

        for i = 0, #gunsmith_data.ammo_points do
            if ammos[i + 1] and gunsmith_data.ammo_points[i + 1] then
                local x, y, z = table.unpack(gunsmith_data.ammo_points[i + 1])
                local d = ammos[i + 1]
                createPrompt(d[4] .. "x " .. ItemList[d[1]].name, d[1], tonumber(string.format("%.2f", d[2] / 100)), tonumber(string.format("%.2f", d[3] / 100)), createProp(ItemList[d[1]].worldModel or d[5], x, y, z, pitch, roll, yaw))
            end
        end
    end

    for _, reqComponent in pairs(requestedComponents) do
        SetModelAsNoLongerNeeded(reqComponent)
    end

    requestedComponents = {}

    hasPropsLoaded = true
end

local components = {
    "barrel1",
    "barrel2",
    "barrel01",
    "barrel02",
    "grip1",
    "grip2",
    "grip3",
    "grip4",
    "grip5",
    "sight1",
    "sight2",
    "clip",
    "clip1",
    "wrap1",
    "mag1",
    "mag2",
    "mag3",
    "w_rifle_scopeinner01",
    "w_rifle_scope04",
    "w_rifle_scope03",
    "w_rifle_scope02",
    "w_rifle_cs_strap01",
    "w_sight_rear02",
    "w_sight_rear01",
    "w_repeater_cloth_strap01",
    "w_repeater_strap01",
    "w_rifle_boltaction03_grip1"
}

function createProp(model, x, y, z, pitch, roll, yaw, weapon_hash)
    -- model = GetHashKey(model)

    local prop = GetClosestObjectOfType(x, y, z, 0.5, model, 0, 0, 0)

    local propsammolenght = #props_ammo

    if prop == 0 then
        if not HasModelLoaded(model) then
            RequestModel(model, false)
            while not HasModelLoaded(model) do
                Citizen.Wait(10)
            end
        end

        local min, max = GetModelDimensions(model)

        if weapon_hash ~= nil then
            for _, component in pairs(components) do
                local comp_m = component
                if not comp_m:find("_") then
                    comp_m = model .. "_" .. comp_m
                end
                if IsModelValid(comp_m) then
                    if not HasModelLoaded(comp_m) then
                        RequestModel(comp_m, false)
                        table.insert(requestedComponents, comp_m)
                    end
                end
            end

            while true do
                local wait = false
                for _, reqComponent in pairs(requestedComponents) do
                    if not HasModelLoaded(reqComponent) then
                        wait = true
                        break
                    end
                end
                if wait then
                    Citizen.Wait(10)
                else
                    break
                end
            end

            prop = Citizen.InvokeNative(0x9888652B8BA77F73, GetHashKey(weapon_hash), -1, vec3(x, y, z), 1, 1065353216)

            if prop == false then
                prop = Citizen.InvokeNative(0x9888652B8BA77F73, GetHashKey(weapon_hash), -1, vec3(x, y, z), 0, 1065353216)
            end
        else
            if model:find("ammo01x") then
                x = x - max.x
            end

            prop = CreateObject(model, x, y, z, true, true, true, true, true)
        end

        Citizen.InvokeNative(0x7DFB49BCDB73089A, prop, false)
        SetEntityRotation(prop, pitch, roll, yaw, 1, 0)
        ActivatePhysics(prop)

        Citizen.CreateThread(
            function()
                while GetEntityVelocity(prop, false) ~= vec3(0, 0, 0) do
                    Citizen.Wait(10)
                end

                Citizen.Wait(150)

                FreezeEntityPosition(prop, true)

                if model:find("ammo01x") then
                    ammo_2 = CreateObject(model, GetOffsetFromEntityInWorldCoords(prop, max.x * 2, 0, min.z), true, true, true, true, true)
                    ammo_3 = CreateObject(model, GetOffsetFromEntityInWorldCoords(prop, max.x, 0, (max.z - min.z)), true, true, true, true, true)

                    Citizen.InvokeNative(0x7DFB49BCDB73089A, ammo_2, false)
                    Citizen.InvokeNative(0x7DFB49BCDB73089A, ammo_3, false)

                    SetEntityRotation(ammo_2, pitch, roll, yaw, 1, 0)
                    SetEntityRotation(ammo_3, pitch, roll, yaw, 1, 0)

                    FreezeEntityPosition(prop, ammo_2)
                    FreezeEntityPosition(prop, ammo_3)

                    if props_ammo[propsammolenght + 1] == nil then
                        props_ammo[propsammolenght + 1] = {}
                    end

                    props_ammo[propsammolenght + 1][2] = ammo_2
                    props_ammo[propsammolenght + 1][3] = ammo_3
                end

                SetModelAsNoLongerNeeded(model)
            end
        )
    end

    if prop ~= 0 and prop ~= false then
        if model:find("ammo01x") then
            if props_ammo[propsammolenght + 1] == nil then
                props_ammo[propsammolenght + 1] = {}
            end

            props_ammo[propsammolenght + 1][1] = prop
        else
            props[prop] = true
        end
    end

    return prop
end

function createPrompt(name, itemId, dollar, gold, entitytarget)
    local group = PromptGetGroupIdForTargetEntity(entitytarget)

    local prompt_dollar = PromptRegisterBegin()
    PromptSetControlAction(prompt_dollar, 0xF84FA74F)
    PromptSetText(prompt_dollar, CreateVarString(10, "LITERAL_STRING", "$" .. dollar))
    PromptSetEnabled(prompt_dollar, 1)
    PromptSetVisible(prompt_dollar, 1)
    PromptSetHoldMode(prompt_dollar, 1)
    PromptSetGroup(prompt_dollar, group)
    PromptRegisterEnd(prompt_dollar)

    local prompt_gold = PromptRegisterBegin()
    PromptSetControlAction(prompt_gold, 0x07CE1E61)
    PromptSetText(prompt_gold, CreateVarString(10, "LITERAL_STRING", "~t4~G" .. gold))
    PromptSetEnabled(prompt_gold, 1)
    PromptSetVisible(prompt_gold, 1)
    PromptSetHoldMode(prompt_gold, 1)
    PromptSetGroup(prompt_gold, group)
    PromptRegisterEnd(prompt_gold)

    promptDatas[entitytarget] = {itemId, CreateVarString(10, "LITERAL_STRING", name), prompt_dollar, prompt_gold}
end

function unload()
    for prop, _ in pairs(props) do
        DeleteEntity(prop)
    end

    for _, proplist in pairs(props_ammo) do
        for _, prop in pairs(proplist) do
            DeleteEntity(prop)
        end
    end

    hasPropsLoaded = false

    -- DEBBUGIN
    -- DeleteEntity(_temp_prop)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            local ped = PlayerPedId()
            local interiorPedIsIn = GetInteriorFromEntity(ped)

            if interiorPedIsIn ~= 0 then
                if Config.Gunsmith_datas[interiorPedIsIn] then
                    if hasPropsLoaded == false then
                        load(interiorPedIsIn)
                    end
                end
            else
                if hasPropsLoaded == true then
                    unload()
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        local entityTargeted
        local ammoIndexTargeted
        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()
            local pedVector = GetEntityCoords(ped)

            local cameraRotation = GetGameplayCamRot()
            local cameraCoord = GetGameplayCamCoord()
            local direction = RotationToDirection(cameraRotation)
            local lastCoords = vec3(cameraCoord.x + direction.x * aimMaxDistance, cameraCoord.y + direction.y * aimMaxDistance, cameraCoord.z + direction.z * aimMaxDistance)

            local rayHandle = StartShapeTestRay(cameraCoord, lastCoords, -1, ped, 0)
            local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

            if hit == 1 then
                lastCoords = endCoords
            end

            -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, lastCoords, lastCoords + vec3(0, 0, 0.7), 252, 180, 131, 255)

            local foundEntityTargeted
            local targetAsAmmo_index

            for prop, _ in pairs(props) do
                local ce = GetClosestObjectOfType(lastCoords, 0.10, GetEntityModel(prop), false, 0, 0)
                if ce ~= 0 then
                    if props[ce] then
                        foundEntityTargeted = ce
                        break
                    end
                end
            end

            if foundEntityTargeted == nil then
                for _, proplist in pairs(props_ammo) do
                    local firstProp = proplist[1]
                    local ce = GetClosestObjectOfType(lastCoords, 0.10, GetEntityModel(firstProp), false, 0, 0)
                    if ce ~= 0 then
                        if ce == firstProp or ce == proplist[2] or ce == proplist[3] then
                            targetAsAmmo_index = _
                        -- PromptSetActiveGroupThisFrame(PromptGetGroupIdForTargetEntity(ce), promptDatas[firstProp][2])
                        end
                    end
                end
            end

            if foundEntityTargeted ~= entityTargeted then
                if entityTargeted ~= nil then
                    Citizen.InvokeNative(0x7DFB49BCDB73089A, entityTargeted, false)
                end

                entityTargeted = foundEntityTargeted

                if foundEntityTargeted ~= nil then
                    Citizen.InvokeNative(0x7DFB49BCDB73089A, foundEntityTargeted, true)
                end
            end

            if targetAsAmmo_index ~= ammoIndexTargeted then
                if ammoIndexTargeted ~= nil then
                    for _, prop in pairs(props_ammo[ammoIndexTargeted]) do
                        Citizen.InvokeNative(0x7DFB49BCDB73089A, prop, false)
                    end
                end

                ammoIndexTargeted = targetAsAmmo_index

                if targetAsAmmo_index ~= nil then
                    for _, prop in pairs(props_ammo[targetAsAmmo_index]) do
                        Citizen.InvokeNative(0x7DFB49BCDB73089A, prop, true)
                    end
                end
            end

            if entityTargeted ~= nil or ammoIndexTargeted ~= nil then
                local data
                if entityTargeted ~= nil then
                    data = promptDatas[entityTargeted]
                    PromptSetActiveGroupThisFrame(PromptGetGroupIdForTargetEntity(entityTargeted), data[2])
                elseif ammoIndexTargeted ~= nil then
                    data = promptDatas[props_ammo[ammoIndexTargeted][1]]
                    PromptSetActiveGroupThisFrame(PromptGetGroupIdForTargetEntity(props_ammo[ammoIndexTargeted][1]), data[2])
                end

                if data == nil then
                    entityTargeted = nil
                    ammoIndexTargeted = nil
                else
                    local itemId = data[1]
                    local prompt_dollar = data[3]
                    local prompt_gold = data[4]

                    if PromptHasHoldModeCompleted(prompt_dollar) then
                        PromptSetEnabled(prompt_dollar, false)

                        TriggerServerEvent("VP:GUNSMITH:TryToBuy", itemId, false)

                        Citizen.CreateThread(
                            function()
                                Wait(500)
                                PromptSetEnabled(prompt_dollar, true)
                            end
                        )
                    end

                    if PromptHasHoldModeCompleted(prompt_gold) then
                        PromptSetEnabled(prompt_gold, false)

                        TriggerServerEvent("VP:GUNSMITH:TryToBuy", itemId, true)

                        Citizen.CreateThread(
                            function()
                                Wait(500)
                                PromptSetEnabled(prompt_gold, true)
                            end
                        )
                    end
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            unload()
        end
    end
)

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

--- DEBBUGING

-- local _temp_prop

-- RegisterCommand(
--     "gstest",
--     function(source, args, rawCommand)
--         if #args > 0 then
--             local lastCoords
--             local lastHeading

--             if _temp_prop ~= nil then
--                 lastCoords = GetEntityCoords(_temp_prop)
--                 lastHeading = GetEntityHeading(_temp_prop)
--                 DeleteEntity(_temp_prop)
--                 _temp_prop = nil
--             else
--                 local ped = PlayerPedId()

--                 local pedVector = GetEntityCoords(ped)

--                 local cameraRotation = GetGameplayCamRot()
--                 local cameraCoord = GetGameplayCamCoord()
--                 local direction = RotationToDirection(cameraRotation)
--                 lastCoords = vec3(cameraCoord.x + direction.x * aimMaxDistance, cameraCoord.y + direction.y * aimMaxDistance, cameraCoord.z + direction.z * aimMaxDistance)

--                 local rayHandle = StartShapeTestRay(pedVector, lastCoords, 1, ped, 0)
--                 local _, hit, endCoords, _, _ = GetShapeTestResult(rayHandle)

--                 if hit == 1 then
--                     lastCoords = endCoords
--                 end
--             end

--             if not HasModelLoaded(args[1]) then
--                 RequestModel(args[1])
--                 while not HasModelLoaded(args[1]) do
--                     Citizen.Wait(10)
--                 end
--             end

--             _temp_prop = CreateObject(args[1], lastCoords, false, false, true)
--             SetEntityHeading(_temp_prop, lastHeading)
--             FreezeEntityPosition(_temp_prop, true)
--         end
--     end,
--     false
-- )

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(10)
--             local ped = PlayerPedId()

--             local pedVector = GetEntityCoords(ped)

--                 local cameraRotation = GetGameplayCamRot()
--                 local cameraCoord = GetGameplayCamCoord()
--                 local direction = RotationToDirection(cameraRotation)
--                 local aimingAt = vec3(cameraCoord.x + direction.x * 3.0, cameraCoord.y + direction.y * 3.0, cameraCoord.z + direction.z * 3.0)

--                 local rayHandle = StartShapeTestRay(cameraCoord, aimingAt, 1, ped, 0)
--                 local _, hit, endCoords, _, _ = GetShapeTestResult(rayHandle)

--                 if hit == 1 then
--                     aimingAt = endCoords
--                 end

--             -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, aimingAt, aimingAt + vec3(0, 0, 0.7), 252, 180, 131, 255)
--             -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, pedVector, lastCoords, 252, 180, 131, 255)

--             if IsControlJustPressed(2, 0xF84FA74F) then
--                 print(aimingAt)
--                 print(GetInteriorFromEntity(ped))
--             end

--             if _temp_prop ~= nil then
--                 SetEntityCoords(_temp_prop, aimingAt, 0, 0, 0, false)

--                 if IsControlPressed(1, 0x07CE1E61) then -- LMB
--                     SetEntityRotation(_temp_prop, GetEntityPitch(_temp_prop) + 5.0, GetEntityRoll(_temp_prop), GetEntityHeading(_temp_prop), 1, true)
--                 end

--                 if IsControlPressed(0, 0x4AF4D473) then -- DEL
--                     SetEntityRotation(_temp_prop, GetEntityPitch(_temp_prop), GetEntityRoll(_temp_prop) + 5.0, GetEntityHeading(_temp_prop), 1, true)
--                 end

--                 if IsControlPressed(1, 0xDFF812F9) then -- E
--                     SetEntityRotation(_temp_prop, GetEntityPitch(_temp_prop), GetEntityRoll(_temp_prop), GetEntityHeading(_temp_prop) + 5.0, 1, true)
--                 end

--                 if IsControlJustPressed(1, 0xF84FA74F) then
--                     DeleteEntity(_temp_prop)
--                     _temp_prop = nil
--                 end

--                 DisplayText(CreateVarString(10, "LITERAL_STRING", "" .. GetEntityCoords(_temp_prop)), 0.05, 0.05)
--                 DisplayText(CreateVarString(10, "LITERAL_STRING", "" .. GetEntityPitch(_temp_prop)), 0.10, 0.10)
--                 DisplayText(CreateVarString(10, "LITERAL_STRING", "" .. GetEntityRoll(_temp_prop)), 0.15, 0.15)
--                 DisplayText(CreateVarString(10, "LITERAL_STRING", "" .. GetEntityHeading(_temp_prop)), 0.20, 0.20)
--             end
--         end
--     end
-- )
