local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('WANTED:checkJOB')
AddEventHandler('WANTED:checkJOB', function()
    local _source = source
    local User = API.getUserFromSource(_source)      
    local Character = User:getCharacter()
    if Character:hasGroup("user") then        
        return true
    end
end)

RegisterServerEvent('WANTED:gunshotInProgress')
AddEventHandler('WANTED:gunshotInProgress', function(targetCoords, CityName, playerGender)
    local _source = source
    local User = API.getUserFromSource(_source)      
    local Character = User:getCharacter()
    if Character:hasGroup("user") then
        if playerGender == -171876066 then
            playerGender = 'homem'
        else
            playerGender = 'mulher'
        end
        TriggerClientEvent('WANTED:outlawNotify', -1, 'Disparos por ' .. playerGender .. ' foram relatados em ' .. CityName)
        TriggerClientEvent('WANTED:gunshotInProgress', -1, targetCoords)
    end
end)


-- RegisterNetEvent("FCRP:ROBBERY:TryToStartRobbery")
-- AddEventHandler(
--     "FCRP:ROBBERY:TryToStartRobbery",
--     function(index, participants)
--         local _source = source
--         local User = API.getUserFromSource(_source)

--         indexBeingRobbed = index
--         local Posse = API.getPosse(User:getPosseId())        
--         local Character = User:getCharacter()
--         local userRank = Posse:getMemberRank(Character:getId())
--         local fortbando = Posse:getData(indexBeingRobbed,'bando')



--         if not User:isInAPosse() then
--            User:notify("Você não está em um bando.")            
--             TriggerClientEvent('FRP:Notify', _source, "Você não está em um bando.")
--             return
--         end

--         if userRank >= 2 then
--             User:notify("Somente um membro de cargo superior pode iniciar dominação.")
--             TriggerClientEvent('FRP:Notify', _source, "Somente um membro de cargo superior pode iniciar dominação.")
--             return
--         end 

--         if Posse.id == fortbando then
--             User:notify("Seu bando já domina este forte.")
--             TriggerClientEvent('FRP:Notify', _source, "Seu bando já domina este forte.")
--             return
--         end

--         if interiorIndexBeingRobbed ~= nil then
--             print("Este forte já está em dominação")
--             TriggerClientEvent('FRP:Notify', _source, "Este forte já está em dominação.")
--             return
--         end

--         if data[index].cooldown ~= nil then
--             if data[index].cooldown > os.time() then
--                 print("Fomos assaltados a pouco tempo, não temos dinheiro")
--                 TriggerClientEvent('FRP:Notify', _source, "Fomos assaltados a pouco tempo, não temos dinheiro")
--                 return
--             else
--                 data[index].cooldown = nil
--             end
--         end
        
--         indexBeingRobbed_playerSourceWhoStarted = _source
--         local numParticipants = 0
--         local maxParticipants = data[index].staticMaxParticipants
--         local numParticipantsToCheck = #participants

--         countdownRobberyTime()

--         for _, playerSource in pairs(GetPlayers()) do
--             playerSource = tonumber(playerSource)
--             local isParticipant = false
--             if numParticipantsToCheck > 0 then
--                 for _, participantSource in pairs(participants) do
--                     if playerSource == participantSource then
--                         numParticipantsToCheck = numParticipantsToCheck - 1
--                         isParticipant = true
--                         if numParticipants < maxParticipants then
--                             numParticipants = numParticipants + 1
--                             print(indexBeingRobbed_seconds)
--                             TriggerClientEvent("FCRP:ROBBERY:StartRobbery", participantSource, index, true, indexBeingRobbed_seconds)

--                             TriggerClientEvent('FRP:Notify', -1, "O Forte ".. data[indexBeingRobbed].staticName .." está sendo disputado.")
--                             participants[participantSource] = true
--                         else
--                             TriggerClientEvent("FCRP:ROBBERY:StartRobberyAsBlocked", participantSource, index)
--                         end
--                     end
--                 end
--             end

--             if isParticipant == false then
--                 TriggerClientEvent("FCRP:ROBBERY:StartRobbery", playerSource, index, false, nil)
--             end

--             isParticipant = nil
--         end
--     end
-- )