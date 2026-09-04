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
local BaseModifier = ____dota_ts_adapter.BaseModifier
--- 转职演出用的空白 Buff（占位）
-- - 目前不包含任何逻辑
-- - 后续可在这里补充粒子、音效、镜头/禁用操作等演出行为
____exports.modifier_job_change_cinematic = __TS__Class()
local modifier_job_change_cinematic = ____exports.modifier_job_change_cinematic
modifier_job_change_cinematic.name = "modifier_job_change_cinematic"
__TS__ClassExtends(modifier_job_change_cinematic, BaseModifier)
function modifier_job_change_cinematic.prototype.IsDebuff(self)
	return false
end
function modifier_job_change_cinematic.prototype.IsHidden(self)
	return true
end
function modifier_job_change_cinematic.prototype.IsPurgable(self)
	return false
end
function modifier_job_change_cinematic.prototype.IsPurgeException(self)
	return false
end
function modifier_job_change_cinematic.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:PlayEffects()
end
function modifier_job_change_cinematic.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._pfx then
		ParticleManager:DestroyParticle(self._pfx, false)
		ParticleManager:ReleaseParticleIndex(self._pfx)
	end
end
function modifier_job_change_cinematic.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
function modifier_job_change_cinematic.prototype.PlayEffects(self)
	local parent = self:GetParent()
	self._pfx = ParticleManager:CreateParticle(
		"particles/unit/tp_pfxecon/events/compendium_2023/compendium_2023_teleport_rewardline_lvl1.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self._pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self._pfx,
		2,
		parent,
		PATTACH_ABSORIGIN,
		"attach_hitloc",
		parent:GetAbsOrigin() + Vector(0, 0, 10),
		false
	)
	ParticleManager:SetParticleControlEnt(
		self._pfx,
		3,
		parent,
		PATTACH_ABSORIGIN,
		"attach_hitloc",
		parent:GetAbsOrigin() + Vector(0, 0, 10),
		false
	)
	ParticleManager:SetParticleControl(self._pfx, 4, Vector(1, 0, 0))
	ParticleManager:SetParticleControl(self._pfx, 5, parent:GetAbsOrigin() + Vector(0, 0, 10))
end
function modifier_job_change_cinematic.prototype.RemoveOnDeath(self)
	return false
end
modifier_job_change_cinematic = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_job_change_cinematic)
____exports.modifier_job_change_cinematic = modifier_job_change_cinematic
return ____exports