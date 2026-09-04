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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local TREASURE_FOUNDATION_PFX = "particles/bb/map/treasure_foundation.vpcf"
local PFX_CP1_X = 2
local PFX_CP11_X = 1
local MAX_FRAME = 19
local DEFAULT_OPEN_DURATION = 1
local DEFAULT_CLOSE_DURATION = 1
____exports.modifier_treasure_foundation_fx = __TS__Class()
local modifier_treasure_foundation_fx = ____exports.modifier_treasure_foundation_fx
modifier_treasure_foundation_fx.name = "modifier_treasure_foundation_fx"
__TS__ClassExtends(modifier_treasure_foundation_fx, BaseModifier_CS)
function modifier_treasure_foundation_fx.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._frame = 0
	self._cp1z = 0
	self._animToken = 0
end
function modifier_treasure_foundation_fx.prototype.IsHidden(self)
	return true
end
function modifier_treasure_foundation_fx.prototype.IsPurgable(self)
	return false
end
function modifier_treasure_foundation_fx.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:CreatePfx()
	local initialFrame = tonumber(params and params.initial_frame) or 0
	self:SetFrame(initialFrame)
end
function modifier_treasure_foundation_fx.prototype.SetFrame(self, frame)
	self._frame = math.max(0, math.min(MAX_FRAME, frame))
	self:UpdateCp1()
end
function modifier_treasure_foundation_fx.prototype.SetCp1Z(self, z)
	self._cp1z = z
	self:UpdateCp1()
end
function modifier_treasure_foundation_fx.prototype.UpdateCp1(self)
	if not self._pfx then
		return
	end
	ParticleManager:SetParticleControl(self._pfx, 1, Vector(PFX_CP1_X, self._frame, self._cp1z))
end
function modifier_treasure_foundation_fx.prototype.PlayOpen(self, duration)
	if duration == nil then
		duration = DEFAULT_OPEN_DURATION
	end
	self:PlayFrame(self._frame, MAX_FRAME, duration)
end
function modifier_treasure_foundation_fx.prototype.PlayClose(self, duration)
	if duration == nil then
		duration = DEFAULT_CLOSE_DURATION
	end
	self:PlayFrame(self._frame, 0, duration)
end
function modifier_treasure_foundation_fx.prototype.PlayFrame(self, from, to, duration)
	local safeDuration = math.max(0.01, duration)
	local ____self_2, ____animToken_3 = self, "_animToken"
	local ____self__animToken_4 = ____self_2[____animToken_3] + 1
	____self_2[____animToken_3] = ____self__animToken_4
	local token = ____self__animToken_4
	local elapsed = 0
	self:SetFrame(from)
	Timers:CreateTimer(0, function()
		if token ~= self._animToken then
			return nil
		end
		if self:IsNull() then
			return nil
		end
		local parent = self:GetParent()
		if not IsValid(nil, parent) or parent:IsNull() then
			return nil
		end
		elapsed = elapsed + FrameTime()
		local t = math.min(elapsed / safeDuration, 1)
		local frame = from + (to - from) * t
		self:SetFrame(frame)
		if t >= 1 then
			return nil
		end
		return FrameTime()
	end)
end
function modifier_treasure_foundation_fx.prototype.CreatePfx(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	local pfx = ParticleManager:CreateParticle(TREASURE_FOUNDATION_PFX, PATTACH_POINT_FOLLOW, parent)
	ParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 1, Vector(PFX_CP1_X, 0, 0))
	ParticleManager:SetParticleControl(pfx, 11, Vector(PFX_CP11_X, 0, 0))
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	self._pfx = pfx
end
function modifier_treasure_foundation_fx.prototype.GetPfx(self)
	return self._pfx
end
function modifier_treasure_foundation_fx.prototype.DestroyPfx(self)
	if not self._pfx then
		return
	end
	ParticleManager:DestroyParticle(self._pfx, false)
	ParticleManager:ReleaseParticleIndex(self._pfx)
	self._pfx = nil
end
function modifier_treasure_foundation_fx.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self._animToken = self._animToken + 1
	self:DestroyPfx()
end
modifier_treasure_foundation_fx =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_treasure_foundation_fx") }, modifier_treasure_foundation_fx)
____exports.modifier_treasure_foundation_fx = modifier_treasure_foundation_fx
return ____exports