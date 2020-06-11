local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local AnimalModelToItem = {
    [`A_C_Egret_01`] = "feather_1",
    [`A_C_Heron_01`] = "feather_2",
    [-1076508705] = "feather_5",
}

RegisterNetEvent("VP:SKINNING:Skinned")
AddEventHandler(
    "VP:SKINNING:Skinned",
    function(entityModelHash)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        local item = "meat"

        if AnimalModelToItem[entityModelHash] then
            item = AnimalModelToItem[entityModelHash] 
        end

        local itemData = API.getItemDataFromId(item)
        local itemWeight = itemData:getWeight()

        if --[[ (Inventory:getWeight() + meatWeight) <= Inventory:getCapacity() and --]] Inventory:addItem(item, 1) then
            User:notify("item", itemData:getName(), 1)
        -- else
        --     User:notify("Bolsa sem espaço!")
        --     TriggerClientEvent("VP:LOOTING:LooteableDenied", _source, GetHashKey('p_whitefleshymeat01xa'))
        end
    end
)
