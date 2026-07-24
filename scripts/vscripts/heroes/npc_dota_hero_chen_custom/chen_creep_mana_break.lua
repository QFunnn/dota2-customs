--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_chen_creep_mana_break", "heroes/npc_dota_hero_chen_custom/chen_creep_mana_break", LUA_MODIFIER_MOTION_NONE )

chen_creep_mana_break = class({})

function chen_creep_mana_break:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/generic_gameplay/generic_manaburn.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_manabreak_slow.vpcf', context )
end

function chen_creep_mana_break:GetIntrinsicModifierName()
	return "modifier_chen_creep_mana_break"
end

modifier_chen_creep_mana_break = class({})

function modifier_chen_creep_mana_break:IsHidden()
	return true
end

function modifier_chen_creep_mana_break:IsPurgable()
	return false
end

function modifier_chen_creep_mana_break:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_chen_creep_mana_break:GetModifierProcAttack_BonusDamage_Physical( params )
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	local target = params.target
	if not target then return end
	if target:GetMaxMana() == 0 then return end
	if target:IsMagicImmune() then return end
    if self:GetParent():GetUnitName() ~= "npc_dota_hero_rubick" then
        if not self:GetParent():HasModifier("modifier_chen_8") then return end
    end
	local mana_per_hit = self:GetAbility():GetSpecialValueFor("mana_per_hit")
	local illusion_percentage = self:GetAbility():GetSpecialValueFor("illusion_percentage")
	local percent_damage_per_burn = self:GetAbility():GetSpecialValueFor("percent_damage_per_burn")

	local reduce_mana_full = mana_per_hit

	if self:GetParent():IsIllusion() then
		reduce_mana_full = mana_per_hit / 100 * illusion_percentage
	end

	local mana_burn =  math.min( target:GetMana(), reduce_mana_full )
	target:Script_ReduceMana(mana_burn, self:GetAbility()) 

	local particle = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN, target )
	ParticleManager:ReleaseParticleIndex( particle )

	target:EmitSound("Hero_Antimage.ManaBreak")

	return mana_burn / 100 * percent_damage_per_burn
end