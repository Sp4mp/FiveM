RegisterServerEvent('sp_fahrschule:checklicense')
AddEventHandler('sp_fahrschule:checklicense', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(target)
		MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
			['@type'] = type,
			['@owner'] = xPlayer.identifier
		}, function(result)
			if tonumber(result[1].count) > 0 then
				haslicense = true
			else
				haslicense = false
			end
			givelicense(xPlayer, type, haslicense)
		end) 
end)

function givelicense(target, type, haslicense)
	local xPlayer = ESX.GetPlayerFromId(source)
	print(target.identifier)
	print(type)
	print(haslicense)
	if type == 'drive' then
		if haslicense == true then
			TriggerClientEvent('okokNotify:Alert', source, "Fahrschule", "Lizenz bereits vorhanden", 20000, 'error')
		elseif haslicense == false then
			TriggerClientEvent('okokNotify:Alert', source, "Fahrschule", "Lizenz vergeben", 20000, 'success')
			TriggerEvent('esx_license:addLicense', target, 'drive')
		else
			TriggerClientEvent('okokNotify:Alert', source, "Fahrschule", "Versuch es nochmal!", 20000, 'info')	
		end
	elseif type == 'bike' then
		if haslicense == true then
			TriggerClientEvent('okokNotify:Alert', source, "Fahrschule", "Lizenz bereits vorhanden", 20000, 'error')
		else 
			TriggerClientEvent('okokNotify:Alert', source, "Fahrschule", "Lizenz vergeben", 20000, 'success')
			TriggerEvent('esx_license:addLicense', target, 'bike')
		end
	end
end
