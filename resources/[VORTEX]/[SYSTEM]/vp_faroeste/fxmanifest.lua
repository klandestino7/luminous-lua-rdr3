fx_version "adamant"
games {"rdr3"}
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_script {
	"@_core/lib/utils.lua",
    "client.lua",
    "client.js",
    "_cfg.lua"
}

server_scripts {
    "server.lua"
}

exports {
	'js_get_ped_component_at_index'
}