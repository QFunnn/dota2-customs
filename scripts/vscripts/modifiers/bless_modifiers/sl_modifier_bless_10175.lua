--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10175.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10175.lua",
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
		["19"] = "6:42",
		["20"] = "7:5",
		["21"] = "8:9",
		["22"] = "7:5",
		["23"] = "11:5",
		["24"] = "12:9",
		["25"] = "11:5",
		["26"] = "15:5",
		["27"] = "16:9",
		["28"] = "15:5",
		["29"] = "19:5",
		["30"] = "20:16",
		["31"] = "20:16",
		["32"] = "20:16",
		["34"] = "20:9",
		["35"] = "19:5",
		["36"] = "6:14",
		["37"] = "5:2",
		["38"] = "5:2",
		["39"] = "5:19",
		["40"] = "5:2",
		["42"] = "5:2",
		["43"] = "6:14",
		["45"] = "6:14",
		["46"] = "24:1",
		["47"] = "25:14",
		["48"] = "24:1",
		["49"] = "25:47",
		["50"] = "26:5",
		["51"] = "27:9",
		["52"] = "26:5",
		["53"] = "30:5",
		["54"] = "31:9",
		["55"] = "30:5",
		["56"] = "34:5",
		["57"] = "35:9",
		["58"] = "34:5",
		["59"] = "38:5",
		["60"] = "39:16",
		["61"] = "39:16",
		["62"] = "39:16",
		["64"] = "39:9",
		["65"] = "38:5",
		["66"] = "25:14",
		["67"] = "24:2",
		["68"] = "24:2",
		["69"] = "24:19",
		["70"] = "24:2",
		["72"] = "24:2",
		["73"] = "25:14",
		["75"] = "25:14",
		["76"] = "43:1",
		["77"] = "44:14",
		["78"] = "43:1",
		["79"] = "44:42",
		["81"] = "44:50",
		["82"] = "59:5",
		["83"] = "43:1",
		["84"] = "45:5",
		["85"] = "46:9",
		["86"] = "45:5",
		["87"] = "49:5",
		["88"] = "50:14",
		["91"] = "51:41",
		["92"] = "51:17",
		["93"] = "51:27",
		["94"] = "52:14",
		["97"] = "53:15",
		["98"] = "54:13",
		["101"] = "55:15",
		["102"] = "56:16",
		["104"] = "56:16",
		["106"] = "56:9",
		["107"] = "49:5",
		["108"] = "60:5",
		["109"] = "61:9",
		["110"] = "60:5",
		["111"] = "44:14",
		["112"] = "43:2",
		["113"] = "43:2",
		["114"] = "43:19",
		["115"] = "43:2",
		["117"] = "43:2",
		["118"] = "44:14",
		["120"] = "44:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10175_atk = __TS__Class()
local sl_modifier_bless_10175_atk = ____exports.sl_modifier_bless_10175_atk
sl_modifier_bless_10175_atk.name = "sl_modifier_bless_10175_atk"
__TS__ClassExtends(sl_modifier_bless_10175_atk, sl_modifier_transmitter_data)
function sl_modifier_bless_10175_atk.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10175_atk.prototype.GetTexture(self)
	return "buff/bless/10175_atk"
end
function sl_modifier_bless_10175_atk.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10175_atk.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
sl_modifier_bless_10175_atk = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10175", nil, getfenv()) },
	sl_modifier_bless_10175_atk
)
____exports.sl_modifier_bless_10175_atk = sl_modifier_bless_10175_atk
____exports.sl_modifier_bless_10175_amp_show = __TS__Class()
local sl_modifier_bless_10175_amp_show = ____exports.sl_modifier_bless_10175_amp_show
sl_modifier_bless_10175_amp_show.name = "sl_modifier_bless_10175_amp_show"
__TS__ClassExtends(sl_modifier_bless_10175_amp_show, sl_modifier_transmitter_data)
function sl_modifier_bless_10175_amp_show.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10175_amp_show.prototype.GetTexture(self)
	return "buff/bless/10175_amp"
end
function sl_modifier_bless_10175_amp_show.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10175_amp_show.prototype.OnTooltip(self)
	local ____table__params_pct_2 = self._params
	if ____table__params_pct_2 ~= nil then
		____table__params_pct_2 = ____table__params_pct_2.pct
	end
	return ____table__params_pct_2 * self:GetStackCount()
end
sl_modifier_bless_10175_amp_show = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10175", nil, getfenv()) },
	sl_modifier_bless_10175_amp_show
)
____exports.sl_modifier_bless_10175_amp_show = sl_modifier_bless_10175_amp_show
____exports.sl_modifier_bless_10175_amp = __TS__Class()
local sl_modifier_bless_10175_amp = ____exports.sl_modifier_bless_10175_amp
sl_modifier_bless_10175_amp.name = "sl_modifier_bless_10175_amp"
__TS__ClassExtends(sl_modifier_bless_10175_amp, SLModifierBase)
function sl_modifier_bless_10175_amp.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._ability_extra_amp_value_map = {}
end
function sl_modifier_bless_10175_amp.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10175_amp.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_4 = event
	local attacker = ____event_4.attacker
	local inflictor = ____event_4.inflictor
	if not IsValid(inflictor) then
		return
	end
	local parent = self:GetParent()
	if parent ~= attacker then
		return
	end
	local ability_name = inflictor:GetAbilityName()
	local ____self__ability_extra_amp_value_map_ability_name_5 = self._ability_extra_amp_value_map[ability_name]
	if ____self__ability_extra_amp_value_map_ability_name_5 == nil then
		____self__ability_extra_amp_value_map_ability_name_5 = 0
	end
	return ____self__ability_extra_amp_value_map_ability_name_5
end
function sl_modifier_bless_10175_amp.prototype.SetAbilityExtraAmpValue(self, ability, value)
	self._ability_extra_amp_value_map[ability] = value
end
sl_modifier_bless_10175_amp = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10175", nil, getfenv()) },
	sl_modifier_bless_10175_amp
)
____exports.sl_modifier_bless_10175_amp = sl_modifier_bless_10175_amp
return ____exports