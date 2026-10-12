--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10203.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10203.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "5:1",
		["16"] = "6:14",
		["17"] = "5:1",
		["18"] = "6:38",
		["20"] = "6:46",
		["21"] = "20:5",
		["22"] = "5:1",
		["23"] = "7:5",
		["24"] = "8:9",
		["25"] = "7:5",
		["26"] = "11:5",
		["27"] = "12:14",
		["30"] = "13:26",
		["31"] = "13:26",
		["32"] = "13:26",
		["34"] = "13:26",
		["36"] = "13:26",
		["38"] = "13:9",
		["39"] = "11:5",
		["40"] = "16:5",
		["41"] = "17:9",
		["42"] = "16:5",
		["43"] = "6:14",
		["44"] = "5:2",
		["45"] = "5:2",
		["46"] = "5:19",
		["47"] = "5:2",
		["49"] = "5:2",
		["50"] = "6:14",
		["52"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 仅在连击 PerformAttack 期间短暂存在的隐藏致命一击 Buff
____exports.sl_modifier_bless_10203 = __TS__Class()
local sl_modifier_bless_10203 = ____exports.sl_modifier_bless_10203
sl_modifier_bless_10203.name = "sl_modifier_bless_10203"
__TS__ClassExtends(sl_modifier_bless_10203, SLModifierBase)
function sl_modifier_bless_10203.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._crit_pct = 0
end
function sl_modifier_bless_10203.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE }
end
function sl_modifier_bless_10203.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____params_crit_pct_0 = params
	if ____params_crit_pct_0 ~= nil then
		____params_crit_pct_0 = ____params_crit_pct_0.crit_pct
	end
	local ____params_crit_pct_0_2 = ____params_crit_pct_0
	if ____params_crit_pct_0_2 == nil then
		____params_crit_pct_0_2 = 0
	end
	self._crit_pct = ____params_crit_pct_0_2
end
function sl_modifier_bless_10203.prototype.GetModifierPreAttack_CriticalStrike(self, _event)
	return self._crit_pct
end
sl_modifier_bless_10203 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10203", nil, getfenv()) },
	sl_modifier_bless_10203
)
____exports.sl_modifier_bless_10203 = sl_modifier_bless_10203
return ____exports