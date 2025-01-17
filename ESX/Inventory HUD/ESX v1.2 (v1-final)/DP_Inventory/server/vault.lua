RegisterServerEvent('DP_Inventory:getItem')
AddEventHandler('DP_Inventory:getItem', function(--[[owner,--]] job, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(xPlayer.identifier)

	if type == 'item_standard' then
		local sourceItem = xPlayer.getInventoryItem(item)
		if xPlayer.job.name == job then
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
				local inventoryItem = inventory.getItem(item)
				if count > 0 and inventoryItem.count >= count then
					if not xPlayer.canCarryItem(item, count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('player_cannot_hold'), length = 5500})
					else
						inventory.removeItem(item, count)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_withdrawn', count, inventoryItem.label), length = 7500})
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('not_enough_in_vault'), length = 5500})
				end
			end)
		--[[elseif xPlayer.club.name == job then
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
				local inventoryItem = inventory.getItem(item)
				if count > 0 and inventoryItem.count >= count then
					if not xPlayer.canCarryItem(item, count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('player_cannot_hold'), length = 5500})
					else
						inventory.removeItem(item, count)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_withdrawn', count, inventoryItem.label), length = 7500})
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('not_enough_in_vault'), length = 5500})
				end
			end)]]
		elseif job == 'vault' then
			TriggerEvent('esx_addoninventory:getInventory', 'vault', xPlayerOwner.identifier, function(inventory)
				local inventoryItem = inventory.getItem(item)
				if count > 0 and inventoryItem.count >= count then
					if not xPlayer.canCarryItem(item, count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', _source,  {type = 'error', text = _U('player_cannot_hold'), length = 5500})
					else
						inventory.removeItem(item, count)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_withdrawn', count, inventoryItem.label), length = 8500})
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('not_enough_in_vault'), length = 5500})
				end
			end)
		end

	elseif type == 'item_account' then
		print('society_'..job..'_'..item)
		if xPlayer.job.name == job then
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
				local policeAccountMoney = account.money
				if policeAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)
		elseif xPlayer.job.name == job then
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
				local nightclubAccountMoney = account.money
				if nightclubAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)
		--[[elseif xPlayer.club.name == job then
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
				local clubMoney = account.money
				if clubMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)]]
		elseif job == 'vault' then
			TriggerEvent('esx_addonaccount:getAccount', 'vault_' .. item, xPlayerOwner.identifier, function(account)
				local roomAccountMoney = account.money
				if roomAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = "Je hebt hier geen permissie voor.", length = 5500})
		end
	end

end)

RegisterServerEvent('DP_Inventory:putItem')
AddEventHandler('DP_Inventory:putItem', function(--[[owner,--]] job, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(xPlayer.identifier)

	if type == 'item_standard' then
		local playerItemCount = xPlayer.getInventoryItem(item).count
		if playerItemCount >= count and count > 0 then
			if xPlayer.job.name == job then
				TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
					xPlayer.removeInventoryItem(item, count)
					inventory.addItem(item, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_deposited', count, inventory.getItem(item).label), length = 7500})
				end)
			--[[elseif xPlayer.club.name == job then
				TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'.. job, function(inventory)
					xPlayer.removeInventoryItem(item, count)
					inventory.addItem(item, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_deposited', count, inventory.getItem(item).label), length = 7500})
				end)]]
			elseif job == 'vault' then
				TriggerEvent('esx_addoninventory:getInventory', 'vault', xPlayerOwner.identifier, function(inventory)
					xPlayer.removeInventoryItem(item, count)
					inventory.addItem(item, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_deposited', count, inventory.getItem(item).label), length = 7500})
				end)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "error", text = 'Je hebt hier geen permissies voor!', length = 5500})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "error", text = _U('invalid_quantity'), length = 5500})
		end

	elseif type == 'item_account' then
		local playerAccountMoney = xPlayer.getAccount(item).money
		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)
			if xPlayer.job.name == job and job == 'police' then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
					account.addMoney(count)
				end)
			elseif xPlayer.job.name == job and job == 'nightclub' then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
					account.addMoney(count)
				end)
			--[[elseif xPlayer.club.name == job then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
					account.addMoney(count)
				end)]]
			elseif job == 'vault' then
				TriggerEvent('esx_addonaccount:getAccount', 'vault_' .. item, xPlayerOwner.identifier, function(account)
					account.addMoney(count)
				end)
			else
				xPlayer.addAccountMoney(item, count)
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'This job not allow for black money', length = 5500})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
		end
	elseif type == 'item_money' then
		local playerAccountMoney = xPlayer.getMoney()
		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeMoney(count)
			if xPlayer.job.name == job and job == 'police' then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_money', function(account)
					print('account',account)
					account.addMoney(count)
				end)
			elseif xPlayer.job.name == job and job == 'nightclub' then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_money', function(account)
					account.addMoney(count)
				end)
			--[[elseif xPlayer.club.name == job then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_money', function(account)
					account.addMoney(count)
				end)]]
			elseif job == 'vault' then
				TriggerEvent('esx_addonaccount:getAccount', 'vault_' .. item, xPlayerOwner.identifier, function(account)
					account.addMoney(count)
				end)
			else
				xPlayer.addAccountMoney(item, count)
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'This job not allow for black money', length = 5500})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
		end
	end
end)

ESX.RegisterServerCallback('DP_Inventory:getVaultInventory', function(source, cb, item, refresh)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem
	if item.needItemLicense ~= '' or item.needItemLicense ~= nil then
		xItem = xPlayer.getInventoryItem(item.needItemLicense)
	else
		xItem = nil
	end
	local refresh = refresh or false

	local blackMoney = 0
	local money = 0
	local items      = {}
	local weapons    = {}

	if not refresh and (item.needItemLicense ~= '' or item.needItemLicense ~= nil) and xItem ~= nil and xItem.count < 1 then
		cb(false)
	elseif not item.InfiniteLicense and not refresh and xItem ~= nil and xItem.count > 0 then
		xPlayer.removeInventoryItem(item.needItemLicense, 1)
	end

	local typeVault = ''
	local society = false
	if string.find(item.job, "vault") then
		typeVault = item.job
	else
		typeVault = "society_"..item.job
		society = true
	end

	if society then
		if item.job == 'police' or item.job == 'nightclub' then
			TriggerEvent('esx_addonaccount:getSharedAccount', typeVault..'_black_money', function(account)
				blackMoney = account.money
			end)
		else
			blackMoney = 0
		end
		if item.job == 'police' or item.job == 'nightclub' or then
			TriggerEvent('esx_addonaccount:getSharedAccount', typeVault..'_money', function(account)
				money = account.money
			end)
		else
			money = 0
		end
		TriggerEvent('esx_addoninventory:getSharedInventory', typeVault, function(inventory)
			items = inventory.items
		end)
		--[[TriggerEvent('esx_datastore:getSharedDataStore', typeVault, function(store)
			weapons = store.get('weapons') or {}
		end)]]
		cb({
			blackMoney = blackMoney,
			items      = items,
			--weapons    = weapons,
			money = money,
			job = item.job
		})
	else
		TriggerEvent('esx_addonaccount:getAccount', typeVault..'_black_money', xPlayer.identifier, function(account)
			blackMoney = account.money
		end)
		TriggerEvent('esx_addonaccount:getAccount', typeVault..'_money', xPlayer.identifier, function(account)
			money = account.money
		end)

		TriggerEvent('esx_addoninventory:getInventory', typeVault, xPlayer.identifier, function(inventory)
			items = inventory.items
		end)

		TriggerEvent('esx_datastore:getDataStore', typeVault, xPlayer.identifier, function(store)
			weapons = store.get('weapons') or {}
		end)

		cb({
			blackMoney = blackMoney,
			items      = items,
			weapons    = weapons,
			money  = money,
			job = item.job
		})
	end
end)
