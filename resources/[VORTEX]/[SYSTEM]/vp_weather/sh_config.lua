--[[
  _____  _         __          __        _   _
 |  __ \(_)        \ \        / /       | | | |
 | |  | |_ _ __   __\ \  /\  / /__  __ _| |_| |__   ___ _ __
 | |  | | | '_ \ / _ \ \/  \/ / _ \/ _` | __| '_ \ / _ \ '__|
 | |__| | | | | | (_) \  /\  /  __/ (_| | |_| | | |  __/ |
 |_____/|_|_| |_|\___/ \/  \/ \___|\__,_|\__|_| |_|\___|_|

FiveM-DinoWeather
A Weather System that enhances realism by using GTA Natives relating to Zones.
Copyright (C) 2019  Jarrett Boice

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]

WeatherConfig = {}
WeatherConfig = setmetatable(WeatherConfig, {})

activeWeatherSystems = {}

WeatherConfig.snowEnabled = false -- Set to false if you do not want snow enabled.
WeatherConfig.decemberSnowDays = { 6, 9, 12, 15, 18, 21, 22, 23, 24, 25, 26, 27 } -- Days that snow will appear during the month of December.

WeatherConfig.weatherTypes = {
  [1] = 0x27EA2814,
  [2] = 0x995C7F44,
  [3] = 0xD61BDE01,
  [4] = 0x7F622122,
  [5] = 0x320D0951,
  [6] = 0x5974E8E5,
  [7] = 0x19D4F1D9,
  [8] = 0x54A69840,
  [9] = 0xB17F6111,
  [10] = 0xEFB6EFF6,
  [11] = 0x614A1F91,
  [12] = 0xB677829F,
  [13] = 0x7C1C4A13,
  [14] = 0x2B402288
}


WeatherConfig.randomizeTime = 3000 -- 1 Hour (TIME TO RANDOMIZE WEATHER SYSTEMS IN MILLISECONDS)

WeatherConfig.weatherSystems = {
  {
    { "GuarmaD", "PuntaOrgullo", "DiezCoronas", "Perdido" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] }, -- Spring
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] }, -- Summer
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] }, -- Fall
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] } -- Winter
  }, -- South LS
  {
    { "GaptoothRidge", "RioBravo", "ChollaSprings" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] },
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] },
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] }
  }, -- Central LS
  {
    { "HennigansStead" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] },
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] },
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] }
  }, -- North LS
  {
    { "GrizzliesWest", "greatPlains", "TallTrees" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] },
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] },
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] }
  }, -- LS Beaches
  {
    { "bigvalley" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] },
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] },
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] }
  }, -- Eastern Valley
  {
    { "GrizzliesEast" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] },
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] },
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] }
  }, -- Coastal Beaches
  {
    { "Cumberland", "Heartlands" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] },
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] },
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] }
  }, -- North LS Hills
  {
    { "roanoke" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] },
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] },
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] }
  }, -- Grand Senora Desert
  {
    { "scarlettMeadows", "BayouNwa", "BluewaterMarsh" },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4] },
    { WeatherConfig.weatherTypes[1], WeatherConfig.weatherTypes[2], WeatherConfig.weatherTypes[3] },
    { WeatherConfig.weatherTypes[3], WeatherConfig.weatherTypes[4], WeatherConfig.weatherTypes[5], WeatherConfig.weatherTypes[6], WeatherConfig.weatherTypes[7], WeatherConfig.weatherTypes[8] },
    { WeatherConfig.weatherTypes[8], WeatherConfig.weatherTypes[9], WeatherConfig.weatherTypes[12], WeatherConfig.weatherTypes[11] }
  },
}

WeatherConfig.timesOfYear = {
  { 3, 4, 5 }, --SPRING 1
  { 6, 7, 8 }, --SUMMER 2
  { 9, 10, 11 }, --FALL 3
  { 12, 1, 2 } --WINTER 4
}

function getCurrentSeason()
  for i, timeOfYear in ipairs(WeatherConfig.timesOfYear) do
    for k, month in ipairs(WeatherConfig.timesOfYear[i]) do
      if month == os.date("*t").month then
        return i
      end
    end
  end
end

function isSnowDay()
  for i, decemberSnowDay in ipairs(WeatherConfig.decemberSnowDays) do
    if decemberSnowDay == os.date("*t").day then
      return true
    end
  end
  return false
end

function findZoneBySubZone(zoneName)
  for i, weatherSystem in ipairs(WeatherConfig.weatherSystems) do
    for _, weatherZone in ipairs(weatherSystem[1]) do
      if weatherZone == zoneName then
        return i
      end
    end
  end
end

function randomizeSystems()
  activeWeatherSystems = {}

  for i, weatherSystem in ipairs(WeatherConfig.weatherSystems) do

    local currentSeason = getCurrentSeason()

    local availableWeathers = weatherSystem[currentSeason + 1]
    local pickedWeather = availableWeathers[math.random(1, #availableWeathers)]

    for _, weatherZone in ipairs(weatherSystem[1]) do
      if os.date("*t").month == 12 and isSnowDay() and WeatherConfig.snowEnabled then
        table.insert(activeWeatherSystems, {weatherZone, "SNOW"})
      else
        table.insert(activeWeatherSystems, {weatherZone, pickedWeather})
      end
    end
  end
end
