local ESX, QBCore = nil, nil
local PlayerData = {}
local isNearCoffeeMachine = false
local currentMachineIndex = nil

-- Framework Detection
if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)
    RegisterNetEvent('esx:setJob', function(job)
        PlayerData.job = job
    end)
elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = QBCore.Functions.GetPlayerData()
    end)
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerData.job = JobInfo
    end)
end

-- Load config
local Config = {}
if LoadResourceFile(GetCurrentResourceName(), 'config.lua') then
    local configContent = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
    local configFunc = load(configContent)
    if configFunc then
        configFunc()
        Config = _G.Config or {}
    end
end

-- Utility Functions
local function ShowNotification(message)
    if ESX then
        ESX.ShowNotification(message)
    elseif QBCore then
        QBCore.Functions.Notify(message, 'primary')
    else
        SetNotificationTextEntry('STRING')
        AddTextComponentString(message)
        DrawNotification(false, false)
    end
end

local function HasJob()
    if not Config.jobRequired then return true end
    
    if not PlayerData or not PlayerData.job then return false end
    
    for _, job in ipairs(Config.allowedJobs) do
        if PlayerData.job.name == job then
            return true
        end
    end
    return false
end

-- Server callback for item checking
RegisterNetEvent('coffee:checkItemsResponse')
AddEventHandler('coffee:checkItemsResponse', function(hasItems, missingItem, callbackId)
    if _G['coffee_callback_' .. callbackId] then
        _G['coffee_callback_' .. callbackId](hasItems, missingItem)
        _G['coffee_callback_' .. callbackId] = nil
    end
end)

-- Generate unique callback ID
local callbackCounter = 0
local function generateCallbackId()
    callbackCounter = callbackCounter + 1
    return 'coffee_' .. GetPlayerServerId(PlayerId()) .. '_' .. callbackCounter
end

-- Server-side item checking with callback
local function HasItems(ingredients, callback)
    local callbackId = generateCallbackId()
    _G['coffee_callback_' .. callbackId] = callback
    TriggerServerEvent('coffee:checkItems', ingredients, callbackId)
end

local function RemoveItems(ingredients)
    if ESX then
        for item, amount in pairs(ingredients) do
            TriggerServerEvent('coffee:removeItem', item, amount)
        end
    elseif QBCore then
        for item, amount in pairs(ingredients) do
            TriggerServerEvent('coffee:removeItem', item, amount)
        end
    end
end

local function GiveItem(item, amount)
    TriggerServerEvent('coffee:giveItem', item, amount)
end

-- Coffee Machine Blips
local function CreateBlips()
    for i, machine in ipairs(Config.coffeeMachines) do
        if machine.showBlip then
            local blip = AddBlipForCoord(machine.coords.x, machine.coords.y, machine.coords.z)
            SetBlipSprite(blip, 52)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 40)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(machine.label or 'Coffee Machine')
            EndTextCommandSetBlipName(blip)
        end
    end
end

-- 3D Text Drawing
local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

-- Coffee Machine Props
local function SpawnCoffeeMachines()
    for i, machine in ipairs(Config.coffeeMachines) do
        local model = GetHashKey(machine.prop or 'prop_coffee_mac_02')
        RequestModel(model)
        
        while not HasModelLoaded(model) do
            Wait(1)
        end
        
        local prop = CreateObject(model, machine.coords.x, machine.coords.y, machine.coords.z, false, false, false)
        SetEntityHeading(prop, machine.coords.w or 0.0)
        FreezeEntityPosition(prop, true)
        SetModelAsNoLongerNeeded(model)
    end
end

-- Main Thread
CreateThread(function()
    SpawnCoffeeMachines()
    CreateBlips()
    
    while true do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        local nearMachine = false
        
        for i, machine in ipairs(Config.coffeeMachines) do
            local distance = #(playerCoords - vector3(machine.coords.x, machine.coords.y, machine.coords.z))
            
            if distance < 2.0 then
                sleep = 0
                nearMachine = true
                currentMachineIndex = i
                
                DrawText3D(machine.coords.x, machine.coords.y, machine.coords.z + 1.0, 
                    Config.jobRequired and not HasJob() and 
                    '[Job Required: ' .. table.concat(Config.allowedJobs, ', ') .. ']' or
                    '[E] - Make Coffee')
                
                if IsControlJustReleased(0, 38) then -- E key
                    if Config.jobRequired and not HasJob() then
                        ShowNotification('You need to work as: ' .. table.concat(Config.allowedJobs, ', '))
                    else
                        OpenCoffeeMenu()
                    end
                end
                break
            end
        end
        
        isNearCoffeeMachine = nearMachine
        if not nearMachine then
            currentMachineIndex = nil
        end
        
        Wait(sleep)
    end
end)

-- Coffee Menu
function OpenCoffeeMenu()
    local coffeeData = {}
    
    for coffeeName, coffeeInfo in pairs(Config.coffeeTypes) do
        table.insert(coffeeData, {
            name = coffeeName,
            label = coffeeInfo.label,
            image = coffeeInfo.image,
            ingredients = coffeeInfo.ingredients,
            price = coffeeInfo.price or 0
        })
    end
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openCoffeeMenu',
        coffees = coffeeData,
        playerMoney = GetPlayerMoney()
    })
end

function GetPlayerMoney()
    if ESX then
        return ESX.GetPlayerData().money or 0
    elseif QBCore then
        return QBCore.Functions.GetPlayerData().money.cash or 0
    end
    return 0
end

-- NUI Callbacks
RegisterNUICallback('closeCoffeeMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('makeCoffee', function(data, cb)
    local coffeeName = data.coffee
    local coffeeInfo = Config.coffeeTypes[coffeeName]
    
    if not coffeeInfo then
        cb('error')
        return
    end
    
    -- Check items server-side with callback
    HasItems(coffeeInfo.ingredients, function(hasItems, missingItem)
        if not hasItems then
            ShowNotification('You are missing: ' .. missingItem)
            cb('error')
            return
        end
        
        -- Start crafting animation
        SetNuiFocus(false, false)
        
        -- Play animation
        local playerPed = PlayerPedId()
        RequestAnimDict('amb@world_human_aa_coffee@idle_a')
        while not HasAnimDictLoaded('amb@world_human_aa_coffee@idle_a') do
            Wait(1)
        end
        
        TaskPlayAnim(playerPed, 'amb@world_human_aa_coffee@idle_a', 'idle_a', 8.0, 8.0, -1, 1, 0, false, false, false)
        
        -- Show crafting UI
        SendNUIMessage({
            action = 'startCrafting',
            coffee = {
                name = coffeeName,
                label = coffeeInfo.label,
                image = coffeeInfo.image
            }
        })
        
        -- Wait for crafting to complete
        Wait(6000)
        
        -- Remove ingredients and give coffee
        RemoveItems(coffeeInfo.ingredients)
        GiveItem(coffeeName, 1)
        
        ClearPedTasks(playerPed)
        ShowNotification('You made a ' .. coffeeInfo.label .. '!')
        
        cb('ok')
    end)
end)

RegisterNUICallback('checkIngredients', function(data, cb)
    local coffeeName = data.coffee
    local coffeeInfo = Config.coffeeTypes[coffeeName]
    
    if not coffeeInfo then
        cb({hasItems = false})
        return
    end
    
    -- Check items server-side with callback
    HasItems(coffeeInfo.ingredients, function(hasItems, missingItem)
        cb({hasItems = hasItems})
    end)
end)