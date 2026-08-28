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
--- 袍泽：单实例全护盾（叠层时累加剩余值后刷新），在 time 秒内线性衰减
____exports.sl_modifier_rnd_event_1022 = __TS__Class()
local sl_modifier_rnd_event_1022 = ____exports.sl_modifier_rnd_event_1022
sl_modifier_rnd_event_1022.name = "sl_modifier_rnd_event_1022"
__TS__ClassExtends(sl_modifier_rnd_event_1022, sl_modifier_shield_all)
function sl_modifier_rnd_event_1022.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1022.prototype.GetTexture(self)
	return "buff/rnd_event_1022"
end
function sl_modifier_rnd_event_1022.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_rnd_event_1022.prototype.IsPermanent(self)
	return false
end
function sl_modifier_rnd_event_1022.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	sl_modifier_shield_all.prototype.OnCreated(self, params)
	self:_StartDecay(params)
end
function sl_modifier_rnd_event_1022.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	sl_modifier_shield_all.prototype.OnRefresh(self, params)
	self:_StartDecay(params)
end
function sl_modifier_rnd_event_1022.prototype.OnIntervalThink(self)
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
function sl_modifier_rnd_event_1022.prototype._StartDecay(self, params)
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
	self._decay_per_tick = max / time * ____exports.sl_modifier_rnd_event_1022._TICK
	self:StartIntervalThink(____exports.sl_modifier_rnd_event_1022._TICK)
end
sl_modifier_rnd_event_1022._TICK = 0.1
sl_modifier_rnd_event_1022 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1022") },
	sl_modifier_rnd_event_1022
)
____exports.sl_modifier_rnd_event_1022 = sl_modifier_rnd_event_1022
return ____exports