local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local Orgs = {}

function Orgs.AddMember(org_id, character_id)
end

function Orgs.RemoveMember(org_id, character_id)
end

function Orgs.IsMember(org_id, character_id)
end

function Orgs.GetCharacterOrg(character_id)
end

function Orgs.GetControlledOutpost(character_id)
end

local Outpost = {}

function Outpost.GetMetadata(outpost_id)
end

function OutPost.SetMetadata(outpost_id)
end

function Outpost.GetUnlocks(outpost_id)
end

function Outpost.AddUnlock(outpost_id, unlock_id)
end

function Outpost.RemoveUnlock(outpost_id, unlock_id)
end

function Outpost.SetControlledBy(outpost_id, org_id)
end

exports("AddMember", Orgs.AddMember)
exports("RemoveMember", Orgs.RemoveMember)
exports("IsMember", Orgs.IsMember)
exports("GetCharacterOrg", Orgs.GetCharacterOrg)
exports("GetControlledOutpost", Orgs.GetControlledOutpost)

exports("GetMetadata", Outpost.GetMetadata)
exports("SetMetadata", Outpost.SetMetadata)
exports("GetUnlocks", Outpost.GetUnlocks)
exports("AddUnlock", Outpost.AddUnlock)
exports("RemoveUnlock", Outpost.RemoveUnlock)
exports("SetControlledBy", Outpost.SetControlledBy)

RegisterNetEvent("VP:ORGS:RequestUnlocks")
AddEventHandler(
    "VP:ORGS:RequestUnlocks",
    function(rqst_outpost_id)
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
