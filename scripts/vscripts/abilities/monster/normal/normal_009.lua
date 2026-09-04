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
local modifier_normal_009_fuse_stun, modifier_normal_009_explosion_hide_health_bar
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 触发距离：有敌方英雄靠近则开始引信
local TRIGGER_RANGE = 200
--- 引信时间：靠近后延迟 1 秒自爆
local FUSE_DELAY = 0.3
--- 被击杀触发时，引爆延迟缩短 50%
local KILLED_FUSE_DELAY_RATE = 0.1
--- 自爆伤害半径
local EXPLOSION_RADIUS = 200
--- 自爆伤害倍率（与 MonsterDamage.damage_rate 语义一致）
local DAMAGE_RATE = 15
--- 爆炸特效：CP0 为地面原点
local PARTICLE_EXPLOSION =
	"particles/unit/monster/econ/items/sand_king/sandking_ti7_arms/sandking_ti7_caustic_finale_crimson_explode.vpcf"
local PARTICLE_EFFECT = "particles/econ/items/sand_king/sandking_ti7_arms/sandking_ti7_caustic_finale_debuff.vpcf"
local PARTICLE_FUSE_PULSES = "particles/sandking_ti7_caustic_finale_crimson_debuff_pulses.vpcf"
--- 沙皇腐蚀毒音效（Caustic Finale）
local SOUND_SANDKING_CAUSTIC_FINALE = "Ability.SandKing_CausticFinale"
--- 普通技能9 - 靠近引信 1 秒后自爆（击杀者为自身）
____exports.normal_009 = __TS__Class()
local normal_009 = ____exports.normal_009
normal_009.name = "normal_009"
__TS__ClassExtends(normal_009, MonsterAbility_CS)
function normal_009.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_EXPLOSION, context)
	PrecacheResource("particle", PARTICLE_FUSE_PULSES, context)
end
function normal_009.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_009.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_009"
end
normal_009 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_009)
____exports.normal_009 = normal_009
local modifier_normal_009 = __TS__Class()
modifier_normal_009.name = "modifier_normal_009"
__TS__ClassExtends(modifier_normal_009, MonsterModifier_CS)
function modifier_normal_009.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.fuseEndTime = 0
	self.exploded = false
end
function modifier_normal_009.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.fuseEndTime = 0
	self.exploded = false
	self.fusePulsesPid = nil
	self.recordedKiller = nil
	self:StartIntervalThink(0.1)
end
function modifier_normal_009.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DoExplosion()
	self.fusePulsesPid = nil
end
function modifier_normal_009.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_normal_009.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if event.ctx.spec.victim ~= caster then
		return
	end
	if self.exploded then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	if self:IsFuseActive() then
		event.prevent_apply = true
		caster:SetHealth(math.max(1, caster:GetHealth()))
		return
	end
	local damage = self:GetCurrentPipeDamage(event.final)
	if damage < caster:GetHealth() then
		return
	end
	local attacker = event.ctx.spec.attacker
	local ____table_IsValidKiller_result_0
	if self:IsValidKiller(caster, attacker) then
		____table_IsValidKiller_result_0 = attacker
	else
		____table_IsValidKiller_result_0 = nil
	end
	self.recordedKiller = ____table_IsValidKiller_result_0
	event.prevent_apply = true
	caster:SetHealth(1)
	self:StartFuse(FUSE_DELAY * KILLED_FUSE_DELAY_RATE, true)
end
function modifier_normal_009.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self.exploded then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local now = GameRules:GetGameTime()
	if self:IsFuseActive() then
		if now >= self.fuseEndTime then
			self:Destroy()
			return
		end
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		TRIGGER_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue23
			end
			self:StartFuse(FUSE_DELAY, false)
			return
		end
		::__continue23::
	end
end
function modifier_normal_009.prototype.StartFuse(self, fuseDelay, hideHealthBar)
	if fuseDelay == nil then
		fuseDelay = FUSE_DELAY
	end
	if hideHealthBar == nil then
		hideHealthBar = false
	end
	if not IsServer() then
		return
	end
	if self:IsFuseActive() then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		return
	end
	local duration = math.max(fuseDelay, 0.03)
	self.fuseEndTime = GameRules:GetGameTime() + duration
	caster:Stop()
	caster:AddNewModifier(caster, ability, modifier_normal_009_fuse_stun.name, { duration = duration })
	if hideHealthBar then
		caster:AddNewModifier(
			caster,
			ability,
			modifier_normal_009_explosion_hide_health_bar.name,
			{ duration = duration + 0.5 }
		)
	end
	self:StartFusePulsesFx()
end
function modifier_normal_009.prototype.StartFusePulsesFx(self)
	if not IsServer() then
		return
	end
	if self.fusePulsesPid ~= nil then
		return
	end
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pid = ParticleManager:CreateParticle(PARTICLE_FUSE_PULSES, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pid,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	self.fusePulsesPid = pid
	self:AddParticle(pid, false, false, -1, false, false)
end
function modifier_normal_009.prototype.DoExplosion(self)
	if self.exploded then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, caster) then
		return
	end
	self.exploded = true
	local origin = caster:GetAbsOrigin()
	local groundZ = GetGroundHeight(origin, caster)
	local ____origin_x_2 = origin.x
	local ____origin_y_3 = origin.y
	local ____temp_1
	if groundZ ~= nil then
		____temp_1 = groundZ
	else
		____temp_1 = origin.z
	end
	local center = Vector(____origin_x_2, ____origin_y_3, ____temp_1)
	EmitSoundOn(SOUND_SANDKING_CAUSTIC_FINALE, caster)
	caster:AddNewModifier(caster, ability, modifier_normal_009_explosion_hide_health_bar.name, { duration = 0.5 })
	self._parent:AddNoDraw()
	local pfx = ParticleManager:CreateParticle(PARTICLE_EXPLOSION, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:ReleaseParticleIndex(pfx)
	local victims = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, victim in ipairs(victims) do
		do
			if not IsValidAlive(nil, victim) or victim:IsBuilding() then
				goto __continue38
			end
			caster:MonsterDamage({ victim = victim, damage_rate = DAMAGE_RATE, ability = ability })
		end
		::__continue38::
	end
	local ____table_IsValidKiller_result_4
	if self:IsValidKiller(caster, self.recordedKiller) then
		____table_IsValidKiller_result_4 = self.recordedKiller
	else
		____table_IsValidKiller_result_4 = caster
	end
	local killer = ____table_IsValidKiller_result_4
	caster:CustomKill(killer, ability)
end
function modifier_normal_009.prototype.IsFuseActive(self)
	return self.fuseEndTime > 0
end
function modifier_normal_009.prototype.IsValidKiller(self, caster, killer)
	if not killer or not IsValid(nil, killer) then
		return false
	end
	if killer == caster then
		return false
	end
	if killer:GetTeamNumber() == caster:GetTeamNumber() then
		return false
	end
	return true
end
function modifier_normal_009.prototype.GetCurrentPipeDamage(self, final)
	local damage = final.base
	if final.add then
		for ____, value in ipairs(final.add) do
			damage = damage + value.value
		end
	end
	if final.mul then
		for ____, value in ipairs(final.mul) do
			damage = damage * value.value
		end
	end
	return math.max(0, damage)
end
function modifier_normal_009.prototype.IsHidden(self)
	return true
end
function modifier_normal_009.prototype.IsPurgable(self)
	return false
end
function modifier_normal_009.prototype.GetEffectName(self)
	return PARTICLE_EFFECT
end
modifier_normal_009 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_009") }, modifier_normal_009)
modifier_normal_009_fuse_stun = __TS__Class()
modifier_normal_009_fuse_stun.name = "modifier_normal_009_fuse_stun"
__TS__ClassExtends(modifier_normal_009_fuse_stun, MonsterModifier_CS)
function modifier_normal_009_fuse_stun.prototype.IsHidden(self)
	return true
end
function modifier_normal_009_fuse_stun.prototype.IsPurgable(self)
	return false
end
function modifier_normal_009_fuse_stun.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
modifier_normal_009_fuse_stun =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_009_fuse_stun") }, modifier_normal_009_fuse_stun)
modifier_normal_009_explosion_hide_health_bar = __TS__Class()
modifier_normal_009_explosion_hide_health_bar.name = "modifier_normal_009_explosion_hide_health_bar"
__TS__ClassExtends(modifier_normal_009_explosion_hide_health_bar, MonsterModifier_CS)
function modifier_normal_009_explosion_hide_health_bar.prototype.IsHidden(self)
	return true
end
function modifier_normal_009_explosion_hide_health_bar.prototype.IsPurgable(self)
	return false
end
function modifier_normal_009_explosion_hide_health_bar.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
modifier_normal_009_explosion_hide_health_bar = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_normal_009_explosion_hide_health_bar") },
	modifier_normal_009_explosion_hide_health_bar
)
return ____exports