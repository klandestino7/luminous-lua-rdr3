
client_script {
    'config/Tents.lua',
    'client/client.lua'
}
server_script {
    'server/server.lua',
    '@mysql-async/lib/MySQL.lua'
}

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'