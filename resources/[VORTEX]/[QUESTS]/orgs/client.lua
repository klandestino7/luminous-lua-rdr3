local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

function RankToRankName(org_type_or_id, rank)
    local ranks = config[org_type_or_id]

    if ranks then
        for rank_id, rank_name in pairs(ranks) do
            if rank == rank_id then
                return rank_name
            end
        end
    end
end

exports("RankToRankName", RankToRankName)

RegisterCommand(
    "org",
    function(source, args, raw)
        local myOrgs = cAPI.getMyOrg()

        local orgsIds = {}

        for _, org in pairs(myOrgs) do
            table.insert(orgsIds, org.org_id)
        end

        TriggerServerEvent("Orgs:GetMembersOrgs", orgsIds)
    end,
    false
)

RegisterNetEvent("Orgs:SetMembersOrgsForClient")
AddEventHandler(
    "Orgs:SetMembersOrgsForClient",
    function(orgsMembers)
        local message = {
            my_member_id = orgsMembers.my_member_id,
            -- my_member_name = orgsMembers.my_member_name,
            orgs = {}
        }

        for org_id, org in pairs(orgsMembers.orgs) do
            local org_type = org.type

            local org_type_4_rank_format = org_type ~= "ilegal" and org_id or org_type

            local members = {}
            for _, member in pairs(org.members) do
                local rank = member.member_rank
                local rank_name = RankToRankName(org_type_4_rank_format, rank)

                -- ? Pass the rank as it's display name so we can display it on the NUI
                -- ? NUI wont have any ideia of the existence of ranks

                table.insert(
                    members,
                    {
                        member_id = member.member_id,
                        member_rank = rank,
                        member_rank_name = rank_name,
                        member_name = member.member_name,
                        joined_at = member.joined_at
                    }
                )
            end

            local my_orgs = cAPI.getMyOrg()

            table.insert(
                message.orgs,
                {
                    org_id = org_id,
                    org_name = my_orgs[org_type].org_name,
                    org_type = org.type,
                    my_rank = my_orgs[org_type].my_rank,
                    members = members
                }
            )
        end

        -- print("--------------------MESSAGE---------------------------------------")
        -- print(json.encode(message))

        SendNUIMessage(
            {
                type = "show",
                data = message
            }
        )
        SetNuiFocus(true, true)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            hide()
        end
    end
)

function hide()
    SendNUIMessage(
        {
            type = "hide"
        }
    )
    SetNuiFocus(false, false)
end

RegisterNUICallback(
    "hide",
    function()
        hide()
    end
)

