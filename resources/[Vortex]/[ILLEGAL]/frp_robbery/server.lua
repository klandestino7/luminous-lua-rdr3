local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local data = {
    [1] = {
        staticReward = 10000,
        staticSecondsToReward = 10,
        staticMaxParticipants = 3,
        staticCooldown = 30 * 60
        -- cooldown
    },
    [2] = {
        staticReward = 10000,
        staticSecondsToReward = 30,
        staticMaxParticipants = 3,
        staticCooldown = 30 * 60
    },
    [3] = {
        staticReward = 10000,
        staticSecondsToReward = 30,
        staticMaxParticipants = 3,
        staticCooldown = 30 * 60
    },
    [4] = {
        staticReward = 10000,
        staticSecondsToReward = 30,
        staticMaxParticipants = 3,
        staticCooldown = 30 * 60
    }

}

local indexBeingRobbed = nil
local indexBeingRobbed_seconds = nil
local indexBeingRobbed_participants = {}
local indexBeingRobbed_playerSourceWhoStarted = nil

local robberyBeingEnded = false

RegisterNetEvent("VP:ROBBERY:TryToStartRobbery")
AddEventHandler(
    "VP:ROBBERY:TryToStartRobbery",
    function(index, participants)
        local _source = source

        if interiorIndexBeingRobbed ~= nil then
            print("Interior já está sendo roubado")
            TriggerClientEvent('VP:Notify', _source, "Esse local já está sendo roubado")
            return
        end

        if data[index].cooldown ~= nil then
            if data[index].cooldown > os.time() then
                print("Fomos assaltados a pouco tempo, não temos dinheiro")
                TriggerClientEvent('VP:Notify', _source, "Fomos assaltados a pouco tempo, não temos dinheiro")
                return
            else
                data[index].cooldown = nil
            end
        end

        indexBeingRobbed = index
        indexBeingRobbed_playerSourceWhoStarted = _source

        local numParticipants = 0
        local maxParticipants = data[index].staticMaxParticipants
        local numParticipantsToCheck = #participants

        countdownRobberyTime()

        for _, playerSource in pairs(GetPlayers()) do
            playerSource = tonumber(playerSource)
            local isParticipant = false
            if numParticipantsToCheck > 0 then
                for _, participantSource in pairs(participants) do
                    if playerSource == participantSource then
                        numParticipantsToCheck = numParticipantsToCheck - 1
                        isParticipant = true
                        if numParticipants < maxParticipants then
                            numParticipants = numParticipants + 1
                            TriggerClientEvent("VP:ROBBERY:StartRobbery", participantSource, index, true, indexBeingRobbed_seconds)
                            participants[participantSource] = true
                        else
                            TriggerClientEvent("VP:ROBBERY:StartRobberyAsBlocked", participantSource, index)
                        end
                    end
                end
            end

            if isParticipant == false then
                TriggerClientEvent("VP:ROBBERY:StartRobbery", playerSource, index, false, nil)
            end

            isParticipant = nil
        end
    end
)

function countdownRobberyTime()
    indexBeingRobbed_seconds = data[indexBeingRobbed].staticSecondsToReward

    Citizen.CreateThread(
        function()
            while indexBeingRobbed ~= nil do
                Citizen.Wait(1000)
                if indexBeingRobbed ~= nil then
                    indexBeingRobbed_seconds = indexBeingRobbed_seconds - 1

                    if indexBeingRobbed_seconds == 0 then
                        print("Robbery seconds is now 0")
           --             TriggerClientEvent('VP:Notify', _source, "O tempo do roubo é de 0s")
                        endRobberyGiveReward()
                    end
                end
            end
        end
    )
end



function endRobberyGiveReward()
    print("endRobberyGiveReward")

    if indexBeingRobbed == nil then
        return
    end

    robberyBeingEnded = true

    local User

    if indexBeingRobbed_playerSourceWhoStarted ~= nil then
        User = API.getUserFromSource(indexBeingRobbed_playerSourceWhoStarted)
    else
        for participantSource, _ in pairs(indexBeingRobbed_participants) do
            User = API.getUserFromSource(participantSource)
            if User ~= nil then
                break
            end
        end
    end

    if User ~= nil then
        local Character = User:getCharacter()
        if Character ~= nil then
            local reward = data[indexBeingRobbed].staticReward
            Character:getInventory():addItem("money", reward)
            --TriggerClientEvent('VP:Notify', User, "Você recebeu R$ " .. reward .. " pelo assalto")
            print("Você recebeu R$ " .. reward / 100 .. " de dólar sujo pelo assalto")
            User:notify("Você recebeu R$ " .. reward / 100 .. " de dólar sujo pelo assalto")
        end
    end

    print("indexBeingRobbed", indexBeingRobbed)
    data[indexBeingRobbed].cooldown = os.time() + (1000 * data[indexBeingRobbed].staticCooldown)

    indexBeingRobbed = nil
    indexBeingRobbed_seconds = 0
    indexBeingRobbed_participants = {}
    robberyBeingEnded = false
    
    TriggerClientEvent("VP:ROBBERY:EndRobbery", -1)
end

RegisterNetEvent("VP:ROBBERY:PlayerAbandonedRobbery")
AddEventHandler(
    "VP:ROBBERY:PlayerAbandonedRobbery",
    function()
        if indexBeingRobbed == nil then
            return
        end

        local _source = source

        if indexBeingRobbed_playerSourceWhoStarted == _source then
            indexBeingRobbed_playerSourceWhoStarted = nil
        end

        indexBeingRobbed_participants[_source] = nil

        if #indexBeingRobbed_participants <= 0 and not robberyBeingEnded then
            data[indexBeingRobbed].cooldown = os.time() + (1000 * data[indexBeingRobbed].staticCooldown)

            indexBeingRobbed = nil
            indexBeingRobbed_seconds = 0
            indexBeingRobbed_participants = {}
            robberyBeingEnded = false

            TriggerClientEvent("VP:ROBBERY:EndRobbery", -1)
        end

        print("Player " .. _source .. " left the robbery")
        TriggerClientEvent('VP:Notify', _source, "O " .. _source .. " left the robbery")
    end
)

AddEventHandler(
    "playerDropped",
    function(source, reason)
        if indexBeingRobbed_participants[source] ~= nil then
            TriggerEvent("VP:ROBBERY:PlayerAbandonedRobbery", source)
        end
    end
)