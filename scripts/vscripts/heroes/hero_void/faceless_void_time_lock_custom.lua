--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_faceless_void_time_lock_custom", "heroes/hero_void/faceless_void_time_lock_custom", LUA_MODIFIER_MOTION_NONE )

faceless_void_time_lock_custom = class({})

function faceless_void_time_lock_custom:GetIntrinsicModifierName()
	return "modifier_faceless_void_time_lock_custom"
end

modifier_faceless_void_time_lock_custom = class({})

function modifier_faceless_void_time_lock_custom:IsPurgable()			return false end
function modifier_faceless_void_time_lock_custom:IsDebuff()			return false end
function modifier_faceless_void_time_lock_custom:IsHidden()			return true end

function modifier_faceless_void_time_lock_custom:OnCreated()
	if IsServer() then
		self:GetParent().bCanTriggerLock=false
	end
end

function modifier_faceless_void_time_lock_custom:AttackLandedModifier(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if self:GetParent():PassivesDisabled() then return end
	if self:GetParent():IsIllusion() then return end

	if self:GetParent().bCanTriggerLock == false then
		if params.no_attack_cooldown then return end
	end

	local target = params.target

	if not target:IsNull() and target:IsAlive() then
		local duration = self:GetAbility():GetSpecialValueFor("duration")
		local duration_creep = self:GetAbility():GetSpecialValueFor("duration_creep")
		local chance_pct = self:GetAbility():GetSpecialValueFor("chance_pct")
		local bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
		local delay = self:GetAbility():GetSpecialValueFor("delay")

		if not target:IsHero() then
			duration = duration_creep
		end

		if RollPercentage(chance_pct) and self:GetParent().bCanTriggerLock == false then
			target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_stunned", {duration = duration * (1 - target:GetStatusResistance())})
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() )
			ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() )
			ParticleManager:SetParticleControlEnt(particle, 2, self:GetParent(), PATTACH_CUSTOMORIGIN, "attach_hitloc", target:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
			Timers:CreateTimer(delay, function()
				self:GetParent().bCanTriggerLock=true
				self:GetParent():PerformAttack(target, true, true, true, false, false, false, false)
				self:GetParent().bCanTriggerLock=false
				target:EmitSound("Hero_FacelessVoid.TimeLockImpact")
				local damage_table = {}
	            damage_table.owner = self:GetParent()
	            damage_table.victim = target
	            damage_table.damage_type = self:GetAbility():GetAbilityDamageType()
	            damage_table.ability = self:GetAbility()
	            damage_table.damage = bonus_damage
	            ApplyDamage(damage_table)
			end)
		end
	end
end

modifier_faceless_void_time_lock_custom_scepter = class({})

function modifier_faceless_void_time_lock_custom_scepter:IsHidden() return true end
function modifier_faceless_void_time_lock_custom_scepter:IsPurgable() return false end

function modifier_faceless_void_time_lock_custom_scepter:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_faceless_void_time_lock_custom_scepter:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetParent():HasModifier("modifier_faceless_void_time_walk") then
		self:Destroy()
	end
end

function modifier_faceless_void_time_lock_custom_scepter:OnDestroy()
	if not IsServer() then return end
	if self:GetParent().bCanTriggerLock == true then return end
	local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, 400, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_ANY_ORDER, false)
	for _, target in pairs(enemies) do
		local duration = self:GetAbility():GetSpecialValueFor("duration")
		local duration_creep = self:GetAbility():GetSpecialValueFor("duration_creep")
		local chance_pct = self:GetAbility():GetSpecialValueFor("chance_pct")
		local bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
		local delay = self:GetAbility():GetSpecialValueFor("delay")
		local parent = self:GetParent()
		local ability = self:GetAbility()

		if not target:IsHero() then
			duration = duration_creep
		end

		target:AddNewModifier(parent, self:GetAbility(), "modifier_stunned", {duration = duration * (1 - target:GetStatusResistance()) })
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() )
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin() )
		ParticleManager:SetParticleControlEnt(particle, 2, parent, PATTACH_CUSTOMORIGIN, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(particle)
		Timers:CreateTimer(delay, function()
			parent.bCanTriggerLock=true
			parent.void_scepter = true
			parent:PerformAttack(target, true, true, true, false, false, false, false)
			parent.void_scepter = false
			parent.bCanTriggerLock=false
			target:EmitSound("Hero_FacelessVoid.TimeLockImpact")
			local damage_table = {}
            damage_table.owner = parent
            damage_table.victim = target
            damage_table.damage_type = ability:GetAbilityDamageType()
            damage_table.ability = ability
            damage_table.damage = bonus_damage
            ApplyDamage(damage_table)
		end)
	end
end