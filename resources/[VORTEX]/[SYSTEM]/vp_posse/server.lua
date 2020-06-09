local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
API_DB = Proxy.getInterface("API_DB")
cAPI = Tunnel.getInterface("API")

RegisterCommand(
    "bando",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        if User:isInAPosse() then
            local data = {}
            local Posse = API.getPosse(User:getPosseId())
            for memberCharId, rank in pairs(Posse:getMembers()) do
                local name = API.getNameById(memberCharId)
                local isOnline = false
                local UserMember = API.getUserFromCharId(memberCharId)
                if UserMember ~= nil and UserMember:getCharacter():getId() == tonumber(memberCharId) then
                    isOnline = true
                end
                data[memberCharId] = {
                    rank = rank,
                    name = name,
                    isOnline = isOnline
                }
            end
            TriggerClientEvent("VP:POSSE:OpenMenu", source, data, Posse:getName())
        else
            -- else
            --     User:notify('Você não tem permissao para criar um Bando')
            -- end
            -- if User:getCharacter():hasGroup('donator01') then
            TriggerClientEvent("VP:POSSE:OpenCreationMenu", source)
        end
    end,
    false
)

RegisterCommand(
    "createBando",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        if not User:isInAPosse() then
            if args[1] then
                API.createPosse(User:getCharacter():getId(),args[1])
            end
        end
    end
)

RegisterNetEvent("VP:POSSE:Invite")
AddEventHandler(
    "VP:POSSE:Invite",
    function(targetUserId)
        local _source = source
        local User = API.getUserFromSource(_source)

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("VP:POSSE:CloseMenu", _source)
            return
        end

        local UserTarget = API.getUserFromUserId(targetUserId)

        if UserTarget == nil then
            User:notify("Usuario de id " .. targetUserId .. " não está online")
            return
        end

        if UserTarget:isInAPosse() then
            User:notify("Usuario de id " .. targetUserId .. " já se encontra em um bando!")
            return
        end

        User:notify("Você convidou o ID " .. targetUserId .. " para entrar no bando")
        UserTarget:notify("Você foi convidado a entrar no bando ")

        local Posse = API.getPosse(User:getPosseId())

        local yes = API.request(UserTarget:getSource(), "Convite para o Bando " .. Posse:getName() .. " ?", 30)

        if yes then
            Posse:addMember(UserTarget, 3)
        else
            User:notify("User " .. targetUserId .. " recusou o convite")
        end
    end
)

RegisterNetEvent("VP:POSSE:Promote")
AddEventHandler(
    "VP:POSSE:Promote",
    function(targetCharId, charName)
        local _source = source
        local User = API.getUserFromSource(_source)

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("VP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        if not Posse:isAMember(targetCharId) then
            User:notify(charName .. " não faz mais parte do bando")
            return
        end

        local targetRank = Posse:getMemberRank(targetCharId)
        if targetRank <= 2 then
            User:notify(charName .. " já está no rank mais alto")
            return
        end

        local userRank = Posse:getMemberRank(Character:getId())

        if userRank <= 2 then
            if userRank == targetRank then
                User:notify("Somente um membro de cargo superior pode promover este membro")
                return
            end

            Posse:promoteMember(targetCharId)
            Posse:notify(charName .. " foi promovido no Bando!")
        end
    end
)

RegisterNetEvent("VP:POSSE:Demote")
AddEventHandler(
    "VP:POSSE:Demote",
    function(targetCharId, charName)
        local _source = source
        local User = API.getUserFromSource(_source)

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("VP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        if not Posse:isAMember(targetCharId) then
            User:notify(charName .. " não faz mais parte do bando")
            return
        end

        local targetRank = Posse:getMemberRank(targetCharId)
        if targetRank == 3 then
            User:notify(charName .. " já está no rank mais baixo!")
            return
        end

        local userRank = Posse:getMemberRank(Character:getId())

        if userRank <= 2 then
            if userRank == targetRank then
                User:notify("Somente um membro de cargo superior pode rebaixar este membro")
                return
            end

            Posse:demoteMember(targetCharId)
            Posse:notifyMembers(charName .. " foi rebaixado no Bando!")
        end
    end
)

RegisterNetEvent("VP:POSSE:Leave")
AddEventHandler(
    "VP:POSSE:Leave",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)

        if not User:isInAPosse() then
            User:notify("Você não está em um bando")
            TriggerClientEvent("VP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        Posse:removeMember(Character:getId())
        Posse:notifyMembers(Character:getName() .. " saiu do bando!")

        User:notify("Você saiu do bando!")
    end
)
