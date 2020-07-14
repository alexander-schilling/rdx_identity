RDX = exports.redm_extended:getSharedObject()
PlayerLoaded = false

AddEventHandler('rdx:onPlayerJoined', function()
    RDX.TriggerServerCallback('rdx_identity:getCharacters', function(characters)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action  = 'showCharacterSelector',
            characters = characters
        })
    end)
end)

RegisterNetEvent('rdx:playerLoaded')
AddEventHandler('rdx:playerLoaded', function(xPlayer)
    PlayerLoaded = true
end)

function CharacterCreated(data)
    Citizen.CreateThread(function()
        while not PlayerLoaded do
            Citizen.Wait(500)
        end

        TriggerServerEvent('rdx_identity:updateIdentity', data)
    end)
end

RegisterCommand('showMenu', function(source, args, rawCommand)
    RDX.TriggerServerCallback('rdx_identity:getCharacters', function(characters)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action  = 'showCharacterSelector',
            characters = characters
        })
    end)
end)

RegisterCommand('closeMenu', function(source, args, rawCommand)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action  = 'hideHud'
    })
end)

RegisterNUICallback('selectCharacter', function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent("rdx:characterSelected", data.characterId)
end)

RegisterNUICallback('createCharacter', function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent("rdx:characterSelected", data.characterId)
    CharacterCreated(data.characterData)
end)
