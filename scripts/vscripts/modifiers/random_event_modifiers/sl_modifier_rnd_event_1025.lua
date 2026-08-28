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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 赵云：杀敌最高，输出↑ 承伤↑ + overhead
____exports.sl_modifier_rnd_event_1025_zhao = __TS__Class()
local sl_modifier_rnd_event_1025_zhao = ____exports.sl_modifier_rnd_event_1025_zhao
sl_modifier_rnd_event_1025_zhao.name = "sl_modifier_rnd_event_1025_zhao"
__TS__ClassExtends(sl_modifier_rnd_event_1025_zhao, SLModifierBase)
function sl_modifier_rnd_event_1025_zhao.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1025_zhao.prototype.GetTexture(self)
	return "buff/rnd_event_1025_zhaoyun"
end
function sl_modifier_rnd_event_1025_zhao.prototype.IsPermanent(self)
	return false
end
function sl_modifier_rnd_event_1025_zhao.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_rnd_event_1025_zhao.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
	self._overhead_pid = SParticleManager:CreateGenericParticle(
		GENERIC_PARTICLES.rnd_event_1025_zhaoyun_overhead,
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
end
function sl_modifier_rnd_event_1025_zhao.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_rnd_event_1025_zhao.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._overhead_pid == nil then
		return
	end
	SParticleManager:DestroyParticle(self._overhead_pid, false)
	self._overhead_pid = nil
end
function sl_modifier_rnd_event_1025_zhao.prototype._ApplyParam(self, params)
	self:_SetParentAttr("shI", params.shI)
	self:_SetParentAttr("csshI", params.csshI)
end
sl_modifier_rnd_event_1025_zhao = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1025") },
	sl_modifier_rnd_event_1025_zhao
)
____exports.sl_modifier_rnd_event_1025_zhao = sl_modifier_rnd_event_1025_zhao
--- 阿斗：死亡最高，承伤↓ + overhead
____exports.sl_modifier_rnd_event_1025_a_dou = __TS__Class()
local sl_modifier_rnd_event_1025_a_dou = ____exports.sl_modifier_rnd_event_1025_a_dou
sl_modifier_rnd_event_1025_a_dou.name = "sl_modifier_rnd_event_1025_a_dou"
__TS__ClassExtends(sl_modifier_rnd_event_1025_a_dou, SLModifierBase)
function sl_modifier_rnd_event_1025_a_dou.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1025_a_dou.prototype.GetTexture(self)
	return "buff/rnd_event_1025_adou"
end
function sl_modifier_rnd_event_1025_a_dou.prototype.IsPermanent(self)
	return false
end
function sl_modifier_rnd_event_1025_a_dou.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_rnd_event_1025_a_dou.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
	self._overhead_pid = SParticleManager:CreateGenericParticle(
		GENERIC_PARTICLES.rnd_event_1025_adou_overhead,
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
end
function sl_modifier_rnd_event_1025_a_dou.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_rnd_event_1025_a_dou.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._overhead_pid == nil then
		return
	end
	SParticleManager:DestroyParticle(self._overhead_pid, false)
	self._overhead_pid = nil
end
function sl_modifier_rnd_event_1025_a_dou.prototype._ApplyParam(self, params)
	self:_SetParentAttr("csshI", -params.csshI)
end
sl_modifier_rnd_event_1025_a_dou = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1025") },
	sl_modifier_rnd_event_1025_a_dou
)
____exports.sl_modifier_rnd_event_1025_a_dou = sl_modifier_rnd_event_1025_a_dou
return ____exports