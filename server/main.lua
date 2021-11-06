AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    deferrals.defer()

    local playerId, kickReason, identifier = source
	
    deferrals.update('Server: Palun oodake 5 sekundit.')
    Wait(1000)
    deferrals.update('Server: Palun oodake 4 sekundit.')
    Wait(1000)
    deferrals.update('Server: Palun oodake 3 sekundit.')
    Wait(1000)
    deferrals.update('Server: Palun oodake 2 sekundit.')
    Wait(1000)
    deferrals.update('Server: Palun oodake 1 sekund.')
    Wait(1000)

    identifier = GetPlayerIdentifiers(playerId)[1] or false

    if not identifier then
	kickReason = 'Viga: Teil ei tööta steam!'
    elseif not checkWhitelist(identifier) then
	kickReason = 'Viga: Te ei ole serveri whitelistis!'
    end

    if kickReason then
	deferrals.done(kickReason)
    else
	deferrals.done()
    end
end)

function checkWhitelist(id)
    local src = id

    if id then
        MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM player_whitelists WHERE identifier = @identifier', {
            ['@identifier'] = src
        }, function(result)
            if result[1] then
                if tonumber(result[1].count) > 0 then
                    return true
                else
                    return false
                end
            end
        end)
    end
end
