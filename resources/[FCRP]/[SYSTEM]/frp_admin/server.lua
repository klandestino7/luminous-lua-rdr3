local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

------------------------------------
------------ADMIN COMMANDS----------
------------------------------------

RegisterCommand(
    "nc",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            cAPI.toggleNoclip(source)
        end
    end
)

RegisterCommand(
    "tpose",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            local x, y, z = cAPI.getPosition(source)
            cAPI.teleport(source, x, y, z)
        end
    end
)

RegisterCommand(
    "tptome",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") and args[1] then
            local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()
            local x, y, z = cAPI.getPosition(source)
            if tplayer then
                cAPI.teleport(tplayer, x, y, z)
            end
        end
    end
)

RegisterCommand(
    "tpto",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") and args[1] then
            local tplayer = API.getUserSource(parseInt(args[1]))
            if tplayer then
                cAPI.teleport(source, cAPI.getPosition(tplayer))
            end
        end
    end
)

RegisterCommand(
    "tpcds",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            local fcoords = cAPI.prompt(source, "Cordenadas:", "")
            if fcoords == "" then
                return
            end
            local coords = {}
            for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
                table.insert(coords, parseInt(coord))
            end
            cAPI.teleport(source, coords[1] or 0, coords[2] or 0, coords[3] or 0)
        end
    end
)

RegisterCommand(
    "tpway",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            cAPI.teleportToWaypoint(source)
        end
    end
)

RegisterCommand(
    "ban",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") and args[1] then
            local sourcePlayer = API.getUserFromUserId(parseInt(args[1])):getSource()
            API.setBanned(sourcePlayer, args[1], "Banido")
        end
    end
)

RegisterCommand(
    "kick",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") and args[1] then
            local sourcePlayer = API.getUserFromUserId(parseInt(args[1])):getSource()
            API.kick(sourcePlayer, "Você foi expulso da cidade.")
        end
    end
)

RegisterCommand(
    "addxp",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():addXp(tonumber(args[2]))
                TriggerClientEvent("chatMessage", source, args[2] .. " XP adicionado ao jogador " .. UserTarget:getCharacter():getName())
            end
        end
    end
)

RegisterCommand(
    "remXP",
    function(source, args, raw)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():removeXp(tonumber(args[2]))
                TriggerClientEvent("chatMessage", source, args[2] .. " XP removido ao jogador " .. UserTarget:getCharacter():getName())
            end
        end
    end
)

RegisterCommand(
    "veh",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            cAPI.createVehicle(source, args[1])
        end
    end
)

RegisterCommand(
    "unban",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
        end
    end
)

RegisterCommand(
    "setlevel",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():setLevel(tonumber(args[2]))
            end
        end
    end
)

RegisterCommand(
    "item",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if #args < 2 and not tonumber(args[2]) then
            return
        end

        if Character:hasGroupOrInheritance("admin") then
            Character:getInventory():addItem(args[1], tonumber(args[2]))
        end
    end
)

RegisterCommand(
    "ped",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroup("admin") then
            cAPI._setModel(source, args[1])
        end
    end
)
RegisterCommand(
    "cds",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroup("admin") then
            local x, y, z = cAPI.getPosition(source)
            API.prompt(source, "Cordenadas:", x .. "," .. y .. "," .. z)
        end
    end
)

RegisterCommand(
    "group",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            if args[1] == "add" or args[1] == "remove" then
                local UserTarget = API.getUserFromUserId(tonumber(args[2]))
                if UserTarget ~= nil then
                    if args[1] == "add" then
                        UserTarget:getCharacter():addGroup(args[3])
                    elseif args[1] == "remove" then
                        UserTarget:getCharacter():removeGroup(args[3])
                    end
                else
                    User:notify("Usuario invalido!")
                end
            end
        end
    end
)

RegisterCommand(
    "spawnped",
    function(source, args, rawCommand)
        if #args >= 1 then
            local User = API.getUserFromSource(source)
            local Character = User:getCharacter()
            if Character:hasGroup("admin") then
                TriggerClientEvent("FCRP:ADMIN:SpawnPed", source, args[1])
            end
        end
    end
)

RegisterCommand(
    "revive",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroup("admin") or Character:hasGroup("medic") then
            if args[1] ~= nil then
                local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()
                if tplayer ~= nil then
                    TriggerClientEvent("FRP:RESPAWN:revive", tplayer)
                end
            else
                TriggerClientEvent("FRP:RESPAWN:revive", _source)
            end
        end
    end
)

-- RegisterCommand(
--     "weapon",
--     function(source, args, rawCommand)
--         local _source = source
--         local User = API.getUserFromSource(source)
--         local Character = User:getCharacter()

--         if Character:hasGroup("admin") then
--             local modelw = args[1]
--             if modelw == nil then
--                 print("Please set the specific name for weapon")
--             else
--                 User:giveWeapon(modelw)
--             end
--         end
--     end
-- )
