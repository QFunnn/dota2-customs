--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spectre_desolate_custom", "abilities/spectre_desolate_custom", LUA_MODIFIER_MOTION_NONE )

spectre_desolate_custom = class({})

function spectre_desolate_custom:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spectre.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_desolate.vpcf", context )
end

function spectre_desolate_custom:GetIntrinsicModifierName()
	return "modifier_spectre_desolate_custom"
end

modifier_spectre_desolate_custom = class({})

function modifier_spectre_desolate_custom:IsHidden()
	return true
end

function modifier_spectre_desolate_custom:IsPurgable()
	return false
end

function modifier_spectre_desolate_custom:OnCreated( kv )
	self.parent = self:GetParent()
	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
end

function modifier_spectre_desolate_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_spectre_desolate_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_spectre_desolate_custom:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor( "attack_speed" )
end

function modifier_spectre_desolate_custom:AttackModifier( params )
	if params.attacker~=self.parent then return end
	if self.parent:PassivesDisabled() then return end
	local bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
    if not params.target:IsHero() then
        bonus = bonus * self:GetAbility():GetSpecialValueFor("creep_multiplier")
    end
	local damageTable =
	{
		victim = params.target,
		attacker = self:GetParent(),
		damage = bonus,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(),
	}
    params.target:EmitSound("Hero_Spectre.Desolate")
	ApplyDamage(damageTable)
end