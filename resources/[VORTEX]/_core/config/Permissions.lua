config_file_GROUPS = {
 -- ["none"]      = 0,      -- 0
    ["admin"]     = 1 << 0, -- 1
    ["moderator"] = 1 << 1, -- 2
    ["sheriff"]   = 1 << 2, -- 8
    ["trooper"]   = 1 << 3, -- 16vc
    -- ["house:1"]
    -- ["house:2"]
    -- ["house:3"]
}

config_file_INHERITANCE = {
    ["admin"] = "moderator",
    ["sheriff"] = "tropper",
}