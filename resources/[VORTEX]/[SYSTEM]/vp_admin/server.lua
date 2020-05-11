local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

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
        if Character:hasGroupOrInheritance("admin") then
            cAPI.toggleNoclip(source)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "tpose",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local x, y, z = cAPI.getPosition(source)
            cAPI.setCoords(source, x, y, z)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "tptome",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") and args[1] then
            local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()
            local x, y, z = cAPI.getPosition(source)
            if tplayer then
                cAPI.setCoords(tplayer, x, y, z)
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "tpto",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") and args[1] then
            local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()
            if tplayer then
                cAPI.setCoords(source, cAPI.getPosition(tplayer))
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "tpcds",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local fcoords = cAPI.prompt(source, "Cordenadas:", "")
            if fcoords == "" then
                return
            end
            local coords = {}
            for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
                table.insert(coords, parseInt(coord))
            end
            cAPI.setCoords(source, coords[1] or 0, coords[2] or 0, coords[3] or 0)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "tpway",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            cAPI.teleportToWaypoint(source)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "ban",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") and args[1] then
            local sourcePlayer = API.getUserFromUserId(parseInt(args[1])):getSource()
            if args[2] ~= nil then
                API.setBanned(sourcePlayer, args[1], "Banido por " .. table.concat(args, " ", 2))
            else
                API.setBanned(sourcePlayer, args[1], "Banido")
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "unban",
    function(source, args, rawCommand)
        if rawCommand then
            if args[2] ~= nil then
                API.UnBan(User, args[1])
            else
                API.UnBan(User, args[1])
            end
            return
        end

        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") and args[1] then
            if args[2] ~= nil then
                API.setBanned(User, args[1])
            else
                API.setBanned(User, args[1])
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "kick",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") and args[1] then
            local sourcePlayer = API.getUserFromUserId(parseInt(args[1])):getSource()
            API.kick(sourcePlayer, "Você foi expulso da cidade.")
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "addxp",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():addXp(tonumber(args[2]))
                TriggerClientEvent("chatMessage", source, args[2] .. " XP adicionado ao jogador " .. UserTarget:getCharacter():getName())
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "remXP",
    function(source, args, raw)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():removeXp(tonumber(args[2]))
                TriggerClientEvent("chatMessage", source, args[2] .. " XP removido ao jogador " .. UserTarget:getCharacter():getName())
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "veh",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            TriggerClientEvent("VP:ADMIN:CreateVehicle", source, args[1])
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "setlevel",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():setLevel(tonumber(args[2]))
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "item",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if #args < 2 and not tonumber(args[2]) then
            User:notify("error", "sintaxe: /item id quantidade")
            return
        end

        if Character:hasGroupOrInheritance("admin") then
            Character:getInventory():addItem(args[1], tonumber(args[2]))
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "ped",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            cAPI.SetModel(source, args[1])
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)
RegisterCommand(
    "cds",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local x, y, z = cAPI.getPosition(source)
            API.prompt(source, "Cordenadas:", string.format("%.3f", x) .. "," .. string.format("%.3f", y) .. "," .. string.format("%.3f", z))
        else
            User:notify("error", "Você não tem permissão!")
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
                    User:notify("error", "Usuario invalido!")
                end
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "spawnped",
    function(source, args, rawCommand)
        if #args >= 1 then
            local User = API.getUserFromSource(source)
            local Character = User:getCharacter()
            if Character:hasGroupOrInheritance("admin") then
                TriggerClientEvent("VP:ADMIN:SpawnPed", source, args[1])
            else
                User:notify("error", "Você não tem permissão!")
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

        if Character:hasGroupOrInheritance("admin") or Character:hasGroupOrInheritance("medic") then
            if args[1] ~= nil then
                local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()
                if tplayer ~= nil then
                    TriggerClientEvent("VP:RESPAWN:revive", tplayer)
                end
            else
                TriggerClientEvent("VP:RESPAWN:revive", _source)
            end
        end
    end
)

RegisterCommand(
    "revivehorse",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            if args[1] ~= nil then
                local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()
                if tplayer ~= nil then
                    cAPI.SetPlayerHorseHealth(tplayer, 100)
                end
            else
                cAPI.SetPlayerHorseHealth(_source, 100)
            end
        end
    end
)


RegisterCommand(
    "outfit",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroup("admin") then
            if args[2] ~= nil then
                local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()
                if tplayer ~= nil then
                    TriggerClientEvent("VP:ADMIN:outift", tplayer, tonumber(args[2]))
                end
            else
                TriggerClientEvent("VP:ADMIN:outift", _source, tonumber(args[1]))
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