-- SMOKE EFFECT GRENADE MODIFICATION
-- AUTHOR zunt1n

local smokeGrenade = "weapon_bzgas" -- OBJETO A SER SPAWNADO

RegisterNetEvent('esp-smoke:client:IniciaFumacinha', function(entity)

    local particleDictionary = "core" -- NUCLEO DO DICIONARIO DE EFEITOS UTILIZADO
    local particleName = "exp_grd_grenade_smoke" --NOME DO EFEITO PARTICULAR A SER GERADO
    local ped = PlayerPedId() -- JOGADOR
    -- print("oi client", entity)

    RequestNamedPtfxAsset(particleDictionary) -- CARREGAMENTO DO DICIONARIO DE PARTICULAS
    while not HasNamedPtfxAssetLoaded(particleDictionary) do  -- VERIFICACAO DO CARREGAMENTO DO DICIONARIO DE PARTICULAS
        Wait(10)
    end

    UseParticleFxAsset(particleDictionary) -- USO DO DICIONARIO DE PARTICULAS
    StartNetworkedParticleFxLoopedOnEntity(particleName, entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.SmokeSize, false, false, false) -- GERA FUMAÇA NA ENTIDADE DE ENTRADA NA FUNÇÃO

    AddEventHandler('gameEventTriggered', function(eventName, args)
        
        if eventName == 'CEventNetworkEntityDamage' then
            -- Verifica se a arma é a BZ Gas
                -- print('causando dano '..ped)
                -- Cancela o dano
                    SetEntityProofs(ped, false, true, true, false, false, false, false, false)
        end
    end)
 
end)

Citizen.CreateThread(function()
local smokeGrenadeHash = GetHashKey("w_ex_grenadesmoke") --ENTIDADE QUE DEVERÁ SER LOCALIZADA

    while true do
        Wait(0)
        local ped = PlayerPedId() -- JOGADOR
        local playerPos = GetEntityCoords(ped) -- POSICAO DO JOGADOR
        SetEntityProofs(ped, false, false, false, false, false, false, false, false) --RESTAURA DANO

        if IsPedShooting(ped) and GetSelectedPedWeapon(ped) == GetHashKey(smokeGrenade) then -- VERIFICA SE A GRANDA FOI LANCADA
            
            Wait(5) --TEMPO DE ESPERA APÓS GRANADA SAIR DA MÃO
	        entity = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 2.0, smokeGrenadeHash, false, false, false) --BUSCA PELA GRANADA LANÇADA MAIS PRÓXIMA
        
            -- print("lancou", entity)
            Wait(2000) -- TEMPO DE ESPERA PARA QUE A FUMAÇA COMECE A SAIR
            -- CreateBigSmoke(grenadePos, entity) --CHAMA A FUNÇÃO QUE LIBERARÁ A FUMAÇA
            TriggerServerEvent('esp-smoke:server:IniciaFumacinha',entity)
			-- print("smokou", entity)
            Wait(30000)
        end
    end
end)