--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_21003.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_21003.lua",
	{
		["10"] = "2:1",
		["11"] = "2:10",
		["12"] = "4:1",
		["13"] = "4:10",
		["14"] = "5:1",
		["15"] = "5:10",
		["16"] = "7:1",
		["17"] = "8:14",
		["18"] = "7:1",
		["19"] = "8:44",
		["20"] = "9:5",
		["21"] = "10:9",
		["22"] = "9:5",
		["23"] = "13:5",
		["24"] = "14:9",
		["25"] = "13:5",
		["26"] = "8:14",
		["27"] = "7:2",
		["28"] = "7:2",
		["29"] = "7:19",
		["30"] = "7:2",
		["32"] = "7:2",
		["33"] = "8:14",
		["35"] = "8:14",
		["36"] = "18:1",
		["37"] = "19:14",
		["38"] = "18:1",
		["39"] = "19:41",
		["40"] = "20:5",
		["41"] = "21:9",
		["42"] = "20:5",
		["43"] = "24:5",
		["44"] = "25:9",
		["45"] = "24:5",
		["46"] = "29:5",
		["47"] = "30:9",
		["48"] = "29:5",
		["49"] = "33:5",
		["50"] = "34:13",
		["51"] = "35:13",
		["53"] = "33:5",
		["54"] = "19:14",
		["55"] = "18:2",
		["56"] = "18:2",
		["57"] = "18:19",
		["58"] = "18:2",
		["60"] = "18:2",
		["61"] = "19:14",
		["63"] = "19:14",
		["64"] = "40:1",
		["65"] = "41:14",
		["66"] = "40:1",
		["67"] = "41:47",
		["68"] = "42:5",
		["69"] = "43:9",
		["70"] = "42:5",
		["71"] = "50:5",
		["72"] = "51:9",
		["73"] = "50:5",
		["74"] = "54:5",
		["75"] = "55:9",
		["76"] = "54:5",
		["77"] = "41:14",
		["78"] = "40:2",
		["79"] = "40:2",
		["80"] = "40:19",
		["81"] = "40:2",
		["83"] = "40:2",
		["84"] = "41:14",
		["86"] = "41:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_21003_ready = __TS__Class()
local sl_modifier_bless_21003_ready = ____exports.sl_modifier_bless_21003_ready
sl_modifier_bless_21003_ready.name = "sl_modifier_bless_21003_ready"
__TS__ClassExtends(sl_modifier_bless_21003_ready, SLModifierBase)
function sl_modifier_bless_21003_ready.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21003_ready.prototype.GetTexture(self)
	return "buff/bless/21003"
end
sl_modifier_bless_21003_ready = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21003", nil, getfenv()) },
	sl_modifier_bless_21003_ready
)
____exports.sl_modifier_bless_21003_ready = sl_modifier_bless_21003_ready
____exports.sl_modifier_bless_21003_cd = __TS__Class()
local sl_modifier_bless_21003_cd = ____exports.sl_modifier_bless_21003_cd
sl_modifier_bless_21003_cd.name = "sl_modifier_bless_21003_cd"
__TS__ClassExtends(sl_modifier_bless_21003_cd, SLModifierBase)
function sl_modifier_bless_21003_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21003_cd.prototype.GetTexture(self)
	return "buff/bless/21003"
end
function sl_modifier_bless_21003_cd.prototype.SetSourceBless(self, bless)
	self._source_bless = bless
end
function sl_modifier_bless_21003_cd.prototype.OnDestroy(self)
	if self._source_bless and self._source_bless:IsValid() then
		self._source_bless:ReadyForShoot()
	end
end
sl_modifier_bless_21003_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21003", nil, getfenv()) },
	sl_modifier_bless_21003_cd
)
____exports.sl_modifier_bless_21003_cd = sl_modifier_bless_21003_cd
____exports.sl_modifier_bless_21003_shooting = __TS__Class()
local sl_modifier_bless_21003_shooting = ____exports.sl_modifier_bless_21003_shooting
sl_modifier_bless_21003_shooting.name = "sl_modifier_bless_21003_shooting"
__TS__ClassExtends(sl_modifier_bless_21003_shooting, sl_modifier_transmitter_data)
function sl_modifier_bless_21003_shooting.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING }
end
function sl_modifier_bless_21003_shooting.prototype.GetModifierDisableTurning(self)
	return 1
end
function sl_modifier_bless_21003_shooting.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
sl_modifier_bless_21003_shooting = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21003", nil, getfenv()) },
	sl_modifier_bless_21003_shooting
)
____exports.sl_modifier_bless_21003_shooting = sl_modifier_bless_21003_shooting
return ____exports