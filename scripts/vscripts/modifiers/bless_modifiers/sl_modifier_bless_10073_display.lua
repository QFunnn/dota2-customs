--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10073_display.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10073_display.lua",
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
		["25"] = "20:5",
		["26"] = "21:9",
		["27"] = "20:5",
		["28"] = "24:5",
		["29"] = "25:9",
		["30"] = "24:5",
		["31"] = "28:5",
		["32"] = "29:14",
		["35"] = "30:9",
		["36"] = "31:9",
		["37"] = "32:9",
		["38"] = "28:5",
		["39"] = "35:5",
		["40"] = "36:14",
		["43"] = "37:9",
		["44"] = "38:9",
		["45"] = "35:5",
		["46"] = "41:5",
		["47"] = "42:9",
		["48"] = "41:5",
		["49"] = "45:5",
		["50"] = "46:9",
		["51"] = "45:5",
		["52"] = "51:5",
		["53"] = "53:9",
		["54"] = "51:5",
		["55"] = "8:14",
		["56"] = "7:2",
		["57"] = "7:2",
		["58"] = "7:19",
		["59"] = "7:2",
		["61"] = "7:2",
		["62"] = "8:14",
		["64"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
--- 10073 灼烧debuff显示层数
____exports.sl_modifier_bless_10073_display = __TS__Class()
local sl_modifier_bless_10073_display = ____exports.sl_modifier_bless_10073_display
sl_modifier_bless_10073_display.name = "sl_modifier_bless_10073_display"
__TS__ClassExtends(sl_modifier_bless_10073_display, SLModifierBase_Debuff)
function sl_modifier_bless_10073_display.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10073_display.prototype.GetTexture(self)
	return "buff/bless/10073"
end
function sl_modifier_bless_10073_display.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10073_display.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10073_display.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._dmg_pct = params.dmg_pct
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10073_display.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._dmg_pct = params.dmg_pct
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10073_display.prototype.HandleCustomTransmitterData(self, data)
	self._dmg_pct = data.dmg_pct
end
function sl_modifier_bless_10073_display.prototype.AddCustomTransmitterData(self)
	return { dmg_pct = self._dmg_pct }
end
function sl_modifier_bless_10073_display.prototype.OnTooltip(self)
	return self._dmg_pct
end
sl_modifier_bless_10073_display = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10073_display", nil, getfenv()) },
	sl_modifier_bless_10073_display
)
____exports.sl_modifier_bless_10073_display = sl_modifier_bless_10073_display
return ____exports