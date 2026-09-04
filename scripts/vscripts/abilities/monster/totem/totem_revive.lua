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
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local AURA_RADIUS = 1200
local TOTEM_REVIVE_ANIM_DEATH_DUR = 1.2
local TOTEM_REVIVE_ANIM_REVIVE_DUR = 1.4
local TOTEM_REVIVE_PERFORMANCE_TOTAL = TOTEM_REVIVE_ANIM_DEATH_DUR + TOTEM_REVIVE_ANIM_REVIVE_DUR
local REVIVE_PARTICLE = "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf"
local HEAL_PARTICLE = "particles/tt/heal_01.vpcf"
local AURA_MASTER_RANGE = 125
local AURA_CLIENT_RANGE = 75
--- 复活图腾 - 假复活形式（参照 elite_027 永恒护卫）
-- 光环：1200 范围内友方单位可拦截一次死亡，触发假死/复活动画演出，实际未死亡
____exports.totem_revive = __TS__Class()
local totem_revive = ____exports.totem_revive
totem_revive.name = "totem_revive"
__TS__ClassExtends(totem_revive, MonsterAbility_CS)
function totem_revive.prototype.Precache(self, context)
	PrecacheResource("particle", REVIVE_PARTICLE, context)
	PrecacheResource("particle", HEAL_PARTICLE, context)
end
function totem_revive.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function totem_revive.prototype.GetIntrinsicModifierName(self)
	return "modifier_totem_revive_aura"
end
totem_revive = __TS__DecorateLegacy({ registerAbility(nil) }, totem_revive)
____exports.totem_revive = totem_revive
--- 光环提供者（附着于图腾单位）
____exports.modifier_totem_revive_aura = __TS__Class()
local modifier_totem_revive_aura = ____exports.modifier_totem_revive_aura
modifier_totem_revive_aura.name = "modifier_totem_revive_aura"
__TS__ClassExtends(modifier_totem_revive_aura, BaseModifier_CS)
function modifier_totem_revive_aura.prototype.GetModifierAura(self)
	return "modifier_totem_revive_effect"
end
function modifier_totem_revive_aura.prototype.GetAuraRadius(self)
	return AURA_RADIUS
end
function modifier_totem_revive_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_totem_revive_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_totem_revive_aura.prototype.GetAuraEntityReject(self, unit)
	return unit == self:GetParent()
end
function modifier_totem_revive_aura.prototype.IsAura(self)
	return true
end
function modifier_totem_revive_aura.prototype.IsHidden(self)
	return true
end
function modifier_totem_revive_aura.prototype.IsPurgable(self)
	return false
end
function modifier_totem_revive_aura.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:SetAngles(0, 270, 0)
	self._pfx = ParticleManager:CreateParticle(HEAL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(self._pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._pfx, 1, Vector(AURA_MASTER_RANGE, 0, 0))
end
function modifier_totem_revive_aura.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._pfx ~= nil then
		ParticleManager:DestroyParticle(self._pfx, false)
		ParticleManager:ReleaseParticleIndex(self._pfx)
	end
end
modifier_totem_revive_aura =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_totem_revive_aura") }, modifier_totem_revive_aura)
____exports.modifier_totem_revive_aura = modifier_totem_revive_aura
--- 光环效果 buff：监听死亡拦截事件，触发假死/复活动画
-- 逻辑完全参照 modifier_elite_027_buff（永恒护卫本体）
____exports.modifier_totem_revive_effect = __TS__Class()
local modifier_totem_revive_effect = ____exports.modifier_totem_revive_effect
modifier_totem_revive_effect.name = "modifier_totem_revive_effect"
__TS__ClassExtends(modifier_totem_revive_effect, BaseModifier_CS)
function modifier_totem_revive_effect.prototype.IsHidden(self)
	return false
end
function modifier_totem_revive_effect.prototype.IsPurgable(self)
	return true
end
function modifier_totem_revive_effect.prototype.IsDebuff(self)
	return false
end
function modifier_totem_revive_effect.prototype.GetTexture(self)
	return "skeleton_king_reincarnation"
end
function modifier_totem_revive_effect.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self._pfx = ParticleManager:CreateParticle(HEAL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(self._pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._pfx, 1, Vector(AURA_CLIENT_RANGE, 0, 0))
end
function modifier_totem_revive_effect.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH_INTERCEPT, priority = DeathRevivePriority.STATUS } }
end
function modifier_totem_revive_effect.prototype.OnUnitDeathIntercept_CS(self, event)
	if not IsServer() then
		return
	end
	if event.prevented then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.victim ~= parent then
		return
	end
	if ____exports.modifier_totem_fake_death_revive:find_on(parent) then
		return
	end
	event.prevented = true
	event.handled_by = self:GetName()
	event.intercept_type = "fake_death"
	event.set_health = 1
	____exports.modifier_totem_fake_death_revive:applys(
		parent,
		parent,
		self:GetAbility(),
		{ duration = TOTEM_REVIVE_PERFORMANCE_TOTAL }
	)
end
function modifier_totem_revive_effect.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._pfx ~= nil then
		ParticleManager:DestroyParticle(self._pfx, false)
		ParticleManager:ReleaseParticleIndex(self._pfx)
	end
end
modifier_totem_revive_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_totem_revive_effect") }, modifier_totem_revive_effect)
____exports.modifier_totem_revive_effect = modifier_totem_revive_effect
--- 假死/复活动画演出：死亡被拦截时触发
-- 前 1.2s：播放死亡动画、眩晕、特效
-- 后 1.4s：播放复活动画，血量逐步恢复至满，眩晕
-- 共 2.6s 后移除
-- 逻辑完全参照 modifier_elite_027_death_revive
____exports.modifier_totem_fake_death_revive = __TS__Class()
local modifier_totem_fake_death_revive = ____exports.modifier_totem_fake_death_revive
modifier_totem_fake_death_revive.name = "modifier_totem_fake_death_revive"
__TS__ClassExtends(modifier_totem_fake_death_revive, BaseModifier_CS)
function modifier_totem_fake_death_revive.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._elapsed = 0
	self._phase2Done = false
	self._healthAtPhase2Start = 0
end
function modifier_totem_fake_death_revive.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_DIE, 1)
	self:PlayEffect()
	EmitSoundOn("Hero_SkeletonKing.Reincarnate", self:GetParent())
	self:StartIntervalThink(FrameTime())
end
function modifier_totem_fake_death_revive.prototype.PlayEffect(self)
	local pfx = ParticleManager:CreateParticle(REVIVE_PARTICLE, PATTACH_CENTER_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(2.6, 0, 0))
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_totem_fake_death_revive.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self._elapsed = self._elapsed + FrameTime()
	if not self._phase2Done and self._elapsed >= TOTEM_REVIVE_ANIM_DEATH_DUR then
		self._phase2Done = true
		self._healthAtPhase2Start = parent:GetHealth()
	end
	if self._phase2Done then
		local maxHp = parent:GetMaxHealth()
		local phase2Elapsed = self._elapsed - TOTEM_REVIVE_ANIM_DEATH_DUR
		local progress = math.min(1, phase2Elapsed / TOTEM_REVIVE_ANIM_REVIVE_DUR)
		local targetHealth = self._healthAtPhase2Start + (maxHp - self._healthAtPhase2Start) * progress
		local healAmount = math.max(0, targetHealth - parent:GetHealth())
		if healAmount > 0 then
			parent:CustomHeal(healAmount, { source = "spell" })
		end
	end
	if self._elapsed >= TOTEM_REVIVE_PERFORMANCE_TOTAL then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
end
function modifier_totem_fake_death_revive.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_totem_fake_death_revive.prototype.IsHidden(self)
	return true
end
function modifier_totem_fake_death_revive.prototype.IsPurgable(self)
	return false
end
function modifier_totem_fake_death_revive.prototype.IsDebuff(self)
	return false
end
modifier_totem_fake_death_revive = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_totem_fake_death_revive") },
	modifier_totem_fake_death_revive
)
____exports.modifier_totem_fake_death_revive = modifier_totem_fake_death_revive
return ____exports