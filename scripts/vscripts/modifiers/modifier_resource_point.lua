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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 资源采集点 / 建筑专用受击反馈 Modifier
--
-- - 建议只挂在 UnitType.BUILDING（或你的资源点单位）上
-- - 具体的受击/死亡表现逻辑请在对应回调中自行实现
local modifier_resource_point = __TS__Class()
modifier_resource_point.name = "modifier_resource_point"
__TS__ClassExtends(modifier_resource_point, BaseModifier_CS)
function modifier_resource_point.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.hit_particle = "particles/econ/events/frostivus/frostivus_tree_cast.vpcf"
	self.default_particle = "particles/econ/events/frostivus/frostivus_versus_tree.vpcf"
end
function modifier_resource_point.prototype.IsHidden(self)
	return true
end
function modifier_resource_point.prototype.IsPurgable(self)
	return false
end
function modifier_resource_point.prototype.IsDebuff(self)
	return false
end
function modifier_resource_point.prototype.IsPermanent(self)
	return true
end
function modifier_resource_point.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_resource_point.prototype.OnTakeAttackLanded_CS(self, event)
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	self:PlayHitParticle(parent)
end
function modifier_resource_point.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:GetParent():SetHullRadius(200)
	self:GetParent():SetAngles(0, 270, 0)
	self:PlayDefaultParticle(self:GetParent())
	FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
end
function modifier_resource_point.prototype.PlayHitParticle(self, parent)
	local particle = ParticleManager:CreateParticle(self.hit_particle, PATTACH_POINT, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin() + Vector(0, 0, 450))
	ParticleManager:ReleaseParticleIndex(particle)
end
function modifier_resource_point.prototype.PlayDefaultParticle(self, parent)
	local particle = ParticleManager:CreateParticle(self.default_particle, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 2, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end
modifier_resource_point = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_resource_point)
return ____exports