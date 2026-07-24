--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_granite_aura", "neutrals/woda_neutral_granite_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_granite_aura_buff", "neutrals/woda_neutral_granite_aura", LUA_MODIFIER_MOTION_NONE)

woda_neutral_granite_aura = class({})

function woda_neutral_granite_aura:GetIntrinsicModifierName()
	return "modifier_woda_neutral_granite_aura"
end

modifier_woda_neutral_granite_aura = class({})

function modifier_woda_neutral_granite_aura:IsPurgable() return false end
function modifier_woda_neutral_granite_aura:IsHidden() return true end
function modifier_woda_neutral_granite_aura:IsAura() return true end
function modifier_woda_neutral_granite_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_woda_neutral_granite_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC end
function modifier_woda_neutral_granite_aura:GetModifierAura() return "modifier_woda_neutral_granite_aura_buff" end
function modifier_woda_neutral_granite_aura:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end

modifier_woda_neutral_granite_aura_buff = class({})

function modifier_woda_neutral_granite_aura_buff:IsPurgable() return false end

function modifier_woda_neutral_granite_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
	}
end

function modifier_woda_neutral_granite_aura_buff:GetModifierExtraHealthPercentage()
	return self:GetAbility():GetSpecialValueFor("health")
end