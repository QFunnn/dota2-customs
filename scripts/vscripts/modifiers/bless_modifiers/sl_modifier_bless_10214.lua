--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10214.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10214.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "4:1",
		["15"] = "4:10",
		["16"] = "6:1",
		["17"] = "7:14",
		["18"] = "6:1",
		["19"] = "7:38",
		["20"] = "8:5",
		["21"] = "9:9",
		["22"] = "8:5",
		["23"] = "12:5",
		["24"] = "13:9",
		["25"] = "12:5",
		["26"] = "16:5",
		["27"] = "17:15",
		["28"] = "18:14",
		["29"] = "18:31",
		["31"] = "19:14",
		["32"] = "19:41",
		["34"] = "20:16",
		["35"] = "20:16",
		["36"] = "20:16",
		["38"] = "20:16",
		["40"] = "20:16",
		["42"] = "20:9",
		["43"] = "16:5",
		["44"] = "7:14",
		["45"] = "6:2",
		["46"] = "6:2",
		["47"] = "6:19",
		["48"] = "6:2",
		["50"] = "6:2",
		["51"] = "7:14",
		["53"] = "7:14",
		["54"] = "24:1",
		["55"] = "25:14",
		["56"] = "24:1",
		["57"] = "25:44",
		["58"] = "26:5",
		["59"] = "27:9",
		["60"] = "26:5",
		["61"] = "30:5",
		["62"] = "31:9",
		["63"] = "30:5",
		["64"] = "34:5",
		["65"] = "35:9",
		["66"] = "34:5",
		["67"] = "38:5",
		["68"] = "39:9",
		["69"] = "38:5",
		["70"] = "42:5",
		["71"] = "43:9",
		["72"] = "42:5",
		["73"] = "46:5",
		["74"] = "47:9",
		["75"] = "46:5",
		["76"] = "50:5",
		["77"] = "51:14",
		["80"] = "52:9",
		["81"] = "52:21",
		["82"] = "52:52",
		["83"] = "52:9",
		["84"] = "50:5",
		["85"] = "55:5",
		["86"] = "56:9",
		["87"] = "55:5",
		["88"] = "25:14",
		["89"] = "24:2",
		["90"] = "24:2",
		["91"] = "24:19",
		["92"] = "24:2",
		["94"] = "24:2",
		["95"] = "25:14",
		["97"] = "25:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
____exports.sl_modifier_bless_10214 = __TS__Class()
local sl_modifier_bless_10214 = ____exports.sl_modifier_bless_10214
sl_modifier_bless_10214.name = "sl_modifier_bless_10214"
__TS__ClassExtends(sl_modifier_bless_10214, sl_modifier_transmitter_data)
function sl_modifier_bless_10214.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10214.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10214.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local target = event.target
	if not IsValid(target) then
		return 0
	end
	if not target:PassivesDisabled() then
		return 0
	end
	local ____table__params_damage_amp_0 = self._params
	if ____table__params_damage_amp_0 ~= nil then
		____table__params_damage_amp_0 = ____table__params_damage_amp_0.damage_amp
	end
	local ____table__params_damage_amp_0_2 = ____table__params_damage_amp_0
	if ____table__params_damage_amp_0_2 == nil then
		____table__params_damage_amp_0_2 = 0
	end
	return ____table__params_damage_amp_0_2
end
sl_modifier_bless_10214 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10214", nil, getfenv()) },
	sl_modifier_bless_10214
)
____exports.sl_modifier_bless_10214 = sl_modifier_bless_10214
____exports.sl_modifier_bless_10214_break = __TS__Class()
local sl_modifier_bless_10214_break = ____exports.sl_modifier_bless_10214_break
sl_modifier_bless_10214_break.name = "sl_modifier_bless_10214_break"
__TS__ClassExtends(sl_modifier_bless_10214_break, SLModifierBase_Debuff)
function sl_modifier_bless_10214_break.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10214_break.prototype.GetTexture(self)
	return "buff/bless/10214"
end
function sl_modifier_bless_10214_break.prototype.IsPermanent(self)
	return false
end
function sl_modifier_bless_10214_break.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_bless_10214_break.prototype.GetEffectName(self)
	return BLESS_PARTICLES.bless_10214_silver_edge
end
function sl_modifier_bless_10214_break.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function sl_modifier_bless_10214_break.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	EmitSoundOn("DOTA_Item.SilverEdge.Target", self:GetParent())
end
function sl_modifier_bless_10214_break.prototype.CheckState(self)
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
end
sl_modifier_bless_10214_break = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10214", nil, getfenv()) },
	sl_modifier_bless_10214_break
)
____exports.sl_modifier_bless_10214_break = sl_modifier_bless_10214_break
return ____exports