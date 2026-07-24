--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_test", "test.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if test == nil then
	test = class({})
end
function test:GetIntrinsicModifierName()
	return "modifier_test"
end
---------------------------------------------------------------------
--Modifiers
if modifier_test == nil then
	modifier_test = class({})
end
function modifier_test:OnCreated(params)
	if IsServer() then
	end
end
function modifier_test:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_test:OnDestroy()
	if IsServer() then
	end
end
function modifier_test:DeclareFunctions()
	return {
	}
end