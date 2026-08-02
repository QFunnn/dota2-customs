--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_levelup_lane_tower_handler", "abilities/levelup_lane_tower_handler", LUA_MODIFIER_MOTION_NONE)

levelup_lane_tower_handler = class({})

function levelup_lane_tower_handler:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_lane_tower_handler:GetIntrinsicModifierName()
	return "modifier_levelup_lane_tower_handler"
end

function levelup_lane_tower_handler:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end

	local caster = self:GetCaster()
	if not IsValid(caster) or not IsValid(target) then
		return true
	end
	if target:IsInvulnerable() or target:IsAttackImmune() or not target:IsAlive() then
		return true
	end
	EmitSoundOn("Tower.Fire.ProjectileImpact", target)
	ApplyDamage(
		{
			victim = target,
			attacker = caster,
			ability = self,
			damage = extra_data.damage or 0,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_kind = "physical_attack",
		},
		"lane_tower_attack"
	)
	return true
end

modifier_levelup_lane_tower_handler = class({})

function modifier_levelup_lane_tower_handler:IsHidden()
	return true
end
function modifier_levelup_lane_tower_handler:IsPurgable()
	return false
end
function modifier_levelup_lane_tower_handler:RemoveOnDeath()
	return false
end

function modifier_levelup_lane_tower_handler:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.next_attack_time = 0
	self.pending_attack = false

	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.1)
end

function modifier_levelup_lane_tower_handler:FindAttackTarget()
	local parent = self.parent
	if not IsValid(parent) then
		return nil
	end

	local attack_range = self.ability:GetSpecialValueFor("attack_range")
	local targets = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		attack_range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_CLOSEST,
		false
	)

	for _, target in ipairs(targets) do
		if IsValid(target) then
			return target
		end
	end

	return nil
end

function modifier_levelup_lane_tower_handler:LaunchProjectile(target)
	local parent = self.parent
	local ability = self.ability
	if not IsValid(parent) or not IsValid(ability) or not IsValid(target) then
		return
	end

	local min_damage = tonumber(parent._levelup_custom_attack_damage_min) or 0
	local max_damage = tonumber(parent._levelup_custom_attack_damage_max) or min_damage

	ProjectileManager:CreateTrackingProjectile({
		Target = target,
		Source = parent,
		Ability = ability,
		EffectName = "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_cyan_attack.vpcf",
		iMoveSpeed = ability:GetSpecialValueFor("projectile_speed"),
		bDodgeable = false,
		bProvidesVision = false,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		ExtraData = {
			damage = RandomInt(min_damage, max_damage),
		},
	})

	EmitSoundOn("Tower.Fire.Attack", parent)
end

function modifier_levelup_lane_tower_handler:OnIntervalThink()
	if not IsServer() then
		return
	end

	local parent = self.parent
	local ability = self.ability
	if not IsValid(parent) or not IsValid(ability) then
		return
	end
	if not parent:IsAlive() or parent:IsStunned() then
		return
	end
	if self.pending_attack then
		return
	end

	local fixed_forward = parent._levelup_fixed_forward
	if fixed_forward then
		parent:SetForwardVector(fixed_forward)
	end

	local now = GameRules:GetGameTime()
	if now < (self.next_attack_time or 0) then
		return
	end

	local target = self:FindAttackTarget()
	if not IsValid(target) then
		return
	end

	parent:StartGesture(ACT_DOTA_ATTACK)
	self.pending_attack = true
	self.next_attack_time = now + math.max(0.5, self.ability:GetSpecialValueFor("attack_interval"))

	Timers:CreateTimer(0.5, function()
		if not self or self:IsNull() then
			return nil
		end

		self.pending_attack = false
		if not IsValid(parent) or not parent:IsAlive() or parent:IsStunned() then
			return nil
		end
		if not IsValid(target) or target:IsInvulnerable() or target:IsAttackImmune() or not target:IsAlive() then
			return nil
		end

		self:LaunchProjectile(target)
		return nil
	end)
end