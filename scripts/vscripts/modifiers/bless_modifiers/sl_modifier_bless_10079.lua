--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10079.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10079.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["16"] = "8:1",
		["17"] = "9:14",
		["18"] = "8:1",
		["19"] = "9:38",
		["20"] = "12:5",
		["21"] = "13:9",
		["22"] = "12:5",
		["23"] = "16:5",
		["24"] = "17:9",
		["25"] = "16:5",
		["26"] = "20:5",
		["27"] = "21:9",
		["28"] = "20:5",
		["29"] = "24:5",
		["30"] = "25:9",
		["31"] = "24:5",
		["32"] = "28:5",
		["33"] = "29:14",
		["36"] = "30:9",
		["37"] = "31:9",
		["38"] = "32:9",
		["39"] = "33:9",
		["40"] = "28:5",
		["41"] = "36:5",
		["42"] = "37:14",
		["45"] = "38:9",
		["46"] = "39:9",
		["47"] = "40:9",
		["48"] = "36:5",
		["49"] = "43:5",
		["50"] = "44:9",
		["51"] = "45:9",
		["52"] = "46:9",
		["53"] = "43:5",
		["54"] = "49:5",
		["55"] = "50:9",
		["56"] = "49:5",
		["57"] = "53:5",
		["58"] = "54:9",
		["59"] = "53:5",
		["60"] = "9:14",
		["61"] = "8:2",
		["62"] = "8:2",
		["63"] = "8:19",
		["64"] = "8:2",
		["66"] = "8:2",
		["67"] = "9:14",
		["69"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 福佑10079 问号buff
-- 移速、攻速、冷却时间减少 +effect_pct%，持续 duration 秒
____exports.sl_modifier_bless_10079 = __TS__Class()
local sl_modifier_bless_10079 = ____exports.sl_modifier_bless_10079
sl_modifier_bless_10079.name = "sl_modifier_bless_10079"
__TS__ClassExtends(sl_modifier_bless_10079, SLModifierBase)
function sl_modifier_bless_10079.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10079.prototype.GetTexture(self)
	return "buff/bless/10079"
end
function sl_modifier_bless_10079.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10079.prototype.OnTooltip(self)
	return self._effect_pct
end
function sl_modifier_bless_10079.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self._effect_pct = params.effect_pct
	self:_ApplyAttrs()
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10079.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._effect_pct = params.effect_pct
	self:_ApplyAttrs()
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10079.prototype._ApplyAttrs(self)
	self:_SetParentAttr("ysI", self._effect_pct)
	self:_SetParentAttr("gsI", self._effect_pct)
	self:_SetParentAttr("lq", self._effect_pct)
end
function sl_modifier_bless_10079.prototype.AddCustomTransmitterData(self)
	return { effect_pct = self._effect_pct }
end
function sl_modifier_bless_10079.prototype.HandleCustomTransmitterData(self, data)
	self._effect_pct = data.effect_pct
end
sl_modifier_bless_10079 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10079", nil, getfenv()) },
	sl_modifier_bless_10079
)
____exports.sl_modifier_bless_10079 = sl_modifier_bless_10079
return ____exports