--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


bloodseeker_bloodrage_lua = class({}) ---@class bloodseeker_bloodrage_lua : CDOTA_Ability_Lua
LinkLuaModifier("modifier_bloodseeker_bloodrage_lua", "heroes/hero_bloodseeker/modifier_bloodseeker_bloodrage_lua",
	LUA_MODIFIER_MOTION_NONE)

function bloodseeker_bloodrage_lua:OnSpellStart()
	local caster = self:GetCaster()

	if not caster then return end

	local duration = self:GetSpecialValueFor("duration")

	caster:AddNewModifier(
		caster,
		self,
		"modifier_bloodseeker_bloodrage",
		{ duration = duration }
	)

	if caster:HasShard() then
		caster:AddNewModifier(
			caster,
			self,
			"modifier_bloodseeker_bloodrage_lua",
			{ duration = duration }
		)
	end

	local sound = "hero_bloodseeker.bloodRage"
	EmitSoundOn(sound, caster)
end