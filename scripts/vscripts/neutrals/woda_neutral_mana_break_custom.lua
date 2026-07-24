--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_woda_neutral_mana_break_custom", "neutrals/woda_neutral_mana_break_custom", LUA_MODIFIER_MOTION_NONE )

woda_neutral_mana_break_custom = class({})

function woda_neutral_mana_break_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/generic_gameplay/generic_manaburn.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_manabreak_slow.vpcf', context )
end

function woda_neutral_mana_break_custom:GetIntrinsicModifierName()
	return "modifier_woda_neutral_mana_break_custom"
end

modifier_woda_neutral_mana_break_custom = class({})

function modifier_woda_neutral_mana_break_custom:IsHidden()
	return true
end

function modifier_woda_neutral_mana_break_custom:IsPurgable()
	return false
end

function modifier_woda_neutral_mana_break_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_woda_neutral_mana_break_custom:GetModifierProcAttack_BonusDamage_Physical( params )
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	local target = params.target
	if not target then return end
	if target:GetMaxMana() == 0 then return end
	if target:IsMagicImmune() then return end
	local mana_per_hit = self:GetAbility():GetSpecialValueFor("mana_per_hit")
	local illusion_percentage = self:GetAbility():GetSpecialValueFor("illusion_percentage")
	local percent_damage_per_burn = self:GetAbility():GetSpecialValueFor("percent_damage_per_burn")
	local reduce_mana_full = target:GetMaxMana() / 100 * mana_per_hit
	local mana_burn =  math.min( target:GetMana(), reduce_mana_full )
	target:Script_ReduceMana(mana_burn, self:GetAbility()) 
	local particle = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN, target )
	ParticleManager:ReleaseParticleIndex( particle )
	target:EmitSound("Hero_Antimage.ManaBreak")
	return mana_burn / 100 * percent_damage_per_burn
end