local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local Locations = {
    [1] = {vector3(-4219.9692382813,-3460.451171875,37.817359924316), 46},  -- VALENTINE
    [2] = {vector3(347.75500488281,1484.5426025391,179.63270568848), 26}
}

local interiorIndexBeingRobbed = nil
local interiorIndexPlayerIsIn = nil
local inposition = nil

local isParticipantOfRobbery = false
local isBlockedByRobbery = false

local secondsUntilRobberyEnds = nil
local secondsUntilAbandonRobbery = nil

local shootingToStartCooldown = false

local roubo = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)            
            local ped = PlayerPedId()
            local interiorIdPlayerIsIn = GetInteriorFromEntity(ped)
            local coords = GetEntityCoords(ped)
            for index, vector in pairs(Locations) do
                local dst = #(vector[1] - coords)
                if dst < vector[2] then
                    inposition = index    
                    break                    
                else 
                    inposition = nil               
                end    
            end      
        end
    end
)

Citizen.CreateThread(
    function()
        ClearPedTasksImmediately(PlayerPedId())
            
        --AddTextEntry("shoot_to_start", "Atire para começar o assalto")
        --AddTextEntry("wait_to_shoot", "Aguarde 10 segundos...")
        local hashUnarmed = GetHashKey("WEAPON_UNARMED")
        while true do
            Citizen.Wait(0)
            --print(inposition)
            if inposition ~= nil then
                local ped = PlayerPedId()
                local retval, weaponHash = GetCurrentPedWeapon(ped, 1)
                if weaponHash ~= hashUnarmed then
                    if interiorIndexBeingRobbed == nil then
                        if not shootingToStartCooldown then
                            if not roubo then
                                notify('Atire para começar a ~e~dominação.')
                                roubo = true
                            end
                          --  TriggerEvent('VP:Notify', 'Atire para começar o assalto.')
                            if IsPedShooting(ped) then
                                initShootingCountdown()

                                local playerId = PlayerId()
                                local interiorIdPlayerIsIn = inposition

                                local participants = {
                                    GetPlayerServerId(playerId)
                                }

                                for _, activePlayerId in pairs(GetActivePlayers()) do
                                    if activePlayerId ~= playerId then
                                        local activePlayerPed = GetPlayerPed(activePlayerId)
                                        if activePlayerPed ~= 0 then
                                            table.insert(participants, GetPlayerServerId(activePlayerId))                                
                                        end
                                    end
                                end
                                TriggerServerEvent("VP:FORT:TryToStartRobbery", interiorIdPlayerIsIn, participants)
                            end
                        else
                            notify('Começando...')
                           -- DisplayHelpTextThisFrame("wait_to_shoot", false)
                           --TriggerEvent('VP:Notify', 'Aguarde 10 segundos...')
                        end
                    else
                        if IsPedShooting(ped) then
                           --notify('Roubo em andamento, aguarde...')
                         --   print("Roubo em andamento, aguarde")
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
                       -- DisableControlAction(0, 24, true)
                      --  DisableControlAction(0, 25, true)
                      --  DisableControlAction(0, 140, true)
                      --  DisableControlAction(0, 141, true)
                       -- DisableControlAction(0, 142, true)
                      --  DisableControlAction(0, 257, true)
                      --  DisableControlAction(0, 263, true)
                     --   DisableControlAction(0, 264, true)

                        if weaponHash ~= hashUnarmed then
                            SetCurrentPedWeapon(ped, hashUnarmed, true)
                        end
                        if not IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3) then
                            TaskPlayAnim(ped, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 63, 0, 0, 0, 0)
                        end
                    end
                end

                if inposition == interiorIndexBeingRobbed then
                    if secondsUntilRobberyEnds ~= nil then                       
                       -- local hours = secondsUntilRobberyEnds / 3600
                        local minutes = math.floor((secondsUntilRobberyEnds % 3600) / 60)
                        local seconds = secondsUntilRobberyEnds % 60
                        drawText('Dominando em: ' ..minutes .. " minutos e " .. seconds .. " segundos" , true)
                    end
                end
            else
                if secondsUntilAbandonRobbery ~= nil then
                    drawText("~r~Volte para do forte em " .. math.floor((secondsUntilAbandonRobbery / 10)) .. " segundos", true)
                end
            end
            --print(secondsUntilAbandonRobbery)
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

                local interiorIdBeingRobbed = interiorIndexBeingRobbed
                local interiorIdPlayerIsIn = inposition

                if interiorIdPlayerIsIn ~= interiorIdBeingRobbed then
                    if secondsUntilAbandonRobbery == nil then
                        secondsUntilAbandonRobbery = defaultSeconds
                    end

                    secondsUntilAbandonRobbery = secondsUntilAbandonRobbery - 1 -- Wait ms
                    if secondsUntilAbandonRobbery <= 0 then
                        if not isBlockedByRobbery then
                            print("Você ficou tempo demais fora do roubo")
                            TriggerServerEvent("VP:FORT:PlayerAbandonedRobbery")
                        else
                            isBlockedByRobbery = false
                            ClearPedTasks(ped)
                            print("Você ficou tempo demais fora do roubo blocked")
                        end

                        TriggerEvent("VP:FORT:EndRobbery")

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

RegisterNetEvent("VP:FORT:StartRobbery")
AddEventHandler(
    "VP:FORT:StartRobbery",
    function(index, asParticipant, seconds)
        interiorIndexBeingRobbed = index
        if asParticipant then
            initCheckPedIsOutside()
            initSecondsCountdown(seconds)
        end
    end
)

RegisterNetEvent("VP:FORT:StartRobberyAsBlocked")
AddEventHandler(
    "VP:FORT:StartRobberyAsBlocked",
    function(index)
        interiorIndexBeingRobbed = index
        isBlockedByRobbery = true
        initCheckPedIsOutside()

        if not HasAnimDictLoaded("random@arrests@busted") then
            RequestAnimDict("random@arrests@busted")
        end
    end
)


RegisterNetEvent("VP:FORT:EndRobbery")
AddEventHandler(
    "VP:FORT:EndRobbery",
    function()
        interiorIndexBeingRobbed = nil

        isParticipantOfRobbery = false
        isBlockedByRobbery = false

        secondsUntilRobberyEnds = nil
        secondsUntilAbandonRobbery = nil        
        shootingToStartCooldown = false
        Wait(5000)
        roubo = false
    end
)

function drawText(str, center)
    local x =  0.87
    local y = 0.95
	local str = CreateVarString(10, "LITERAL_STRING", str)
	SetTextScale(0.4, 0.4)
	SetTextColor(255, 255, 255, 255)
	Citizen.InvokeNative(0xADA9255D, 1)
	--DisplayText(str, x, y)
	if center then
		SetTextCentre(center)
		DisplayText(str, x, y)
	elseif alignRight then
	DisplayText(str, x+0.15, y)
	else 
	DisplayText(str, x, y)
    end
end


function notify(_message)
	local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", _message, Citizen.ResultAsLong())
	SetTextScale(0.25, 0.25)
	SetTextCentre(1)
	Citizen.InvokeNative(0xFA233F8FE190514C, str)
	Citizen.InvokeNative(0xE9990552DEC71600)
end


-- function drawText(text)
--     SetTextFont(0)
--     SetTextProportional(1)
--     SetTextScale(0.0, 0.3)
--     SetTextColour(128, 128, 128, 255)
--     SetTextDropshadow(0, 0, 0, 0, 255)
--     SetTextEdge(1, 0, 0, 0, 255)
--     SetTextDropShadow()
--     SetTextOutline()
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(0.5, 0.5)
-- end
