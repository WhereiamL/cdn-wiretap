fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'LuaLogic'
description 'LuaLogic Wire Tap Script'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}