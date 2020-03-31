local interiors = {
    [1] = 82690, -- Joalheria
    [2] = 179969 -- Banco Interior
}

local interiorIndexBeingRobbed = nil
local interiorIndexPlayerIsIn = nil

local isParticipantOfRobbery = false
local isBlockedByRobbery = false

local secondsUntilRobberyEnds = nil
local secondsUntilAbandonRobbery = nil

local shootingToStartCooldown = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()

            local interiorIdPlayerIsIn = GetInteriorFromEntity(ped)

            if interiorIdPlayerIsIn ~= 0 then
                for index, interiorId in pairs(interiors) do
                    if interiorIdPlayerIsIn == interiorId then
                        interiorIndexPlayerIsIn = index
                    end
                end
            else
                interiorIndexPlayerIsIn = nil
            end
        end
    end
)

Citizen.CreateThread(
    function()
        ClearPedTasksImmediately(PlayerPedId())

        AddTextEntry("shoot_to_start", "Atire para começar o assalto")
        AddTextEntry("wait_to_shoot", "Aguarde 10 segundos...")
        local hashUnarmed = GetHashKey("WEAPON_UNARMED")
        while true do
            Citizen.Wait(0)

            if interiorIndexPlayerIsIn ~= nil then
                local ped = PlayerPedId()
                local retval, weaponHash = GetCurrentPedWeapon(ped, 1)

                if weaponHash ~= hashUnarmed then
                    if interiorIndexBeingRobbed == nil then
                        if not shootingToStartCooldown then
                            DisplayHelpTextThisFrame("shoot_to_start", false)
                            if IsPedShooting(ped) then
                                initShootingCountdown()

                                print("Roubo começo!!")

                                local playerId = PlayerId()
                                local interiorIdPlayerIsIn = interiors[interiorIndexPlayerIsIn]

                                local participants = {
                                    GetPlayerServerId(playerId)
                                }

                                for _, activePlayerId in pairs(GetActivePlayers()) do
                                    if activePlayerId ~= playerId then
                                        local activePlayerPed = GetPlayerPed(activePlayerId)
                                        if activePlayerPed ~= 0 then
                                            local activePlayerPedInterior = GetInteriorFromEntity(activePlayerPed)
                                            if activePlayerPedInterior == interiorIdPlayerIsIn then
                                                table.insert(participants, GetPlayerServerId(activePlayerId))
                                            end
                                        end
                                    end
                                end

                                TriggerServerEvent("FCRP:ROBBERY:TryToStartRobbery", interiorIndexPlayerIsIn, participants)
                            end
                        else
                            DisplayHelpTextThisFrame("wait_to_shoot", false)
                        end
                    else
                        if IsPedShooting(ped) then
                            print("Roubo em andamento, aguarde")
                        end
                    end

                -- Block player actions if they are not an active participant
                end

                if isBlockedByRobbery then
                    if interiorIndexBeingRobbed == nil then
                        isBlockedByRobbery = false
                        RemoveAnimDict("random@arrests@busted")
                        ClearPedTasks(ped)
                    else
                        DisableControlAction(0, 24, true)
                        DisableControlAction(0, 25, true)
                        DisableControlAction(0, 140, true)
                        DisableControlAction(0, 141, true)
                        DisableControlAction(0, 142, true)
                        DisableControlAction(0, 257, true)
                        DisableControlAction(0, 263, true)
                        DisableControlAction(0, 264, true)

                        if weaponHash ~= hashUnarmed then
                            SetCurrentPedWeapon(ped, hashUnarmed, true)
                        end
                        if not IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3) then
                            TaskPlayAnim(ped, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 63, 0, 0, 0, 0)
                        end
                    end
                end

                if interiorIndexPlayerIsIn == interiorIndexBeingRobbed then
                    if secondsUntilRobberyEnds ~= nil then
                        -- local hours = secondsUntilRobberyEnds / 3600
                        local minutes = math.floor((secondsUntilRobberyEnds % 3600) / 60)
                        local seconds = secondsUntilRobberyEnds % 60

                        drawText(minutes .. " minutos e " .. seconds .. " segundos")
                    end
                end
            else
                if secondsUntilAbandonRobbery ~= nil then
                    drawText("~r~Volte para dentro do banco! " .. math.floor((secondsUntilAbandonRobbery / 10)) .. " segundos")
                end
            end
        end
    end
)

function initCheckPedIsOutside()
    isParticipantOfRobbery = true
    Citizen.CreateThread(
        function()
            local defaultSeconds = 5 
            defaultSeconds = defaultSeconds * 10 -- 100ms (Wait) * 50 = 5000ms
            secondsUntilAbandonRobbery = defaultCount
            while isParticipantOfRobbery do
                Citizen.Wait(100)

                local ped = PlayerPedId()

                local interiorIdBeingRobbed = interiors[interiorIndexBeingRobbed]
                local interiorIdPlayerIsIn = GetInteriorFromEntity(ped)

                if interiorIdPlayerIsIn ~= interiorIdBeingRobbed then
                    if secondsUntilAbandonRobbery == nil then
                        secondsUntilAbandonRobbery = defaultSeconds
                    end

                    secondsUntilAbandonRobbery = secondsUntilAbandonRobbery - 1 -- Wait ms
                    if secondsUntilAbandonRobbery <= 0 then
                        if not isBlockedByRobbery then
                            print("Você ficou tempo demais fora do roubo")
                            TriggerServerEvent("FCRP:ROBBERY:PlayerAbandonedRobbery")
                        else
                            isBlockedByRobbery = false
                            ClearPedTasks(ped)
                            print("Você ficou tempo demais fora do roubo blockedd")
                        end

                        TriggerEvent("FCRP:ROBBERY:EndRobbery")

                        break
                    end
                else
                    if secondsUntilAbandonRobbery ~= nil then
                        secondsUntilAbandonRobbery = nil
                    end
                end
            end

            if not isParticipantOfRobbery then
                local ped = PlayerPedId()
                if IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3) then
                    ClearPedTasks(ped)
                end
            end
        end
    )
end

function initSecondsCountdown(seconds)
    print("got seconds", seconds)
    secondsUntilRobberyEnds = seconds

    Citizen.CreateThread(
        function()
            while secondsUntilRobberyEnds ~= nil do
                Citizen.Wait(1000)
                if secondsUntilRobberyEnds ~= nil then
                    secondsUntilRobberyEnds = secondsUntilRobberyEnds - 1

                    if secondsUntilRobberyEnds == 0 then
                        secondsUntilRobberyEnds = nil
                    end
                end
            end
        end
    )
end

function initShootingCountdown()
    shootingToStartCooldown = true
    seconds = 10

    Citizen.CreateThread(
        function()
            while seconds > 0 do
                Citizen.Wait(1000)
                seconds = seconds - 1
            end
            shootingToStartCooldown = false
        end
    )
end

RegisterNetEvent("FCRP:ROBBERY:StartRobbery")
AddEventHandler(
    "FCRP:ROBBERY:StartRobbery",
    function(index, asParticipant, seconds)
        interiorIndexBeingRobbed = index
        if asParticipant then
            initCheckPedIsOutside()
            initSecondsCountdown(seconds)
        end
    end
)

RegisterNetEvent("FCRP:ROBBERY:StartRobberyAsBlocked")
AddEventHandler(
    "FCRP:ROBBERY:StartRobberyAsBlocked",
    function(index)
        interiorIndexBeingRobbed = index
        isBlockedByRobbery = true
        initCheckPedIsOutside()

        if not HasAnimDictLoaded("random@arrests@busted") then
            RequestAnimDict("random@arrests@busted")
        end
    end
)

RegisterNetEvent("FCRP:ROBBERY:EndRobbery")
AddEventHandler(
    "FCRP:ROBBERY:EndRobbery",
    function()
        interiorIndexBeingRobbed = nil

        isParticipantOfRobbery = false
        isBlockedByRobbery = false

        secondsUntilRobberyEnds = nil
        secondsUntilAbandonRobbery = nil

        shootingToStartCooldown = false
    end
)

function drawText(text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.3)
    SetTextColour(128, 128, 128, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.5)
end
