local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local Unlock = {}

function Unlock.Get(unlock_id)
    return type, name, price
end

exports("Get", Unlock.Get(unlock_id))

RegisterNetEvent("VP:ORGS:RequestUnlocks")
AddEventHandler(
    "VP:ORGS:RequestUnlocks",
    function(reqst_org_id, rqst_outpost_id)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local character_id = Character:getId()

        local org_id = GetOrgIdFromCharacter(character_id)

        if org_id then
            local outpost_id = GetPostoIdFromOrgId(org_id)

            if outpost_id then
                -- local query = API.query("", {id_posto = "ab"})

                if outpost_id == rqst_outpost_id then
                    local unlocks = {}

                    if #query > 0 then
                        for i = 1, #query do
                            table.insert(unlocks, query[i].unlock_id)
                        end
                    end

                    TriggerClientEvent("VP:FORT:RespondToUnlocksRequest", _source, unlocks)
                else
                    User:notify("error", "Você não tem acesso a esse posto")
                end
            else
                User:notify("error", "Sua organização não é dona de nenhum posto")
            end
        else
            User:notify("error", "Você não está em um bando!")
        end
    end
)
