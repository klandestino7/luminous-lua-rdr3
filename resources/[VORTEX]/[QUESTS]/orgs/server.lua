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

function Orgs.GetCharacterOrgs(character_id)
end

function Orgs.GetControlledOutpost(character_id)
end

function Orgs.GetMetadata(org_id)
end

function Orgs.SetMetadata(org_id, json)
end

exports("AddMember", Orgs.AddMember)
exports("RemoveMember", Orgs.RemoveMember)
exports("IsMember", Orgs.IsMember)
exports("GetCharacterOrg", Orgs.GetCharacterOrg)
exports("GetControlledOutpost", Orgs.GetControlledOutpost)

