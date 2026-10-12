--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10118.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10118.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:43",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "5:14",
		["25"] = "4:2",
		["26"] = "4:2",
		["27"] = "4:19",
		["28"] = "4:2",
		["30"] = "4:2",
		["31"] = "5:14",
		["33"] = "5:14",
		["34"] = "15:1",
		["35"] = "16:14",
		["36"] = "15:1",
		["37"] = "16:38",
		["39"] = "16:46",
		["40"] = "31:5",
		["41"] = "15:1",
		["42"] = "17:5",
		["43"] = "18:9",
		["44"] = "17:5",
		["45"] = "21:5",
		["46"] = "22:14",
		["49"] = "23:41",
		["50"] = "23:17",
		["51"] = "23:27",
		["52"] = "24:14",
		["55"] = "25:15",
		["56"] = "26:13",
		["59"] = "27:15",
		["60"] = "28:16",
		["62"] = "28:16",
		["64"] = "28:9",
		["65"] = "21:5",
		["66"] = "32:5",
		["67"] = "33:9",
		["68"] = "32:5",
		["69"] = "16:14",
		["70"] = "15:2",
		["71"] = "15:2",
		["72"] = "15:19",
		["73"] = "15:2",
		["75"] = "15:2",
		["76"] = "16:14",
		["78"] = "16:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10118_show = __TS__Class()
local sl_modifier_bless_10118_show = ____exports.sl_modifier_bless_10118_show
sl_modifier_bless_10118_show.name = "sl_modifier_bless_10118_show"
__TS__ClassExtends(sl_modifier_bless_10118_show, SLModifierBase)
function sl_modifier_bless_10118_show.prototype.GetTexture(self)
	return "buff/bless/10118"
end
function sl_modifier_bless_10118_show.prototype.IsHidden(self)
	return false
end
sl_modifier_bless_10118_show = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10118", nil, getfenv()) },
	sl_modifier_bless_10118_show
)
____exports.sl_modifier_bless_10118_show = sl_modifier_bless_10118_show
____exports.sl_modifier_bless_10118 = __TS__Class()
local sl_modifier_bless_10118 = ____exports.sl_modifier_bless_10118
sl_modifier_bless_10118.name = "sl_modifier_bless_10118"
__TS__ClassExtends(sl_modifier_bless_10118, SLModifierBase)
function sl_modifier_bless_10118.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._ability_extra_amp_value_map = {}
end
function sl_modifier_bless_10118.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10118.prototype.GetModifierSpellAmplify_Percentage(self, event)
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
function sl_modifier_bless_10118.prototype.SetAbilityExtraAmpValue(self, ability, value)
	self._ability_extra_amp_value_map[ability] = value
end
sl_modifier_bless_10118 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10118", nil, getfenv()) },
	sl_modifier_bless_10118
)
____exports.sl_modifier_bless_10118 = sl_modifier_bless_10118
return ____exports