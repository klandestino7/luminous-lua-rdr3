local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

-- Set this to false if you don't want the weather to change automatically every 10 minutes.
DynamicWeather = true

--------------------------------------------------
debugprint = false -- don't touch this unless you know what you're doing or you're being asked by Vespura to turn this on.
--------------------------------------------------

-------------------- DON'T CHANGE THIS --------------------
AvailableWeatherTypes = {
    ['BLIZZARD'] = 0x27EA2814,
    ['CLOUDS'] = 0x30FDAF5C,
    ['DRIZZLE'] = 0x995C7F44,
    ['FOG'] = 0xD61BDE01,
    ['GROUNDBLIZZARD'] = 0x7F622122,
    ['HAIL'] = 0x75A9E268,
    ['HIGHPRESSURE'] = 0xF5A87B65,
    ['HURRICANE'] = 0x320D0951,
    ['MISTY'] = 0x5974E8E5,
    ['OVERCAST'] = 0xBB898D2D,
    ['OVERCASTDARK'] = 0x19D4F1D9,
    ['RAIN'] = 0x54A69840,
    ['SANDSTORM'] = 0xB17F6111,
    ['SHOWER'] = 0xE72679D5,
    ['SLEET'] = 0xCA71D7C,
    ['SNOW'] = 0xEFB6EFF6,
    ['SNOWCLEARING'] = 0x641DFC11,
    ['SNOWLIGHT'] = 0x23FB812B,
    ['SUNNY'] = 0x614A1F91,
    ['THUNDER'] = 0xB677829F,
    ['THUNDESTORM'] = 0x7C1C4A13,
    ['WHITEOUT'] = 0x2B402288
}

CurrentWeather = 'SUNNY'
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local whiteout = false
local newWeatherTimer = 60

RegisterServerEvent('vSync:requestSync')
AddEventHandler(
    'vSync:requestSync',
    function()
        TriggerClientEvent('vSync:updateWeather', -1, AvailableWeatherTypes[CurrentWeather])
        TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
)

function isAllowedToChange(source)
    local User = API.getUserFromSource(source)
    return User:getCharacter():hasGroup('admin')
end

RegisterCommand(
    'freezetime',
    function(source, args)
        if source ~= 0 then
            if isAllowedToChange(source) then
                freezeTime = not freezeTime
                if freezeTime then
                    TriggerClientEvent('vSync:notify', source, 'Time is now ~b~frozen~s~.')
                else
                    TriggerClientEvent('vSync:notify', source, 'Time is ~y~no longer frozen~s~.')
                end
            else
                TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^8Error: ^1You are not allowed to use this command.')
            end
        else
            freezeTime = not freezeTime
            if freezeTime then
                print('Time is now frozen.')
            else
                print('Time is no longer frozen.')
            end
        end
    end
)

RegisterCommand(
    'freezeweather',
    function(source, args)
        if source ~= 0 then
            if isAllowedToChange(source) then
                DynamicWeather = not DynamicWeather
                if not DynamicWeather then
                    TriggerClientEvent('vSync:notify', source, 'Dynamic weather changes are now ~r~disabled~s~.')
                else
                    TriggerClientEvent('vSync:notify', source, 'Dynamic weather changes are now ~b~enabled~s~.')
                end
            else
                TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^8Error: ^1You are not allowed to use this command.')
            end
        else
            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                print('Weather is now frozen.')
            else
                print('Weather is no longer frozen.')
            end
        end
    end
)

RegisterCommand(
    'weather',
    function(source, args)
        local nomew = args[1]
        if isAllowedToChange(source) then
            if nomew ~= nil then
                TriggerClientEvent('vSync:notify', source, 'Weather will change to: ~y~' .. string.lower(nomew) .. '~s~.')
                CurrentWeather = nomew:toupper()
                newWeatherTimer = 60
                -- NewWeather = AvailableWeatherTypes[nomew:toupper()]
                TriggerEvent('vSync:requestSync')
            else
                TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^8Error: ^1Invalid weather type, valid weather types are: ^0\nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ')
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^8Error: ^1You do not have access to that command.')
            print('Access for command /weather denied.')
        end
    end,
    false
)

RegisterCommand(
    'whiteout',
    function(source)
        if source == 0 then
            whiteout = not whiteout
            if whiteout then
                print('whiteout is now enabled.')
            else
                print('whiteout is now disabled.')
            end
        else
            if isAllowedToChange(source) then
                whiteout = not whiteout
                if whiteout then
                    TriggerClientEvent('vSync:notify', source, 'whiteout is now ~b~enabled~s~.')
                else
                    TriggerClientEvent('vSync:notify', source, 'whiteout is now ~r~disabled~s~.')
                end
                TriggerEvent('vSync:requestSync')
            end
        end
    end
)

RegisterCommand(
    'morning',
    function(source)
        if source == 0 then
            print('For console, use the "/time <hh> <mm>" command instead!')
            return
        end
        if isAllowedToChange(source) then
            ShiftToMinute(0)
            ShiftToHour(9)
            TriggerClientEvent('vSync:notify', source, 'Time set to ~y~morning~s~.')
            TriggerEvent('vSync:requestSync')
        end
    end
)
RegisterCommand(
    'noon',
    function(source)
        if source == 0 then
            print('For console, use the "/time <hh> <mm>" command instead!')
            return
        end
        if isAllowedToChange(source) then
            ShiftToMinute(0)
            ShiftToHour(12)
            TriggerClientEvent('vSync:notify', source, 'Time set to ~y~noon~s~.')
            TriggerEvent('vSync:requestSync')
        end
    end
)
RegisterCommand(
    'evening',
    function(source)
        if source == 0 then
            print('For console, use the "/time <hh> <mm>" command instead!')
            return
        end
        if isAllowedToChange(source) then
            ShiftToMinute(0)
            ShiftToHour(18)
            TriggerClientEvent('vSync:notify', source, 'Time set to ~y~evening~s~.')
            TriggerEvent('vSync:requestSync')
        end
    end
)
RegisterCommand(
    'night',
    function(source)
        if source == 0 then
            print('For console, use the "/time <hh> <mm>" command instead!')
            return
        end
        if isAllowedToChange(source) then
            ShiftToMinute(0)
            ShiftToHour(23)
            TriggerClientEvent('vSync:notify', source, 'Time set to ~y~night~s~.')
            TriggerEvent('vSync:requestSync')
        end
    end
)

function ShiftToMinute(minute)
    timeOffset = timeOffset - (((baseTime + timeOffset) % 60) - minute)
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ((((baseTime + timeOffset) / 60) % 24) - hour) * 60
end

RegisterCommand(
    'time',
    function(source, args, rawCommand)
        if source == 0 then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                if argh < 24 then
                    ShiftToHour(argh)
                else
                    ShiftToHour(0)
                end
                if argm < 60 then
                    ShiftToMinute(argm)
                else
                    ShiftToMinute(0)
                end
                print('Time has changed to ' .. argh .. ':' .. argm .. '.')
                TriggerEvent('vSync:requestSync')
            else
                print('Invalid syntax, correct syntax is: time <hour> <minute> !')
            end
        elseif source ~= 0 then
            if isAllowedToChange(source) then
                if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                    local argh = tonumber(args[1])
                    local argm = tonumber(args[2])
                    if argh < 24 then
                        ShiftToHour(argh)
                    else
                        ShiftToHour(0)
                    end
                    if argm < 60 then
                        ShiftToMinute(argm)
                    else
                        ShiftToMinute(0)
                    end
                    local newtime = tonumber(((baseTime + timeOffset) / 60) % 24) .. ':'
                    local minute = tonumber((baseTime + timeOffset) % 60)
                    if minute < 10 then
                        newtime = newtime .. '0' .. minute
                    else
                        newtime = newtime .. minute
                    end
                    TriggerClientEvent('vSync:notify', source, 'Time was changed to: ~y~' .. newtime .. '~s~!')
                    TriggerEvent('vSync:requestSync')
                else
                    TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^8Error: ^1Invalid syntax. Use ^0/time <hour> <minute> ^1instead!')
                end
            else
                TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, '^8Error: ^1You do not have access to that command.')
                print('Access for command /time denied.')
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local newBaseTime = os.time(os.date('!*t')) / 2 + 360
            if freezeTime then
                timeOffset = timeOffset + baseTime - newBaseTime
            end
            baseTime = newBaseTime
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5000)
            TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(300000)
            TriggerClientEvent('vSync:updateWeather', -1, AvailableWeatherTypes[CurrentWeather], whiteout)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            newWeatherTimer = newWeatherTimer - 1
            Citizen.Wait(60000)
            if newWeatherTimer == 0 then
                if DynamicWeather then
                    NextWeatherStage()
                end
                newWeatherTimer = 60
            end
        end
    end
)

function NextWeatherStage()
    if CurrentWeather == 'CLEARING' or CurrentWeather == 'MISTY' or CurrentWeather == 'SUNNY' then
        local new = math.random(1, 5)
        if new == 1 then
            CurrentWeather = 'CLEARING'
        else
            CurrentWeather = 'OVERCASTDARK'
        end
    elseif CurrentWeather == 'CLEARING' or CurrentWeather == 'OVERCASTDARK' then
        local new = math.random(1, 10)
        if new == 1 then
            CurrentWeather = 'CLEARING'
        elseif new == 2 then
            CurrentWeather = 'SLEET'
        elseif new == 3 then
            CurrentWeather = 'DRIZZLE'
        elseif new == 4 then
            CurrentWeather = 'SHOWER'
        elseif new == 5 then
            CurrentWeather = 'HAIL'
        else
            CurrentWeather = 'WHITEOUT'
        end
    end
    TriggerEvent('vSync:requestSync')
    if debugprint then
        print('[vSync] New random weather type has been generated: ' .. CurrentWeather .. '.\n')
        print('[vSync] Resetting timer to 10 minutes.\n')
    end
end

function NextWeatherStage()
    if CurrentWeather == 'CLEARING' or CurrentWeather == 'MISTY' or CurrentWeather == 'SUNNY' then
        local new = math.random(1, 5)
        if new == 1 then
            CurrentWeather = 'CLEARING'
        else
            CurrentWeather = 'HIGHPRESSURE'
        end
    elseif CurrentWeather == 'CLEARING' or CurrentWeather == 'OVERCASTDARK' then
        local new = math.random(1, 10)
        if new == 1 then
            if CurrentWeather == 'CLEARING' then
                CurrentWeather = 'SLEET'
            else
                CurrentWeather = 'SANDSTORM'
            end
        elseif new == 2 then
            CurrentWeather = 'MISTY'
        elseif new == 3 then
            CurrentWeather = 'HIGHPRESSURE'
        elseif new == 4 then
            CurrentWeather = 'SUNNY'
        elseif new == 5 then
            CurrentWeather = 'FOG'
        else
            CurrentWeather = 'WHITEOUT'
        end
    elseif CurrentWeather == 'SHOWER' or CurrentWeather == 'RAIN' then
        CurrentWeather = 'CLEARING'
    elseif CurrentWeather == 'FOG' or CurrentWeather == 'MISTY' then
        CurrentWeather = 'CLEARING'
    end
    TriggerEvent('vSync:requestSync')
    if debugprint then
        print('[vSync] New random weather type has been generated: ' .. CurrentWeather .. '.\n')
        print('[vSync] Resetting timer to 10 minutes.\n')
    end
end
