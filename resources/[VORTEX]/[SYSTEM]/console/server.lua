local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local commands = {}

commands.print = function(source, args)
    if source == 0 then
        print("^4CONSOLE | ^0" .. args)
    else
    end
end

commands.commands = function(source, args)
    -- commands.print(source, "Commandos")
    for command, _ in pairs(commands) do
        commands.print(source, command)
    end
    -- commands.print(source, " ")
end

commands.addwhitelist = function(source, args)
    local steamId = args[1]

    if steamId then
        if API.setAsWhitelisted(steamId, true) then
            commands.print(source, name .. " [" .. steamId .. "] Adicionado a whitelist!")
        else
            commands.print(source, name .. " [" .. steamId .. "] Já possui whitelist")
        end
    else
        commands.print(source, "Syntax: addwhitelist <steamId>")
    end
end

commands.removewhitelist = function(source, args)
    local steamId = args[1]

    if steamId then
        if API.setAsWhitelisted(steamId, false) then
            commands.print(source, name .. " [" .. steamId .. "] Removido da whitelist!")
        else
            commands.print(source, name .. " [" .. steamId .. "] Não possui whitelist")
        end
    else
        commands.print(source, "Syntax: removewhitelist <steamId>")
    end
end

commands.players = function(source, args)
    local users = API.getUsers()

    commands.print(source, "Conectados " .. #users .. "/32")

    listusers(users)
end

commands.playersbygroup = function(source, args)
    local group = args[1]

    if group then
        local users = API.getUsersByGroup(group)

        commands.print(source, "Conectados " .. #users .. "/32 GRUPO: " .. group)

        listusers(users)
    end
end

function listusers(users)
    for user_id, User in pairs(users) do
        local d = {}

        d.src = User:getSource()
        d.steam_id = User:getIdentifiers()[1]
        d.ip_address = User:getIpAddress()
        d.char_id = "X"

        local Character = User:getCharacter()

        if Character then
            d.char_id = Character:getId()
            d.char_name = Character:getName()
            d.char_age = Character:getAge()
            d.char_exp = Character:getExp()
            d.char_level = Character:getLevel()
            d.char_role = Character.role

            local Horse = Character:getHorse()

            if Horse then
                d.horse_id = Horse:getId()
            end
        end

        for k, v in pairs(d) do
            commands.print(source, k .. ": " .. v)
        end
    end
end

-- steam:110000109766c18

RegisterCommand(
    "console",
    function(source, args, raw)
        if #args <= 0 then
            return
        end

        local hasPermission = false

        if source == 0 then
            hasPermission = true
        else
            local User = API.getUserFromSource(source)
            local Character = User:getCharacter()
            if Character and Character:hasGroupOrInheritance("superadmin") then
                hasPermission = true
            end
        end

        if hasPermission then
            local command = args[1]

            if commands[command] then
                table.remove(args, 1)

                commands[command](source, args)
            end
        end
    end,
    false
)
