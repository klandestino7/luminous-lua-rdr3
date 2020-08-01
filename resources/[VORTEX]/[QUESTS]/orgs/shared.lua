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