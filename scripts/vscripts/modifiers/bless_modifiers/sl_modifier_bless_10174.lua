--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10174.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10174.lua",
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
		["20"] = "20:5",
		["21"] = "4:1",
		["22"] = "6:5",
		["23"] = "7:9",
		["24"] = "6:5",
		["25"] = "10:5",
		["26"] = "11:14",
		["29"] = "12:41",
		["30"] = "12:17",
		["31"] = "12:27",
		["32"] = "13:14",
		["35"] = "14:15",
		["36"] = "15:13",
		["39"] = "16:15",
		["40"] = "17:16",
		["42"] = "17:16",
		["44"] = "17:9",
		["45"] = "10:5",
		["46"] = "21:5",
		["47"] = "22:9",
		["48"] = "21:5",
		["49"] = "5:14",
		["50"] = "4:2",
		["51"] = "4:2",
		["52"] = "4:19",
		["53"] = "4:2",
		["55"] = "4:2",
		["56"] = "5:14",
		["58"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10174 = __TS__Class()
local sl_modifier_bless_10174 = ____exports.sl_modifier_bless_10174
sl_modifier_bless_10174.name = "sl_modifier_bless_10174"
__TS__ClassExtends(sl_modifier_bless_10174, SLModifierBase)
function sl_modifier_bless_10174.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._ability_extra_amp_value_map = {}
end
function sl_modifier_bless_10174.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10174.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local inflictor = ____event_0.inflictor
	if not IsValid(inflictor) then
		return
	end
	local parent = self:GetParent()
	if parent ~= attacker then
		return
	end
	local ability_name = inflictor:GetAbilityName()
	local ____self__ability_extra_amp_value_map_ability_name_1 = self._ability_extra_amp_value_map[ability_name]
	if ____self__ability_extra_amp_value_map_ability_name_1 == nil then
		____self__ability_extra_amp_value_map_ability_name_1 = 0
	end
	return ____self__ability_extra_amp_value_map_ability_name_1
end
function sl_modifier_bless_10174.prototype.SetAbilityExtraAmpValue(self, ability, value)
	self._ability_extra_amp_value_map[ability] = value
end
sl_modifier_bless_10174 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10174", nil, getfenv()) },
	sl_modifier_bless_10174
)
____exports.sl_modifier_bless_10174 = sl_modifier_bless_10174
return ____exports