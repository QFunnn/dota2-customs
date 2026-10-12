--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10089.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10089.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:38",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "16:5",
		["25"] = "17:9",
		["26"] = "16:5",
		["27"] = "23:5",
		["28"] = "24:14",
		["31"] = "25:9",
		["32"] = "26:9",
		["33"] = "23:5",
		["34"] = "29:5",
		["35"] = "30:9",
		["36"] = "29:5",
		["37"] = "33:5",
		["38"] = "34:9",
		["39"] = "33:5",
		["40"] = "5:14",
		["41"] = "4:2",
		["42"] = "4:2",
		["43"] = "4:19",
		["44"] = "4:2",
		["46"] = "4:2",
		["47"] = "5:14",
		["49"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10089 = __TS__Class()
local sl_modifier_bless_10089 = ____exports.sl_modifier_bless_10089
sl_modifier_bless_10089.name = "sl_modifier_bless_10089"
__TS__ClassExtends(sl_modifier_bless_10089, SLModifierBase)
function sl_modifier_bless_10089.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_MODEL_SCALE }
end
function sl_modifier_bless_10089.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
function sl_modifier_bless_10089.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
function sl_modifier_bless_10089.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._model = params.model
	self._model_scale = params.model_scale
end
function sl_modifier_bless_10089.prototype.GetModifierModelChange(self)
	return self._model
end
function sl_modifier_bless_10089.prototype.GetModifierModelScale(self)
	return self._model_scale
end
sl_modifier_bless_10089 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10089", nil, getfenv()) },
	sl_modifier_bless_10089
)
____exports.sl_modifier_bless_10089 = sl_modifier_bless_10089
return ____exports