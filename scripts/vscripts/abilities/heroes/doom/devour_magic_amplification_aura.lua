--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier ("modifier_devour_magic_amplification_aura", "abilities/heroes/doom/devour_magic_amplification_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier ("modifier_devour_magic_amplification_aura_debuff", "abilities/heroes/doom/devour_magic_amplification_aura", LUA_MODIFIER_MOTION_NONE)

if devour_magic_amplification_aura == nil then
    devour_magic_amplification_aura = class({})
end

function devour_magic_amplification_aura:GetIntrinsicModifierName()
    return "modifier_devour_magic_amplification_aura"
end


------------------------------------------------------------------------------

modifier_devour_magic_amplification_aura = modifier_devour_magic_amplification_aura or class({
	IsHidden 				= function(self) return true end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	IsAura	                = function(self) return true end,
	RemoveOnDeath 			= function(self) return false end,
	AllowIllusionDuplicate	= function(self) return true end,
	IsPermanent             = function(self) return false end,
})

function modifier_devour_magic_amplification_aura:OnCreated()
	local ability = self:GetAbility()
	if not ability then return end

	self.radius = ability:GetSpecialValueFor("radius")
end

function modifier_devour_magic_amplification_aura:OnRefresh()
	self:OnCreated()
end

function modifier_devour_magic_amplification_aura:GetModifierAura()
    return "modifier_devour_magic_amplification_aura_debuff"
end

function modifier_devour_magic_amplification_aura:GetAuraRadius()
    return self.radius
end

function modifier_devour_magic_amplification_aura:GetTexture()
    return "black_drake_magic_amplification_aura"
end

function modifier_devour_magic_amplification_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_devour_magic_amplification_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_devour_magic_amplification_aura:GetAuraDuration()
    return 0.3
end

------------------------------------------------------------------------------

modifier_devour_magic_amplification_aura_debuff = modifier_devour_magic_amplification_aura_debuff or class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return true end,
	IsBuff                  = function(self) return false end,
	RemoveOnDeath 			= function(self) return true end,
	AllowIllusionDuplicate	= function(self) return true end,
	IsPermanent             = function(self) return false end,
})

function modifier_devour_magic_amplification_aura_debuff:GetTexture()
    return "black_drake_magic_amplification_aura"
end

function modifier_devour_magic_amplification_aura_debuff:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_devour_magic_amplification_aura_debuff:GetModifierIncomingDamage_Percentage()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("spell_amp")
	else
		return 0
	end
end