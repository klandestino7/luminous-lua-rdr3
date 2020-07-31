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
function Orgs.Create(org_name)
    local org_id

    local rows = dbAPI.query("INSERT:organization", {name = name, type = "ilegal"})
    if #rows > 0 then
        org_id = rows[1].id
    end

    return org_id
end

function Orgs.Delete(org_id)
    dbAPI.execute("orgs:delete", {org_id = org_id})
end

function Orgs.GetType(org_id)
end

--[[
    Ranks:

    -1: Nenhum/Default
    1: Chefe/Dono
    ...
]]
function Orgs.AddMember(org_id, member_id, member_rank)
    dbAPI.execute("INSERT:org_members", {org_id = org_id, char_id = member_id, rank = member_rank, joined_at = date2string(os.date())})
end

function Orgs.RemoveMember(org_id, member_id)
end

-- Poder ser o nome da org ou o id dela
function Orgs.IsMember(org, member_id)
    local my_orgs = Orgs.GetMemberOrgs(member_id)

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
exports("GetMemberOrgs", Orgs.GetMemberOrgs)
exports("UtilsArrayHasOrgName", Orgs.UtilsArrayHasOrgName)

function string2date(str)
    p = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
    year, month, day, hour, min, sec = str:match(p)
    return os.time({tz = "GMT", day = day, month = month, year = year, hour = hour, min = min, sec = sec})
end

function date2string(date)
    return os.date("%Y-%m-%d %H:%M:%S", date)
end

local _ILEGAL_ORG_CREATION_PRICE = 100

RegisterNetEvent("Orgs:TryToCreateOrg")
AddEventHandler(
    "Orgs:TryToCreateOrg",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)

        if User then
            local Character = User:getCharacter()

            if Character then
                local member_id = Character:getId()

                local hasIlegalOrg = Orgs.GetMemberOrgByType(member_id, "ilegal") == nil

                if not hasIlegalOrg then
                    local Inventory = Character:getInventory()

                    if Inventory:removeItem(-1, "money", _ILEGAL_ORG_CREATION_PRICE) then
                        local org_id = Orgs.Create(org_name)

                        if org_id then
                            Orgs.addMember(org_id, member_id, 1)

                            User:notify("success", "Organizaçao criada!")
                        else
                            User:notify("Ocorreu um erro ao criar sua org :(")
                            Inventory:addItem("money", _ILEGAL_ORG_CREATION_PRICE)
                        end
                    else
                        User:notify("Sem dinheiro")
                    end
                else
                    User:notify("Você já está em uma org")
                end
            end
        end
    end
)
