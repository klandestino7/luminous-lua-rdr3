local sessionQueue = {}

LoginCooldown = {}

function connectUser(source, user_id)
    if API.users[user_id] then
        return
    end

    if #GetPlayers() == 33 then
        API.dropPlayer(source, 'Quase bugou a instancia')
    end

    local steamID = GetPlayerIdentifiers(source)[1]

    local User = API.User(source, user_id, GetPlayerEndpoint(source))

    API.users[user_id] = User
    API.sources[source] = user_id
    API.identifiers[steamID] = GetPlayerIdentifiers(source)
    cAPI._clientConnected(source, true)

    print(#GetPlayers() .. "/32 | " .. GetPlayerName(source) .. " (" .. User:getIpAddress() .. ") entrou (user_id = " .. user_id .. ", source = " .. source .. ")")
    
    TriggerEvent("VP:IDENTITY:DisplayCharSelection", User)

    TriggerClientEvent('VP:_CORE:SetServerIdAsUserId', -1, source, user_id)
    TriggerClientEvent('VP:_CORE:SetServerIdAsUserIdPacked', source, API.sources)

    return User
end

AddEventHandler(
    "playerConnecting",
    function(playerName, kickReason, deferrals)
        deferrals.defer()

        if #GetPlayers() >= 32 or #API.users >= 32 then
            print("Authentication: " .. source .. " Erro ao autenticar, limite de players alcançado!")
            deferrals.done("32/32")
            CancelEvent()
            return
        end

        local _source = source
        local ids = GetPlayerIdentifiers(_source)

        if ids[1] == nil then
            deferrals.done("Abra a Steam.")
            CancelEvent()
            return
        end

        if LoginCooldown[ids[1]] == nil then
            deferrals.update("Verificando sua whitelist...")
            if API.isWhitelisted(ids[1]) then
                local user_id = API.getUserIdByIdentifiers(ids, playerName)
                if user_id then
                    deferrals.update("Checando lista de banimentos...")
                    if API.isBanned(user_id) == 0 then
                        if API.users[user_id] == nil then
                            deferrals.update("Tudo encontrado, carregando seus dados...")
                            API.onFirstSpawn[user_id] = true

                            table.insert(sessionQueue, _source)

                            local index = indexOf(_source)

                            while index ~= nil do
                                Citizen.Wait(1000)

                                index = indexOf(_source)

                                -- print("user_id" .. user_id .. " source: " .. source, index)

                                if index ~= nil then
                                    deferrals.update("Conectando em " .. (index * 30) .. " segundos. Aguarde!")

                                    -- print(_source, index)

                                    if index == 1 then
                                        Citizen.Wait(30000)

                                        -- sessionQueue = splice(sessionQueue, index, 1)
                                        table.remove(sessionQueue, index)

                                        if #GetPlayers() < 32 and #API.users < 32 then
                                            TriggerEvent("API:playerJoin", user_id, _source, playerName)
                                            deferrals.done()
                                        else
                                            print("Authentication: " .. _source .. " Erro ao autenticar, limite de players alcançado!")
                                            deferrals.done("32/32")
                                            CancelEvent()
                                            return
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    else
                        deferrals.done("Você está banido do servidor.")
                        CancelEvent()
                    end
                else
                    deferrals.done("Erro de identificação.")
                    CancelEvent()
                end
            else
                LoginCooldown[ids[1]] = true
                Citizen.CreateThread(
                    function()
                        Citizen.Wait(60000)
                        LoginCooldown[ids[1]] = nil
                    end
                )
                print(playerName .. " (" .. ids[1] .. ") tentou conectar sem whitelist")
                deferrals.done("Sem permissão para entrar. HEX: " .. ids[1] .. " | discord.gg/nf4Qbdm")
                CancelEvent()
            end
        else
            deferrals.done("Aguarde um minuto e você logo conseguira entrar.")
            CancelEvent()
        end
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        --[[ 
            local User = API.getUserFromSource(_source)
            Salvar arma a munição quando o User desconectar do servidor
            Por enquanto executa a query para cada arma
        ]]
        print(reason)
        API.dropPlayer(_source, reason)

        local index = indexOf(_source)

        if index ~= nil then
            -- sessionQueue = splice(sessionQueue, index, 1)
            table.remove(sessionQueue, index)
        end
    end
)

RegisterNetEvent("pre_playerSpawned")
AddEventHandler(
    "pre_playerSpawned",
    function()
        local _source = source
        local user_id = API.getUserIdByIdentifiers(GetPlayerIdentifiers(_source), GetPlayerName(_source))
        if user_id then
            local isFirstSpawn = API.onFirstSpawn[user_id]
            TriggerEvent("API:playerSpawned", _source, user_id, isFirstSpawn)
            if onFirstSpawn then
                API.onFirstSpawn[user_id] = nil
            end
        end
    end
)

RegisterNetEvent("API:playerSpawned") -- Use this one !!!!!!!!!!!!!!!!!
AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            connectUser(source, user_id)
        -- API.onFirstSpawn[user_id] = nil
        end
    end
)

RegisterNetEvent("API:addReconnectPlayer")
AddEventHandler(
    "API:addReconnectPlayer",
    function()
        local _source = source
        local ids = GetPlayerIdentifiers(_source)
        local user_id = API.getUserIdByIdentifiers(ids, GetPlayerName(_source))
        if user_id then
            connectUser(_source, user_id)
        end
    end
)

RegisterNetEvent("API:OnUserSelectCharacter")
-- AddEventHandler(
--     "API:OnUserSelectCharacter",
--     function(User, characterId)

--     end
-- )

RegisterNetEvent("API:OnUserCharacterInitialization")
AddEventHandler(
    "API:OnUserCharacterInitialization",
    function(User, character_id)
        TriggerClientEvent("VP:EVENTS:CharacterSetRole", User:getSource(), User:getCharacter().role)
    end
)

RegisterNetEvent("API:pre_OnUserCharacterInitialization")
AddEventHandler(
    "API:pre_OnUserCharacterInitialization",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        TriggerEvent("API:OnUserCharacterInitialization", User, Character:getId())
    end
)

function indexOf(v)
    for i, s in pairs(sessionQueue) do
        if s == v then
            return i
        end
    end
end