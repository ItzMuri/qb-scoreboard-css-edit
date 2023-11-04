local QBCore = exports['qb-core']:GetCoreObject()
local scoreboardOpen = false
local PlayerOptin = {}

-- Functions

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            players[#players+1] = player
        end
    end
    return players
end

local function GetPlayersFromCoords(coords, distance)
    local players = GetPlayers()
    local closePlayers = {}

    if coords == nil then
		coords = GetEntityCoords(PlayerPedId())
    end
    if distance == nil then
        distance = 5.0
    end
    for _, player in pairs(players) do
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = #(targetCoords - vector3(coords.x, coords.y, coords.z))
		if targetdistance <= distance then
            closePlayers[#closePlayers+1] = player
		end
    end

    return closePlayers
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetConfig', function(config)
        Config.IllegalActions = config
    end)
end)

RegisterNetEvent('qb-scoreboard:client:SetActivityBusy', function(activity, busy)
    Config.IllegalActions[activity].busy = busy
end)

-- Command

RegisterCommand('scoreboard', function()
    if not scoreboardOpen then
        TriggerEvent('animations:client:EmoteCommandStart', {"think"})
        QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetPlayersArrays', function(playerList)
            QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetActivity', function(police, ambulance , sasp ,saspr , bcso ,hayes ,tuner)
                QBCore.Functions.TriggerCallback("qb-scoreboard:server:GetCurrentPlayers", function(Players)
                    PlayerOptin = playerList
                    Config.CurrentCops = police
                    Config.CurrentAmbulance = ambulance
                    Config.currentSasp = sasp
                    Config.currentSaspr =saspr
                    Config.currentBcso = bcso
                    Config.currentHayes = hayes
                    Config.currentTuner = tuner

                    SendNUIMessage({
                        action = "open",
                        players = Players,
                        maxPlayers = Config.MaxPlayers,
                        requiredCops = Config.IllegalActions,
                        currentCops = Config.CurrentCops,
                        currentAmbulance = Config.CurrentAmbulance,
                        currentSasp = Config.currentSasp,
                        currentSaspr = Config.currentSaspr,
                        currentBcso = Config.currentBcso,
                        currentHayes = Config.currentHayes,
                        currentTuner = Config.currentTuner,
                    })
                    scoreboardOpen = true
                end)
            end)
        end)
    else
        SendNUIMessage({
            action = "close",
        })
        scoreboardOpen = false
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end
end)

RegisterKeyMapping('scoreboard', 'Open Scoreboard', 'keyboard', Config.OpenKey)

-- Threads

-- if you want to see player id uncommend this
--[[CreateThread(function()
    while true do
        if scoreboardOpen then
            for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 10.0)) do
                local PlayerId = GetPlayerServerId(player)
                local PlayerPed = GetPlayerPed(player)
                local PlayerCoords = GetEntityCoords(PlayerPed)
                if not PlayerOptin[PlayerId].permission then
                    DrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 1.0, '['..PlayerId..']')
                else
                    DrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 1.0, '~r~ ADMIN ~w~ ['..PlayerId..']')
                end
            end
        end
        Wait(5)
    end
end)]]