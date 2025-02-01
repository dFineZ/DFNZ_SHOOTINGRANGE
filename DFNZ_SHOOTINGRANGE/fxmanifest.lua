fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'dfnzScripts'
description 'Shootingrange'
version '1.0.0'

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

files {
    'locales/*.json'
}

client_scripts {
    'shared/config.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'shared/config.lua',
    'server/*.lua'
}

dependencies {
    'es_extended',
    'ox_lib',
    'oxmysql',
    'ox_target'
}
