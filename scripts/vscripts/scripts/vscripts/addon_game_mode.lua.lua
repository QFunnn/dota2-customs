--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_addon_game_mode", "scripts/vscripts/addon_game_mode.lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if addon_game_mode == nil then
	addon_game_mode = class({})
end
function addon_game_mode:GetIntrinsicModifierName()
	return "modifier_addon_game_mode"
end
---------------------------------------------------------------------
--Modifiers
if modifier_addon_game_mode == nil then
	modifier_addon_game_mode = class({})
end
function modifier_addon_game_mode:OnCreated(params)
	if IsServer() then
	end
end
function modifier_addon_game_mode:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_addon_game_mode:OnDestroy()
	if IsServer() then
	end
end
function modifier_addon_game_mode:DeclareFunctions()
	return {}
end