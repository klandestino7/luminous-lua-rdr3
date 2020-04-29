Config_Permissions = {
    ["admin"] = {
        type = "staff",
        inheritance = "moderator"
    },
    ["moderator"] = {
        type = "staff",
        inheritance = "helper"
    },
    ["helper"] = {
        type = "staff"
    },
    ----------
    ["chief"] = {
        type = "police",
        inheritance = "soldier"
    },
    ["soldier"] = {
        type = "police",
        inheritance = "recruit"
    },
    ["recruit"] = {
        type = "police"
    },
    ----------
    ["house:1"] = {
        type = "house_rent"
    },
    ["house:2"] = {
        type = "house_rent"
    }
}
