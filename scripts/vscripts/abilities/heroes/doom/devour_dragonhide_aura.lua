--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier ("modifier_devour_dragonhide_aura", "abilities/heroes/doom/devour_dragonhide_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier ("modifier_devour_dragonhide_aura_buff", "abilities/heroes/doom/devour_dragonhide_aura", LUA_MODIFIER_MOTION_NONE)

if devour_dragonhide_aura == nil then
    devour_dragonhide_aura = class({})
end

function devour_dragonhide_aura:GetIntrinsicModifierName()
    return "modifier_devour_dragonhide_aura"
end


------------------------------------------------------------------------------

modifier_devour_dragonhide_aura = modifier_devour_dragonhide_aura or class({
	IsHidden 				= function(self) return true end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	IsAura	                = function(self) return true end,
	RemoveOnDeath 			= function(self) return false end,
	AllowIllusionDuplicate	= function(self) return true end,
	IsPermanent             = function(self) return false end,
})

function modifier_devour_dragonhide_aura:OnCreated()
	local ability = self:GetAbility()
	if not ability then return end

	self.radius = ability:GetSpecialValueFor("radius")
end

function modifier_devour_dragonhide_aura:OnRefresh()
	self:OnCreated()
end

function modifier_devour_dragonhide_aura:GetModifierAura()
    return "modifier_devour_dragonhide_aura_buff"
end

function modifier_devour_dragonhide_aura:GetAuraRadius()
    return self.radius
end

function modifier_devour_dragonhide_aura:GetTexture()
    return "black_dragon_dragonhide_aura"
end

function modifier_devour_dragonhide_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_devour_dragonhide_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_devour_dragonhide_aura:GetAuraDuration()
    return 0.3
end

------------------------------------------------------------------------------

modifier_devour_dragonhide_aura_buff = modifier_devour_dragonhide_aura_buff or class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return true end,
	AllowIllusionDuplicate	= function(self) return true end,
	IsPermanent             = function(self) return false end,
})

function modifier_devour_dragonhide_aura_buff:GetTexture()
    return "black_dragon_dragonhide_aura"
end

function modifier_devour_dragonhide_aura_buff:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_devour_dragonhide_aura_buff:GetModifierPhysicalArmorBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_armor")
	else
		return 0
	end
end