--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


custom_fountain_empower = custom_fountain_empower or class({})
LinkLuaModifier("modifier_custom_fountain_empower", "abilities/units/custom_fountain_empower", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_fountain_phasing_effect", "abilities/units/custom_fountain_empower", LUA_MODIFIER_MOTION_NONE)

function custom_fountain_empower:GetIntrinsicModifierName()
	return "modifier_custom_fountain_empower"
end

modifier_custom_fountain_empower = class({})

function modifier_custom_fountain_empower:IsAura()
	return true
end
function modifier_custom_fountain_empower:GetModifierAura()
	return "modifier_fountain_phasing_effect"
end
function modifier_custom_fountain_empower:IsHidden()
	return true
end
function modifier_custom_fountain_empower:IsPurgable()
	return false
end
function modifier_custom_fountain_empower:IsPurgeException()
	return false
end
function modifier_custom_fountain_empower:RemoveOnDeath()
	return false
end
function modifier_custom_fountain_empower:IsHidden()
	return false
end
function modifier_custom_fountain_empower:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_custom_fountain_empower:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP
end
function modifier_custom_fountain_empower:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_custom_fountain_empower:GetAuraRadius()
	return 1200
end

function modifier_custom_fountain_empower:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

modifier_fountain_phasing_effect = class({})

function modifier_fountain_phasing_effect:IsHidden()
	return true
end
function modifier_fountain_phasing_effect:IsPurgable()
	return false
end
function modifier_fountain_phasing_effect:IsPurgeException()
	return false
end
function modifier_fountain_phasing_effect:RemoveOnDeath()
	return false
end

function modifier_fountain_phasing_effect:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end