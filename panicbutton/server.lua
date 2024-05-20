local lastButtonPress = {}

ESX = exports["es_extended"]:getSharedObject()

Panicbutton = {}

Panicbutton.Item = 'panicbutton'
Panicbutton.Cooldown = 60

Panicbutton.authorized = {
    jobs = {
        'police',
        'fib',
        'lssd',
        'swat',
    }
}


RegisterServerEvent('avalonvgeilerpanicbuttoneigentlichssssspanicbutton:sendmessage')
AddEventHandler('avalonvgeilerpanicbuttoneigentlichssssspanicbutton:sendmessage', function(source)
    local source = source
    local xPlayers = ESX.GetPlayers()
    local tPlayer = ESX.GetPlayerFromId(source)

    
    if lastButtonPress[source] == nil or (os.time() - lastButtonPress[source]) > 30 then
        
        lastButtonPress[source] = os.time()

        local coords = tPlayer.getCoords(true)
        if (tPlayer.getInventoryItem(Panicbutton.Item).count >= 1) then
            for i = 1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if (xPlayer) then
                    for index, value in pairs(Panicbutton.authorized.jobs) do
                        if (xPlayer.getJob() == value) then
                            xPlayer.showNotification(string.format("Panicbutton wurde ausgelöst [%s] %s ist in Not", tPlayer.getJob().label, tPlayer.name))
                            TriggerClientEvent('avalonvgeilerpanicbuttoneigentlichssssspanicbutton:sendblip', xPlayer.source, coords)
                        end
                    end
                end
            end
            else
                tPlayer.showNotification("Du hast keinen Panicbutton dabei")
            end
    else
        
        tPlayer.showNotification("Du musst noch " .. (30 - (os.time() - lastButtonPress[source])) .. " Sekunden warten, bevor du den Panic Button erneut drücken kannst.")
    end
end)

ESX.RegisterUsableItem('panicbutton', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.getJob().name == 'police') then
        TriggerEvent("avalonvgeilerpanicbuttoneigentlichssssspanicbutton:sendmessage", source)
    else
        TriggerClientEvent('esx:showNotification', source, 'Dieses Item darfst du nicht nutzen!') 
    end
end)

ESX.RegisterServerCallback('avalonvgeilerpanicbuttoneigentlichssssspanicbutton:getjob', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.getJob().name
    cb(job)
end)
