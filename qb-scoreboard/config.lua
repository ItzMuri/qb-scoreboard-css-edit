Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 'F10' -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- It returns 48 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["storerobbery"] = {
        minimum = 3,
        busy = false,
    },
    ["atmrobbery"] = {
        minimum = 3,
        busy = false,
    },
    ["houserobbery"] = {
        minimum = 4,
        busy = false,
    },
    ["banktruck"] = {
        minimum = 4,
        busy = false,
    },
    ["jewellery"] = {
        minimum = 4,
        busy = false,
    },
    ["Fleeca"] = {
        minimum = 4,
        busy = false,
    },
    ["Paleto"] = {
        minimum = 5,
        busy = false,
    },
    ["Pacific"] = {
        minimum = 8,
        busy = false,
    },
}

-- Current Cops Online
Config.CurrentCops = 0
Config.currentSasp = 0
Config.currentSaspr = 0
Config.currentBcso = 0
Config.currentHayes = 0
Config.currentTuner = 0

-- Current Ambulance / Doctors Online`
Config.CurrentAmbulance = 0

-- Show ID's for all players or Opted in Staff
Config.ShowIDforALL = false
