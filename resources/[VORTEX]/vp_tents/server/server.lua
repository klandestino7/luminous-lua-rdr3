Tents = {}

inv = {}
TriggerEvent('crz_inventory:use', function(invcall)
    inv = invcall
end)

RegisterServerEvent('VP:TENTS:createdTent')
AddEventHandler('VP:TENTS:createdTent', function(tent, model, pos, rot, heading)
    local src = source
    TriggerEvent('redem:getPlayerFromId', src, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        inv.removeItem(src, tent, 1)
        Tents.addNew(src, model, pos, rot, heading)
    end)
end)

RegisterServerEvent('VP:TENTS:removeTents')
AddEventHandler('VP:TENTS:removeTents', function(tentId, id)
    local src = source
    Tents.removeTent(src, tonumber(tentId), tonumber(id))
end)

RegisterServerEvent('VP:TENTS:spawnTents')
AddEventHandler('VP:TENTS:spawnTents', function()
    local src = source 
    Tents.getAllTents(src, function(tents)
        TriggerClientEvent('VP:TENTS:spawnCliTents', src, tents, GetPlayerIdentifier(src))
    end)
end)

function Tents.addNew(src, model, pos, rot, heading)
    TriggerEvent('redem:getPlayerFromId', src, function(user)
		local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local position = {
            ["x"] = math.floor(pos.x*100)*0.01, -- DEUS PODEROSO
            ["y"] = math.floor(pos.y*100)*0.01, -- DEUS PODEROSO
            ["z"] = math.floor(pos.z*100)*0.01, -- DEUS PODEROSO
            ["rotx"] = math.floor(rot.x*100)*0.01,
            ["roty"] = math.floor(rot.y*100)*0.01,
            ["rotz"] = math.floor(rot.z*100)*0.01,
            ["h"] = math.floor(heading*100)*0.01
        }
        MySQL.Async.fetchAll("INSERT INTO VP:TENTS(identifier, charid, model, position) VALUES ('"..identifier.."',"..charid..","..model..",'"..json.encode(position).."')", {}, function()
        end)
    end)
end

function Tents.getTents(source, callback)
    TriggerEvent('redem:getPlayerFromId', source, function(user)
		local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        MySQL.Async.fetchAll("SELECT * FROM VP:TENTS WHERE identifier = @identifier and charid = @charid", {['@identifier'] = identifier, ['@charid'] = charid}, function(call)
            callback(call) -- if have + 1
        end)
    end)
end

function Tents.getAllTents(src, callback)
    MySQL.Async.fetchAll("SELECT * FROM VP:TENTS", {}, function(call)
        callback(call)
    end)
end

function Tents.removeTent(src, id, itemId)
    MySQL.Async.fetchAll("DELETE FROM VP:TENTS WHERE id = @id", {['@id'] = id}, function(rows)
        if rows then
            inv.addItem(src, itemId, 1, 0, 0) 
        end
    end)
end