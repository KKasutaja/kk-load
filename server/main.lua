AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    deferrals.defer()

    local playerId, kickReason, identifier = source
	
    deferrals.update('Please wait 5 seconds.')
    Wait(1000)
    deferrals.update('Please wait 4 seconds.')
    Wait(1000)
    deferrals.update('Please wait 3 seconds.')
    Wait(1000)
    deferrals.update('Please wait 2 seconds.')
    Wait(1000)
    deferrals.update('Please wait 1 second.')
    Wait(1000)

    identifier = GetPlayerIdentifiers(playerId)[1] or false

    if not identifier then
	    kickReason = 'Steam must be running to join this server!'
    elseif not checkWhitelist(identifier) then
	    kickReason = 'You must be allowlisted to join this server!'
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
	local result = exports.oxmysql:executeSync('SELECT * FROM player_whitelists WHERE identifier = @identifier', {
	    ['@identifier'] = src
	})
		
        if result[1] then
            if result[1].identifier == src then
		  return true
	    else
		  return false			
	    end
	else
	    return false
        end
    end
end
