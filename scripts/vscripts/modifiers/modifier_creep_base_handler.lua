--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_creep_base_handler = class({})

local DEFAULT_MAIN_BUILDING_DAMAGE_PCT = 3

local MAIN_BUILDING_DAMAGE_PCT_BY_UNIT = {
	npc_levelup_wave_boss = 15,
}

function modifier_creep_base_handler:IsHidden()
	return true
end
function modifier_creep_base_handler:IsPurgable()
	return false
end
function modifier_creep_base_handler:IsPurgeException()
	return false
end
function modifier_creep_base_handler:RemoveOnDeath()
	return false
end
function modifier_creep_base_handler:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end
function modifier_creep_base_handler:GetModifierIncomingDamage_Percentage(params)
	return -10000
end

local function get_main_building_attack_damage(attacker, target)
	if not IsValid(attacker, target) then
		return 0
	end
	if target:GetUnitName() ~= "npc_levelup_main_building" then
		return 0
	end

	local damage_pct = MAIN_BUILDING_DAMAGE_PCT_BY_UNIT[attacker:GetUnitName()] or DEFAULT_MAIN_BUILDING_DAMAGE_PCT
	local max_health = target._levelup_max_health or 0
	if max_health <= 0 or damage_pct <= 0 then
		return 0
	end

	return math.floor(max_health * damage_pct * 0.01 + 0.5)
end

local function find_assistant_secondary_targets(parent, origin, main_target, radius, max_targets)
	if not IsValid(parent, main_target) or max_targets <= 0 or radius <= 0 then
		return {}
	end

	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_CLOSEST,
		false
	)

	local targets = {}
	local main_entindex = main_target:entindex()
	for _, enemy in ipairs(enemies or {}) do
		if
			enemy:entindex() ~= main_entindex
			and IsValid(enemy)
			and enemy:IsAlive()
			and enemy._levelup_current_health
			and enemy:GetTeamNumber() ~= parent:GetTeamNumber()
			and enemy:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS
		then
			table.insert(targets, enemy)
			if #targets >= max_targets then
				break
			end
		end
	end
	return targets
end

local function launch_assistant_attack_projectile(parent, source_loc, target, damage, fx_tag)
	if not IsValid(parent, target) or (tonumber(damage) or 0) <= 0 then
		return
	end

	local ability = parent.FindAbilityByName and parent:FindAbilityByName("levelup_assistant_special_handler") or nil
	local projectile_name = (parent.GetRangedProjectileName and parent:GetRangedProjectileName()) or ""

	if IsValid(ability) and projectile_name ~= "" then
		ProjectileManager:CreateTrackingProjectile({
			Target = target,
			vSourceLoc = source_loc or parent:GetAbsOrigin(),
			Ability = ability,
			EffectName = projectile_name,
			iMoveSpeed = (parent.GetProjectileSpeed and parent:GetProjectileSpeed()) or 1000,
			bDodgeable = false,
			bIsAttack = false,
			bVisibleToEnemies = true,
			bProvidesVision = false,
			ExtraData = {
				assistant_attack_projectile = 1,
				damage = damage,
			},
		})
	else
		ApplyDamage(
			{
				victim = target,
				attacker = parent,
				ability = nil,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_kind = "physical_attack",
			},
			fx_tag or "assistant_attack_projectile"
		)
	end
end

local function roll_assistant_base_damage(parent)
	local min_damage = tonumber(parent._levelup_custom_attack_damage_min) or 0
	local max_damage = tonumber(parent._levelup_custom_attack_damage_max) or min_damage
	return RandomInt(math.floor(min_damage), math.max(math.floor(min_damage), math.floor(max_damage)))
end

function modifier_creep_base_handler:OnAttack(params)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if params.attacker ~= parent then
		return
	end
	if not IsValid(parent) then
		return
	end
	if not (IsLevelUpAssistant and IsLevelUpAssistant(parent)) then
		return
	end
	if parent:GetAttackCapability() == DOTA_UNIT_CAP_NO_ATTACK then
		return
	end

	local target = params.target
	if not IsValid(target) or not target:IsAlive() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end

	local extra_attacks = math.floor(tonumber(parent.levelup_assistant_extra_attacks) or 0)
	if extra_attacks <= 0 then
		return
	end

	local attack_range = (parent.Script_GetAttackRange and parent:Script_GetAttackRange()) or 500
	local extra_targets =
		find_assistant_secondary_targets(parent, parent:GetAbsOrigin(), target, attack_range + 50, extra_attacks)
	for _, extra_target in ipairs(extra_targets) do
		local damage = roll_assistant_base_damage(parent)
		if damage > 0 then
			launch_assistant_attack_projectile(
				parent,
				parent:GetAbsOrigin(),
				extra_target,
				damage,
				"assistant_extra_attack"
			)
		end
	end
end

function modifier_creep_base_handler:OnAttackLanded(params)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if params.attacker ~= parent then
		return
	end
	if not IsValid(parent) then
		return
	end
	if parent:IsRealHero() then
		return
	end
	if parent:GetAttackCapability() == DOTA_UNIT_CAP_NO_ATTACK then
		return
	end

	local target = params.target
	if not IsValid(target) or not target:IsAlive() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if not target._levelup_current_health then
		return
	end

	local attack_damage = get_main_building_attack_damage(parent, target)
	if attack_damage <= 0 then
		local min_damage = tonumber(parent._levelup_custom_attack_damage_min) or 0
		local max_damage = tonumber(parent._levelup_custom_attack_damage_max) or min_damage
		attack_damage = RandomInt(math.floor(min_damage), math.max(math.floor(min_damage), math.floor(max_damage)))
	end
	if attack_damage <= 0 then
		return
	end

	ApplyDamage(
		{
			victim = target,
			attacker = parent,
			ability = nil,
			damage = attack_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_kind = "physical_attack",
		},
		"creep_attack"
	)

	if IsLevelUpAssistant and IsLevelUpAssistant(parent) then
		local bounce_count = math.floor(tonumber(parent.levelup_assistant_bounce_count) or 0)
		if bounce_count > 0 then
			local bounce_origin = target:GetAbsOrigin()
			local bounce_targets = find_assistant_secondary_targets(parent, bounce_origin, target, 500, bounce_count)
			for _, bounce_target in ipairs(bounce_targets) do
				launch_assistant_attack_projectile(
					parent,
					bounce_origin,
					bounce_target,
					attack_damage,
					"assistant_bounce"
				)
			end
		end
	end
end

function modifier_creep_base_handler:OnLevelUpCustomIncomingDamage(damage, event)
	if not IsServer() then
		return damage
	end
	if event and IsValid(event.attacker, self:GetParent()) and self:GetParent()._roshpit_spawn ~= nil then
		local Distance = (self:GetParent()._roshpit_spawn - event.attacker:GetAbsOrigin()):Length2D()
		if Distance > 900 then
			return 0
		end
	end
	return damage
end