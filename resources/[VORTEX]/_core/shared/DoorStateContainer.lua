local SERVER = IsDuplicityVersion()
local CLIENT = not SERVER

-- doorHash { doorState | doorPair | doorMinGroup }
local doorStates = {
    -- HOUSE:1
    [1595076728] = {false, 1439227364},
    [1439227364] = {false, 1595076728},
    [530930529] = {false, 1299101427},
    [1299101427] = {false, 530930529},
    [764233269] = {false},
    [2504431014] = {false},
    -- HOUSE:2
    [1282705079] = {false},
    [1511858696] = {false},
    -- HOUSE:3
    [3929468747] = {false},
    -- HOUSE:4
    -- [1377231573] = {false},
    -----------------------------------
    -- OFFICER/JAIL
    [1207903970] = {false},
    [902070893] = {false},
    [831345624] = {false},
    [2677989449] = {false},
    [2984805596] = {false},
    [1711767580] = {false},
    [1995743734] = {false},
    [2515591150] = {false},
    [3365520707] = {false},
    [2167775834] = {false},
    [2514996158] = {false}
    -----------------------------------
}

-- TALVEZ MUDAR O SISTEMA PARA O CLIENT SÓ PEDIR O SYNC
-- DE x PORTA QUANDO ELE ESTIVER PROXIMO DA PORTA!

Citizen.CreateThread(
    function()
        if SERVER then
            function setControllableDoorsForGroup(group, doorHashArray)
                for _, doorHash in pairs(doorHashArray) do
                    if doorStates[doorHash] then
                        doorStates[doorHash][3] = group
                    end
                end
            end

            setControllableDoorsForGroup(
                "house:1",
                {
                    1595076728,
                    1439227364,
                    530930529,
                    1299101427,
                    764233269,
                    2504431014
                }
            )

            setControllableDoorsForGroup(
                "house:2",
                {
                    1282705079,
                    1511858696
                }
            )

            setControllableDoorsForGroup(
                "house:3",
                {
                    3929468747
                }
            )

            -- setControllableDoorsForGroup(
            --     "house:4",
            --     {
            --         1377231573
            --     }
            -- )

            setControllableDoorsForGroup(
                "sheriff",
                {
                    1207903970,
                    902070893,
                    831345624,
                    2677989449,
                    2984805596,
                    1711767580,
                    1995743734,
                    2515591150,
                    3365520707,
                    2167775834,
                    2514996158
                }
            )

            RegisterNetEvent("VP:DOORSTATECONTAINER:TryToToggleDoorState")
            AddEventHandler(
                "VP:DOORSTATECONTAINER:TryToToggleDoorState",
                function(doorHash)
                    local _source = source
                    local User = API.getUserFromSource(_source)

                    if not doorStates[doorHash] then
                        User:notify("error", "ERROR PORTA REGISTRADA???")
                        return
                    end

                    if doorStates[doorHash][3] ~= nil then
                        local Character = User:getCharacter()
                        if Character == nil or not Character:hasGroupOrInheritance(doorStates[doorHash][3]) then
                            User:notify("error", "Você não pode abrir esta porta")
                            return
                        end
                    end

                    local newDoorState = not doorStates[doorHash][1]
                    doorStates[doorHash][1] = newDoorState

                    if doorStates[doorHash][2] ~= nil then
                        local doorPair = doorStates[doorHash][2]
                        doorStates[doorPair][1] = newDoorState
                    end

                    TriggerClientEvent("VP:DOORSTATECONTAINER:SetDoorState", -1, doorHash, newDoorState)
                end
            )

            AddEventHandler(
                "API:playerSpawned",
                function(source, user_id, isFirstSpawn)
                    if isFirstSpawn then
                        local _temp = deepcopy(doorStates)
                        for _, v in pairs(_temp) do
                            v[3] = nil
                        end

                        TriggerClientEvent("VP:DOORSTATECONTAINER:SetMultipleDoorsState", source, _temp)
                    end
                end
            )

            Citizen.CreateThread(
                function()
                    Citizen.Wait(2000)

                    local _temp = deepcopy(doorStates)
                    for _, v in pairs(_temp) do
                        v[3] = nil
                    end

                    TriggerClientEvent("VP:DOORSTATECONTAINER:SetMultipleDoorsState", -1, _temp)
                end
            )
        elseif CLIENT then
            RegisterNetEvent("VP:DOORSTATECONTAINER:SetDoorState")
            AddEventHandler(
                "VP:DOORSTATECONTAINER:SetDoorState",
                function(doorHash, doorState)
                    doorStates[doorHash][1] = doorState

                    RegisterDoorSomething(doorHash)
                    DoorSystemSetDoorState(doorHash, doorState == true and 0 or 1)

                    if doorStates[doorHash][2] ~= nil then
                        local doorPair = doorStates[doorHash][2]
                        doorStates[doorPair][1] = doorState

                        RegisterDoorSomething(doorPair)
                        DoorSystemSetDoorState(doorPair, doorState == true and 0 or 1)
                    end
                end
            )

            RegisterNetEvent("VP:DOORSTATECONTAINER:SetMultipleDoorsState")
            AddEventHandler(
                "VP:DOORSTATECONTAINER:SetMultipleDoorsState",
                function(_doorStates)
                    doorStates = _doorStates
                end
            )

            local closestDoorHash

            Citizen.CreateThread(
                function()
                    while true do
                        local ped = PlayerPedId()
                        local pCoords = GetEntityCoords(ped)

                        local dist
                        for doorHash, values in pairs(doorStates) do
                            local doorEntity = GetDoorEntity(doorHash)

                            if DoesEntityExist(doorEntity) then
                                local doorState = values[1]

                                RegisterDoorSomething(doorHash)
                                DoorSystemSetDoorState(doorHash, doorState == true and 0 or 1)

                                local _dist = #(pCoords - GetEntityCoords(doorEntity))

                                if _dist <= 50 and (dist == nil or _dist < dist) then
                                    dist = _dist
                                    closestDoorHash = doorHash
                                end
                            end
                        end

                        if dist == nil then
                            closestDoorHash = nil
                        end

                        Citizen.Wait(1000)
                    end
                end
            )

            local prompt_group_open
            local prompt_open

            local prompt_group_close
            local prompt_close

            local prompt_group_name = CreateVarString(10, "LITERAL_STRING", "Porta")

            Citizen.CreateThread(
                function()
                    initPrompts()

                    while true do
                        Citizen.Wait(0)

                        if closestDoorHash ~= nil then
                            local doorEntity = GetDoorEntity(closestDoorHash)

                            local ped = PlayerPedId()
                            local pCoords = GetEntityCoords(ped)

                            local dist = #(pCoords - GetEntityCoords(doorEntity))

                            if dist <= 1.7 then
                                if HasEntityClearLosToEntityInFront(ped, doorEntity, 0) then
                                    local doorState = doorStates[closestDoorHash][1]

                                    if doorState == true then
                                        PromptSetActiveGroupThisFrame(prompt_group_close, prompt_group_name)

                                        if PromptHasHoldModeCompleted(prompt_close) then
                                            PromptSetEnabled(prompt_close, false)
                                            TriggerServerEvent("VP:DOORSTATECONTAINER:TryToToggleDoorState", closestDoorHash)
                                            Citizen.CreateThread(
                                                function()
                                                    Citizen.Wait(250)
                                                    PromptSetEnabled(prompt_close, true)
                                                end
                                            )
                                        end
                                    else
                                        PromptSetActiveGroupThisFrame(prompt_group_open, prompt_group_name)

                                        if PromptHasHoldModeCompleted(prompt_open) then
                                            PromptSetEnabled(prompt_open, false)
                                            TriggerServerEvent("VP:DOORSTATECONTAINER:TryToToggleDoorState", closestDoorHash)
                                            Citizen.CreateThread(
                                                function()
                                                    Citizen.Wait(250)
                                                    PromptSetEnabled(prompt_open, true)
                                                end
                                            )
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            )

            function initPrompts()
                prompt_group_open = GetRandomIntInRange(0, 0xffffff)

                prompt_open = PromptRegisterBegin()
                PromptSetControlAction(prompt_open, 0xDFF812F9)
                PromptSetText(prompt_open, CreateVarString(10, "LITERAL_STRING", "Abrir"))
                PromptSetEnabled(prompt_open, true)
                PromptSetVisible(prompt_open, true)
                PromptSetHoldMode(prompt_open, true)
                PromptSetGroup(prompt_open, prompt_group_open)
                PromptRegisterEnd(prompt_open)

                prompt_group_close = GetRandomIntInRange(0, 0xffffff)

                prompt_close = PromptRegisterBegin()
                PromptSetControlAction(prompt_close, 0xDFF812F9)
                PromptSetText(prompt_close, CreateVarString(10, "LITERAL_STRING", "Fechar"))
                PromptSetEnabled(prompt_close, true)
                PromptSetVisible(prompt_close, true)
                PromptSetHoldMode(prompt_close, true)
                PromptSetGroup(prompt_close, prompt_group_close)
                PromptRegisterEnd(prompt_close)
            end

            AddEventHandler(
                "onResourceStop",
                function(resourceName)
                    if GetCurrentResourceName() == resourceName then
                        PromptDelete(prompt_open)
                        PromptDelete(prompt_close)
                    end
                end
            )
        end
    end
)

function GetDoorEntity(doorHash)
    return Citizen.InvokeNative(0xF7424890E4A094C0, doorHash)
end

function RegisterDoorSomething(doorHash)
    Citizen.InvokeNative(0xD99229FE93B46286, doorHash, 1, 1, 0, 0, 0, 0)
end
