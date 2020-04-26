local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterCommand('questhu', function(source)

    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
    local CharId = Character:getId()
    print(CharId)

    local mission = API.Quest(CharId, 'hunter')
    

    print(mission)
    


end)