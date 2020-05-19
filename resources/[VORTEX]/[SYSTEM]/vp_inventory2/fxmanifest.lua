fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    "@_core/lib/utils.lua",
    '_cfg_items.lua',
    'client_joaat.js',
    'client_main.lua',
    'client_inventory.lua',
    -- 'client_endurance.lua',
    -- 'client_drink.lua',
}

-- server_scripts {
-- 	"@_core/lib/utils.lua",
-- 	'server.lua'
-- }

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/design.css',
    'nui/script.js',
    'nui/*',
    'nui/assets/*'
}

exports {
	'js_joaat',
}