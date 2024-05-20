ESX = exports["es_extended"]:getSharedObject()

Panicbutton = {}

Panicbutton.authorized = {
    jobs = {
    'police',
    'fib',
    'lssd',
    'swat',
    }
}

Panicbutton.BlipSettings = {
    Id          = 161,
    Size        = 1.0,
    Display     = 2,
    Color       = 1,
    AsShort     = false,
    Route       = true,
    RouteColor  = 1,
    DeleteTimer = 60 -- in sek
}


function playthissound()
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
    Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
    Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('avalonvgeilerpanicbuttoneigentlichssssspanicbutton:sendblip')
AddEventHandler('avalonvgeilerpanicbuttoneigentlichssssspanicbutton:sendblip', function(player)
    ESX.TriggerServerCallback('avalonvgeilerpanicbuttoneigentlichssssspanicbutton:getjob', function(job)
        for k,v in pairs(Panicbutton.authorized) do
            for f = 1, #v, 1 do
                if job == v[f] then
                    local blip = AddBlipForCoord(player)
                    SetBlipSprite(blip, Panicbutton.BlipSettings['Id'])
                    SetBlipAsShortRange(blip , Panicbutton.BlipSettings['AsShort'])
                    SetBlipColour(blip, Panicbutton.BlipSettings['Color'])
                    SetBlipDisplay(blip, Panicbutton.BlipSettings['Display'])
                    SetBlipScale(blip, Panicbutton.BlipSettings['Size'])
                    SetBlipAsShortRange(blip , Panicbutton.BlipSettings['AsShort'])
                    SetBlipColour(blip, Panicbutton.BlipSettings['Color'])
                    SetBlipRoute(blip, Panicbutton.BlipSettings['Route'])
                    SetBlipRouteColour(blip, Panicbutton.BlipSettings['RouteColor'])
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString('PANICBUTTON')
                    EndTextCommandSetBlipName(blip)
                    playthissound()
                    Citizen.Wait(Panicbutton.BlipSettings['DeleteTimer'] * 1000)
                    RemoveBlip(blip)
                end
            end
        end
    end)
end)