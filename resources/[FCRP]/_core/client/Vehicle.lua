-- cVehicle = {}
-- Tunnel.bindInterface("API:cVehicle", cVehicle)
-- Proxy.addInterface("API:cVehicle", cVehicle)

-- function cVehicle.GetClosest(radius, maxArraySize)
--     local r = {}
--     local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
--     for _, veh in pairs(tvRP.getAllVehicles()) do
--         local x, y, z = table.unpack(GetEntityCoords(veh))
--         local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, true)
--         if distance <= radius then
--             r[veh] = distance

--             if #r >= maxArraySize then
--                 break
--             end
--         end
--     end
--     return r
-- end

