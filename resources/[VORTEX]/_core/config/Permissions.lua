config_file_GROUPS = {
 -- ["none"]      = 0,      -- 0
    ["admin"]     = 1 << 0, -- 1
    ["moderator"] = 1 << 1, -- 2
    ["sheriff"]   = 1 << 2, -- 4
    ["trooper"]   = 1 << 3, -- 8vc
    ["medic"]   = 1 << 4, -- 16vc
 --   ["medic"]   = 1 << 5, -- 32vc
    -- ["house:1"]
    -- ["house:2"]
    -- ["house:3"]
}

config_file_INHERITANCE = {
    ["admin"] = "moderator",
    ["sheriff"] = "tropper",
}