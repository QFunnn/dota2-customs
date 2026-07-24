--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier ("modifier_devour_heal_amp_aura", "abilities/heroes/doom/devour_heal_amp_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier ("modifier_devour_heal_amp_aura_buff", "abilities/heroes/doom/devour_heal_amp_aura", LUA_MODIFIER_MOTION_NONE)

if devour_heal_amp_aura == nil then
    devour_heal_amp_aura = class({})
end

function devour_heal_amp_aura:GetIntrinsicModifierName()
    return "modifier_devour_heal_amp_aura"
end


------------------------------------------------------------------------------

modifier_devour_heal_amp_aura = modifier_devour_heal_amp_aura or class({
	IsHidden 				= function(self) return true end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	IsAura	                = function(self) return true end,
	RemoveOnDeath 			= function(self) return false end,
	AllowIllusionDuplicate	= function(self) return true end,
	IsPermanent             = function(self) return false end,
})

function modifier_devour_heal_amp_aura:OnCreated()
	local ability = self:GetAbility()
	if not ability then return end

	self.radius = ability:GetSpecialValueFor("radius")
end

function modifier_devour_heal_amp_aura:OnRefresh()
	self:OnCreated()
end

function modifier_devour_heal_amp_aura:GetModifierAura()
    return "modifier_devour_heal_amp_aura_buff"
end

function modifier_devour_heal_amp_aura:GetAuraRadius()
    return self.radius
end

function modifier_devour_heal_amp_aura:GetTexture()
    return "forest_troll_high_priest_heal_amp_aura"
end

function modifier_devour_heal_amp_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_devour_heal_amp_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_devour_heal_amp_aura:GetAuraDuration()
    return 0.3
end

------------------------------------------------------------------------------

modifier_devour_heal_amp_aura_buff = modifier_devour_heal_amp_aura_buff or class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return true end,
	AllowIllusionDuplicate	= function(self) return true end,
	IsPermanent             = function(self) return false end,
})

function modifier_devour_heal_amp_aura_buff:GetTexture()
    return "forest_troll_high_priest_heal_amp_aura"
end

function modifier_devour_heal_amp_aura_buff:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE,
	}
	return funcs
end

function modifier_devour_heal_amp_aura_buff:GetModifierHealAmplify_PercentageSource()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("heal_amp")
	else
		return 0
	end
end