--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


drow_ranger_marksmanship_lua = class({})
LinkLuaModifier( "modifier_drow_ranger_marksmanship_lua", "heroes/hero_drow_ranger/modifier_drow_ranger_marksmanship_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_lua_debuff", "heroes/hero_drow_ranger/modifier_drow_ranger_marksmanship_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_lua_effect", "heroes/hero_drow_ranger/modifier_drow_ranger_marksmanship_lua_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function drow_ranger_marksmanship_lua:GetIntrinsicModifierName()
	if self:GetCaster():IsIllusion() then return end
	return "modifier_drow_ranger_marksmanship_lua"
end

--------------------------------------------------------------------------------
-- Projectile
function drow_ranger_marksmanship_lua:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	-- perform attack
	self.split = true
	self.split_procs = data.procs==1
	self:GetCaster().split_attack = true
	--不能使用弹道
	self:GetCaster():PerformAttack( target, true, true, true, true, false, false, data.procs==1 )
	self:GetCaster().split_attack = false
	self.split = false
end