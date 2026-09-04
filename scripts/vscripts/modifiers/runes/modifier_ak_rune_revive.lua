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
local playRuneReviveFinishEffect, RUNE_REVIVE_FINISH_EFFECT
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
function playRuneReviveFinishEffect(self, parent)
	local effect = ParticleManager:CreateParticle(RUNE_REVIVE_FINISH_EFFECT, PATTACH_ABSORIGIN_FOLLOW, parent)
	local origin = parent:GetAbsOrigin()
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControl(effect, 1, origin)
	ParticleManager:SetParticleControl(effect, 2, origin)
	ParticleManager:ReleaseParticleIndex(effect)
end
local RUNE_REVIVE_DELAY = 3
local RUNE_REVIVE_RESTORE_PCT = 50
local RUNE_REVIVE_PRIORITY = DeathRevivePriority.STATUS - 1
local RUNE_REVIVE_WAITING_EFFECT = "particles/items_fx/aegis_timer.vpcf"
RUNE_REVIVE_FINISH_EFFECT = "particles/items_fx/aegis_respawn.vpcf"
local RUNE_REVIVE_SOUND = "DOTAMusic_Hero.Reincarnate"
local function playRuneReviveWaitingEffect(self, parent)
	local effect = ParticleManager:CreateParticle(RUNE_REVIVE_WAITING_EFFECT, PATTACH_ABSORIGIN_FOLLOW, parent)
	local origin = parent:GetAbsOrigin()
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControl(effect, 1, origin)
	parent:EmitSound(RUNE_REVIVE_SOUND)
	return effect
end
local function finishRuneRevive(self, parent, waitingEffect)
	ParticleManager:DestroyParticle(waitingEffect, true)
	ParticleManager:ReleaseParticleIndex(waitingEffect)
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	if parent:HasModifier("modifier_generic_fake_death") then
		parent:RemoveModifierByName("modifier_generic_fake_death")
	end
	local restorePct = RUNE_REVIVE_RESTORE_PCT / 100
	parent:SetHealth(math.max(1, parent:GetMaxHealth() * restorePct))
	parent:SetMana(math.max(0, parent:GetMaxMana() * restorePct))
	playRuneReviveFinishEffect(nil, parent)
end
____exports.modifier_ak_rune_revive = __TS__Class()
local modifier_ak_rune_revive = ____exports.modifier_ak_rune_revive
modifier_ak_rune_revive.name = "modifier_ak_rune_revive"
__TS__ClassExtends(modifier_ak_rune_revive, BaseModifier_CS)
function modifier_ak_rune_revive.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.triggered = false
end
function modifier_ak_rune_revive.GetLocalizationCN(self)
	return {
		name = "复活神符",
		description = "持续期间受到致死伤害时优先消耗，进入复活流程并恢复 50%% 最大生命值与魔法值。",
	}
end
function modifier_ak_rune_revive.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.triggered = false
	self:UpdateRemainingSeconds()
	self:StartIntervalThink(1)
end
function modifier_ak_rune_revive.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self.triggered = false
	self:UpdateRemainingSeconds()
	self:StartIntervalThink(1)
end
function modifier_ak_rune_revive.prototype.OnIntervalThink(self)
	self:UpdateRemainingSeconds()
end
function modifier_ak_rune_revive.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH_INTERCEPT, priority = RUNE_REVIVE_PRIORITY } }
end
function modifier_ak_rune_revive.prototype.OnUnitDeathIntercept_CS(self, event)
	if not IsServer() then
		return
	end
	if event.prevented then
		return
	end
	if self.triggered then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.victim ~= parent then
		return
	end
	if parent:HasModifier("modifier_generic_fake_death") then
		return
	end
	self.triggered = true
	event.prevented = true
	event.handled_by = self:GetName()
	event.intercept_type = "fake_death"
	event.set_health = 1
	parent:AddNewModifier(parent, self:GetAbility(), "modifier_generic_fake_death", { duration = RUNE_REVIVE_DELAY })
	local waitingEffect = playRuneReviveWaitingEffect(nil, parent)
	self:Destroy()
	Timers:CreateTimer(math.max(0.1, RUNE_REVIVE_DELAY + FrameTime()), function()
		finishRuneRevive(nil, parent, waitingEffect)
	end)
end
function modifier_ak_rune_revive.prototype.GetTexture(self)
	return "aegis"
end
function modifier_ak_rune_revive.prototype.GetEffectName(self)
	return "particles/generic_gameplay/rune_regen_owner.vpcf"
end
function modifier_ak_rune_revive.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_ak_rune_revive.prototype.IsHidden(self)
	return false
end
function modifier_ak_rune_revive.prototype.IsDebuff(self)
	return false
end
function modifier_ak_rune_revive.prototype.IsPurgable(self)
	return true
end
function modifier_ak_rune_revive.prototype.UpdateRemainingSeconds(self)
	self:SetStackCount(math.max(0, math.ceil(self:GetRemainingTime())))
end
modifier_ak_rune_revive =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_ak_rune_revive") }, modifier_ak_rune_revive)
____exports.modifier_ak_rune_revive = modifier_ak_rune_revive
return ____exports