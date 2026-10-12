--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10200.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10200.lua",
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
		["30"] = "25:14",
		["31"] = "25:41",
		["33"] = "26:38",
		["34"] = "26:17",
		["35"] = "26:27",
		["36"] = "27:15",
		["37"] = "28:13",
		["38"] = "29:20",
		["39"] = "29:20",
		["40"] = "29:20",
		["42"] = "29:13",
		["44"] = "24:5",
		["45"] = "33:5",
		["46"] = "34:14",
		["47"] = "34:41",
		["49"] = "35:38",
		["50"] = "35:17",
		["51"] = "35:27",
		["52"] = "36:15",
		["53"] = "37:13",
		["54"] = "38:20",
		["55"] = "38:20",
		["56"] = "38:20",
		["58"] = "38:13",
		["60"] = "33:5",
		["61"] = "9:14",
		["62"] = "8:2",
		["63"] = "8:2",
		["64"] = "8:19",
		["65"] = "8:2",
		["67"] = "8:2",
		["68"] = "9:14",
		["70"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 10200 - 福佑持有者身上的buff
-- 对恩人造成额外伤害，受到恩人额外伤害
____exports.sl_modifier_bless_10200 = __TS__Class()
local sl_modifier_bless_10200 = ____exports.sl_modifier_bless_10200
sl_modifier_bless_10200.name = "sl_modifier_bless_10200"
__TS__ClassExtends(sl_modifier_bless_10200, sl_modifier_transmitter_data)
function sl_modifier_bless_10200.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10200.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_bless_10200.prototype.SetBenefactor(self, hero)
	self._benefactor = hero
end
function sl_modifier_bless_10200.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsValid(self._benefactor) then
		return nil
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	local parent = self:GetParent()
	if attacker == parent and target == self._benefactor then
		local ____table__params_sh_pct_1 = self._params
		if ____table__params_sh_pct_1 ~= nil then
			____table__params_sh_pct_1 = ____table__params_sh_pct_1.sh_pct
		end
		return ____table__params_sh_pct_1
	end
end
function sl_modifier_bless_10200.prototype.GetModifierIncomingDamage_Percentage(self, event)
	if not IsValid(self._benefactor) then
		return nil
	end
	local ____event_3 = event
	local attacker = ____event_3.attacker
	local target = ____event_3.target
	local parent = self:GetParent()
	if parent == target and attacker == self._benefactor then
		local ____table__params_cs_pct_4 = self._params
		if ____table__params_cs_pct_4 ~= nil then
			____table__params_cs_pct_4 = ____table__params_cs_pct_4.cs_pct
		end
		return ____table__params_cs_pct_4
	end
end
sl_modifier_bless_10200 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10200", nil, getfenv()) },
	sl_modifier_bless_10200
)
____exports.sl_modifier_bless_10200 = sl_modifier_bless_10200
return ____exports