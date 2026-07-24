--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_rally", "neutrals/woda_neutral_rally", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_rally_buff", "neutrals/woda_neutral_rally", LUA_MODIFIER_MOTION_NONE)

woda_neutral_rally = class({})

function woda_neutral_rally:GetIntrinsicModifierName()
	return "modifier_woda_neutral_rally"
end

modifier_woda_neutral_rally = class({})

function modifier_woda_neutral_rally:IsPurgable() return false end
function modifier_woda_neutral_rally:IsHidden() return true end
function modifier_woda_neutral_rally:IsAura() return true end
function modifier_woda_neutral_rally:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_woda_neutral_rally:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC end
function modifier_woda_neutral_rally:GetModifierAura() return "modifier_woda_neutral_rally_buff" end
function modifier_woda_neutral_rally:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end

modifier_woda_neutral_rally_buff = class({})

function modifier_woda_neutral_rally_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_woda_neutral_rally_buff:IsPurgable() return false end

function modifier_woda_neutral_rally_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
	}
end

function modifier_woda_neutral_rally_buff:GetModifierDamageOutgoing_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end