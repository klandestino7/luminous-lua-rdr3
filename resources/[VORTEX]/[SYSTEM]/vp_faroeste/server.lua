
RegisterCommand("outfit", function(source, args)
 local player = tonumber(args[1])
 local kek = tonumber(args[2])
 local _source = source
    
 TriggerClientEvent('VP:FAROESTE:loadtenue', player, kek)
end)

