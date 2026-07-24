--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


test_kill_one = class({}) ---@class test_kill_one : CDOTA_Ability_Lua

function test_kill_one:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if not target then return end
	ApplyDamage({
		victim       = target,
		damage       = target:GetMaxHealth() * 10,
		damage_type  = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker     = self:GetCaster(),
		ability      = self
	})
end