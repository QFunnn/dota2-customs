--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



creature_ogre_jump_smash = class({})
LinkLuaModifier( "modifier_command_restricted", "creature_ability/modifier/modifier_command_restricted", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_tank_melee_smash_thinker", "creature_ability/modifier/modifier_ogre_tank_melee_smash_thinker", LUA_MODIFIER_MOTION_NONE )

function creature_ogre_jump_smash:ProcsMagicStick()
	return false
end

function creature_ogre_jump_smash:GetPlaybackRateOverride()
	return 0.9
end

function creature_ogre_jump_smash:OnSpellStart()
	if IsServer() then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_command_restricted", {duration=self:GetSpecialValueFor( "jump_speed")})
		local hThinker = CreateModifierThinker( self:GetCaster(), self, "modifier_ogre_tank_melee_smash_thinker", { duration = self:GetSpecialValueFor( "jump_speed") }, self:GetCaster():GetOrigin(), self:GetCaster():GetTeamNumber(), false )
	end
end