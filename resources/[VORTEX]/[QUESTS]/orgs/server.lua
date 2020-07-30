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

-- Poder ser o nome da org ou o id dela
function Orgs.IsMember(org, member_id)
    local my_orgs = Orgs.GetOrgs(member_id)

    return Orgs.OrgListHas(my_orgs, org)
end

function Orgs.GetMemberRank(org_id, member_id)
end

function Orgs.SetMemberRank(org_id, member_id)
end

function Orgs.GetControlledOutpost(org_id)
end

function Orgs.GetMemberOrgs(member_id)
end

function Orgs.GetMemberOrgByType(member_id, org_type)
    local query = dbAPI.query("orgs:getmemberorgbytype", {member_id = member_id, org_type = org_type})

    if query[1] then
        local _ = query[1]

        local org_id, org_name = _.id, _.name
    end

    return org_id, org_name
end

-- @param org   // Pode ser um ID ou um NAME
function Orgs.OrgListHas(array, org)
    for org_id, org_name in pairs(array) do
        if org_id == org or org_name == id then
            return true
        end
    end

    return false
end

exports("GetMetadata", Orgs.GetMetadata)
exports("SetMetadata", Orgs.SetMetadata)
exports("AddMember", Orgs.AddMember)
exports("RemoveMember", Orgs.RemoveMember)
exports("IsMember", Orgs.IsMember)
exports("GetMemberRank", Orgs.GetMemberRank)
exports("GetControlledOutpost", Orgs.GetControlledOutpost)
exports("GetOrgs", Orgs.GetOrgs)
exports("UtilsArrayHasOrgName", Orgs.UtilsArrayHasOrgName)

do
    Orgs.IsMember(1, 2)
    print("called IsMember")
end
