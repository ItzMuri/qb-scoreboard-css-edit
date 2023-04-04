local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0
    local saspCount = 0
    local sasprCount = 0
    local bcsoCount = 0
    local mechanic1Count = 0
    local tunerCount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            PoliceCount = PoliceCount + 1
        end
        if v.PlayerData.job.name == "ambulance" and v.PlayerData.job.onduty then
            AmbulanceCount = AmbulanceCount + 1
        end
        if v.PlayerData.job.name == "sasp" and v.PlayerData.job.onduty then
            saspCount = saspCount + 1
        end
        if v.PlayerData.job.name == "saspr" and v.PlayerData.job.onduty then
            sasprCount = sasprCount + 1
        end
        if v.PlayerData.job.name == "bcso" and v.PlayerData.job.onduty then
            bcsoCount = bcsoCount + 1
        end
        if v.PlayerData.job.name == "hayes" and v.PlayerData.job.onduty then
            mechanic1Count = mechanic1Count + 1
        end
        if v.PlayerData.job.name == "tuner" and v.PlayerData.job.onduty then
            tunerCount = tunerCount + 1
        end
    end
    cb(PoliceCount, AmbulanceCount,saspCount,sasprCount,bcsoCount,mechanic1Count,tunerCount)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        players[v.PlayerData.source] = {}
        players[v.PlayerData.source].permission = QBCore.Functions.IsOptin(v.PlayerData.source)
    end
    cb(players)
end)

RegisterNetEvent('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)