local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local data = {
    [1] = {
        staticReward = 10000,
        staticSecondsToReward = 7,
        staticMaxParticipants = 3,
        staticCooldown = 30 * 60,
        staticName = 'Mercer'
    },
    [2] = {
        staticReward = 10000,
        staticSecondsToReward = 7,
        staticMaxParticipants = 3,
        staticCooldown = 30 * 60,
        staticName = 'Wallace'
    }
}

local indexBeingRobbed = nil
local indexBeingRobbed_seconds = nil
local indexBeingRobbed_participants = {}
local indexBeingRobbed_playerSourceWhoStarted = nil

local robberyBeingEnded = false
local index = nil
RegisterNetEvent("FRP:FORT:TryToStartRobbery")
AddEventHandler(
    "FRP:FORT:TryToStartRobbery",
    function(index, participants)
        local _source = source
        local User = API.getUserFromSource(_source)

        indexBeingRobbed = index
        local Posse = API.getPosse(User:getPosseId())        
        local Character = User:getCharacter()
        local userRank = Posse:getMemberRank(Character:getId())
        local fortbando = Posse:getData(indexBeingRobbed,'bando')

        if not User:isInAPosse() then
           -- User:notify("Você não está em um bando.")            
            TriggerClientEvent('FRP:Notify', _source, "Você não está em um bando.")
            return
        end

        if userRank >= 2 then
            --User:notify("Somente um membro de cargo superior pode iniciar dominação.")
            TriggerClientEvent('FRP:Notify', _source, "Somente um membro de cargo superior pode iniciar dominação.")
            return
        end 

        if Posse.id == fortbando then
            --User:notify("Seu bando já domina este forte.")
            TriggerClientEvent('FRP:Notify', _source, "Seu bando já domina este forte.")
            return
        end

        if interiorIndexBeingRobbed ~= nil then
            print("Este forte já está em dominação")
            TriggerClientEvent('FRP:Notify', _source, "Este forte já está em dominação.")
            return
        end

        if data[index].cooldown ~= nil then
            if data[index].cooldown > os.time() then
                print("Fomos assaltados a pouco tempo, não temos dinheiro")
                TriggerClientEvent('FRP:Notify', _source, "Fomos assaltados a pouco tempo, não temos dinheiro")
                return
            else
                data[index].cooldown = nil
            end
        end
        
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
                            print(indexBeingRobbed_seconds)
                            TriggerClientEvent("FRP:FORT:StartRobbery", participantSource, index, true, indexBeingRobbed_seconds)

                            TriggerClientEvent('FRP:Notify', -1, "O Forte ".. data[indexBeingRobbed].staticName .." está sendo disputado.")
                            participants[participantSource] = true
                        else
                            TriggerClientEvent("FRP:FORT:StartRobberyAsBlocked", participantSource, index)
                        end
                    end
                end
            end

            if isParticipant == false then
                TriggerClientEvent("FRP:FORT:StartRobbery", playerSource, index, false, nil)
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
           --             TriggerClientEvent('FRP:Notify', _source, "O tempo do roubo é de 0s")
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
        local Posse = API.getPosse(User:getPosseId())        
        if Character ~= nil then 
            Posse:setData(indexBeingRobbed, 'bando', 'bando', Posse.id)
            TriggerClientEvent('FRP:Notify', User, "Você dominou esse forte!")
        end
    end

    print("indexBeingRobbed", indexBeingRobbed)
    data[indexBeingRobbed].cooldown = os.time() + (1000 * data[indexBeingRobbed].staticCooldown)

    indexBeingRobbed = nil
    indexBeingRobbed_seconds = 0
    indexBeingRobbed_participants = {}
    robberyBeingEnded = false
    
    TriggerClientEvent("FRP:FORT:EndRobbery", -1)
end

RegisterNetEvent("FRP:FORT:PlayerAbandonedRobbery")
AddEventHandler(
    "FRP:FORT:PlayerAbandonedRobbery",
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

            TriggerClientEvent("FRP:FORT:EndRobbery", -1)
        end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        print("Player " .. _source .. " left the robbery")
        TriggerClientEvent('FRP:Notify', _source, "O " .. Character:getName() .. " saiu da área da dominação.")
    end
)

AddEventHandler(
    "playerDropped",
    function(source, reason)
        if indexBeingRobbed_participants[source] ~= nil then
            TriggerEvent("FRP:FORT:PlayerAbandonedRobbery", source)
        end
    end
)