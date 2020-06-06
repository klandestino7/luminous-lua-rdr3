local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local AnimalModelToItem = {
    [`A_C_Egret_01`] = 'feather_1',
    [`A_C_Heron_01`] = 'feather_2',
}

RegisterNetEvent("VP:SKINNING:Skinned")
AddEventHandler(
    "VP:SKINNING:Skinned",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        local meatData = API.getItemDataFromId("meat")
        local meatWeight = meatData:getWeight()

        if --[[ (Inventory:getWeight() + meatWeight) <= Inventory:getCapacity() and --]] Inventory:addItem("meat", 1) then
            User:notify("item", meatData:getName(), 1)
        -- else
        --     User:notify("Bolsa sem espaço!")
        --     TriggerClientEvent("VP:LOOTING:LooteableDenied", _source, GetHashKey('p_whitefleshymeat01xa'))
        end
    end
)
