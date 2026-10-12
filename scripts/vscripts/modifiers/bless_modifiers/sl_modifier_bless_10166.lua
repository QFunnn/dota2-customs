--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10166.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10166.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:38",
		["19"] = "5:46",
		["20"] = "22:5",
		["21"] = "4:1",
		["22"] = "6:5",
		["23"] = "7:9",
		["24"] = "6:5",
		["25"] = "10:5",
		["26"] = "11:9",
		["27"] = "10:5",
		["28"] = "14:5",
		["29"] = "15:16",
		["30"] = "15:16",
		["31"] = "15:16",
		["33"] = "15:9",
		["34"] = "14:5",
		["35"] = "18:5",
		["36"] = "19:9",
		["37"] = "18:5",
		["38"] = "23:5",
		["39"] = "24:9",
		["40"] = "25:9",
		["41"] = "29:9",
		["42"] = "23:5",
		["43"] = "5:14",
		["44"] = "4:2",
		["45"] = "4:2",
		["46"] = "4:19",
		["47"] = "4:2",
		["49"] = "4:2",
		["50"] = "5:14",
		["52"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10166 = __TS__Class()
local sl_modifier_bless_10166 = ____exports.sl_modifier_bless_10166
sl_modifier_bless_10166.name = "sl_modifier_bless_10166"
__TS__ClassExtends(sl_modifier_bless_10166, sl_modifier_transmitter_data)
function sl_modifier_bless_10166.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._pct = 0
end
function sl_modifier_bless_10166.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10166.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10166.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
function sl_modifier_bless_10166.prototype.GetTexture(self)
	return "buff/bless/10166"
end
function sl_modifier_bless_10166.prototype.Modify10166BonusDamage(self, pct)
	self._pct = self._pct + pct
	self:_ApplyParams({ pct = self._pct, update_data = 1 })
	self:SetStackCount(math.floor(self._pct))
end
sl_modifier_bless_10166 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10166", nil, getfenv()) },
	sl_modifier_bless_10166
)
____exports.sl_modifier_bless_10166 = sl_modifier_bless_10166
return ____exports