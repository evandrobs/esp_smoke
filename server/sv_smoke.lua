 RegisterNetEvent('esp-smoke:server:IniciaFumacinha', function(entity)

    local src = source
    -- print("oi servidor", entity)

	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('esp-smoke:client:IniciaFumacinha', playerId, entity)
    end


 end)


