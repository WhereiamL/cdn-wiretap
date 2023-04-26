local function Initialize()
    local options = {}
    local radioChannel = lib.callback.await('cdn-wiretap:scanRadioChannels', false)
    local callChannel = lib.callback.await('cdn-wiretap:scanPhoneCalls', false)

    for k, v in pairs(radioChannel) do
        options[#options + 1] = {id = 'radio_frequency_' .. k, icon = "fa-regular fa-walkie-talkie", onSelect = function(args) setRadioFreq(k) lib.showContext('MainMenu') lib.showTextUI('You connect to ' ..v.min ..' MHz ~ '..v.max .." MHz") end, title = v.min ..' MHz ~ '..v.max .." MHz"}
    end

    for k, v in pairs(callChannel) do
        options[#options + 1] = {id = 'call_frequency_' .. k, icon = "fa-sharp fa-regular fa-phone-volume", onSelect = function(args) setPhoneFreq(k) lib.showContext('MainMenu') lib.showTextUI('You connect to ' ..v.min ..' MHz ~ '..v.max .." MHz") end, title = v.min ..' MHz ~ '..v.max .." MHz"}
    end

    lib.registerContext({id = 'radio_menu', title = 'Radio Channels', onExit = function() exports['pma-voice']:setRadioChannel(0) lib.hideTextUI() end, options = options})
    lib.registerContext({id = 'calls_menu', title = 'Phone Calls', onExit = function() exports['pma-voice']:setCallChannel(0) lib.hideTextUI() end, options = options})

    lib.registerContext({
        id = 'MainMenu',
        title = 'Wire Tap Connections',
        onExit = function()
            exports['pma-voice']:setRadioChannel(0)
            exports['pma-voice']:setCallChannel(0)
            lib.hideTextUI()
        end,
        options = {
            {
                title = 'Phone Calls',
                description = 'Select to view phone calls within radius.',
                onSelect = function(args)
                    lib.hideTextUI()
                    lib.showContext('calls_menu')
                end
            },
            {
                title = 'Radio Channels',
                description = 'Select to view radio channels within radius.',
                onSelect = function(args)
                    lib.hideTextUI()
                    lib.showContext('radio_menu')
                end
            }
        }
    })
end

local function openMainMenu()
    Initialize()
    lib.showContext('MainMenu')
end

local function finalScan()
    if lib.progressBar({
        duration = Config.useTime,
        label = 'Scanning Radius...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            scenario = 'WORLD_HUMAN_STAND_MOBILE'
        },
    }) then openMainMenu() else ClearPedTasksImmediately(GetPlayerPed(-1)) lib.hideTextUI() end
end

function setPhoneFreq(phoneFreq)
	freq = tonumber(phoneFreq)

	if (freq == 0) then
		listening = false
		exports['pma-voice']:setCallChannel(freq)
	else
		listening = true
		exports['pma-voice']:setCallChannel(freq)
	end	
end

function setRadioFreq(radioFreq)
	freq = tonumber(radioFreq)

	if (freq == 0) then
		listening = false
		exports['pma-voice']:setRadioChannel(freq)
	else
		listening = true
		exports['pma-voice']:setRadioChannel(freq)
	end	
end

exports('tapRadio', finalScan)
exports('tapPhone', finalScan)