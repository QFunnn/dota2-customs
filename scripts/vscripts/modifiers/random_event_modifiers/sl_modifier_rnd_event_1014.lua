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
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
--- 袍泽：可叠层全护盾，在 time 秒内线性衰减
____exports.sl_modifier_rnd_event_1014 = __TS__Class()
local sl_modifier_rnd_event_1014 = ____exports.sl_modifier_rnd_event_1014
sl_modifier_rnd_event_1014.name = "sl_modifier_rnd_event_1014"
__TS__ClassExtends(sl_modifier_rnd_event_1014, sl_modifier_shield_all)
function sl_modifier_rnd_event_1014.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_rnd_event_1014.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1014.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_rnd_event_1014.prototype.IsPermanent(self)
	return false
end
function sl_modifier_rnd_event_1014.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	sl_modifier_shield_all.prototype.OnCreated(self, params)
	local ____params_time_0 = params.time
	if ____params_time_0 == nil then
		____params_time_0 = self:GetDuration()
	end
	local time = ____params_time_0
	local ____params_shield_amount_max_1 = params.shield_amount_max
	if ____params_shield_amount_max_1 == nil then
		____params_shield_amount_max_1 = 0
	end
	local max = ____params_shield_amount_max_1
	if time <= 0 or max <= 0 then
		self:Destroy()
		return
	end
	self._decay_per_tick = max / time * ____exports.sl_modifier_rnd_event_1014._TICK
	self:StartIntervalThink(____exports.sl_modifier_rnd_event_1014._TICK)
end
function sl_modifier_rnd_event_1014.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local current = self:GetCurrentShieldAmount()
	local next = current - self._decay_per_tick
	if next <= 0 then
		self:Destroy()
		return
	end
	self:_ApplyParam({
		shield_amount_max = self:GetMaxShieldAmount(),
		shield_amount = next,
	})
end
sl_modifier_rnd_event_1014._TICK = 0.1
sl_modifier_rnd_event_1014 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1014") },
	sl_modifier_rnd_event_1014
)
____exports.sl_modifier_rnd_event_1014 = sl_modifier_rnd_event_1014
return ____exports