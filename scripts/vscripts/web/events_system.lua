--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function store_system:StartHighFive(params)
    if params.PlayerID == nil then return end
    local player = PlayerResource:GetPlayer(params.PlayerID)
    local hero = PlayerResource:GetSelectedHeroEntity(params.PlayerID)
    if hero then
        local player = PlayerResource:GetPlayer(params.PlayerID)
        if player.high_five_cooldown == nil then
            player.high_five_cooldown = 0
        end
        if player.high_five_cooldown and player.high_five_cooldown > 0 then
            local player = PlayerResource:GetPlayer(params.PlayerID)
            if player then
                CustomGameEventManager:Send_ServerToPlayer(player, "PauseNotification", {message="#cha_highfive_cooldown", time=player.high_five_cooldown})
            end
            return
        end
        player.high_five_cooldown = 15
        local modifier_cha_high_cooldown = hero:AddNewModifier(hero, nil, "modifier_cha_high_cooldown", {duration = player.high_five_cooldown})
        Timers:CreateTimer(1, function() 
            if player.high_five_cooldown <= 0 then
                if modifier_cha_high_cooldown and not modifier_cha_high_cooldown:IsNull() then
                    modifier_cha_high_cooldown:Destroy()
                end
                return nil
            end
            player.high_five_cooldown = player.high_five_cooldown - 1
            return 1
        end)
        hero:AddNewModifier(hero, nil, "modifier_cha_high_five", {duration = 10})
        if IsInToolsMode() then
            local units = FindUnitsInRadius(hero:GetTeamNumber(), hero:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
            units[1]:AddNewModifier(units[1], nil, "modifier_cha_high_five", {})
        end
    end
end

function store_system:PauseDisconnectPlayer(id)
    if store_system.LeavePauseCount[id] == nil then
        store_system.LeavePauseCount[id] = 1
    end
    if store_system.LeavePauseCount[id] >= 2 then
        return
    else
        store_system.LeavePauseCount[id] = store_system.LeavePauseCount[id] + 1
    end
    local hero = PlayerResource:GetSelectedHeroEntity(id) 
    if hero and not hero:IsNull() and hero:IsAlive() then
        if store_system.PlayerLeavePauseCooldown[id] and store_system.PlayerLeavePauseCooldown[id] <= 0 and not GameRules:IsGamePaused() then
            PauseGame(true)
            store_system.PauseOwner = id
            CustomNetTables:SetTableValue("pause_owner", "owner", {owner = id})
            store_system.PauseCooldown = 20
            Timers:CreateTimer({useGameTime = false, endTime = 1, callback = function()
                if store_system.PauseCooldown <= 0 then return end
                if PlayerResource:GetConnectionState(id) ~= nil and (PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_ABANDONED or PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_UNKNOWN or PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_CONNECTED ) then
                    PauseGame(false)
                    store_system.PauseOwner = nil
                    store_system.PauseCooldown = 0
                end
                
                store_system.PauseCooldown = store_system.PauseCooldown - 1
                return 1
            end})
            store_system.PlayerLeavePauseCooldown[id] = 120
            Timers:CreateTimer({useGameTime = false, endTime = 1, callback = function()
                if store_system.PlayerLeavePauseCooldown[id] <= 0 then return nil end
                store_system.PlayerLeavePauseCooldown[id] = store_system.PlayerLeavePauseCooldown[id] - 1
                return 1
            end})
        end
    end
end