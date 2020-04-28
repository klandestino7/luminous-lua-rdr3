local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local pocketables = {
    [`s_dis_flourite01x`] = "flourite",
    [`p_coal01x`] = "raw_coal",
    [`s_meteoriteshard01x`] = "raw_copper",
    [`s_pickup_goldbar01x`] = "raw_gold",
    [`s_dis_ammolite01x`] = "ammolite",
}

RegisterNetEvent("VP:POCKET_LOOTING:Pocket")
AddEventHandler(
    "VP:POCKET_LOOTING:Pocket",
    function(entityModel)
        local _source = source

        local User = API.getUserFromSource(_source)

        if not pocketables[entityModel] then
            User:notify("Você não pode pegar este item!")
            TriggerClientEvent("VP:POCKET_LOOTING:ItemDenied", _source, entityModel)
            return
        end

        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        local itemId = pocketables[entityModel]

        if Inventory:addItem(itemId, 1) then
        else
            User:notify("Espaço insuficiente!")
            TriggerClientEvent("VP:POCKET_LOOTING:ItemDenied", _source, entityModel)
        end
    end
)
