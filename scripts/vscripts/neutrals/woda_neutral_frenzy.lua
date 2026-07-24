--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_frenzy", "neutrals/woda_neutral_frenzy", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_frenzy_buff", "neutrals/woda_neutral_frenzy", LUA_MODIFIER_MOTION_NONE)

woda_neutral_frenzy = class({})

function woda_neutral_frenzy:GetIntrinsicModifierName()
	return "modifier_woda_neutral_frenzy"
end

modifier_woda_neutral_frenzy = class({})

function modifier_woda_neutral_frenzy:IsPurgable() return false end
function modifier_woda_neutral_frenzy:IsHidden() return true end
function modifier_woda_neutral_frenzy:IsAura() return true end
function modifier_woda_neutral_frenzy:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_woda_neutral_frenzy:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC end
function modifier_woda_neutral_frenzy:GetModifierAura() return "modifier_woda_neutral_frenzy_buff" end
function modifier_woda_neutral_frenzy:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end

modifier_woda_neutral_frenzy_buff = class({})

function modifier_woda_neutral_frenzy_buff:IsPurgable() return false end

function modifier_woda_neutral_frenzy_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_woda_neutral_frenzy_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("attack_speed")
end