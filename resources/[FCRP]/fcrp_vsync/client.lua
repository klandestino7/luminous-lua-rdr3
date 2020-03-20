local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)
--[[
Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(0)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25  
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime

        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        seconds = math.floor(((baseTime+timeOffset)*60)%60)
        NetworkOverrideClockTime(hour, minute, seconds)
        
       print(hour, minute, seconds)
    end
end) ]]


Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(0)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25  
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset 
        end

     --   print(timeOffset)

        baseTime = newBaseTime     

        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        seconds = math.floor(((baseTime+timeOffset)*60)%60)
        NetworkOverrideClockTime(hour, minute, seconds)
        
     --  print(hour, minute, seconds)
    end
end)



AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vSync:requestSync')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', 'Change the weather.', {{ name="weatherType", help="Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
    TriggerEvent('chat:addSuggestion', '/time', 'Change the time.', {{ name="hours", help="A number between 0 - 23"}, { name="minutes", help="A number between 0 - 59"}})
    TriggerEvent('chat:addSuggestion', '/freezetime', 'Freeze / unfreeze time.')
    TriggerEvent('chat:addSuggestion', '/freezeweather', 'Enable/disable dynamic weather changes.')
    TriggerEvent('chat:addSuggestion', '/morning', 'Set the time to 09:00')
    TriggerEvent('chat:addSuggestion', '/noon', 'Set the time to 12:00')
    TriggerEvent('chat:addSuggestion', '/evening', 'Set the time to 18:00')
    TriggerEvent('chat:addSuggestion', '/night', 'Set the time to 23:00')
    TriggerEvent('chat:addSuggestion', '/blackout', 'Toggle blackout mode.')
end)

-- Display a notification above the minimap.


RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message, blink)
    print(message, blink)
end)
