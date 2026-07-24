--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_templar_assassin_third_eye", "heroes/hero_templar_assassin/third_eye.lua", LUA_MODIFIER_MOTION_NONE )

if ability_templar_assassin_third_eye == nil then
	ability_templar_assassin_third_eye = class({})
end
function ability_templar_assassin_third_eye:GetIntrinsicModifierName()
	return "modifier_ability_templar_assassin_third_eye"
end

modifier_ability_templar_assassin_third_eye = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	IsAura                  = function(self) return true end,
    GetAuraDuration         = function(self) return 0.5 end,
    GetAuraRadius           = function(self) return self.Radius or 0 end,
    GetAuraSearchFlags      = function(self) return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end,
    GetAuraSearchTeam       = function(self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
    GetAuraSearchType       = function(self) return DOTA_UNIT_TARGET_ALL end,
    GetModifierAura         = function(self) return "modifier_truesight" end,
})

function modifier_ability_templar_assassin_third_eye:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.Radius = ability:GetSpecialValueFor("radius")
	end
end