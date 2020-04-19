local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

--local dinero = math.random(Config.money['min'], Config.money['max'])
--local xp = math.random(Config.xp['min'], Config.xp['max'])
local using = false
local using2 = false

marksizeX = 1.0
marksizeY = 1.0
marksizeZ = 0.5

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        for k,v in ipairs(Config.Locations) do
            if (Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0) then
                DrawTxt('Aperte (ENTER) para minerar', 0.87, 0.95, 0.4, 0.4, false, 255, 255, 255, 145, 100, 7)
                Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153, v.x,v.y,v.z , 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, marksizeX, marksizeY, marksizeZ, 233, 0, 150, 10, 0, 2, 0, 0, 0, false)   
                if IsControlJustPressed(0, 0xC7B5340A) and not using then    
                    TriggerServerEvent('minercollect:checkitem')        
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        for k,v in ipairs(Config.LocationsProcess) do
            if (Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0) then
                DrawTxt('Aperte (ENTER) para processar', 0.87, 0.95, 0.4, 0.4, false, 255, 255, 255, 145, 100, 7)
                if IsControlJustPressed(0, 0xC7B5340A) and not using2 then    
                    TriggerServerEvent('minercollect:checkprocess')     
                end
            end
        end
    end
end)

RegisterNetEvent('minercollect:anim')
AddEventHandler('minercollect:anim', function()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 20000, true, false, false, false)
   -- exports['progressBars']:startUI(2000, 'Minerando')
    Wait(2000)
    TriggerServerEvent('minercollect:getitem')
    ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent('minercollect:processanim')
AddEventHandler('minercollect:processanim', function(num)
    print('chegou')
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CLEAN_TABLE'), 20000, true, false, false, false)  -- colocar uma animação para processar 
    --exports['progressBars']:startUI(20000, Language.translate[Config.lang]['process'])
    Wait(20000)
    TriggerServerEvent('minercollect:processitem', num)
    ClearPedTasksImmediately(PlayerPedId())
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
 local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end