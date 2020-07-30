local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

RegisterNetEvent("VP:ORGANIZATION:CreateOrganization")
AddEventHandler("VP:ORGANIZATION:CreateOrganization", function(name)
  local _source = source
  local User = API.getUserFromSource(_source)
  local Character = User.getCharacter()

  local rows = dbAPI.query("INSERT:organization", {name = name, type = "governo"})
  if #rows > 0 then
      local id = rows[1].id
      dbAPI.execute("INSERT:org_members", {org_id = id, char_id = Character.id, rank = 1, joined_at = toStr(os.time())})
  end
end)

AddEventHandler("API:OnUserCharacterInitialization", function(User, character_id)
  local rows = dbAPI.query("SELECT:myOrganization", {char_id = character_id})
  local myOrgs = {}
  for _, org in pairs(rows) do
    -- myOrgs.insert(org.type, { id = org.id, name = org.name, rank = org.rank})
    myOrgs[org.type] = { id = org.id, name = org.name, rank = org.rank}
  end
  cAPI.setMyOrg(User:getSource(), json.encode(myOrgs))
end)

RegisterNetEvent("VP:ORGANIZATION:ViewOrg")
AddEventHandler("VP:ORGANIZATION:ViewOrg", function()
  -- local _source = source
  -- local User = API.getUserFromSource(_source)
  -- local Character = User.getCharacter()
  -- -- organizations.id, organizations.name, organizations.type, org_members.rank
  -- local rows = dbAPI.query("SELECT:myOrganization", {char_id = Character.id})
  -- local myOrgs
  -- for _, org in pairs(rows) do
  --   myOrgs[org.type] = { id = org.id, name = org.name, rank = org.rank}
  -- end
  -- local value = {}
  -- callback(value)
end)

function toDate(strDate)
  p="(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
  year,month,day,hour,min,sec=strDate:match(p)
  print(os.time({tz="GMT",day=day,month=month,year=year,hour=hour,min=min,sec=sec}))
end

function toStr(date)
  return os.date('%Y-%m-%d %H:%M:%S', date)
end
