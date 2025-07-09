local ESX, QBCore = nil, nil

-- Framework Detection
if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
end

-- Check Items Server-side
RegisterServerEvent('coffee:checkItems')
AddEventHandler('coffee:checkItems', function(ingredients, callbackId)
    local src = source
    local hasAllItems = true
    local missingItem = nil
    
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            for item, amount in pairs(ingredients) do
                local playerItem = xPlayer.getInventoryItem(item)
                if not playerItem or playerItem.count < amount then
                    hasAllItems = false
                    missingItem = item
                    break
                end
            end
        else
            hasAllItems = false
        end
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            for item, amount in pairs(ingredients) do
                local playerItem = Player.Functions.GetItemByName(item)
                if not playerItem or playerItem.amount < amount then
                    hasAllItems = false
                    missingItem = item
                    break
                end
            end
        else
            hasAllItems = false
        end
    end
    
    TriggerClientEvent('coffee:checkItemsResponse', src, hasAllItems, missingItem, callbackId)
end)

-- Remove Item Event
RegisterServerEvent('coffee:removeItem')
AddEventHandler('coffee:removeItem', function(item, amount)
    local src = source
    
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            xPlayer.removeInventoryItem(item, amount)
        end
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.RemoveItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
        end
    end
end)

-- Give Item Event
RegisterServerEvent('coffee:giveItem')
AddEventHandler('coffee:giveItem', function(item, amount)
    local src = source
    
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            xPlayer.addInventoryItem(item, amount)
        end
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.AddItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
        end
    end
end)