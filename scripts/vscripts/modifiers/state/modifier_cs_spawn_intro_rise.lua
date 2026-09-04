--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_cs_spawn_intro_rise = __TS__Class()
local modifier_cs_spawn_intro_rise = ____exports.modifier_cs_spawn_intro_rise
modifier_cs_spawn_intro_rise.name = "modifier_cs_spawn_intro_rise"
__TS__ClassExtends(modifier_cs_spawn_intro_rise, BaseModifier)
function modifier_cs_spawn_intro_rise.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self._duration = 1
	self._elapsed = 0
end
function modifier_cs_spawn_intro_rise.prototype.IsDebuff(self)
	return false
end
function modifier_cs_spawn_intro_rise.prototype.IsHidden(self)
	return true
end
function modifier_cs_spawn_intro_rise.prototype.IsPurgable(self)
	return false
end
function modifier_cs_spawn_intro_rise.prototype.IsPurgeException(self)
	return false
end
function modifier_cs_spawn_intro_rise.prototype.IsPermanent(self)
	return false
end
function modifier_cs_spawn_intro_rise.prototype.RemoveOnDeath(self)
	return true
end
function modifier_cs_spawn_intro_rise.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	self._endPos = parent:GetAbsOrigin()
	self._startPos = self._endPos + Vector(0, 0, -100)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
	parent:SetAbsOrigin(self._startPos)
	self._elapsed = 0
	self:OnIntervalThink()
	self:StartIntervalThink(FrameTime())
end
function modifier_cs_spawn_intro_rise.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	if not self._startPos or not self._endPos then
		self:Destroy()
		return
	end
	self._elapsed = self._elapsed + FrameTime()
	local t = math.min(self._elapsed / self._duration, 1)
	local pos = self._startPos + (self._endPos - self._startPos) * t
	parent:SetAbsOrigin(pos)
	if t >= 1 then
		parent:SetAbsOrigin(self._endPos)
		self:Destroy()
	end
end
function modifier_cs_spawn_intro_rise.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:SetOnClearGround(true)
end
function modifier_cs_spawn_intro_rise.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_STUNNED] = true }
end
modifier_cs_spawn_intro_rise = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_cs_spawn_intro_rise)
____exports.modifier_cs_spawn_intro_rise = modifier_cs_spawn_intro_rise
return ____exports