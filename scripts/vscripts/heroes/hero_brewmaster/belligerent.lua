--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_brewmaster_belligerent", "heroes/hero_brewmaster/belligerent.lua", LUA_MODIFIER_MOTION_NONE )

if ability_brewmaster_belligerent == nil then
	ability_brewmaster_belligerent = class({})
end

function ability_brewmaster_belligerent:GetIntrinsicModifierName()
	return "modifier_ability_brewmaster_belligerent"
end

modifier_ability_brewmaster_belligerent = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
			MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        }
    end,

	GetModifierBaseDamageOutgoing_Percentage		= function(self)
		return self.AttacksAmplify or 0
	end,
	GetModifierSpellAmplify_Percentage		= function(self)
		return self.SpellAmplify or 0
	end,
})

function modifier_ability_brewmaster_belligerent:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.AttacksAmplify = ability:GetSpecialValueFor("physical_damage_pct")
		self.SpellAmplify = ability:GetSpecialValueFor("magical_damage_pct")
	end
end