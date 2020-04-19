local doorStates = {
    [622733334] = 622733334
}

-- [doorHash] = pair

local closestDoorHash

Citizen.CreateThread(
    function()
        local windows = {
            {-1484366741, vec3(-5206.49, -3493.25, -21.63)},
            {-1484366741, vec3(-5207.82, -3488.29, -21.63)}
        }

        while true do
            Citizen.Wait(1000)

            closestDoorHash = nil

            local ped = PlayerPedId()
            local pedVector = GetEntityCoords(ped)

            for doorHash, values in pairs(doorStates) do
                local doorEntity = Citizen.InvokeNative(0xF7424890E4A094C0, doorHash)
                local doorVector = GetEntityCoords(doorEntity)

                local dist = #(pedVector - doorVector)
                if #(pedVector - doorVector) <= 50 then
                    if closestDoorHash ~= nil then
                        local pair = doorStates[closestDoorHash]
                        local closestDoorEntity = Citizen.InvokeNative(0xF7424890E4A094C0, closestDoorHash)
                        local closestDoorVector = GetEntityCoords(closestDoorEntity)
                        if pair ~= doorHash and dist < #(pedVector - closestDoorVector) then
                            closestDoorHash = doorHash
                        end
                    else
                        closestDoorHash = doorHash
                    end
                end
            end

            for _, values in pairs(windows) do
                local windowVector = values[2]

                local dist = #(pedVector - windowVector)

                if dist <= 100 then
                    local windowsEntity = GetClosestObjectOfType(windowVector, 1.0, values[1], false, false, false)
                    if windowsEntity ~= 0 then
                        SetEntityInvincible(windowsEntity, true)
                    end
                end
            end
        end
    end
)

RegisterNetEvent("VP:HOUSING:SetDoorState")
AddEventHandler(
    "VP:HOUSING:SetDoorState",
    function(doorHash, doorState)
        Citizen.InvokeNative(0xD99229FE93B46286, doorHash, 1, 1, 0, 0, 0, 0)
        DoorSystemSetDoorState(doorHash, doorState)
    end
)

local doorStatePrompt = -1

Citizen.CreateThread(
    function()
        local promptOpen = PromptRegisterBegin()
        local promptGroupOpen = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(promptOpen, 0x7F8D09B8)
        PromptSetText(promptOpen, CreateVarString(10, "LITERAL_STRING", "Abrir Porta"))
        PromptSetEnabled(promptOpen, 1)
        PromptSetVisible(promptOpen, 1)
        PromptSetHoldMode(promptOpen, 1)
        -- PromptSetStandardizedHoldMode(promptOpen, 1)
        PromptSetGroup(promptOpen, promptGroupOpen)
        PromptRegisterEnd(promptOpen)

        local promptClose = PromptRegisterBegin()
        local promptGroupClose = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(promptClose, 0x7F8D09B8)
        PromptSetText(promptClose, CreateVarString(10, "LITERAL_STRING", "Fechar Porta"))
        PromptSetEnabled(promptClose, 1)
        PromptSetVisible(promptClose, 1)
        PromptSetHoldMode(promptClose, 1)
        -- PromptSetStandardizedHoldMode(promptClose, 1)
        PromptSetGroup(promptClose, promptGroupClose)
        PromptRegisterEnd(promptClose)

        for doorHash, _ in pairs(doorStates) do
            Citizen.InvokeNative(0xD99229FE93B46286, doorHash, 1, 1, 0, 0, 0, 0)
            DoorSystemSetDoorState(doorHash, 0)
        end

        local holdModeOn = false

        while true do
            Citizen.Wait(0)

            if closestDoorHash ~= nil then
                local ped = PlayerPedId()
                local pedVector = GetEntityCoords(ped)

                local doorEntity = Citizen.InvokeNative(0xF7424890E4A094C0, closestDoorHash)
                local doorVector = GetEntityCoords(doorEntity)

                local dist = #(pedVector - doorVector)

                if dist <= 1.5 then
                    doorStatePrompt = DoorSystemGetDoorState(closestDoorHash)
                else
                    doorStatePrompt = -1
                end
            end

            if doorStatePrompt ~= -1 then
                local prompt
                if doorStatePrompt == 0 then
                    PromptSetActiveGroupThisFrame(promptGroupClose, CreateVarString(10, "LITERAL_STRING", "Residencia"))
                    prompt = promptClose
                else
                    PromptSetActiveGroupThisFrame(promptGroupOpen, CreateVarString(10, "LITERAL_STRING", "Residencia"))
                    prompt = promptOpen
                end

                if holdModeOn == false and not PromptHasHoldModeCompleted(prompt) and PromptIsHoldModeRunning(prompt) then
                    holdModeOn = true
                    Citizen.CreateThread(
                        function()
                            while PromptIsHoldModeRunning(prompt) do
                                Citizen.Wait(0)
                                if PromptHasHoldModeCompleted(prompt) then
                                    if closestDoorHash ~= nil then
                                        TriggerServerEvent("VP:HOUSING:TryToToggleDoorState", closestDoorHash)
                                    end
                                    break
                                end
                            end

                            holdModeOn = false
                        end
                    )
                end
            end
        end
    end
)
