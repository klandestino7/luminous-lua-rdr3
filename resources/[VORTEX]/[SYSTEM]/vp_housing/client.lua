local doorGroups = {
    [1] = {
        [1] = {1595076728, false, 2},
        [2] = {1439227364, false, 1},
        [3] = {530930529, false , 4},
        [4] = {1299101427, false, 3},
        [10] = {764233269, false},
        [11] = {2504431014, false},
    }
}

-- 1006.160,-1772.393,47.620

local windows = {
    {-1484366741, vec3(-5206.49, -3493.25, -21.63)},
    {-1484366741, vec3(-5207.82, -3488.29, -21.63)},
}

local cDoorGroup
local cDoorIndex

Citizen.CreateThread(
    function()
        local ped = PlayerPedId()
        local pedVec3 = GetEntityCoords(ped)

        for _, v in pairs(windows) do
            local windowModel = v[1]
            local windowVec3 = v[2]

            -- if #(pedVec3 - windowVec3) <= 100 then
            local window = GetClosestObjectOfType(windowVec3, 1.0, windowModel, false, 0, 0)
            if window ~= 0 then
                SetEntityInvincible(window, true)
            end
            -- end
        end

        while true do
            Citizen.Wait(1000)

            ped = PlayerPedId()
            pedVec3 = GetEntityCoords(ped)

            if cDoorGroup ~= nil then
                local isClose = false
                for _, v in pairs(doorGroups[cDoorGroup]) do
                    local doorHash = v[1]
                    -- local doorState = v[2]
                    local door = GetDoorEntity(doorHash)

                    if door ~= 0 then
                        if #(pedVec3 - GetEntityCoords(door)) <= 10.0 then
                            isClose = true
                        end
                    end
                end
                if isClose == false then
                    cDoorGroup = nil
                    cDoorIndex = nil
                end
            end

            if cDoorGroup == nil then
                for doorGroup, doorInfo in pairs(doorGroups) do
                    for _, v in pairs(doorInfo) do
                        local doorHash = v[1]
                        -- local doorState = v[2]
                        local door = GetDoorEntity(doorHash)

                        if door ~= 0 then
                            if #(pedVec3 - GetEntityCoords(door)) <= 10.0 then
                                cDoorGroup = doorGroup
                                print("cDoorGroup", cDoorGroup)
                                break
                            end
                        end
                    end
                end
            end

            for _, v in pairs(windows) do
                local windowModel = v[1]
                local windowVec3 = v[2]

                -- if #(pedVec3 - windowVec3) <= 100 then
                local window = GetClosestObjectOfType(windowVec3, 1.0, windowModel, false, 0, 0)
                -- print('Window ' .. window .. ' is now invincible')
                if window ~= 0 then
                    SetEntityInvincible(window, true)
                end
                -- end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if cDoorGroup ~= nil then
                local ped = PlayerPedId()
                local pedVec3 = GetEntityCoords(ped)
                local player = PlayerId()

                if cDoorIndex ~= nil then
                    local v = doorGroups[cDoorGroup][cDoorIndex]
                    local doorHash = v[1]
                    local doorIsOpen = v[2]
                    local door = GetDoorEntity(doorHash)


                    local dist = #(pedVec3 - GetEntityCoords(door))
                    if door ~= 0 and dist <= 2.5 then
                        -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, pedVec3, GetEntityCoords(door), 255, 0, 0, 255)
                        if dist <= 1.9 then
                            drawPrompt(doorIsOpen)
                        end
                    else
                        cDoorIndex = nil
                        deletePrompt()
                    end
                else
                    for _, v in pairs(doorGroups[cDoorGroup]) do
                        if cDoorIndex ~= _ then
                            local doorHash = v[1]
                            local doorIsOpen = v[2]
                            local door = GetDoorEntity(doorHash)

                            if door ~= 0 and #(pedVec3 - GetEntityCoords(door)) <= 2.5 then
                                cDoorIndex = _
                                -- print("cDoorIndex", cDoorIndex)
                            end
                        end
                    end
                end
            end

            local ped = PlayerPedId()
            local pedVec3 = GetEntityCoords(ped)
            for k,vv in pairs(doorGroups) do
                for _, v in pairs(vv) do
                    local doorHash = v[1]
                    local door = GetDoorEntity(doorHash)

                    -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, pedVec3, GetEntityCoords(door), 255, 0, 0, 255)
                end
            end
        end
    end
)

local prompt
local promptGroup
local varStringCasa = CreateVarString(10, "LITERAL_STRING", "Casa")

function drawPrompt(isOpen)
    if prompt == nil then
        prompt = PromptRegisterBegin()
        promptGroup = GetRandomIntInRange(0, 0xffffff)
        local text = isOpen == true and "Fechar" or "Abrir"
        PromptSetControlAction(prompt, 0x7F8D09B8)
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", text))
        PromptSetEnabled(prompt, true)
        PromptSetVisible(prompt, true)
        PromptSetStandardMode(prompt, true)
        PromptSetGroup(prompt, promptGroup)
        PromptRegisterEnd(prompt)
    else
        PromptSetActiveGroupThisFrame(promptGroup, varStringCasa)

        if PromptIsJustPressed(prompt) then
            TriggerServerEvent("VP:HOUSING:TryToToggleDoorState", cDoorGroup, cDoorIndex, doorGroups[cDoorGroup][cDoorIndex][3])
        end
    end
    -- if IsControlJustPressed(0, 0x7F8D09B8) then
    --     TriggerServerEvent("VP:HOUSING:TryToToggleDoorState", cDoorGroup, cDoorIndex, doorGroups[cDoorGroup][cDoorIndex][3])
    -- end
end

function deletePrompt()
    if prompt ~= nil then
        PromptSetVisible(prompt, false)
        PromptSetEnabled(prompt, false)
        PromptDelete(prompt)
        prompt = nil
        promptGroup = nil
    end
end

function GetDoorEntity(doorHash)
    return Citizen.InvokeNative(0xF7424890E4A094C0, doorHash)
end

function RegisterDoorSomething(doorHash)
    Citizen.InvokeNative(0xD99229FE93B46286, doorHash, 1, 1, 0, 0, 0, 0)
end

RegisterNetEvent("VP:HOUSING:SetDoorIsOpen")
AddEventHandler(
    "VP:HOUSING:SetDoorIsOpen",
    function(doorGroup, doorIndex, isOpen)
        doorGroups[doorGroup][doorIndex][2] = isOpen
        cDoorIndex = nil
        deletePrompt()

        local doorHash = doorGroups[doorGroup][doorIndex][1]
        local state = isOpen == true and 0 or 1

        RegisterDoorSomething(doorHash)
        DoorSystemSetDoorState(doorHash, state)

        local pair = doorGroups[doorGroup][doorIndex][3]

        if pair ~= nil then
            doorGroups[doorGroup][pair][2] = isOpen
            local doorHash_pair = doorGroups[doorGroup][pair][1]
            RegisterDoorSomething(doorHash_pair)
            DoorSystemSetDoorState(doorHash_pair, state)
        end

        -- local door = GetDoorEntity(doorHash)
        -- if isOpen then
        --     ApplyForceToEntityCenterOfMass(door, 1, GetEntityCoords(door) - (GetEntityForwardVector(door) * 5), 0, 0, 1, 0)
        -- else
        --     ApplyForceToEntityCenterOfMass(door, 1, GetEntityCoords(door) + (GetEntityForwardVector(door) * 5), 0, 0, 1, 0)
        -- end
    end
)

RegisterNetEvent("VP:HOUSING:SyncDoorStates")
AddEventHandler(
    "VP:HOUSING:SyncDoorStates",
    function(data)
        for doorGroup, indexes in pairs(data) do
            for index, isOpen in pairs(indexes) do
                doorGroups[doorGroup][index][2] = isOpen

                local doorHash = doorGroups[doorGroup][index][1]
                local state = isOpen == true and 0 or 1

                -- print(doorHash, state)

                RegisterDoorSomething(doorHash)
                DoorSystemSetDoorState(doorHash, state)
            end
        end
    end
)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            TriggerServerEvent("VP:HOUSING:GetSynced")
        end
    end
)
