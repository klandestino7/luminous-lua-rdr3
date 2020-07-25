local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

--[[
    ? fort
    ? id      coord       balance     balance_withdraw_at

    ? fort_members
    ? id      charid

    ? fort_upgrades
    ? id      upgrade            
]]
RegisterNetEvent("VP:FORT:RequestUnlocks")
AddEventHandler(
    "VP:FORT:RequestUnlocks",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local character_id = Character:getId()

        local fort_id = API.GetFortIdFromCharacterId(character_id)

        if fort_id then

            

        end
    end
)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(100)
--         TriggerClientEvent("VP:FORT:SetPlayerBalance", -1, math.random(10000), math.random(99))
--     end
-- end)

--[[
* API.SetFortUnlockUnlocked()
* API.IsFortUnlockUnlocked()

* API.GetFortBalance()
* API.SetFortBalance()

* API.GetFortIdFromCharacterId()

* API.GetFortMembers()
* API.AddFortMember()
* API.RemoveFortMember()
* API.IsFortMember(character_id)
]]
