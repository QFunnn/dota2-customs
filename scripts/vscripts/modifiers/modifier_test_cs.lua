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
____exports.modifier_test_cs = __TS__Class()
local modifier_test_cs = ____exports.modifier_test_cs
modifier_test_cs.name = "modifier_test_cs"
__TS__ClassExtends(modifier_test_cs, BaseModifier_CS)
function modifier_test_cs.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._attack_speed = 0
end
function modifier_test_cs.prototype.IsHidden(self)
	return false
end
function modifier_test_cs.prototype.IsDebuff(self)
	return false
end
function modifier_test_cs.prototype.IsPurgable(self)
	return false
end
function modifier_test_cs.prototype.IsPurgeException(self)
	return false
end
function modifier_test_cs.prototype.GetTexture(self)
	return "alchemist_chemical_rage"
end
function modifier_test_cs.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	DebugPrint(nil, "modifier_test_cs OnCreated")
	self:StartIntervalThink(FrameTime())
end
function modifier_test_cs.prototype.OnIntervalThink(self)
	DebugPrint(nil, "modifier_test_cs OnIntervalThink", self._parent:IsAttacking())
	DebugPrint(nil, "GetAttackTarget", self._parent:GetAttackTarget() and "true" or "false")
	DebugPrint(nil, "TimeUntilNextAttack", self._parent:TimeUntilNextAttack())
	DebugPrint(nil, "AttackReady", self._parent:AttackReady())
end
function modifier_test_cs.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
end
function modifier_test_cs.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_test_cs.prototype.GetAttributeBonus(self)
	return { attack_speed = self._attack_speed + 20 }
end
function modifier_test_cs.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	self._attack_speed = MyGameAttribute:GetAttribute(self._parent, "total_attack_speed")
	self:RefreshAttributes()
	self:PlayEffect()
	local attack_point = self._parent:GetAttackAnimationPoint() * 0.8
	Timers:CreateTimer(attack_point, function()
		self._attack_speed = 0
		self:RefreshAttributes()
	end)
end
function modifier_test_cs.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING }
end
function modifier_test_cs.prototype.GetModifierDisableTurning(self)
	return self._parent:TimeUntilNextAttack() > 0 and 1 or 0
end
function modifier_test_cs.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	self:PlayEffect2()
end
function modifier_test_cs.prototype.PlayEffect(self)
	if not IsServer() then
		return
	end
	local particle = "particles/monster/10001/attack_01.vpcf"
	local effect = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		effect,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetParent():GetAbsOrigin(),
		true
	)
	local target_pos = self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 100
	ParticleManager:SetParticleControl(effect, 1, target_pos)
	ParticleManager:ReleaseParticleIndex(effect)
	return effect
end
function modifier_test_cs.prototype.PlayEffect2(self)
	if not IsServer() then
		return
	end
	local particle = "particles/monster/10001/attack_02.vpcf"
	local effect = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	local target_pos = self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 100
	ParticleManager:SetParticleControl(effect, 0, target_pos)
	ParticleManager:SetParticleControl(effect, 1, target_pos)
	ParticleManager:ReleaseParticleIndex(effect)
	return effect
end
modifier_test_cs = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_test_cs)
____exports.modifier_test_cs = modifier_test_cs
return ____exports