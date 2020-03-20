--BlueBerryRP creator

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
'@_core/libs/utils.lua',
'client/warmenu.lua',
'client/client.lua',
'config.lua',
'ped/hash_provisions.lua',
'ped/hash_peds.lua'
}

server_scripts {
'@_core/libs/utils.lua',
'config.lua',
'server/server.lua'
}