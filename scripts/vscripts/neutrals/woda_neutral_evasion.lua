--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_evasion", "neutrals/woda_neutral_evasion", LUA_MODIFIER_MOTION_NONE)

woda_neutral_evasion = class({})

function woda_neutral_evasion:GetIntrinsicModifierName()
	return "modifier_woda_neutral_evasion"
end

modifier_woda_neutral_evasion = class({})
function modifier_woda_neutral_evasion:IsHidden() return true end
function modifier_woda_neutral_evasion:IsPurgable() return false end
function modifier_woda_neutral_evasion:IsPurgeException() return false end
function modifier_woda_neutral_evasion:RemoveOnDeath() return false end

function modifier_woda_neutral_evasion:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EVASION_CONSTANT
	}
end

function modifier_woda_neutral_evasion:GetModifierEvasion_Constant()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_evasion")
	end
end