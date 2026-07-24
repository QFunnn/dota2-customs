--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_skadi", "neutrals/woda_neutral_skadi", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_skadi_debuff", "neutrals/woda_neutral_skadi", LUA_MODIFIER_MOTION_NONE)

woda_neutral_skadi = class({})

function woda_neutral_skadi:GetIntrinsicModifierName()
	return "modifier_woda_neutral_skadi"
end

modifier_woda_neutral_skadi = class({})
function modifier_woda_neutral_skadi:IsHidden() return true end
function modifier_woda_neutral_skadi:IsPurgable() return false end
function modifier_woda_neutral_skadi:IsPurgeException() return false end
function modifier_woda_neutral_skadi:RemoveOnDeath() return false end

function modifier_woda_neutral_skadi:DeclareFunctions()
	return
	{
		 
	}
end

function modifier_woda_neutral_skadi:OnAttackLanded(params)
	if not IsServer() then return end
	if params.target == self:GetParent() then return end
	if params.attacker ~= self:GetParent() then return end
	params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_woda_neutral_skadi_debuff", {duration = self:GetAbility():GetSpecialValueFor("duration") * (1-params.target:GetStatusResistance())})
end

modifier_woda_neutral_skadi_debuff = class({})

function modifier_woda_neutral_skadi_debuff:OnCreated()
	self.reduce = self:GetAbility():GetSpecialValueFor("heal_reduce")
end

function modifier_woda_neutral_skadi_debuff:GetTexture()
	return "woda_neutral_skadi"
end

function modifier_woda_neutral_skadi_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end

function modifier_woda_neutral_skadi_debuff:GetModifierPropertyRestorationAmplification()
	return self.reduce
end

function modifier_woda_neutral_skadi_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_woda_neutral_skadi_debuff:StatusEffectPriority()
    return 10
end