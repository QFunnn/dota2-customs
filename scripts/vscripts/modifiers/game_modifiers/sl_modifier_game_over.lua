--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_game_over = __TS__Class()
local sl_modifier_game_over = ____exports.sl_modifier_game_over
sl_modifier_game_over.name = "sl_modifier_game_over"
__TS__ClassExtends(sl_modifier_game_over, SLModifierBase)
function sl_modifier_game_over.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_TAUNTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
function sl_modifier_game_over.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function sl_modifier_game_over.prototype.GetOverrideAnimation(self)
	if not IsServer() then
		return
	end
	local team = self:GetCaster():GetTeamNumber()
	local winner = SLModules.Settlement:GetWinner()
	if team == winner then
		return ACT_DOTA_VICTORY
	end
	return ACT_DOTA_DEFEAT
end
sl_modifier_game_over =
	__TS__Decorate({ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_game_over") }, sl_modifier_game_over)
____exports.sl_modifier_game_over = sl_modifier_game_over
return ____exports