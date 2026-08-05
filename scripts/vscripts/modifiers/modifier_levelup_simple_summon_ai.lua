--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_levelup_simple_summon_ai = class({})

function modifier_levelup_simple_summon_ai:IsHidden()
	return true
end
function modifier_levelup_simple_summon_ai:IsPurgable()
	return false
end
function modifier_levelup_simple_summon_ai:IsPurgeException()
	return false
end

local function get_lane_goal_position(owner_player_id)
	if not wave_manager or not owner_player_id then
		return nil
	end

	local lane_state = wave_manager:GetLaneState(owner_player_id)
	if not lane_state or not lane_state.spawner_name then
		return nil
	end

	if wave_manager.spawn_points_by_name and wave_manager.spawn_points_by_name[lane_state.spawner_name] then
		return wave_manager.spawn_points_by_name[lane_state.spawner_name]
	end

	local spawner = Entities:FindByName(nil, lane_state.spawner_name)
	if IsValid(spawner) then
		return spawner:GetAbsOrigin()
	end
end

function modifier_levelup_simple_summon_ai:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
	}
end

function modifier_levelup_simple_summon_ai:CheckState()
	local parent = self:GetParent()
	local state = {}

	if parent.levelup_summon_attack_immune == true then
		state[MODIFIER_STATE_ATTACK_IMMUNE] = true
	end
	if parent.levelup_summon_magic_immune == true then
		state[MODIFIER_STATE_MAGIC_IMMUNE] = true
	end
	if parent.levelup_summon_unselectable == true then
		state[MODIFIER_STATE_UNSELECTABLE] = true
	end
	if parent.levelup_summon_no_health_bar == true then
		state[MODIFIER_STATE_NO_HEALTH_BAR] = true
	end

	return state
end

function modifier_levelup_simple_summon_ai:OnCreated()
	local parent = self:GetParent()
	self.owner_player_id = parent.levelup_summon_owner_player_id
	self.goal_position = get_lane_goal_position(self.owner_player_id)
	self.search_radius = parent.levelup_summon_search_radius or 6000
	self.target_types = parent.levelup_summon_target_types or DOTA_UNIT_TARGET_BASIC
	self.target_flags = parent.levelup_summon_target_flags or DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE

	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
end

function modifier_levelup_simple_summon_ai:OnIntervalThink()
	local parent = self:GetParent()
	if not IsValid(parent) or not parent:IsAlive() then
		return
	end

	local target = nil
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		self.search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		self.target_types,
		self.target_flags,
		FIND_CLOSEST,
		false
	)
	if enemies and #enemies > 0 then
		target = enemies[1]
	end

	if target then
		if parent:GetAggroTarget() ~= target then
			parent:SetForceAttackTarget(target)
			parent:SetAggroTarget(target)
			parent:MoveToTargetToAttack(target)
		end
		return
	end

	if parent:GetAggroTarget() then
		parent:SetForceAttackTarget(nil)
		parent:SetAggroTarget(nil)
	end

	if
		self.goal_position
		and (parent:GetAbsOrigin() - self.goal_position):Length2D() > 150
		and GridNav:CanFindPath(parent:GetAbsOrigin(), self.goal_position)
	then
		parent:MoveToPositionAggressive(self.goal_position)
	end
end

function modifier_levelup_simple_summon_ai:GetModifierAttackRangeBonus()
	return self:GetParent().levelup_summon_attack_range_bonus or 0
end

function modifier_levelup_simple_summon_ai:GetModifierAttackSpeedPercentage()
	return self:GetParent().levelup_summon_attack_speed_pct or 0
end