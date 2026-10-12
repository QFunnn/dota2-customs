--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10031.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10031.lua",
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
		["20"] = "10:5",
		["21"] = "11:9",
		["22"] = "10:5",
		["23"] = "14:5",
		["24"] = "15:9",
		["25"] = "14:5",
		["26"] = "18:5",
		["27"] = "19:14",
		["30"] = "20:9",
		["31"] = "21:9",
		["32"] = "18:5",
		["33"] = "24:5",
		["34"] = "25:9",
		["35"] = "24:5",
		["36"] = "28:5",
		["37"] = "29:9",
		["38"] = "28:5",
		["39"] = "32:5",
		["40"] = "33:9",
		["41"] = "32:5",
		["42"] = "36:5",
		["43"] = "37:24",
		["45"] = "37:24",
		["47"] = "37:15",
		["48"] = "38:9",
		["49"] = "36:5",
		["50"] = "7:14",
		["51"] = "6:2",
		["52"] = "6:2",
		["53"] = "6:19",
		["54"] = "6:2",
		["56"] = "6:2",
		["57"] = "7:14",
		["59"] = "7:14",
		["60"] = "47:1",
		["61"] = "48:14",
		["62"] = "47:1",
		["63"] = "48:59",
		["64"] = "48:14",
		["65"] = "47:2",
		["66"] = "47:2",
		["67"] = "47:19",
		["68"] = "47:2",
		["70"] = "47:2",
		["71"] = "48:14",
		["73"] = "48:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_override_attack_rate = ____sl_modifier_simple.sl_modifier_override_attack_rate
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10031 = __TS__Class()
local sl_modifier_bless_10031 = ____exports.sl_modifier_bless_10031
sl_modifier_bless_10031.name = "sl_modifier_bless_10031"
__TS__ClassExtends(sl_modifier_bless_10031, SLModifierBase)
function sl_modifier_bless_10031.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10031.prototype.GetTexture(self)
	return "buff/bless/10031"
end
function sl_modifier_bless_10031.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._factor = params.factor
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_bless_10031.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
end
function sl_modifier_bless_10031.prototype.HandleCustomTransmitterData(self, data)
	self._factor = data.factor
end
function sl_modifier_bless_10031.prototype.AddCustomTransmitterData(self)
	return { factor = self._factor }
end
function sl_modifier_bless_10031.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____self__factor_0 = self._factor
	if ____self__factor_0 == nil then
		____self__factor_0 = 0
	end
	local factor = ____self__factor_0
	return self:GetParent():GetAttackSpeed(false) * 100 * factor
end
sl_modifier_bless_10031 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10031", nil, getfenv()) },
	sl_modifier_bless_10031
)
____exports.sl_modifier_bless_10031 = sl_modifier_bless_10031
____exports.sl_modifier_bless_10031_override_attack_rate = __TS__Class()
local sl_modifier_bless_10031_override_attack_rate = ____exports.sl_modifier_bless_10031_override_attack_rate
sl_modifier_bless_10031_override_attack_rate.name = "sl_modifier_bless_10031_override_attack_rate"
__TS__ClassExtends(sl_modifier_bless_10031_override_attack_rate, sl_modifier_override_attack_rate)
sl_modifier_bless_10031_override_attack_rate = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10031", nil, getfenv()) },
	sl_modifier_bless_10031_override_attack_rate
)
____exports.sl_modifier_bless_10031_override_attack_rate = sl_modifier_bless_10031_override_attack_rate
return ____exports