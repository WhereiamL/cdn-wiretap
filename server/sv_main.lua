lib.callback.register("cdn-wiretap:scanRadioChannels", function(source)
    local src = source
    local channels = {}
    if Config.itemCheck then
        local scanner = exports.ox_inventory:Search(src, 'count', Config.scanRadioChannelsItem)
        if scanner == false or scanner < 1 then return channels end
    end
    local pCoords = GetEntityCoords(GetPlayerPed(src))
	for _, player in pairs(GetPlayers()) do
		if player ~= src then
            local dist = #(pCoords - GetEntityCoords(GetPlayerPed(player)))
            if dist <= Config.ScanRadius then             
                local radioChannel = Player(player).state.radioChannel
                if radioChannel ~= 0 then
                    channels[radioChannel] = {min = (radioChannel - math.random(10, Config.ScanRangeAccuracyMin * 10) / 10), max = (radioChannel + math.random(10, Config.ScanRangeAccuracyMax * 10) / 10)}
                end
            elseif dist >= Config.ScanRadius then
                TriggerClientEvent('cdn-wiretap:dcRadio', src)
            end
		end
	end
    return channels
end)

lib.callback.register("cdn-wiretap:scanPhoneCalls", function(source)
    local src = source
    local calls = {}
    if Config.itemCheck then
        local scanner = exports.ox_inventory:Search(src, 'count', Config.scanPhoneCallsItem)
        if scanner == false or scanner < 1 then return calls end
    end
    local pCoords = GetEntityCoords(GetPlayerPed(src))
	for _, player in pairs(GetPlayers()) do
		if player ~= src then
            local dist = #(pCoords - GetEntityCoords(GetPlayerPed(player)))
            if dist <= Config.ScanRadius then             
                local callChannel = Player(player).state.callChannel
                if callChannel ~= 0 then
                    calls[callChannel] = {min = (callChannel - math.random(10, Config.ScanRangeAccuracyMin * 10) / 10), max = (callChannel + math.random(10, Config.ScanRangeAccuracyMax * 10) / 10)}
                end
            elseif dist >= Config.ScanRadius then
                TriggerClientEvent('cdn-wiretap:dcPhone', src)
            end
		end
	end
    return calls
end)