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
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_027_REVIVE_DAMAGE_PCT = 50
local ELITE_027_REVIVE_ATTACK_SPEED_PCT = 50
local ELITE_027_REVIVE_MOVESPEED_PCT = 50
local ELITE_027_REVIVE_HEALTH_PCT = 50
local ELITE_027_REVIVE_EFFECT = "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf"
local ELITE_027_REVIVE_SOUND = "Hero_SkeletonKing.Reincarnate"
local ELITE_027_ANIM_DEATH_DUR = 1.2
local ELITE_027_ANIM_REVIVE_DUR = 1.4
local ELITE_027_PERFORMANCE_TOTAL = ELITE_027_ANIM_DEATH_DUR + ELITE_027_ANIM_REVIVE_DUR
local function PlayElite027ReviveEffect(self, parent)
	local pfx = ParticleManager:CreateParticle(ELITE_027_REVIVE_EFFECT, PATTACH_CENTER_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(ELITE_027_PERFORMANCE_TOTAL, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn(ELITE_027_REVIVE_SOUND, parent)
end
--- 精英技能27 - 永恒复苏：被动触发一次死亡拦截，复活后获得永久强化。
____exports.elite_027 = __TS__Class()
local elite_027 = ____exports.elite_027
elite_027.name = "elite_027"
__TS__ClassExtends(elite_027, MonsterAbility_CS)
function elite_027.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_027_REVIVE_EFFECT, context)
end
function elite_027.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_027_buff"
end
function elite_027.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castDuration = 0 }
end
elite_027 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_027)
____exports.elite_027 = elite_027
--- 被动监听：每个持有者只拦截一次死亡，并在复活后施加强化 Buff。
____exports.modifier_elite_027_buff = __TS__Class()
local modifier_elite_027_buff = ____exports.modifier_elite_027_buff
modifier_elite_027_buff.name = "modifier_elite_027_buff"
__TS__ClassExtends(modifier_elite_027_buff, MonsterModifier_CS)
function modifier_elite_027_buff.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._revived = false
end
function modifier_elite_027_buff.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH_INTERCEPT, priority = DeathRevivePriority.STATUS } }
end
function modifier_elite_027_buff.prototype.OnUnitDeathIntercept_CS(self, event)
	if not IsServer() then
		return
	end
	if event.prevented or self._revived then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.victim ~= parent then
		return
	end
	self._revived = true
	event.prevented = true
	event.handled_by = self:GetName()
	event.intercept_type = "revive"
	event.set_health = 1
	____exports.modifier_elite_027_death_revive:applys(
		parent,
		parent,
		self:GetAbility(),
		{ duration = ELITE_027_PERFORMANCE_TOTAL }
	)
end
function modifier_elite_027_buff.prototype.IsHidden(self)
	return true
end
function modifier_elite_027_buff.prototype.IsPurgable(self)
	return false
end
function modifier_elite_027_buff.prototype.RemoveOnDeath(self)
	return true
end
modifier_elite_027_buff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_027_buff") }, modifier_elite_027_buff)
____exports.modifier_elite_027_buff = modifier_elite_027_buff
--- 复活过程：播放死亡/复活动作，过程期间无敌并限制行动，完成后施加强化。
____exports.modifier_elite_027_death_revive = __TS__Class()
local modifier_elite_027_death_revive = ____exports.modifier_elite_027_death_revive
modifier_elite_027_death_revive.name = "modifier_elite_027_death_revive"
__TS__ClassExtends(modifier_elite_027_death_revive, MonsterModifier_CS)
function modifier_elite_027_death_revive.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._elapsed = 0
	self._phase2Done = false
	self._finished = false
end
function modifier_elite_027_death_revive.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:Purge(false, true, false, true, true)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_DIE, 1)
	PlayElite027ReviveEffect(nil, parent)
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_027_death_revive.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self._elapsed = self._elapsed + FrameTime()
	if not self._phase2Done and self._elapsed >= ELITE_027_ANIM_DEATH_DUR then
		self._phase2Done = true
		parent:StartGestureWithPlaybackRate(ACT_DOTA_DIE_SPECIAL, 1)
	end
	if self._elapsed >= ELITE_027_PERFORMANCE_TOTAL then
		self:StartIntervalThink(-1)
		self:FinishRevive(parent)
		self:Destroy()
	end
end
function modifier_elite_027_death_revive.prototype.FinishRevive(self, parent)
	if self._finished then
		return
	end
	self._finished = true
	if not IsValidAlive(nil, parent) then
		return
	end
	local targetHp = math.max(1, parent:GetMaxHealth() * ELITE_027_REVIVE_HEALTH_PCT * 0.01)
	local healAmount = math.max(0, targetHp - parent:GetHealth())
	if healAmount > 0 then
		parent:CustomHeal(healAmount, { source = "spell" })
	end
	____exports.modifier_elite_027_revive_buff:applys(parent, parent, self:GetAbility())
end
function modifier_elite_027_death_revive.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:FinishRevive(parent)
end
function modifier_elite_027_death_revive.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
function modifier_elite_027_death_revive.prototype.IsHidden(self)
	return false
end
function modifier_elite_027_death_revive.prototype.IsPurgable(self)
	return false
end
function modifier_elite_027_death_revive.prototype.IsDebuff(self)
	return false
end
modifier_elite_027_death_revive =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_027_death_revive") }, modifier_elite_027_death_revive)
____exports.modifier_elite_027_death_revive = modifier_elite_027_death_revive
--- 复活强化：输出伤害、攻速、移速提高 50%。
____exports.modifier_elite_027_revive_buff = __TS__Class()
local modifier_elite_027_revive_buff = ____exports.modifier_elite_027_revive_buff
modifier_elite_027_revive_buff.name = "modifier_elite_027_revive_buff"
__TS__ClassExtends(modifier_elite_027_revive_buff, MonsterModifier_CS)
function modifier_elite_027_revive_buff.GetLocalizationCN(self)
	return {
		name = "永恒复苏",
		description = "复活后恢复50%%生命值并获得强化，输出伤害、攻击速度、移动速度提高50%%。",
	}
end
function modifier_elite_027_revive_buff.prototype.GetEffectName(self)
	return "particles/dd/fire_effect.vpcf"
end
function modifier_elite_027_revive_buff.prototype.GetAttributeBonus(self)
	return {
		outgoing_damage_pct = ELITE_027_REVIVE_DAMAGE_PCT,
		attack_speed_pct = ELITE_027_REVIVE_ATTACK_SPEED_PCT,
		bonus_movespeed_pct = ELITE_027_REVIVE_MOVESPEED_PCT,
	}
end
function modifier_elite_027_revive_buff.prototype.IsHidden(self)
	return false
end
function modifier_elite_027_revive_buff.prototype.IsPurgable(self)
	return false
end
function modifier_elite_027_revive_buff.prototype.IsDebuff(self)
	return false
end
modifier_elite_027_revive_buff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_027_revive_buff") }, modifier_elite_027_revive_buff)
____exports.modifier_elite_027_revive_buff = modifier_elite_027_revive_buff
return ____exports