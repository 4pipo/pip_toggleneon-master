local alavalot = false
QBCore = nil

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(0)
	end
end)

--## Uncomment and comment whichever notifications you want to use, or implement your own. By default it's using Mythic_notify, made it usable with ESX notifications also.
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
		local driver  = GetPedInVehicleSeat(vehicle, -1)
        local alavalotkiinni = IsVehicleNeonLightEnabled(vehicle, 1)
		
        if IsPedInVehicle(ped,vehicle, true) and driver == ped then
			-- If Ctrl + G pressed
            if IsControlPressed(1, 132) and IsControlJustPressed(1, 47) then
				if alavalotkiinni then
					if alavalot == false then
						alavalot = true
						DisableVehicleNeonLights(vehicle, true)
						--TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', length = 3000, text = 'Neonlights : OFF' })
						--ESX.ShowNotification('Neonlights: ~r~OFF')
						QBCore.Functions.Notify('Neonlights: ~r~OFF')
						Wait(2000)
					elseif alavalot == true then
						alavalot = false
						DisableVehicleNeonLights(vehicle, false)
						--TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', length = 3000, text = 'Neonlights : ON' })
						--ESX.ShowNotification('Neonlights: ~g~ON')
						QBCore.Functions.Notify('Neonlights: ~r~ON')
						Wait(2000)
					end
				else
					--TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', length = 5000, text = 'You need to have installed Neonlights?' })
					--ESX.ShowNotification('You need to have installed Neonlights')
					QBCore.Functions.Notify('You need to have installed Neonlights')
					Wait(2000)
				end
            end
        else
            Wait(1000)
        end
    end
end)
