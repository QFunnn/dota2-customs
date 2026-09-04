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
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
--- 存活召唤单位超过此数则无法施法
local BOSS_003_MAX_SUMMONS = 4
--- 施法者身上用于记录当前存活召唤数的 CustomValue key（与 elite_014 用法一致）
local BOSS_003_SUMMON_COUNT_KEY = "boss_003_summon_count"
local HIT_DIST = 500
local FRAME_COUNT = 4
local SEMI_ARC_START = -90
local SEMI_ARC_SPAN = 300
local BOSS_003_CAST_SOUND = "Hero_SkywrathMage.MysticFlare.Cast"
local BOSS_003_SUMMON_SOUND = "Hero_SkywrathMage.AncientSeal.Target"
--- Boss技能3 - 框架技能：从自身右侧起点，面前半圆弧落点每帧一发共 6 帧；存活召唤数 >5 时不可施法
____exports.boss_003 = __TS__Class()
local boss_003 = ____exports.boss_003
boss_003.name = "boss_003"
__TS__ClassExtends(boss_003, BossPhaseTransitionAbility_CS)
function boss_003.prototype.Precache(self, context)
	PrecacheResource(
		"particle",
		"particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack.vpcf",
		context
	)
	PrecacheResource("particle", "particles/boss/boss_004debuff.vpcf", context)
end
function boss_003.prototype.GetBossPhaseTransitionGesture(self)
	return ACT_DOTA_CAST_ABILITY_3
end
function boss_003.prototype.GetBossPhaseTransitionGesturePlaybackRate(self)
	return 0.5
end
function boss_003.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0,
		castDuration = self:GetBossPhaseTransitionReturnToSpawnDuration() + self:GetBossPhaseTransitionWindowDuration(),
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 0.5,
		canCast = function()
			return UF_SUCCESS
		end,
		castError = function()
			return "#boss_003_too_many_summons"
		end,
		OnPhaseStart = function() end,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			EmitSoundOn(BOSS_003_CAST_SOUND, caster)
			local origin = caster:GetAbsOrigin()
			local baseDir = self:GetForwardVector()
			local frameIndex = 0
			self:Timer(0, function()
				if not IsValidAlive(nil, caster) then
					return nil
				end
				local angleDeg = FRAME_COUNT <= 1 and 0
					or SEMI_ARC_START + frameIndex / (FRAME_COUNT - 1) * SEMI_ARC_SPAN
				local dir = RotateVector2D(nil, baseDir, angleDeg)
				local hitPoint = origin + dir * HIT_DIST
				hitPoint.z = origin.z
				CreateProjectile(nil, {
					ability = self,
					caster = caster,
					effect_name = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack.vpcf",
					target = hitPoint,
					start_point = caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_weapon_tip_fx")),
					projectile_type = "collideground",
					projectile_speed = 500,
					on_hit = function(____, _hitTarget, hp)
						self:PlayEffects(hp)
						return true
					end,
				})
				frameIndex = frameIndex + 1
				if frameIndex < FRAME_COUNT then
					return FrameTime()
				end
				return nil
			end)
		end,
	}
end
function boss_003.prototype.PlayEffects(self, hitPoint)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOnLocationWithCaster(hitPoint, BOSS_003_SUMMON_SOUND, caster)
	local effect_name = "particles/boss/boss_004debuff.vpcf"
	local effect = ParticleManager:CreateParticle(effect_name, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, hitPoint)
	ParticleManager:SetParticleControl(effect, 1, hitPoint)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	local effectReleased = false
	local function releaseSummonGroundFx()
		if effectReleased then
			return
		end
		effectReleased = true
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
	end
	Timers:CreateTimer(1, function()
		releaseSummonGroundFx(nil)
		return nil
	end)
	local roomId = caster:GetRoomId()
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = "monster_10068",
		maxSummons = BOSS_003_MAX_SUMMONS,
		position = hitPoint,
		roomId = roomId,
		team = DOTA_TEAM_BADGUYS,
		owner = caster,
		findClearSpace = true,
		onSpawn = function(____, unit)
			if unit and IsValid(nil, unit) and not unit:IsNull() then
				caster:AddCustomValue(BOSS_003_SUMMON_COUNT_KEY, 1)
				unit:AddNewModifier(caster, self, "modifier_boss_003_debuff", { duration = 0.5 })
				unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
				unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, caster:GetAbsOrigin(), unit:GetAbsOrigin()))
			end
		end,
		onDeath = function()
			if IsValidAlive(nil, caster) then
				caster:AddCustomValue(BOSS_003_SUMMON_COUNT_KEY, -1)
			end
		end,
	})
end
boss_003 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_003)
____exports.boss_003 = boss_003
____exports.modifier_boss_003_debuff = __TS__Class()
local modifier_boss_003_debuff = ____exports.modifier_boss_003_debuff
modifier_boss_003_debuff.name = "modifier_boss_003_debuff"
__TS__ClassExtends(modifier_boss_003_debuff, MonsterModifier_CS)
function modifier_boss_003_debuff.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
modifier_boss_003_debuff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_003_debuff)
____exports.modifier_boss_003_debuff = modifier_boss_003_debuff
return ____exports