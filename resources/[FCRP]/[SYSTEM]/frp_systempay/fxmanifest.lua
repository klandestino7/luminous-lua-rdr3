fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'KlandesTino Development'

version '1.0.0'

server_scripts {
  '@_core/libs/utils.lua',
  'server/server.lua',
  'config.lua',
}

client_scripts {
  'client/client.lua',
  'config.lua',
}
