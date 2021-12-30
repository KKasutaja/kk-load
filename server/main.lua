local function checkWhitelist(identifier)
    local rowCount = MySQL.Sync.fetchScalar('SELECT COUNT(identifier) FROM player_whitelists WHERE identifier = ?;', {
        identifier
    })

    return rowCount > 0;
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    deferrals.defer();

    local playerId = source;

    for i=1, 5 do
        deferrals.update('Loading on the server: '..i..'/5.')
        Wait(1000);
    end

    local identifier, kickReason = GetPlayerIdentifiers(playerId)[1] or false;

    if not identifier then
	    kickReason = 'Steam must be running to join this server!'
    elseif not checkWhitelist(identifier) then
	    kickReason = 'You must be allowlisted to join this server!'
    end

    if kickReason then
	    deferrals.done(kickReason);
    else
        deferrals.done();
    end
end)
