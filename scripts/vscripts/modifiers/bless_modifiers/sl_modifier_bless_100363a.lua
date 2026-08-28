--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100363a") },
	sl_modifier_bless_100363a
)
____exports.sl_modifier_bless_100363a = sl_modifier_bless_100363a
return ____exports