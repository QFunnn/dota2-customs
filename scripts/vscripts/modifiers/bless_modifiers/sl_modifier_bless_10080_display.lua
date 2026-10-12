--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10080_display.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10080_display.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:46",
		["19"] = "11:5",
		["20"] = "12:9",
		["21"] = "11:5",
		["22"] = "15:5",
		["23"] = "16:9",
		["24"] = "15:5",
		["25"] = "19:5",
		["26"] = "20:9",
		["27"] = "19:5",
		["28"] = "23:5",
		["29"] = "24:14",
		["32"] = "25:9",
		["33"] = "26:9",
		["34"] = "27:9",
		["35"] = "23:5",
		["36"] = "30:5",
		["37"] = "31:14",
		["40"] = "32:9",
		["41"] = "33:9",
		["42"] = "30:5",
		["43"] = "36:5",
		["44"] = "37:9",
		["45"] = "36:5",
		["46"] = "40:5",
		["47"] = "41:9",
		["48"] = "40:5",
		["49"] = "46:5",
		["50"] = "48:9",
		["51"] = "46:5",
		["52"] = "8:14",
		["53"] = "7:2",
		["54"] = "7:2",
		["55"] = "7:19",
		["56"] = "7:2",
		["58"] = "7:2",
		["59"] = "8:14",
		["61"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 10080 剑心犹在显示buff
____exports.sl_modifier_bless_10080_display = __TS__Class()
local sl_modifier_bless_10080_display = ____exports.sl_modifier_bless_10080_display
sl_modifier_bless_10080_display.name = "sl_modifier_bless_10080_display"
__TS__ClassExtends(sl_modifier_bless_10080_display, SLModifierBase)
function sl_modifier_bless_10080_display.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10080_display.prototype.GetTexture(self)
	return "buff/bless/10080"
end
function sl_modifier_bless_10080_display.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10080_display.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self._main_stats = params.main_stats
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10080_display.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._main_stats = params.main_stats
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10080_display.prototype.HandleCustomTransmitterData(self, data)
	self._main_stats = data.main_stats
end
function sl_modifier_bless_10080_display.prototype.AddCustomTransmitterData(self)
	return { main_stats = self._main_stats }
end
function sl_modifier_bless_10080_display.prototype.OnTooltip(self)
	return self._main_stats
end
sl_modifier_bless_10080_display = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10080_display", nil, getfenv()) },
	sl_modifier_bless_10080_display
)
____exports.sl_modifier_bless_10080_display = sl_modifier_bless_10080_display
return ____exports