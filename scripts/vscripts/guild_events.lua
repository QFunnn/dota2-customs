--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


if guild_events == nil then
	_G.guild_events = class({})
end

_G.guild_event_team = false
guild_events.event_units = guild_events.event_units or {}
guild_events.event_guild_exp = guild_events.event_guild_exp or 0

guild_events.solo_active_players = guild_events.solo_active_players or {}
guild_events.player_units = guild_events.player_units or {}
guild_events.player_guild_exp = guild_events.player_guild_exp or {}

guild_events.items_storage = {}

guild_events.guild_exp_for_unit = {
	["npc_dota_zone_1_unit_1"] = 1,
	["npc_dota_zone_1_unit_2"] = 1,
	["npc_dota_zone_1_unit_3"] = 1,
	["npc_dota_zone_1_unit_4"] = 1,
	["npc_dota_zone_1_unit_5"] = 1,
	["npc_dota_zone_1_unit_6"] = 1,

	["npc_dota_zone_2_unit_2"] = 1,
	["npc_dota_zone_2_unit_3"] = 1,

	["npc_dota_zone_3_unit_1"] = 1,
	["npc_dota_zone_3_unit_2"] = 1,
	["npc_dota_zone_3_unit_3"] = 1,

	["npc_dota_zone_4_unit_1"] = 1,
	["npc_dota_zone_4_unit_2"] = 1,
	["npc_dota_zone_4_unit_3"] = 1,
	["npc_dota_zone_4_unit_5"] = 1,

	["npc_dota_zone_5_unit_1"] = 1,
	["npc_dota_zone_5_unit_2"] = 1,
	["npc_dota_zone_5_unit_3"] = 1,

	["npc_dota_zone_6_unit_1"] = 1,
	["npc_dota_zone_6_unit_3"] = 1,
	["npc_dota_zone_6_unit_4"] = 1,

	["npc_dota_zone_7_unit_1"] = 1,
	["npc_dota_zone_7_unit_2"] = 1,
	["npc_dota_zone_7_unit_3"] = 1,
	["npc_dota_zone_7_unit_4"] = 1,

	["npc_dota_zone_8_unit_2"] = 1,
	["npc_dota_zone_8_unit_3"] = 1,
	["npc_dota_zone_8_unit_4"] = 1,
	["npc_dota_zone_8_unit_5"] = 1,
	["npc_dota_zone_8_unit_6"] = 1,

	["npc_dota_zone_9_unit_1"] = 1,
	["npc_dota_zone_9_unit_2"] = 1,
	["npc_dota_zone_9_unit_3"] = 1,

	["npc_dota_zone_10_unit_1"] = 1,
	["npc_dota_zone_10_unit_3"] = 1,
	["npc_dota_zone_10_unit_4"] = 1,
	["npc_dota_zone_10_unit_5"] = 1,

	["npc_dota_zone_11_unit_1"] = 1,
	["npc_dota_zone_11_unit_2"] = 1,
	["npc_dota_zone_11_unit_3"] = 1,
	["npc_dota_zone_11_unit_4"] = 1,

	["npc_dota_zone_12_unit_1"] = 1,
	["npc_dota_zone_12_unit_2"] = 1,
	["npc_dota_zone_12_unit_3"] = 1,
	["npc_dota_zone_12_unit_4"] = 1,
}

-----------------------------------------------------------------------------------------

function guild_events:IsAnyEventActiveForPlayer(unit)
	if _G.guild_event_team then
		return true
	end

	local nPlayerID = unit:GetPlayerID()

	if nPlayerID == -1 then
		local owner = unit:GetOwner()
		if owner and not owner:HasModifier("modifier_guild_event") then
			nPlayerID = owner:GetPlayerID()
		else
			return true
		end
	end

	if nPlayerID and self.solo_active_players[nPlayerID] then
		return true
	end

	return false
end

-----------------------------------------------------------------------------------------

function guild_events:IsAnySoloEventActive()
	for nPlayerID, isActive in pairs(self.solo_active_players) do
		if isActive then
			return true
		end
	end
	return false
end

function guild_events:EventTeleport(hero, point_name, status)
	if not hero or hero:IsNull() or not status then
		return
	end

	hero:AddNewModifier(hero, nil, "modifier_teleport_event", { duration = 3.5 })
	hero:EmitSound("Portal.Loop_Appear")

	Timers:CreateTimer(3, function()
		if not hero or hero:IsNull() then
			return
		end

		local point_ent = Entities:FindByName(nil, point_name)
		if point_ent then
			local point = point_ent:GetAbsOrigin()
			hero:SetAbsOrigin(point)
			FindClearSpaceForUnit(hero, point, true)
			hero:Stop()
			hero:StopSound("Portal.Loop_Appear")
			hero:RemoveModifierByName("modifier_teleport_event")

			local pID = hero:GetPlayerOwnerID()
			PlayerResource:SetCameraTarget(pID, hero)
			Timers:CreateTimer(0.1, function()
				PlayerResource:SetCameraTarget(pID, nil)
			end)
		end
	end)
end

-----------------------------------------------------------------------------------------

function guild_events:CanStartTeamEvent(initiatorID)
	if _G.ability_mode then
		rules:DisplayError(initiatorID, "#event_only_in_non_ability_mode")
		return false
	end

	if _G.guild_event_team then
		rules:DisplayError(initiatorID, "#event_already_started")
		return false
	end

	if self:IsAnySoloEventActive() then
		rules:DisplayError(initiatorID, "#someone_in_solo_event")
		return false
	end

	local players = rules:GetAllPlayers()
	local REQUIRED_LEVEL = 30
	local REQUIRED_PLAYERS = 5

	if players ~= REQUIRED_PLAYERS then
		rules:DisplayError(initiatorID, "#need_5_players")
		return false
	end

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS and PlayerResource:HasSelectedHero(nPlayerID) then
			local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)

			if not hero:IsAlive() then
				rules:DisplayError(nPlayerID, "#you_dead")
				return false
			end

			if hero:GetLevel() < REQUIRED_LEVEL then
				rules:DisplayError(nPlayerID, "#need_level_30")
				return false
			end
		end
	end

	return true
end

function guild_events:StartTeamEvent()
	_G.guild_event_team = true

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
		if hero then
			hero:AddNewModifier(hero, nil, "modifier_guild_event", {})
			if hero:HasModifier("modifier_fountain_invulnerability") then
				hero:RemoveModifierByName("modifier_fountain_invulnerability")
			end
			guild_events:ClearItems(hero)
			self:EventTeleport(hero, "event_point_enemy", true)
		end
	end

	self:StartTeamEventLogic()
end

function guild_events:StartTeamEventLogic()
	local EVENT_MULT = 1.0
	local EVENT_STEP = 0.15
	local MAX_UNITS = 20
	local HP_BASE = 2000
	local MIN_DAMAGE = 100
	local MAX_DAMAGE = 200
	local current_stacks = 1

	local enemy_point_ent = Entities:FindByName(nil, "event_point_enemy")
	if not enemy_point_ent then
		return
	end
	local enemy_point = enemy_point_ent:GetAbsOrigin()

	Timers:CreateTimer(5, function()
		if not _G.guild_event_team then
			return nil
		end

		if self:CheckTeamEventStatus() then
			self:EndTeamEvent()
			return nil
		end

		for i = #self.event_units, 1, -1 do
			local u = self.event_units[i]
			if not u or u:IsNull() or not u:IsAlive() then
				table.remove(self.event_units, i)
			end
		end

		if #self.event_units < MAX_UNITS then
			local spawn_count = math.min(5, MAX_UNITS - #self.event_units)
			for i = 1, spawn_count do
				local unit_name = _G.excludedUnits[RandomInt(1, #_G.excludedUnits)]
				local spawn_pos = enemy_point + RandomVector(RandomFloat(100, 500))
				local unit = CreateUnitByName(unit_name, spawn_pos, true, nil, nil, DOTA_TEAM_BADGUYS)

				unit.solo_event_player_id = 7

				table.insert(self.event_units, unit)
				unit:SetBaseMaxHealth(HP_BASE * EVENT_MULT)
				unit:SetMaxHealth(HP_BASE * EVENT_MULT)
				unit:SetHealth(HP_BASE * EVENT_MULT)
				unit:SetBaseDamageMin(MIN_DAMAGE * EVENT_MULT)
				unit:SetBaseDamageMax(MAX_DAMAGE * EVENT_MULT)
				unit:SetDeathXP(0)

				local mod = unit:AddNewModifier(hero, nil, "modifier_event_buff", {})
				if mod then
					mod:SetStackCount(current_stacks)
				end
			end
		end

		EVENT_MULT = EVENT_MULT + EVENT_STEP
		current_stacks = current_stacks + 1

		return 2
	end)
end

function guild_events:EndTeamEvent()
	_G.guild_event_team = false
	for _, u in pairs(self.event_units) do
		if u and not u:IsNull() and u:IsAlive() then
			UTIL_Remove(u)
		end
	end

	local all_entities = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in pairs(all_entities) do
		if unit.solo_event_player_id == 7 then
			UTIL_Remove(unit)
		end
	end

	self.event_units = {}

	local playerIds = {}

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
		if hero then
			hero:RemoveModifierByName("modifier_guild_event")
			hero:RemoveModifierByName("modifier_wait")
			self:EventTeleport(hero, "relay_zone_2", false)
			table.insert(playerIds, nPlayerID)
		end
	end

	local collected_exp = guild_events.event_guild_exp
	guild_events.event_guild_exp = 0

	local exp_for_each_player = math.floor(collected_exp / #playerIds)

	for _, pid in ipairs(playerIds) do
		guilds:AddGuildExp(pid, exp_for_each_player, true)
	end
end

function guild_events:CheckTeamEventStatus()
	local heroes = HeroList:GetAllHeroes()
	for _, hero in pairs(heroes) do
		if hero:IsRealHero() and hero:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
			if not hero:HasModifier("modifier_wait") then
				return false
			end
		end
	end
	return true
end

-----------------------------------------------------------------------------------------

function guild_events:CanStartSoloEvent(nPlayerID)
	if not PlayerResource:IsValidPlayerID(nPlayerID) then
		return
	end

	if _G.ability_mode then
		rules:DisplayError(nPlayerID, "#event_only_in_non_ability_mode")
		return false
	end

	if _G.guild_event_team then
		rules:DisplayError(nPlayerID, "#team_event_active_now")
		return false
	end

	local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	local REQUIRED_LEVEL = 30

	if hero:GetLevel() < REQUIRED_LEVEL then
		rules:DisplayError(nPlayerID, "#need_level_30")
		return false
	end

	if not hero:IsAlive() then
		rules:DisplayError(nPlayerID, "#you_dead")
		return false
	end

	if self.solo_active_players[nPlayerID] then
		rules:DisplayError(nPlayerID, "#event_already_started")
		return false
	end

	return true
end

function guild_events:StartSoloEvent(nPlayerID)
	local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	guild_events:ClearItems(hero)

	self.solo_active_players[nPlayerID] = true
	self.player_units[nPlayerID] = {}
	hero:AddNewModifier(hero, nil, "modifier_guild_event", {})

	if hero:HasModifier("modifier_fountain_invulnerability") then
		hero:RemoveModifierByName("modifier_fountain_invulnerability")
	end

	self:EventTeleport(hero, "solo_event_point_" .. nPlayerID, true)
	self:StartSoloEventLogic(nPlayerID)
end

function guild_events:StartSoloEventLogic(nPlayerID)
	local EVENT_MULT = 1.0
	local EVENT_STEP = 0.1
	local MAX_UNITS = 7
	local HP_BASE = 2000
	local MIN_DAMAGE = 100
	local MAX_DAMAGE = 200
	local current_stacks = 1

	local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	local player_point = Entities:FindByName(nil, "solo_event_point_" .. nPlayerID)
	local spawn_ent = Entities:FindByName(nil, "solo_event_point_enemy_" .. nPlayerID)
	if not spawn_ent then
		return
	end
	local enemy_point = spawn_ent:GetAbsOrigin()

	Timers:CreateTimer(5, function()
		if not self.solo_active_players[nPlayerID] then
			return nil
		end

		for i = #self.player_units[nPlayerID], 1, -1 do
			local u = self.player_units[nPlayerID][i]
			if not u or u:IsNull() or not u:IsAlive() then
				table.remove(self.player_units[nPlayerID], i)
			end
		end

		if #self.player_units[nPlayerID] < MAX_UNITS then
			local spawn_count = math.min(3, MAX_UNITS - #self.player_units[nPlayerID])
			for i = 1, spawn_count do
				local unit_name = _G.excludedUnits[RandomInt(1, #_G.excludedUnits)]
				local spawn_pos = enemy_point + RandomVector(RandomFloat(100, 400))
				local unit = CreateUnitByName(unit_name, spawn_pos, true, nil, nil, DOTA_TEAM_BADGUYS)

				unit.solo_event_player_id = nPlayerID

				unit.bInitialized = true
				unit.vInitialSpawnPos = player_point:GetAbsOrigin()

				table.insert(self.player_units[nPlayerID], unit)
				unit:SetBaseMaxHealth(HP_BASE * EVENT_MULT)
				unit:SetMaxHealth(HP_BASE * EVENT_MULT)
				unit:SetHealth(HP_BASE * EVENT_MULT)
				unit:SetBaseDamageMin(MIN_DAMAGE * EVENT_MULT)
				unit:SetBaseDamageMax(MAX_DAMAGE * EVENT_MULT)
				unit:SetDeathXP(0)

				local mod = unit:AddNewModifier(hero, nil, "modifier_event_buff", {})
				if mod then
					mod:SetStackCount(current_stacks)
				end
			end
		end

		EVENT_MULT = EVENT_MULT + EVENT_STEP
		current_stacks = current_stacks + 1

		return 2
	end)
end

function guild_events:EndSoloEvent(nPlayerID)
	self.solo_active_players[nPlayerID] = false

	if self.player_units[nPlayerID] then
		for i, u in pairs(self.player_units[nPlayerID]) do
			if u and not u:IsNull() then
				if u:IsAlive() then
					UTIL_Remove(u)
				end
			end
		end
		self.player_units[nPlayerID] = {}
	end

	local all_entities = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in pairs(all_entities) do
		if unit.solo_event_player_id == nPlayerID then
			UTIL_Remove(unit)
		end
	end

	local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	if hero then
		hero:RemoveModifierByName("modifier_guild_event")
		self:EventTeleport(hero, "relay_zone_2", false)
	end

	local collected_exp = guild_events.player_guild_exp[nPlayerID]
	guild_events.player_guild_exp[nPlayerID] = 0

	guilds:AddGuildExp(nPlayerID, collected_exp, true)
end

-----------------------------------------------------------------------------------------

function guild_events:OnHeroDied(hero)
	local nPlayerID = hero:GetPlayerID()

	Timers:CreateTimer(1, function()
		hero:RespawnHero(false, false)
		hero:SetHealth(hero:GetMaxHealth())
		hero:SetMana(hero:GetMaxMana())
		guild_events:RestoreItems(hero)
		if self.solo_active_players[nPlayerID] then
			self:EndSoloEvent(nPlayerID)
		elseif _G.guild_event_team then
			hero:AddNewModifier(hero, nil, "modifier_wait", {})
		end
	end)
end

-----------------------------------------------------------------------------------------

function guild_events:ClearItems(hero)
	if not hero or hero:IsNull() then
		return
	end

	local steamID = PlayerResource:GetSteamAccountID(hero:GetPlayerID())

	if not guild_events.items_storage[steamID] then
		guild_events.items_storage[steamID] = {}
		local item = hero:GetItemInSlot(15)

		if item and item:GetName() == "item_tpscroll" then
			table.insert(guild_events.items_storage[steamID], {
				name = item:GetAbilityName(),
				level = item:GetLevel(),
				charges = item:GetCurrentCharges(),
			})
			hero:RemoveItem(item)
		end
	end
end

function guild_events:RestoreItems(hero)
	if not hero or hero:IsNull() then
		return
	end

	local steamID = PlayerResource:GetSteamAccountID(hero:GetPlayerID())
	local saved_items = guild_events.items_storage[steamID]

	if saved_items then
		for _, item_data in pairs(saved_items) do
			local item = hero:AddItemByName(item_data.name)
			if item then
				item:SetLevel(item_data.level)
				item:SetCurrentCharges(item_data.charges)
			end
		end
		guild_events.items_storage[steamID] = nil
	end
end