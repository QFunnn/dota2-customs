--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_100363a.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_100363a.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:40",
		["19"] = "5:48",
		["20"] = "22:5",
		["21"] = "4:1",
		["22"] = "6:5",
		["23"] = "7:9",
		["24"] = "6:5",
		["25"] = "10:5",
		["26"] = "11:9",
		["27"] = "10:5",
		["28"] = "14:5",
		["29"] = "15:9",
		["30"] = "14:5",
		["31"] = "18:5",
		["32"] = "19:9",
		["33"] = "18:5",
		["34"] = "23:5",
		["35"] = "24:14",
		["38"] = "25:30",
		["39"] = "25:42",
		["40"] = "25:42",
		["41"] = "25:42",
		["43"] = "25:42",
		["45"] = "25:42",
		["47"] = "25:9",
		["48"] = "23:5",
		["49"] = "28:5",
		["50"] = "29:9",
		["51"] = "28:5",
		["52"] = "32:5",
		["53"] = "33:9",
		["54"] = "32:5",
		["55"] = "5:14",
		["56"] = "4:2",
		["57"] = "4:2",
		["58"] = "4:19",
		["59"] = "4:2",
		["61"] = "4:2",
		["62"] = "5:14",
		["64"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_invisible_non_break = ____sl_modifier_simple.sl_modifier_invisible_non_break
____exports.sl_modifier_bless_100363a = __TS__Class()
local sl_modifier_bless_100363a = ____exports.sl_modifier_bless_100363a
sl_modifier_bless_100363a.name = "sl_modifier_bless_100363a"
__TS__ClassExtends(sl_modifier_bless_100363a, sl_modifier_invisible_non_break)
function sl_modifier_bless_100363a.prototype.____constructor(self, ...)
	sl_modifier_invisible_non_break.prototype.____constructor(self, ...)
	self._damageReduce = 0
end
function sl_modifier_bless_100363a.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_100363a.prototype.IsPurgable(self)
	return false
end
function sl_modifier_bless_100363a.prototype.OnCreated(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_100363a.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_100363a.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____math_max_3 = math.max
	local ____params_damage_reduce_0 = params
	if ____params_damage_reduce_0 ~= nil then
		____params_damage_reduce_0 = ____params_damage_reduce_0.damage_reduce
	end
	local ____params_damage_reduce_0_2 = ____params_damage_reduce_0
	if ____params_damage_reduce_0_2 == nil then
		____params_damage_reduce_0_2 = 0
	end
	self._damageReduce = ____math_max_3(0, ____params_damage_reduce_0_2)
end
function sl_modifier_bless_100363a.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL, MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_bless_100363a.prototype.GetModifierIncomingDamage_Percentage(self)
	return -self._damageReduce
end
sl_modifier_bless_100363a = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100363a", nil, getfenv()) },
	sl_modifier_bless_100363a
)
____exports.sl_modifier_bless_100363a = sl_modifier_bless_100363a
return ____exports