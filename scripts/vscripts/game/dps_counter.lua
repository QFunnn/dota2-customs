--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


DPS_Counter = DPS_Counter or class({})

function DPS_Counter:Init()
	EventStream:Listen("DPS_Counter:reset", DPS_Counter.Reset, DPS_Counter)
	EventStream:Listen("DPS_Counter:toggle_reset_on_respawn", DPS_Counter.ToggleResetOnSpawn, DPS_Counter)
	EventStream:Listen("DPS_Counter:toggle_auto_opening", DPS_Counter.ToggleAutoOpening, DPS_Counter)
	EventStream:Listen("DPS_Counter:get_settings", DPS_Counter.UpdateSettings, DPS_Counter)

	EventStream:Listen("DPS_Counter:change_observed_player", DPS_Counter.ChangeObservedPlayer, DPS_Counter)

	DPS_Counter.reset_on_respawn = {}
	DPS_Counter.last_reset_time = {}
	DPS_Counter.outcoming_damage = {}
	-- only send dps data of the player you are viewing
	-- each player can only observe 1 other, selected on client
	DPS_Counter.observed_players = {}

	for p_id = 0, 24 do
		DPS_Counter.observed_players[p_id] = DPS_Counter.observed_players[p_id]
	end

	DPS_Counter.update_timer = Timers:CreateTimer(5, function()
		return DPS_Counter:Update()
	end)

	ListenToGameEvent("npc_spawned", Dynamic_Wrap(DPS_Counter, "OnNPCSpawned"), DPS_Counter)
	EventDriver:Listen("Events:entity_killed", DPS_Counter.OnEntityKilled, DPS_Counter)
	EventDriver:Listen("EventProxy:OnTakeDamage", DPS_Counter.OnTakeDamage, DPS_Counter)
end

function DPS_Counter:OnNPCSpawned(event)
	local unit = event.entindex and EntIndexToHScript(event.entindex)
	local owner_player_id = unit.GetPlayerOwnerID and unit:GetPlayerOwnerID()
	if not owner_player_id then
		return
	end

	local player = PlayerResource:GetPlayer(owner_player_id)
	if not player or player:IsNull() then
		return
	end

	if not DPS_Counter.last_reset_time[owner_player_id] then
		Timers:CreateTimer(0, function()
			if not DPS_Counter.last_reset_time[owner_player_id] then
				DPS_Counter.last_reset_time[owner_player_id] = GameRules:GetGameTime()
			end
		end)
	end

	if unit ~= PlayerResource:GetSelectedHeroEntity(owner_player_id) then
		return
	end

	if DPS_Counter.reset_on_respawn[owner_player_id] then
		DPS_Counter:Reset({
			PlayerID = owner_player_id,
		})
	end

	if
		WebSettings:GetSettingValue(owner_player_id, "dps_auto_opening")
		and DPS_Counter.outcoming_damage[owner_player_id]
	then
		DPS_Counter:ForceClose(player)
	end
end

function DPS_Counter:OnEntityKilled(event)
	local owner_player_id = event.killed.GetPlayerOwnerID and event.killed:GetPlayerOwnerID()
	if not owner_player_id then
		return
	end

	local player = PlayerResource:GetPlayer(owner_player_id)
	if not player or player:IsNull() then
		return
	end

	if event.killed ~= PlayerResource:GetSelectedHeroEntity(owner_player_id) then
		return
	end
	if
		WebSettings:GetSettingValue(owner_player_id, "dps_auto_opening")
		and DPS_Counter.outcoming_damage[owner_player_id]
	then
		DPS_Counter:ForceOpen(player)
	end
end

function DPS_Counter:ForceOpen(player)
	CustomGameEventManager:Send_ServerToPlayer(player, "DPS_Counter:force_open", {})
end

function DPS_Counter:ForceClose(player)
	CustomGameEventManager:Send_ServerToPlayer(player, "DPS_Counter:force_close", {})
end

function DPS_Counter:RegisterPlayer(player_id)
	if not IsValidPlayerID(player_id) then
		return
	end

	-- if not DPS_Counter.current_damage_records[player_id] then
	-- 	DPS_Counter.current_damage_records[player_id] = {}
	-- end
end

function DPS_Counter:UpdateSettings(event)
	local player_id = event.PlayerID
	if not player_id or not IsValidPlayerID(player_id) then
		return
	end

	local player = PlayerResource:GetPlayer(player_id)
	if not player or player:IsNull() then
		return
	end

	DPS_Counter:RegisterPlayer(player_id)

	CustomGameEventManager:Send_ServerToPlayer(player, "DPS_Counter:update_settings", {
		reset_on_respawn = DPS_Counter.reset_on_respawn[player_id],
	})
end

function DPS_Counter:ToggleAutoOpening(event)
	local player_id = event.PlayerID
	if not player_id or not IsValidPlayerID(player_id) then
		return
	end

	local player = PlayerResource:GetPlayer(player_id)
	if not player or player:IsNull() then
		return
	end

	WebSettings:SetSettingValue(
		player_id,
		"dps_auto_opening",
		not WebSettings:GetSettingValue(player_id, "dps_auto_opening")
	)
end

function DPS_Counter:ToggleResetOnSpawn(event)
	local player_id = event.PlayerID
	if not player_id or not IsValidPlayerID(player_id) then
		return
	end

	local player = PlayerResource:GetPlayer(player_id)
	if not player or player:IsNull() then
		return
	end

	DPS_Counter.reset_on_respawn[player_id] = not DPS_Counter.reset_on_respawn[player_id]
end

function DPS_Counter:Reset(event)
	local player_id = event.PlayerID
	if not player_id or not IsValidPlayerID(player_id) then
		return
	end

	local player = PlayerResource:GetPlayer(player_id)
	if not player or player:IsNull() then
		return
	end

	DPS_Counter.last_reset_time[player_id] = GameRules:GetGameTime()
	DPS_Counter.outcoming_damage[player_id] = {}

	CustomGameEventManager:Send_ServerToPlayer(player, "DPS_Counter:reset_client", {})
end

function DPS_Counter:Update()
	for player_id, hero in pairs(GameLoop.hero_by_player_id) do
		if IsValidPlayerID(player_id) then
			DPS_Counter:UpdatePlayer(player_id)
		end
	end

	return 5
end

function DPS_Counter:UpdatePlayer(player_id)
	local observed_player_id = DPS_Counter.observed_players[player_id]
	if not observed_player_id or not IsValidPlayerID(observed_player_id) then
		observed_player_id = player_id
	end

	local damage_table = DPS_Counter.outcoming_damage[observed_player_id] or {}

	-- print("[DPS Counter] Update player", player_id, "observing", observed_player_id)

	local player = PlayerResource:GetPlayer(player_id)

	CustomGameEventManager:Send_ServerToPlayer(player, "DPS_Counter:update", {
		supporter_level = WebPlayer:GetSubscriptionTier(player_id),
		dps_data = damage_table,
		last_reset_time = DPS_Counter.last_reset_time[player_id] or 0,
		observed_player_id = observed_player_id,
	})
end

function DPS_Counter:GetDamageInstanceName(inflictor, hero, unit)
	if inflictor and inflictor.GetAbilityName then
		local ability_name = inflictor:GetAbilityName()
		if ability_name == "item_magical_damage_perk_dummy" then
			return "attack"
		end
		return ability_name
	else
		if hero ~= unit then
			if unit:IsIllusion() then
				return "illusion"
			end
			return "summon"
		else
			return "attack"
		end
	end
end

function DPS_Counter:RegisterDamageInstance(unit, target, damage, damage_type, inflictor)
	if not damage_type or damage_type < 1 or damage_type > 4 or damage == 0 then
		return
	end
	local player_owner = unit:GetPlayerOwner()
	if not player_owner or player_owner:IsNull() then
		return
	end

	local attacker_id = player_owner:GetPlayerID()

	local hero = player_owner:GetAssignedHero()
	if not hero or hero:IsNull() then
		return
	end

	local inflictor_name = DPS_Counter:GetDamageInstanceName(inflictor, hero, unit)

	if not DPS_Counter.outcoming_damage[attacker_id] then
		DPS_Counter.outcoming_damage[attacker_id] = {}
	end

	local damage_instance = DPS_Counter.outcoming_damage[attacker_id][inflictor_name]

	if not damage_instance then
		DPS_Counter.outcoming_damage[attacker_id][inflictor_name] = {
			total = {
				count = 0,
				damage_by_type = {},
			},
			heroes = {
				count = 0,
				damage_by_type = {},
			},
			buildings = {
				count = 0,
				damage_by_type = {},
			},
		}
	end

	local save_damage = function(type)
		local current_damage = DPS_Counter.outcoming_damage[attacker_id][inflictor_name][type]

		current_damage.damage_by_type[damage_type] = (current_damage.damage_by_type[damage_type] or 0) + damage
		current_damage.count = current_damage.count + 1
	end

	save_damage("total")
	if target:IsRealHero() then
		save_damage("heroes")
	end
	if target:IsBuilding() then
		save_damage("buildings")
	end
end

function DPS_Counter:OnTakeDamage(event)
	if not event.attacker then
		return
	end

	DPS_Counter:RegisterDamageInstance(event.attacker, event.target, event.damage, event.damage_type, event.inflictor)
end

function DPS_Counter:ChangeObservedPlayer(event)
	local player_id = event.PlayerID
	local new_observed = event.observed_player_id
	if not IsValidPlayerID(player_id) or not IsValidPlayerID(new_observed) then
		return
	end

	local subscription_tier = WebPlayer:GetSubscriptionTier(player_id)

	if subscription_tier == 0 and player_id ~= new_observed then
		DPS_Counter.observed_players[player_id] = player_id
		DisplayError(player_id, "#dps_lock_supp_1")
		return
	end

	if subscription_tier == 1 and PlayerResource:GetTeam(player_id) ~= PlayerResource:GetTeam(new_observed) then
		DPS_Counter.observed_players[player_id] = player_id
		DisplayError(player_id, "#dps_lock_supp_2")
		return
	end

	DPS_Counter.observed_players[player_id] = new_observed
	print("Switched DPS meter for", player_id, "to", new_observed)

	DPS_Counter:UpdatePlayer(player_id)
end