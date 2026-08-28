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
local BaseItem = ____dota_ts_adapter.BaseItem
____exports.SLItemBase = __TS__Class()
local SLItemBase = ____exports.SLItemBase
SLItemBase.name = "SLItemBase"
__TS__ClassExtends(SLItemBase, BaseItem)
function SLItemBase.prototype.CreateParticle(self, name, attach, owner)
	return SParticleManager:CreateItemParticle(self, name, attach, owner)
end
function SLItemBase.prototype.DestroyParticle(self, particle, immediate)
	SParticleManager:DestroyParticle(particle, immediate)
end
function SLItemBase.prototype.ReleaseParticleIndex(self, particle)
	SParticleManager:ReleaseParticleIndex(particle)
end
function SLItemBase.prototype.SetParticleControl(self, particle, control_point, value)
	SParticleManager:SetParticleControl(particle, control_point, value)
end
function SLItemBase.prototype.SetParticleControlEnt(
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
function SLItemBase.prototype.SetParticleControlTransform(self, fx_index, point, origin, q_angles)
	SParticleManager:SetParticleControlTransform(fx_index, point, origin, q_angles)
end
function SLItemBase.prototype.SetParticleControlTransformForward(self, fx_index, point, origin, forward)
	SParticleManager:SetParticleControlTransformForward(fx_index, point, origin, forward)
end
function SLItemBase.prototype.SetParticleAlwaysSimulate(self, pid)
	SParticleManager:SetParticleAlwaysSimulate(pid)
end
function SLItemBase.prototype.AddStatusEffect(self, unit, effect)
	return SParticleManager:AddStatusEffect(unit, effect, 2, self)
end
return ____exports