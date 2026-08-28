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
--- 复仇：挂在复仇者身上，仅对标记目标增伤；标记目标头顶特效
____exports.sl_modifier_rnd_event_1016 = __TS__Class()
local sl_modifier_rnd_event_1016 = ____exports.sl_modifier_rnd_event_1016
sl_modifier_rnd_event_1016.name = "sl_modifier_rnd_event_1016"
__TS__ClassExtends(sl_modifier_rnd_event_1016, SLModifierBase)
function sl_modifier_rnd_event_1016.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1016.prototype.IsPermanent(self)
	return false
end
function sl_modifier_rnd_event_1016.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_rnd_event_1016.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
	self:_CreateMarkParticle()
end
function sl_modifier_rnd_event_1016.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_DestroyMarkParticle()
	self:_ApplyParam(params)
	self:_CreateMarkParticle()
end
function sl_modifier_rnd_event_1016.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:_DestroyMarkParticle()
end
function sl_modifier_rnd_event_1016.prototype._ApplyParam(self, params)
	self._damage_pct = params.damage_pct
	self._marked_target = params.marked_target
end
function sl_modifier_rnd_event_1016.prototype._CreateMarkParticle(self)
	local target = EntIndexToHScript(self._marked_target)
	if not IsValid(target) then
		return
	end
	self._overhead_pid =
		SParticleManager:CreateGenericParticle(BLESS_PARTICLES.bless_10034_head, PATTACH_OVERHEAD_FOLLOW, target)
end
function sl_modifier_rnd_event_1016.prototype._DestroyMarkParticle(self)
	if self._overhead_pid == nil then
		return
	end
	SParticleManager:DestroyParticle(self._overhead_pid, false)
	self._overhead_pid = nil
end
function sl_modifier_rnd_event_1016.prototype.GetMarkedTarget(self)
	local target = EntIndexToHScript(self._marked_target)
	if not IsValid(target) then
		return nil
	end
	return target
end
function sl_modifier_rnd_event_1016.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_rnd_event_1016.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	local parent = self:GetParent()
	if attacker ~= parent then
		return
	end
	if not IsValid(target) then
		return
	end
	if target:GetEntityIndex() ~= self._marked_target then
		return
	end
	return self._damage_pct
end
sl_modifier_rnd_event_1016 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1016") },
	sl_modifier_rnd_event_1016
)
____exports.sl_modifier_rnd_event_1016 = sl_modifier_rnd_event_1016
return ____exports