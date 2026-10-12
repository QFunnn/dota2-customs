--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10158.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10158.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:38",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "14:5",
		["25"] = "15:9",
		["26"] = "14:5",
		["27"] = "18:5",
		["28"] = "19:9",
		["29"] = "18:5",
		["30"] = "22:5",
		["31"] = "23:14",
		["34"] = "24:9",
		["35"] = "24:9",
		["36"] = "24:9",
		["38"] = "22:5",
		["39"] = "5:14",
		["40"] = "4:2",
		["41"] = "4:2",
		["42"] = "4:19",
		["43"] = "4:2",
		["45"] = "4:2",
		["46"] = "5:14",
		["48"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10158 = __TS__Class()
local sl_modifier_bless_10158 = ____exports.sl_modifier_bless_10158
sl_modifier_bless_10158.name = "sl_modifier_bless_10158"
__TS__ClassExtends(sl_modifier_bless_10158, SLModifierBase)
function sl_modifier_bless_10158.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
		MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
	}
end
function sl_modifier_bless_10158.prototype.GetModifierAttackSpeed_Limit(self)
	return 1
end
function sl_modifier_bless_10158.prototype.OnDamageCalculated(self, event)
	self:Destroy()
end
function sl_modifier_bless_10158.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return 500
end
function sl_modifier_bless_10158.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____table_GetParent_result_AttackNoEarlierThan_result_0 = self:GetParent()
	if ____table_GetParent_result_AttackNoEarlierThan_result_0 ~= nil then
		____table_GetParent_result_AttackNoEarlierThan_result_0 =
			____table_GetParent_result_AttackNoEarlierThan_result_0:AttackNoEarlierThan(0, 0)
	end
end
sl_modifier_bless_10158 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10158", nil, getfenv()) },
	sl_modifier_bless_10158
)
____exports.sl_modifier_bless_10158 = sl_modifier_bless_10158
return ____exports