--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


PingModifiers = PingModifiers or {}

local PING_TYPE = {
	NONE = -1,
	SELF_UNIT = 0,
	ALLY_HERO = 1,
	ALLY_UNIT = 2,
	ENEMY_HERO = 3,
	ENEMY_UNIT = 4,
	SELF_BH_TRACK = 5,
	ALLY_BH_TRACK = 6,
	ENEMY_BH_TRACK = 7,
	SELF_SB_CHARGE = 8,
	ALLY_SB_CHARGE = 9,
	ENEMY_SB_CHARGE = 10,
}

local MODIFIER_TO_TYPE = {
	modifier_bounty_hunter_track = {
		self = PING_TYPE.SELF_BH_TRACK,
		ally = PING_TYPE.ALLY_BH_TRACK,
		enemy = PING_TYPE.ENEMY_BH_TRACK,
	},
	modifier_spirit_breaker_charge_of_darkness_target = {
		self = PING_TYPE.SELF_SB_CHARGE,
		ally = PING_TYPE.ALLY_SB_CHARGE,
		enemy = PING_TYPE.ENEMY_SB_CHARGE,
	},
}

local TYPE_MESSAGES = {
	[PING_TYPE.SELF_UNIT] = "DOTA_Modifier_Alert",
	[PING_TYPE.ALLY_HERO] = "DOTA_Modifier_Alert_Ally_Hero",
	[PING_TYPE.ALLY_UNIT] = "DOTA_Modifier_Alert_Ally_Unit",
	[PING_TYPE.ENEMY_HERO] = "DOTA_Modifier_Alert_Enemy_Hero",
	[PING_TYPE.ENEMY_UNIT] = "DOTA_Modifier_Alert_Enemy_Unit",
	[PING_TYPE.SELF_BH_TRACK] = "DOTA_Modifier_Alert_Self_BH_Track",
	[PING_TYPE.ALLY_BH_TRACK] = "DOTA_Modifier_Alert_Ally_BH_Track",
	[PING_TYPE.ENEMY_BH_TRACK] = "DOTA_Modifier_Alert_Enemy_BH_Track",
	[PING_TYPE.SELF_SB_CHARGE] = "DOTA_Modifier_Alert_Self_SB_ChargeOfDarknessTarget",
	[PING_TYPE.ALLY_SB_CHARGE] = "DOTA_Modifier_Alert_Ally_SB_ChargeOfDarknessTarget",
	[PING_TYPE.ENEMY_SB_CHARGE] = "DOTA_Modifier_Alert_Enemy_SB_ChargeOfDarknessTarget",
}

function PingModifiers:Init()
	self.sb_charge_targets = {}
	EventStream:Listen("PingModifeirs:ping", function(event)
		local player_id = event.PlayerID
		if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

		local player = PlayerResource:GetPlayer(player_id)
		if not IsValidEntity(player) then return end

		PingModifiers:Ping(player_id, event.target_entity, event.modifier_name)
	end)
	EventDriver:Listen("Events:modifier_added", PingModifiers.OnModifierAdded, PingModifiers)
end

function PingModifiers:OnModifierAdded(event)
	if not event.unit then return end
	if not event.modifier or not event.modifier.GetName or not event.modifier.GetCaster then return end
	if event.modifier:GetName() ~= "modifier_spirit_breaker_charge_of_darkness_vision" then return end

	local caster = event.modifier:GetCaster()
	if not caster then return end

	local caster_owner_id = caster:GetPlayerOwnerID()
	if not caster_owner_id then return end


	self.sb_charge_targets[caster_owner_id] = event.unit
end

function PingModifiers:Ping(player_id, target_entity, modifier_name)
	local target = EntIndexToHScript(target_entity)
	if not target then return end

	local type = PING_TYPE.NONE
	local target_owned_id = target:GetPlayerOwnerID()

	local player_team = PlayerResource:GetTeam(player_id)

	if target_owned_id == player_id then
		type = MODIFIER_TO_TYPE[modifier_name] and MODIFIER_TO_TYPE[modifier_name].self or PING_TYPE.SELF_UNIT
	elseif target:GetTeam() == player_team then
		type = MODIFIER_TO_TYPE[modifier_name] and MODIFIER_TO_TYPE[modifier_name].ally
				or (target:IsRealHero() and PING_TYPE.ALLY_HERO or PING_TYPE.ALLY_UNIT)
	else
		type = MODIFIER_TO_TYPE[modifier_name] and MODIFIER_TO_TYPE[modifier_name].enemy
				or (target:IsRealHero() and PING_TYPE.ENEMY_HERO or PING_TYPE.ENEMY_UNIT)
	end

	if type == PING_TYPE.NONE then return end

	local modifier = target:FindModifierByName(modifier_name)
	if not modifier then return end

	local data = {
		hard_replace = {},
		not_localize = {},
	}

	local extra_data = {}

	local swap_cpp_to_dialog = function (n, dialog_var_name)
		local token = "";
		if dialog_var_name ~= token then token = "{s:" .. dialog_var_name .. "}" end
		data.hard_replace["%s" .. n] = token
	end

	local add_remaining_time = function (n, remaining_time)
		if not remaining_time or remaining_time <= 0 then
			swap_cpp_to_dialog(n, "")
		else
			extra_data.remaining_time = {
				key = "%s" .. n,
				value = remaining_time,
			}
		end
	end

	local setup_value = function(var_n, var_k, value, is_localize)
		swap_cpp_to_dialog(var_n, var_k)

		if not value then return end

		if is_localize then
			data[var_k] = value
		else
			data.not_localize[var_k] = value
		end
	end

	local setup_sb_target = function(color_n, name_n)
		local sb_target = PingModifiers.sb_charge_targets[target_owned_id]
		if sb_target then
			local sb_target_owner_id = sb_target:GetPlayerOwnerID()

			if sb_target_owner_id > -1 then
				data.players = data.players or {}
				setup_value(color_n, "sb_target_color", nil)
				setup_value(name_n, "sb_target_name", nil)

				data.players[sb_target:GetPlayerOwnerID()] = {
					sb_target_color = C_CHAT_ENUM.PLAYER_COLOR,
					sb_target_name = C_CHAT_ENUM.HERO_NAME,
				}
			else
				setup_value(color_n, "sb_target_color", "#ffffff", false)
				setup_value(name_n, "sb_target_name", sb_target:GetUnitName(), true)
			end
		end
	end

	setup_value(1, "modifier_color", modifier:IsDebuff() and "#ff0000" or "#00ff00", false)
	swap_cpp_to_dialog(2, "")
	setup_value(3, "modifier_name", "DOTA_Tooltip_" .. modifier:GetName(), true)

	local stacks = modifier:GetStackCount()
	if stacks and stacks > 0 then
		swap_cpp_to_dialog(2, "modifier_stacks")
		data.not_localize.modifier_stacks = stacks .. " "
	end

	local rem_time = modifier:GetRemainingTime()
	if modifier:GetAuraOwner() then
		rem_time = 0
	end

	if type == PING_TYPE.SELF_UNIT then
		add_remaining_time(4, rem_time)
	elseif type == PING_TYPE.ALLY_HERO or type == PING_TYPE.ENEMY_HERO then
		setup_value(4, "player_color", nil)
		setup_value(5, "hero_name", nil)
		data.players = { [target_owned_id] = C_CHAT_PRESETS.PLAYER_HERO }
		add_remaining_time(6, rem_time)
	elseif type == PING_TYPE.ALLY_UNIT or type == PING_TYPE.ENEMY_UNIT then
		setup_value(4, "target_color", "#ffffff", false)
		setup_value(5, "unit_name", target:GetUnitName(), true)
		add_remaining_time(6, rem_time)
	elseif type == PING_TYPE.SELF_BH_TRACK then
		setup_value(6, "gold", PlayerResource:GetGold(target_owned_id), false)
		add_remaining_time(7, rem_time)
	elseif type == PING_TYPE.ALLY_BH_TRACK or type == PING_TYPE.ENEMY_BH_TRACK then
		setup_value(4, "player_color", nil)
		setup_value(5, "hero_name", nil)
		data.players = { [target_owned_id] = C_CHAT_PRESETS.PLAYER_HERO }
		add_remaining_time(7, rem_time)
	elseif type == PING_TYPE.SELF_SB_CHARGE then
		setup_value(3, "arrow_image", "%ARROW%", false)
		setup_sb_target(6, 7)
	elseif type == PING_TYPE.ALLY_SB_CHARGE then
		setup_value(3, "arrow_image", "%ARROW%", false)
		setup_value(4, "target_color", nil)
		setup_value(5, "target_name", nil)
		data.players = {
			[target_owned_id] = {
				target_color = C_CHAT_ENUM.PLAYER_COLOR,
				target_name = C_CHAT_ENUM.HERO_NAME,
			},
		}
		setup_sb_target(6, 7)
	elseif type == PING_TYPE.ENEMY_SB_CHARGE then
		setup_value(3, "arrow_image", "%ARROW%", false)
		setup_sb_target(4, 5)
	end

	CustomChat:MessageToTeam(player_id, player_team, TYPE_MESSAGES[type], data, nil, extra_data)
end

PingModifiers:Init()