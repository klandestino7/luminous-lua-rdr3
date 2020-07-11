local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterCommand(
    "o",
    function(source, args, raw)
        local listingType = args[1]

        if listingType then
            local groupToList
            local groupName

            if listingType == "policia" then
                groupToList = "trooper"
                groupName = "Policiais"
            end

            if listingType == "medico" then
                groupToList = "medic"
                groupName = "Medicos"
            end

            if groupToList then
                local User = API.getUserFromSource(source)

                local users = API.getUsersByGroup(groupToList)

                User:notify("dev_longer", #users .. " " .. groupName .. " online!")
            end
        end
    end,
    false
)
