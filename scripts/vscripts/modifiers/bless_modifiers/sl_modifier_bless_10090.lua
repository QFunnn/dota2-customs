--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10090.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10090.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "3:1",
		["15"] = "3:10",
		["16"] = "5:1",
		["17"] = "6:14",
		["18"] = "5:1",
		["19"] = "6:38",
		["21"] = "6:46",
		["22"] = "11:5",
		["23"] = "5:1",
		["24"] = "7:5",
		["25"] = "8:9",
		["26"] = "7:5",
		["27"] = "13:5",
		["28"] = "14:9",
		["29"] = "13:5",
		["30"] = "17:5",
		["31"] = "18:9",
		["32"] = "17:5",
		["33"] = "21:5",
		["34"] = "22:14",
		["37"] = "23:38",
		["38"] = "23:17",
		["39"] = "23:27",
		["40"] = "24:13",
		["43"] = "25:16",
		["45"] = "25:16",
		["47"] = "25:9",
		["48"] = "21:5",
		["49"] = "6:14",
		["50"] = "5:2",
		["51"] = "5:2",
		["52"] = "5:19",
		["53"] = "5:2",
		["55"] = "5:2",
		["56"] = "6:14",
		["58"] = "6:14",
		["59"] = "29:1",
		["60"] = "30:14",
		["61"] = "29:1",
		["62"] = "30:45",
		["63"] = "31:5",
		["64"] = "32:9",
		["65"] = "31:5",
		["66"] = "35:5",
		["67"] = "36:9",
		["68"] = "35:5",
		["69"] = "30:14",
		["70"] = "29:2",
		["71"] = "29:2",
		["72"] = "29:19",
		["73"] = "29:2",
		["75"] = "29:2",
		["76"] = "30:14",
		["78"] = "30:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_disable_healing = ____sl_modifier_simple.sl_modifier_disable_healing
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10090 = __TS__Class()
local sl_modifier_bless_10090 = ____exports.sl_modifier_bless_10090
sl_modifier_bless_10090.name = "sl_modifier_bless_10090"
__TS__ClassExtends(sl_modifier_bless_10090, SLModifierBase)
function sl_modifier_bless_10090.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._record = {}
end
function sl_modifier_bless_10090.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10090.prototype.SetSpecialTargetPct(self, unit, pct)
	self._record[unit] = pct
end
function sl_modifier_bless_10090.prototype.RemoveSpecialTargetPct(self, unit)
	self._record[unit] = nil
end
function sl_modifier_bless_10090.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	if attacker ~= self:GetParent() then
		return
	end
	local ____self__record_target_1 = self._record[target]
	if ____self__record_target_1 == nil then
		____self__record_target_1 = 0
	end
	return ____self__record_target_1
end
sl_modifier_bless_10090 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10090", nil, getfenv()) },
	sl_modifier_bless_10090
)
____exports.sl_modifier_bless_10090 = sl_modifier_bless_10090
____exports.sl_modifier_bless_10090_debuff = __TS__Class()
local sl_modifier_bless_10090_debuff = ____exports.sl_modifier_bless_10090_debuff
sl_modifier_bless_10090_debuff.name = "sl_modifier_bless_10090_debuff"
__TS__ClassExtends(sl_modifier_bless_10090_debuff, sl_modifier_disable_healing)
function sl_modifier_bless_10090_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10090_debuff.prototype.GetTexture(self)
	return "buff/bless/10090"
end
sl_modifier_bless_10090_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10090", nil, getfenv()) },
	sl_modifier_bless_10090_debuff
)
____exports.sl_modifier_bless_10090_debuff = sl_modifier_bless_10090_debuff
return ____exports