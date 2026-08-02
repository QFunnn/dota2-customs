--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_dazzle_good_juju_lua",
	"heroes/hero_dazzle/dazzle_good_juju_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)
--Abilities
if dazzle_good_juju_lua == nil then
	dazzle_good_juju_lua = class({})
end
function dazzle_good_juju_lua:GetIntrinsicModifierName()
	return "modifier_dazzle_good_juju_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_dazzle_good_juju_lua == nil then
	modifier_dazzle_good_juju_lua = class({})
end
function modifier_dazzle_good_juju_lua:OnCreated(params)
	if IsServer() then
	end
end
function modifier_dazzle_good_juju_lua:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_dazzle_good_juju_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_dazzle_good_juju_lua:DeclareFunctions()
	return {}
end