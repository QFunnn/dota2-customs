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
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
____exports.SLAbilityBase = __TS__Class()
local SLAbilityBase = ____exports.SLAbilityBase
SLAbilityBase.name = "SLAbilityBase"
__TS__ClassExtends(SLAbilityBase, BaseAbility)
function SLAbilityBase.prototype.CreateParticle(self, name, attach, owner)
	return SParticleManager:CreateAbilityParticle(self, name, attach, owner)
end
function SLAbilityBase.prototype.DestroyParticle(self, particle, immediate)
	SParticleManager:DestroyParticle(particle, immediate)
end
function SLAbilityBase.prototype.ReleaseParticleIndex(self, particle)
	SParticleManager:ReleaseParticleIndex(particle)
end
function SLAbilityBase.prototype.SetParticleControl(self, particle, control_point, value)
	SParticleManager:SetParticleControl(particle, control_point, value)
end
function SLAbilityBase.prototype.SetParticleControlEnt(
	self,
	particle,
	control_point,
	unit,
	particle_attach,
	attachment,
	offset,
	lock_orientation
)
	SParticleManager:SetParticleControlEnt(
		particle,
		control_point,
		unit,
		particle_attach,
		attachment,
		offset,
		lock_orientation
	)
end
function SLAbilityBase.prototype.SetParticleControlTransform(self, fx_index, point, origin, q_angles)
	SParticleManager:SetParticleControlTransform(fx_index, point, origin, q_angles)
end
function SLAbilityBase.prototype.SetParticleControlTransformForward(self, fx_index, point, origin, forward)
	SParticleManager:SetParticleControlTransformForward(fx_index, point, origin, forward)
end
function SLAbilityBase.prototype.SetParticleAlwaysSimulate(self, pid)
	SParticleManager:SetParticleAlwaysSimulate(pid)
end
function SLAbilityBase.prototype.AddStatusEffect(self, unit, effect)
	return SParticleManager:AddStatusEffect(unit, effect, 3, self)
end
return ____exports