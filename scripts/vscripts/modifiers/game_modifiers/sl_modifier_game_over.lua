--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_game_over.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_game_over.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:36",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "8:13",
		["21"] = "9:13",
		["22"] = "10:13",
		["23"] = "11:13",
		["24"] = "12:13",
		["25"] = "7:16",
		["26"] = "6:5",
		["27"] = "16:5",
		["28"] = "17:9",
		["29"] = "16:5",
		["30"] = "20:5",
		["31"] = "21:14",
		["34"] = "22:15",
		["35"] = "23:15",
		["36"] = "24:13",
		["37"] = "25:13",
		["39"] = "27:9",
		["40"] = "20:5",
		["41"] = "5:14",
		["42"] = "4:2",
		["43"] = "4:2",
		["44"] = "4:19",
		["45"] = "4:2",
		["47"] = "4:2",
		["48"] = "5:14",
		["50"] = "5:14",
	}
)
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
sl_modifier_game_over = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_game_over", nil, getfenv()) },
	sl_modifier_game_over
)
____exports.sl_modifier_game_over = sl_modifier_game_over
return ____exports