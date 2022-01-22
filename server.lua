
ESX                             = nil
local JobNPC                    = 0
local JobCooldown               = {}
local NPCspawned                = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while not NPCspawned do
        JobNPC = math.random(1,#Config.JobNPC)
        TriggerClientEvent("scrap_przewodnik:spawnNPC",-1,Config.JobNPC[JobNPC])
        NPCspawned = true
    end
end)

AddEventHandler('esx:playerLoaded', function(playerId)
    TriggerClientEvent("scrap_przewodnik:spawnNPC",playerId,Config.JobNPC[JobNPC])
end)