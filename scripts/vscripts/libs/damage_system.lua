--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if damage_system == nil then
    _G.damage_system = class({})
    damage_system.damage_table = {}
    damage_system.damage_table_server = {}
    damage_system.damage_dirty_players = {}
    damage_system.update_timer_started = false
end

function damage_system:Init()
    damage_system.damage_dirty_players = {}
    for i=0,24 do
        if PlayerResource:IsValidPlayerID(i) then
            damage_system.damage_table[i] = 
            {
                {},
                {},
            }
            damage_system.damage_table_server[i] = 
            {
                {},
                {},
            }
        end
    end
    damage_system:StartUpdateTimer()
end

function damage_system:StartUpdateTimer()
    if damage_system.update_timer_started then return end
    damage_system.update_timer_started = true
    Timers:CreateTimer(5, function()
        damage_system:SendUpdate()
        return 5
    end)
end

function damage_system:MarkPlayerDirty(player_id)
    if player_id == nil then return end
    if damage_system.damage_table[player_id] == nil then return end
    damage_system.damage_dirty_players[player_id] = true
end

function damage_system:SendUpdate()
    for player_id, _ in pairs(damage_system.damage_dirty_players) do
        local player = PlayerResource:GetPlayer(player_id)
        if player and damage_system.damage_table[player_id] then
            CustomGameEventManager:Send_ServerToPlayer(player, "WODA_Player_update_damage_filter", damage_system.damage_table[player_id])
        end
        damage_system.damage_dirty_players[player_id] = nil
    end
end

function damage_system:UpdatePlayerDamage(attacker_id, victim_id, damage, damage_type)
    if damage_system.damage_table[attacker_id] then
        damage_system.damage_table[attacker_id][2][damage_type] = (damage_system.damage_table[attacker_id][2][damage_type] or 0) + damage
        damage_system.damage_table_server[attacker_id][2][damage_type] = (damage_system.damage_table_server[attacker_id][2][damage_type] or 0) + damage
        damage_system:MarkPlayerDirty(attacker_id)
    end
    if damage_system.damage_table[victim_id] then
        damage_system.damage_table[victim_id][1][damage_type] = (damage_system.damage_table[victim_id][1][damage_type] or 0) + damage
        damage_system.damage_table_server[victim_id][1][damage_type] = (damage_system.damage_table_server[victim_id][1][damage_type] or 0) + damage
        damage_system:MarkPlayerDirty(victim_id)
    end
end

function damage_system:EndGameUpdate()
    for id, info in pairs(PLAYERS) do
		if info.hero ~= nil and damage_system.damage_table_server[id] then
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_damage", player_id = id, data = damage_system.damage_table_server[id]})
        end
    end
end

function damage_system:WODA_Player_reset_damage_filter(data)
    local player_id = data.PlayerID
    local damage_type = data.damage_type
    if damage_system.damage_table[player_id] then
        damage_system.damage_table[player_id][damage_type] = {}
        damage_system:MarkPlayerDirty(player_id)
    end
end