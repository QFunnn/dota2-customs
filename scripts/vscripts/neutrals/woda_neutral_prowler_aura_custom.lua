--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_prowler_aura_custom", "neutrals/woda_neutral_prowler_aura_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_prowler_aura_custom_buff", "neutrals/woda_neutral_prowler_aura_custom", LUA_MODIFIER_MOTION_NONE)

woda_neutral_prowler_aura_custom = class({})

function woda_neutral_prowler_aura_custom:GetIntrinsicModifierName()
    return "modifier_woda_neutral_prowler_aura_custom"
end

modifier_woda_neutral_prowler_aura_custom = class({})

function modifier_woda_neutral_prowler_aura_custom:IsPurgable() return false end
function modifier_woda_neutral_prowler_aura_custom:IsHidden() return true end
function modifier_woda_neutral_prowler_aura_custom:IsAura() return true end
function modifier_woda_neutral_prowler_aura_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_woda_neutral_prowler_aura_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_woda_neutral_prowler_aura_custom:GetModifierAura() return "modifier_woda_neutral_prowler_aura_custom_buff" end
function modifier_woda_neutral_prowler_aura_custom:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end

modifier_woda_neutral_prowler_aura_custom_buff = class({})
function modifier_woda_neutral_prowler_aura_custom_buff:IsPurgable() return false end

function modifier_woda_neutral_prowler_aura_custom_buff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL
	}
end

function modifier_woda_neutral_prowler_aura_custom_buff:GetModifierProperty_PhysicalLifesteal()
	return self:GetAbility():GetSpecialValueFor("lifesteal")
end