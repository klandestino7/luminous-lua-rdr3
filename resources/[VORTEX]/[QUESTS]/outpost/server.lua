local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local Outpost = {}

function Outpost.GetMetadata(outpost_id)
end

function OutPost.SetMetadata(outpost_id, json)
end

function Outpost.GetUnlocks(outpost_id)
end

function Outpost.AddUnlock(outpost_id, unlock_id)
end

function Outpost.RemoveUnlock(outpost_id, unlock_id)
end

function Outpost.SetControlledBy(outpost_id, org_id)
end

exports("GetMetadata", Outpost.GetMetadata)
exports("SetMetadata", Outpost.SetMetadata)
exports("GetUnlocks", Outpost.GetUnlocks)
exports("AddUnlock", Outpost.AddUnlock)
exports("RemoveUnlock", Outpost.RemoveUnlock)
exports("SetControlledBy", Outpost.SetControlledBy)