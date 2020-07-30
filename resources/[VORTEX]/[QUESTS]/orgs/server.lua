local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local Orgs = {}

-- function Orgs.IsValid(org_id)
-- end

--[[
    RDR3
        member_id = member_id
    GTAV
        member_id = user_id
]]

function Orgs.Create(org_id, org_name, member_id)
end

function Orgs.Destroy(org_id, org_name, member_id)
end

function Orgs.GetType(org_id, member_id)
end

function Orgs.AddMember(org_id, member_id)
end

function Orgs.RemoveMember(org_id, member_id)
end

function Orgs.IsMember(org_id, member_id)
end

function Orgs.GetMemberRank(org_id, member_id)
end

function Orgs.SetMemberRank(org_id, member_id)
end

function Orgs.GetControlledOutpost(member_id)
end

function Orgs.GetOrgs(member_id)
end

exports("GetMetadata", Orgs.GetMetadata)
exports("SetMetadata", Orgs.SetMetadata)
exports("AddMember", Orgs.AddMember)
exports("RemoveMember", Orgs.RemoveMember)
exports("IsMember", Orgs.IsMember)
exports("GetMemberRank", Orgs.GetMemberRank)
exports("GetControlledOutpost", Orgs.GetControlledOutpost)
exports("GetOrgs", Orgs.GetOrgs)

do
    Orgs.IsMember(1, 2)
    print("called IsMember")
end
