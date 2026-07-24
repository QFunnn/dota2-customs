--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_faceless_void_time_lock_custom_handle", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_time_lock_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_faceless_void_time_lock_custom_stun", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_time_lock_custom", LUA_MODIFIER_MOTION_NONE )
faceless_void_time_lock_custom = class({})
faceless_void_time_lock_custom.modifier_faceless_void_13 = {3,6}
faceless_void_time_lock_custom.modifier_faceless_void_18 = {40,60,80}

function faceless_void_time_lock_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_faceless_void_13") then
        return "faceless_void_13"
    end
    return "faceless_void_time_lock"
end

function faceless_void_time_lock_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf", context)
end

function faceless_void_time_lock_custom:GetIntrinsicModifierName()
	return "modifier_faceless_void_time_lock_custom_handle"
end

function faceless_void_time_lock_custom:TimeLock(target, forse, IgnoteStatus, loc_reverse)
	if not target:IsAlive() then return end
	if target:IsInvulnerable() then return end
    local chance = self:GetSpecialValueFor("chance_pct")
    if self:GetCaster():HasModifier("modifier_faceless_void_13") and self:GetCaster():IsSilenced() then
        chance = chance + self.modifier_faceless_void_13[self:GetCaster():GetTalentLevel("modifier_faceless_void_13")]
    end
	if forse or RollPseudoRandomPercentage(chance, DOTA_PSEUDO_RANDOM_FACELESS_BASH, self:GetCaster()) then
		local caster = self:GetCaster()
		EmitSoundOn("Hero_FacelessVoid.TimeLockImpact", target)
		local nFX = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf", PATTACH_ABSORIGIN, caster)
		ParticleManager:SetParticleControl(nFX, 0, target:GetAbsOrigin() )
		ParticleManager:SetParticleControl(nFX, 1, target:GetAbsOrigin() )
		ParticleManager:SetParticleControlEnt(nFX, 2, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(nFX, 4, target:GetAbsOrigin() )
		ParticleManager:SetParticleControl(nFX, 5, Vector(1,1,1) )
		ParticleManager:ReleaseParticleIndex(nFX)
		local duration = self:GetSpecialValueFor("duration")
		if not IgnoteStatus then
			duration = duration * (1 - target:GetStatusResistance())
		end
        target:AddNewModifier(caster, self, "modifier_faceless_void_time_lock_custom_stun", {duration = duration})
		local delay = self:GetSpecialValueFor("delay")
		Timers:CreateTimer(delay, function()
			target.set_in_bash = false
			self:GetCaster().proc_bush = true
			self:GetCaster().loc_reverse = loc_reverse
			if IgnoteStatus then
				self:GetCaster().IgnoteStatus = true
			end
			self:GetCaster():PerformAttack(target, true, true, true, true, false, false, true)
            local damage = self:GetSpecialValueFor("bonus_damage")
            if self:GetCaster():HasModifier("modifier_faceless_void_18") then
                damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_faceless_void_18[self:GetCaster():GetTalentLevel("modifier_faceless_void_18")])
            end
            ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
			self:GetCaster().proc_bush = false
			self:GetCaster().IgnoteStatus = false
			self:GetCaster().loc_reverse = false
		end)
	end
end

function faceless_void_time_lock_custom:TimeLock_visual(position)		
	local nFX = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(nFX, 0, position )
	ParticleManager:SetParticleControl(nFX, 1, position )
	ParticleManager:SetParticleControlEnt(nFX, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(nFX, 4, position )
	ParticleManager:SetParticleControl(nFX, 5, Vector(1,1,1) )
	ParticleManager:ReleaseParticleIndex(nFX)
end

modifier_faceless_void_time_lock_custom_handle = class({}) 
function modifier_faceless_void_time_lock_custom_handle:IsPurgable()  return false end
function modifier_faceless_void_time_lock_custom_handle:IsDebuff()    return false end
function modifier_faceless_void_time_lock_custom_handle:IsHidden()    return true end
function modifier_faceless_void_time_lock_custom_handle:OnAttackLanded(params)
	if params.attacker == self:GetParent() then
		if self:GetParent():PassivesDisabled() then return end
		if params.target:IsBuilding() then return end
        if self:GetParent():IsIllusion() then return end
		if self:GetParent():GetTeamNumber() == params.target:GetTeamNumber() then return end
		self:GetAbility():TimeLock(params.target, false, self:GetParent().IgnoteStatus)
	end
end

modifier_faceless_void_time_lock_custom_stun = class({})

function modifier_faceless_void_time_lock_custom_stun:IsHidden()
	return false
end

function modifier_faceless_void_time_lock_custom_stun:IsDebuff()
	return true
end

function modifier_faceless_void_time_lock_custom_stun:IsPurgable()
	return false
end

function modifier_faceless_void_time_lock_custom_stun:IsPurgeException()
	return true
end

function modifier_faceless_void_time_lock_custom_stun:IsStunDebuff()
	return true
end

function modifier_faceless_void_time_lock_custom_stun:RemoveOnDeath()
	return true
end

function modifier_faceless_void_time_lock_custom_stun:DestroyOnExpire()
	return true
end

function modifier_faceless_void_time_lock_custom_stun:CheckState()
	return 
    {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_faceless_void_time_lock_custom_stun:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_faceless_void_time_lock_custom_stun:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

function modifier_faceless_void_time_lock_custom_stun:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_faceless_void_time_lock_custom_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end