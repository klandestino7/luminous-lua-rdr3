local sessionQueue = {}

LoginCooldown = {}

function connectUser(source, user_id)
    if API.users[user_id] then
        return
    end

    local steamID = GetPlayerIdentifiers(source)[1]

    local User = API.User(source, user_id, GetPlayerEndpoint(source))

    API.users[user_id] = User
    API.sources[source] = user_id
    API.identifiers[steamID] = GetPlayerIdentifiers(source)
    cAPI._clientConnected(source, true)

    print(GetPlayerName(source) .. " (" .. User:getIpAddress() .. ") entrou (user_id = " .. user_id .. ", source = " .. source .. ")")
    TriggerEvent("VP:IDENTITY:DisplayCharSelection", User)
    return User
end

AddEventHandler(
    "playerConnecting",
    function(playerName, kickReason, deferrals)
        deferrals.defer()
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

                                print("user_id" .. user_id .. " source: " .. source, index)

                                if index ~= nil then
                                    deferrals.update("Conectando em " .. (index * 15) .. " segundos. Aguarde!")

                                    -- print(_source, index)

                                    if index == 1 then
                                        Citizen.Wait(15000)

                                        -- sessionQueue = splice(sessionQueue, index, 1)
                                        table.remove(sessionQueue, index)

                                        TriggerEvent("API:playerJoin", user_id, source, playerName)

                                        deferrals.done()
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
        --[[ local User = API.getUserFromSource(_source)
        -- Salvar arma a munição quando o User desconectar do servidor
        -- Por enquanto executa a query para cada arma
        if User ~= nil and User:getCharacter() ~= nil then
            local weapons = cAPI.getWeapons(_source)
            User:getCharacter():setWeapons(weapons)
        end ]]
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

-- function splice(t, index, howMany, ...)
--     local removed = {}
--     local tableSize = #t -- Table size
--     -- Lua 5.0 handling of vararg...
--     local argNb = #{...} -- Number of elements to insert
--     -- Check parameter validity
--     if index < 1 then
--         index = 1
--     end
--     if howMany < 0 then
--         howMany = 0
--     end
--     if index > tableSize then
--         index = tableSize + 1 -- At end
--         howMany = 0 -- Nothing to delete
--     end
--     if index + howMany - 1 > tableSize then
--         howMany = tableSize - index + 1 -- Adjust to number of elements at index
--     end

--     local argIdx = 1 -- Index in arg
--     -- Replace min(howMany, argNb) entries
--     for pos = index, index + math.min(howMany, argNb) - 1 do
--         -- Copy removed entry
--         table.insert(removed, t[pos])
--         -- Overwrite entry
--         t[pos] = arg[argIdx]
--         argIdx = argIdx + 1
--     end
--     argIdx = argIdx - 1
--     -- If howMany > argNb, remove extra entries
--     for i = 1, howMany - argNb do
--         table.insert(removed, table.remove(t, index + argIdx))
--     end
--     -- If howMany < argNb, insert remaining new entries
--     for i = argNb - howMany, 1, -1 do
--         table.insert(t, index + howMany, arg[argIdx + i])
--     end
--     return removed
-- end
