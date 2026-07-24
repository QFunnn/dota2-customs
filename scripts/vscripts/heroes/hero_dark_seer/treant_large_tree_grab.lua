--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_treant_large_tree_grab", "heroes/hero_dark_seer/treant_large_tree_grab.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if treant_large_tree_grab == nil then
	treant_large_tree_grab = class({})
end
function treant_large_tree_grab:GetIntrinsicModifierName()
	return "modifier_treant_large_tree_grab"
end
---------------------------------------------------------------------
--Modifiers
if modifier_treant_large_tree_grab == nil then
	modifier_treant_large_tree_grab = class({})
end
function modifier_treant_large_tree_grab:OnCreated(params)
	if IsServer() then
	end
end
function modifier_treant_large_tree_grab:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_treant_large_tree_grab:OnDestroy()
	if IsServer() then
	end
end
function modifier_treant_large_tree_grab:DeclareFunctions()
	return {
	}
end