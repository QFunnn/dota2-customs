--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


enigma_malefice_custom = class({})
LinkLuaModifier("modifier_enigma_malefice_custom", "abilities/heroes/enigma/enigma_malefice.lua", LUA_MODIFIER_MOTION_NONE)

function enigma_malefice_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not caster or caster:IsNull() then return end
	if not target or target:IsNull() then return end

	if target:TriggerSpellAbsorb( self ) then return end

	local stun_instances = self:GetSpecialValueFor("stun_instances")
	local tick_rate = self:GetSpecialValueFor("tick_rate")
	local duration = tick_rate * (stun_instances - 1)	-- first stun instance is immediate

	target:AddNewModifier(caster, self, "modifier_enigma_malefice_custom", { duration = duration })
	EmitSoundOn( "Hero_Enigma.Malefice", target )
end


--------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_enigma_malefice_custom = class({})

function modifier_enigma_malefice_custom:IsHidden() return false end
function modifier_enigma_malefice_custom:IsDebuff() return true end
function modifier_enigma_malefice_custom:IsStunDebuff() return false end
function modifier_enigma_malefice_custom:IsPurgable() return true end

function modifier_enigma_malefice_custom:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	
	if not self.caster or self.caster:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end
	
	self.tick_rate = self.ability:GetSpecialValueFor( "tick_rate" )
	self.damage = self.ability:GetSpecialValueFor( "damage" )
	self.stun_duration = self.ability:GetSpecialValueFor( "stun_duration" )
	
	if not IsServer() then return end

	self.damage_table = {
		victim = self.parent,
		attacker = self.caster,
		damage = self.damage,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}

	self:StartIntervalThink(self.tick_rate)
	self:OnIntervalThink()
end

function modifier_enigma_malefice_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_enigma_malefice_custom:OnIntervalThink()
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_stunned", { duration = self.stun_duration })
	ApplyDamage( self.damage_table )
	EmitSoundOn( "Hero_Enigma.MaleficeTick", self:GetParent() )
	if not self.caster:HasShard() then return end
	local eidolon_ability = self.caster:FindAbilityByName("enigma_demonic_conversion_custom")
	if not eidolon_ability or eidolon_ability:GetLevel() <= 0 then return end
	local unit_name = eidolon_ability.spawn_unit_name[eidolon_ability:GetLevel()]
	local duration = eidolon_ability:GetDuration()
	eidolon_ability:SpawnEidolons(unit_name, self.parent:GetAbsOrigin(), self.caster, 1, duration, false, true)
end

function modifier_enigma_malefice_custom:GetEffectName()
	return "particles/units/heroes/hero_enigma/enigma_malefice.vpcf"
end

function modifier_enigma_malefice_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_enigma_malefice_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_enigma_malefice.vpcf"
end

function modifier_enigma_malefice_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_enigma_malefice_custom:OnTooltip()
	return self.damage
end

function modifier_enigma_malefice_custom:OnTooltip2()
	return self.stun_duration
end