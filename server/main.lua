local function checkWhitelist(identifier)
    local rowCount = exports.oxmysql:scalarSync('SELECT COUNT(identifier) FROM users WHERE identifier = ?;', {
        identifier
    })

    return rowCount > 0;
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    deferrals.defer();

    local playerId = source;

    for i=1, 5 do
        deferrals.update('Please wait '..i..' seconds.')
        Wait(1000);
    end

    local identifier = GetPlayerIdentifiers(playerId)[1] or false;
    local kickReason = nil;

    if not identifier then
	    kickReason = 'Steam must be running to join this server!'
    elseif not checkWhitelist(identifier) then
	    kickReason = 'You must be allowlisted to join this server!'
    end

	deferrals.done(type(kickReason) == 'string' and kickReason or nil);
end)