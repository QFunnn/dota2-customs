--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_frost_attack", "neutrals/woda_neutral_frost_attack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_frost_attack_debuff", "neutrals/woda_neutral_frost_attack", LUA_MODIFIER_MOTION_NONE)

woda_neutral_frost_attack = class({})

function woda_neutral_frost_attack:GetIntrinsicModifierName()
	return "modifier_woda_neutral_frost_attack"
end

function woda_neutral_frost_attack:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/drow/drow_arcana/drow_arcana_status_effect_frost_arrow.vpcf", context )
end

modifier_woda_neutral_frost_attack = class({})

function modifier_woda_neutral_frost_attack:IsPurgable() return false end
function modifier_woda_neutral_frost_attack:IsHidden() return true end

function modifier_woda_neutral_frost_attack:DeclareFunctions()
	return 
	{
		 
	}
end

function modifier_woda_neutral_frost_attack:OnCreated()
	if not IsServer() then return end
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_woda_neutral_frost_attack:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target:IsMagicImmune() then return end
	params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_woda_neutral_frost_attack_debuff", {duration = self.duration * (1 - params.target:GetStatusResistance())})
end

modifier_woda_neutral_frost_attack_debuff = class({})

function modifier_woda_neutral_frost_attack_debuff:IsPurgable() return false end

function modifier_woda_neutral_frost_attack_debuff:OnCreated()
	self.movement_speed = self:GetAbility():GetSpecialValueFor("movement_speed")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")
end

function modifier_woda_neutral_frost_attack_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_woda_neutral_frost_attack_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.movement_speed
end

function modifier_woda_neutral_frost_attack_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.attack_speed
end

function modifier_woda_neutral_frost_attack_debuff:GetEffectName()
	return "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf"
end

function modifier_woda_neutral_frost_attack_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_woda_neutral_frost_attack_debuff:GetStatusEffectName()
	return "particles/econ/items/drow/drow_arcana/drow_arcana_status_effect_frost_arrow.vpcf"
end

function modifier_woda_neutral_frost_attack_debuff:StatusEffectPriority()
	return 10
end