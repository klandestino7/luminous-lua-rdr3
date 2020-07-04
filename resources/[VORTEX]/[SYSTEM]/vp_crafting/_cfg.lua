-- Config = {
--     ["gold"] = {
--         ["gold_nugget"] = 36
--     },
--     ["campfiresmall"] = {
--         ["row_rock"] = 3,
--         ["log"] = 3
--     },
--     ["campfiremed"] = {
--         ["row_rock"] = 5,
--         ["log"] = 5
--     },
--     ["bow"] = {
--         ["stick"] = 2,
--         ["ropecuted"] = 1
--     },
--     ["ammo_arrow"] = {
--         ["stick"] = 2,
--         ["bones"] = 1
--     },
--     ["ropecuted"] = {
--         ["roperoll"] = 1
--     },
--     ["ropecuted"] = {
--         ["roperoll"] = 1
--     }
-- }

Config = {
    {
        -- position = vec3(0, 0, 0) -- No position, its global
      --  campfire = true,
        craftings = {
            {
                -- ! cIndex (crafting index)
                time = 40,
                input = {
                    {item = "meat_poor", amount = 1, alias = {"meat_good", "meat_perfect"}} -- ! cInputIndex (crafting input index)
                },
                output = {
                    -- {item = "money", amount = 1, name = "Na fogueira"} -- ! cInputIndex (crafting input index)
                    {item = "meat_cooked", amount = 1}
                }
            },
            {
                time = 60,
                input = {
                    {item = "meat_poor", amount = 1, alias = {"meat_good", "meat_perfect"}},
                    {item = "herb_oregano", amount = 1}
                },
                output = {
                    {item = "meat_oregano_cooked", amount = 1}
                }
            }
        }
    },
    { 
       -- position = vec3(0, 0, 0), -- No position, its global
        craftings = {
            {
                time = 15,
                input = {
                    {item = "bones", amount = 1},
                    {item = "stick", amount = 1},
                    {item = "melee_knife", amount = 0},
                },
                output = {
                    {item = "ammo_arrow", amount = 1}
                }
            },
            {
                time = 40,
                input = {
                    {item = "stick", amount = 2},
                    {item = "ropecuted", amount = 1},
                    {item = "melee_knife", amount = 0},
                },
                output = {
                    {item = "bow", amount = 1}
                }
            },
            {
                time = 30,
                input = {
                    {item = "rope", amount = 1},
                    {item = "melee_knife", amount = 0},
                },
                output = {
                    {item = "ropecuted", amount = 5}
                }
            },
            {
                time = 30,
                input = {
                    {item = "rope", amount = 1},
                    {item = "melee_knife", amount = 0},
                },
                output = {
                    {item = "ropecuted", amount = 5}
                }
            }
        }
    }
    -- {
    --     craftings = {
    --         {
    --             time = 0,
    --             input = {
    --                 {item = "fishingrod", amount = 1},
    --                 {item = "gold", amount = 1}
    --             },
    --             output = {
    --                 {item = "money", amount = 1}
    --             }
    --         }
    --     }
    -- },
    -- {
    --     position = vec3(-93.260, 399.647, 113.579),
    --     distance = 20.0,
    --     craftings = {
    --         {
    --             time = 25,
    --             input = {
    --                 {item = "money", amount = 1}
    --             },
    --             output = {
    --                 {item = "ammo_arrow", amount = 10}
    --             }
    --         }
    --     }
    -- }
}

--[[

CRAFTING

CARCANO
DESATIVAR ROLLINGBLOCK
LANCHESTER
WHINCESTER
REVOLVER MOUSER

--]]
