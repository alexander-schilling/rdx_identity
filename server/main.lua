RDX = exports.redm_extended:getSharedObject()

Citizen.CreateThread(function()
    while RDX.Jobs['unemployed'] == nil do
        RDX = exports.redm_extended:getSharedObject()
        Citizen.Wait(500)
    end
end)

RDX.RegisterServerCallback('rdx_identity:getCharacters', function(source, cb)
    local identifier, license = RDX.GetPlayerIdentifiers(source)
    MySQL.Async.fetchAll('SELECT id, character_id, accounts, job, job_grade, firstname, lastname, sex FROM characters WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result then
            for k,v in ipairs(result) do
                v.jobLabel = RDX.Jobs[v.job].label
            end
        end

        cb(result or {})
    end)
end)

RegisterNetEvent('rdx_identity:updateIdentity')
AddEventHandler('rdx_identity:updateIdentity', function(data)
    local xPlayer = RDX.GetPlayerFromId(source)

    MySQL.Async.execute('UPDATE characters SET firstname = @firstname, lastname = @lastname, sex = @sex WHERE id = @id', {
        ['@firstname'] = data.firstname,
        ['@lastname'] = data.lastname,
        ['@sex'] = data.sex,
        ['@id'] = xPlayer.getUniqueId()
    })
end)
