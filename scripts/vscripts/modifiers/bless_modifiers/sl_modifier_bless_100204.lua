--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
____exports.sl_modifier_bless_100204 = __TS__Class()
local sl_modifier_bless_100204 = ____exports.sl_modifier_bless_100204
sl_modifier_bless_100204.name = "sl_modifier_bless_100204"
__TS__ClassExtends(sl_modifier_bless_100204, SLModifierBase_Debuff)
function sl_modifier_bless_100204.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_100204.prototype.GetTexture(self)
	return "buff/bless/100204"
end
function sl_modifier_bless_100204.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
function sl_modifier_bless_100204.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function sl_modifier_bless_100204.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetCaster() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	self:ExtendDuration(self:GetDelay())
end
function sl_modifier_bless_100204.prototype.ExtendDuration(self, extraDuration)
	if not IsServer() then
		return
	end
	if extraDuration <= 0 then
		return
	end
	local remainingTime = self:GetRemainingTime()
	local newDuration = remainingTime + extraDuration
	self:SetDuration(newDuration, true)
end
function sl_modifier_bless_100204.prototype.OnCreated(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_100204.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_100204.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	self._params = params
end
function sl_modifier_bless_100204.prototype.GetBaseDuration(self)
	local ____table__params_base_duration_0 = self._params
	if ____table__params_base_duration_0 ~= nil then
		____table__params_base_duration_0 = ____table__params_base_duration_0.base_duration
	end
	local ____table__params_base_duration_0_2 = ____table__params_base_duration_0
	if ____table__params_base_duration_0_2 == nil then
		____table__params_base_duration_0_2 = 0
	end
	return ____table__params_base_duration_0_2
end
function sl_modifier_bless_100204.prototype.GetDelay(self)
	local ____table__params_delay_3 = self._params
	if ____table__params_delay_3 ~= nil then
		____table__params_delay_3 = ____table__params_delay_3.delay
	end
	local ____table__params_delay_3_5 = ____table__params_delay_3
	if ____table__params_delay_3_5 == nil then
		____table__params_delay_3_5 = 0
	end
	return ____table__params_delay_3_5
end
sl_modifier_bless_100204 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100204") },
	sl_modifier_bless_100204
)
____exports.sl_modifier_bless_100204 = sl_modifier_bless_100204
return ____exports