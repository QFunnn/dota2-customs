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
local modifier_boss_bone_warrior_phase_jump
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
local BONE_WARRIOR_PHASE_SUMMON_UNIT_NAME = "monster_10029"
local BONE_WARRIOR_PHASE_SUMMON_TAG = "bone_warrior_phase_summon"
local BONE_WARRIOR_PHASE_ACTION = ACT_DOTA_CAST_ABILITY_4
local BONE_WARRIOR_PHASE_ACTION_PLAYBACK_RATE = 1
local BONE_WARRIOR_PHASE_ACTION_DURATION = 2.6
local BONE_WARRIOR_PHASE_ACTION_COUNT = 2
local BONE_WARRIOR_PHASE_ACTION_INTERVAL_EXTRA = 1
local BONE_WARRIOR_PHASE_ACTION_INTERVAL = BONE_WARRIOR_PHASE_ACTION_DURATION + BONE_WARRIOR_PHASE_ACTION_INTERVAL_EXTRA
local BONE_WARRIOR_PHASE_DURATION = BONE_WARRIOR_PHASE_ACTION_DURATION * BONE_WARRIOR_PHASE_ACTION_COUNT
	+ BONE_WARRIOR_PHASE_ACTION_INTERVAL_EXTRA * (BONE_WARRIOR_PHASE_ACTION_COUNT - 1)
local BONE_WARRIOR_PHASE_PREP_END_TIME = 0.47
local BONE_WARRIOR_PHASE_RISE_END_TIME = 0.77
local BONE_WARRIOR_PHASE_IMPACT_TIME = 1.33
local BONE_WARRIOR_PHASE_FALL_TIME = 0.2
local BONE_WARRIOR_PHASE_FALL_START_TIME = BONE_WARRIOR_PHASE_IMPACT_TIME - BONE_WARRIOR_PHASE_FALL_TIME
local BONE_WARRIOR_PHASE_JUMP_HEIGHT = 420
local BONE_WARRIOR_PHASE_TARGET_SEARCH_RANGE = 2500
local BONE_WARRIOR_PHASE_LAND_TARGET_OFFSET = 160
local BONE_WARRIOR_PHASE_RISE_POWER = 0.25
local BONE_WARRIOR_PHASE_FALL_POWER = 0.25
local BONE_WARRIOR_PHASE_FALL_HORIZONTAL_POWER = 1.6
local BONE_WARRIOR_PHASE_IMPACT_DAMAGE = 500
local BONE_WARRIOR_PHASE_IMPACT_RADIUS = 500
local BONE_WARRIOR_PHASE_IMPACT_SELF_EFFECT_DURATION = 2
local BONE_WARRIOR_PHASE_IMPACT_SELF_HEAL_PCT = 5
local BONE_WARRIOR_PHASE_SUMMON_COUNT_PER_IMPACT = 3
local BONE_WARRIOR_PHASE_TOTAL_SUMMON_COUNT = BONE_WARRIOR_PHASE_SUMMON_COUNT_PER_IMPACT
	* BONE_WARRIOR_PHASE_ACTION_COUNT
local BONE_WARRIOR_PHASE_SUMMON_RADIUS = 320
local BONE_WARRIOR_PHASE_SUMMON_ACQUISITION_RANGE = 2000
local BONE_WARRIOR_PHASE_SUMMON_BIRTH_DURATION = 1
local BONE_WARRIOR_PHASE_SUMMON_BIRTH_EFFECT =
	"particles/econ/items/dazzle/dazzle_ti9/dazzle_shadow_wave_ti9_impact_damage.vpcf"
local BONE_WARRIOR_PHASE_SUMMON_CREATE_EFFECT = "particles/items2_fx/ward_die_generic_sentry.vpcf"
local BONE_WARRIOR_PHASE_WARNING_EFFECT = "particles/monster/ability_warning_ring.vpcf"
local BONE_WARRIOR_PHASE_IMPACT_EFFECT =
	"particles/econ/items/earthshaker/deep_magma/deep_magma_10th/deep_magma_10th_echoslam_start.vpcf"
local BONE_WARRIOR_PHASE_IMPACT_SELF_EFFECT = "particles/killstreak/killstreak_ti10_hud_lv2.vpcf"
local BONE_WARRIOR_PHASE_IMPACT_SOUND = "Hero_EarthShaker.EchoSlam"
local BONE_WARRIOR_PHASE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts"
--- 荒颅战士专属 Boss 转阶段：连续两次追敌跃起砸地，并在每次砸地时召唤半人马矿工。
____exports.boss_bone_warrior_phase_summon = __TS__Class()
local boss_bone_warrior_phase_summon = ____exports.boss_bone_warrior_phase_summon
boss_bone_warrior_phase_summon.name = "boss_bone_warrior_phase_summon"
__TS__ClassExtends(boss_bone_warrior_phase_summon, BossPhaseTransitionAbility_CS)
function boss_bone_warrior_phase_summon.prototype.Precache(self, context)
	PrecacheResource("particle", BONE_WARRIOR_PHASE_WARNING_EFFECT, context)
	PrecacheResource("particle", BONE_WARRIOR_PHASE_IMPACT_EFFECT, context)
	PrecacheResource("particle", BONE_WARRIOR_PHASE_IMPACT_SELF_EFFECT, context)
	PrecacheResource("particle", BONE_WARRIOR_PHASE_SUMMON_BIRTH_EFFECT, context)
	PrecacheResource("particle", BONE_WARRIOR_PHASE_SUMMON_CREATE_EFFECT, context)
	PrecacheResource("soundfile", BONE_WARRIOR_PHASE_SOUND_EVENTS, context)
end
function boss_bone_warrior_phase_summon.prototype.GetBossPhaseTransitionReturnToSpawnDuration(self)
	return 0
end
function boss_bone_warrior_phase_summon.prototype.GetBossPhaseTransitionWindowDuration(self)
	return BONE_WARRIOR_PHASE_DURATION
end
function boss_bone_warrior_phase_summon.prototype.GetBossPhaseTransitionGesture(self)
	return nil
end
function boss_bone_warrior_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_HIDDEN,
		castPoint = 0,
		castDuration = BONE_WARRIOR_PHASE_DURATION + 2,
		castAnimation = "",
		animationPlaybackRate = 1,
		isNotMove = true,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:StartBoneWarriorPhase(caster)
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			if not IsValid(nil, caster) or caster:IsNull() then
				return
			end
			modifier_boss_bone_warrior_phase_jump:remove(caster)
		end,
	}
end
function boss_bone_warrior_phase_summon.prototype.StartBoneWarriorPhase(self, caster)
	do
		local roundIndex = 0
		while roundIndex < BONE_WARRIOR_PHASE_ACTION_COUNT do
			local currentRound = roundIndex
			local roundStartTime = BONE_WARRIOR_PHASE_ACTION_INTERVAL * currentRound
			self:Timer(roundStartTime, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:StartSmashRound(caster, currentRound)
			end)
			roundIndex = roundIndex + 1
		end
	end
end
function boss_bone_warrior_phase_summon.prototype.StartSmashRound(self, caster, roundIndex)
	modifier_boss_bone_warrior_phase_jump:remove(caster)
	local targetPos = self:ResolveLandingTarget(caster)
	self:WarningRingEffect(targetPos, BONE_WARRIOR_PHASE_IMPACT_RADIUS, BONE_WARRIOR_PHASE_IMPACT_TIME, { speed = 0 })
	caster:FadeGesture(BONE_WARRIOR_PHASE_ACTION)
	caster:StartGestureWithPlaybackRate(BONE_WARRIOR_PHASE_ACTION, BONE_WARRIOR_PHASE_ACTION_PLAYBACK_RATE)
	modifier_boss_bone_warrior_phase_jump:applys(caster, caster, self, {
		duration = BONE_WARRIOR_PHASE_IMPACT_TIME,
		target_x = targetPos.x,
		target_y = targetPos.y,
		target_z = targetPos.z,
		round_index = roundIndex,
	})
end
function boss_bone_warrior_phase_summon.prototype.ResolveLandingTarget(self, caster)
	local targetPos = caster:GetAbsOrigin()
	local target = caster:GetMinDistanceUnit(BONE_WARRIOR_PHASE_TARGET_SEARCH_RANGE, caster:GetAbsOrigin())
	if IsValidAlive(nil, target) then
		local origin = caster:GetAbsOrigin()
		local rawTargetPos = target:GetAbsOrigin()
		local direction = GetDirection(nil, rawTargetPos, origin)
		local distance = GetDistance(nil, origin, rawTargetPos)
		local landDistance = math.max(distance - BONE_WARRIOR_PHASE_LAND_TARGET_OFFSET, 0)
		targetPos = origin:__add(direction:__mul(landDistance))
	end
	targetPos = Vector(targetPos.x, targetPos.y, GetGroundHeight(targetPos, caster) or targetPos.z)
	local direction = GetDirection(nil, targetPos, caster:GetAbsOrigin())
	if direction:Length2D() > 0.01 then
		caster:SetForwardVectorWithoutInterrupt(direction)
	end
	return targetPos
end
function boss_bone_warrior_phase_summon.prototype.ResolveSmashImpact(self, caster, roundIndex)
	if not IsValidAlive(nil, caster) then
		return
	end
	local impactPos = GetGroundPosition(caster:GetAbsOrigin(), caster)
	caster:SetAbsOrigin(impactPos)
	FindClearSpaceForUnit(caster, impactPos, true)
	self:PlayImpactEffect(impactPos, caster)
	self:DamageImpactEnemies(caster, impactPos)
	self:SummonImpactMonsters(caster, impactPos, roundIndex)
	self:ApplyImpactSelfReward(caster)
end
function boss_bone_warrior_phase_summon.prototype.PlayImpactEffect(self, position, caster)
	local pfx = ParticleManager:CreateParticle(BONE_WARRIOR_PHASE_IMPACT_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:SetParticleControl(pfx, 1, position)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(position, BONE_WARRIOR_PHASE_IMPACT_SOUND, caster)
	ScreenShake(position, 18, 18, 0.35, 2200, 0, true)
end
function boss_bone_warrior_phase_summon.prototype.DamageImpactEnemies(self, caster, impactPos)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		impactPos,
		nil,
		BONE_WARRIOR_PHASE_IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue23
			end
			self:ApplyDamage(enemy, BONE_WARRIOR_PHASE_IMPACT_DAMAGE, 2)
		end
		::__continue23::
	end
end
function boss_bone_warrior_phase_summon.prototype.SummonImpactMonsters(self, caster, impactPos, roundIndex)
	local roomId = caster:GetRoomId()
	do
		local i = 0
		while i < BONE_WARRIOR_PHASE_SUMMON_COUNT_PER_IMPACT do
			local currentIndex = i
			local angle = math.pi * 2 * currentIndex / BONE_WARRIOR_PHASE_SUMMON_COUNT_PER_IMPACT
				+ roundIndex * math.rad(40)
			local offset = Vector(
				math.cos(angle) * BONE_WARRIOR_PHASE_SUMMON_RADIUS,
				math.sin(angle) * BONE_WARRIOR_PHASE_SUMMON_RADIUS,
				0
			)
			local summonPos = GetGroundPosition(impactPos:__add(offset), caster)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = BONE_WARRIOR_PHASE_SUMMON_UNIT_NAME,
				summonTag = (BONE_WARRIOR_PHASE_SUMMON_TAG .. "_") .. caster:GetUnitName(),
				maxSummons = BONE_WARRIOR_PHASE_TOTAL_SUMMON_COUNT,
				position = summonPos,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					if not unit or not IsValidAlive(nil, unit) then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(unit)
						return
					end
					unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, summonPos, impactPos))
					unit:SetAcquisitionRange(BONE_WARRIOR_PHASE_SUMMON_ACQUISITION_RANGE)
					unit:AddNewModifier(
						caster,
						self,
						"modifier_monster_born",
						{ duration = BONE_WARRIOR_PHASE_SUMMON_BIRTH_DURATION }
					)
					self:PlaySummonCreateEffect(unit)
				end,
			})
			i = i + 1
		end
	end
end
function boss_bone_warrior_phase_summon.prototype.PlaySummonCreateEffect(self, unit)
	local pfx = ParticleManager:CreateParticle(BONE_WARRIOR_PHASE_SUMMON_CREATE_EFFECT, PATTACH_ABSORIGIN_FOLLOW, unit)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_bone_warrior_phase_summon.prototype.ApplyImpactSelfReward(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
	local pfx = ParticleManager:CreateParticle(BONE_WARRIOR_PHASE_IMPACT_SELF_EFFECT, PATTACH_ABSORIGIN_FOLLOW, caster)
	local healAmount = caster:GetMaxHealth() * BONE_WARRIOR_PHASE_IMPACT_SELF_HEAL_PCT / 100
	caster:CustomHeal(healAmount, { ability = self, source = "spell" })
	self:Timer(BONE_WARRIOR_PHASE_IMPACT_SELF_EFFECT_DURATION, function()
		caster:CustomHeal(healAmount, { ability = self, source = "spell" })
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
boss_bone_warrior_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_bone_warrior_phase_summon)
____exports.boss_bone_warrior_phase_summon = boss_bone_warrior_phase_summon
modifier_boss_bone_warrior_phase_jump = __TS__Class()
modifier_boss_bone_warrior_phase_jump.name = "modifier_boss_bone_warrior_phase_jump"
__TS__ClassExtends(modifier_boss_bone_warrior_phase_jump, MonsterModifier_CS)
function modifier_boss_bone_warrior_phase_jump.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.elapsed = 0
	self.groundZ = 0
	self.roundIndex = 0
end
function modifier_boss_bone_warrior_phase_jump.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local origin = parent:GetAbsOrigin()
	self.groundZ = GetGroundHeight(origin, parent) or origin.z
	self.originPos = Vector(origin.x, origin.y, self.groundZ)
	local targetX = params.target_x or origin.x
	local targetY = params.target_y or origin.y
	local targetZ = params.target_z or self.groundZ
	self.targetPos = Vector(targetX, targetY, targetZ)
	self.forward = GetDirection(nil, self.targetPos, self.originPos)
	if self.forward:Length2D() > 0.01 then
		parent:SetForwardVectorWithoutInterrupt(self.forward)
	end
	self.roundIndex = params.round_index or 0
	self.elapsed = 0
	self:OnIntervalThink()
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_bone_warrior_phase_jump.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local dt = FrameTime()
	self.elapsed = math.min(self.elapsed + dt, BONE_WARRIOR_PHASE_IMPACT_TIME)
	self:UpdateJumpTrajectory(parent)
	if self.elapsed >= BONE_WARRIOR_PHASE_IMPACT_TIME then
		self:Destroy()
	end
end
function modifier_boss_bone_warrior_phase_jump.prototype.UpdateJumpTrajectory(self, parent)
	if not self.originPos or not self.targetPos then
		return
	end
	local x = self.originPos.x
	local y = self.originPos.y
	if self.elapsed > BONE_WARRIOR_PHASE_FALL_START_TIME then
		local fallProgress =
			math.min((self.elapsed - BONE_WARRIOR_PHASE_FALL_START_TIME) / BONE_WARRIOR_PHASE_FALL_TIME, 1)
		local horizontalProgress = 1 - math.pow(1 - fallProgress, BONE_WARRIOR_PHASE_FALL_HORIZONTAL_POWER)
		x = self.originPos.x + (self.targetPos.x - self.originPos.x) * horizontalProgress
		y = self.originPos.y + (self.targetPos.y - self.originPos.y) * horizontalProgress
	end
	local height = 0
	if self.elapsed <= BONE_WARRIOR_PHASE_PREP_END_TIME then
		height = 0
	elseif self.elapsed <= BONE_WARRIOR_PHASE_RISE_END_TIME then
		local riseProgress = (self.elapsed - BONE_WARRIOR_PHASE_PREP_END_TIME)
			/ (BONE_WARRIOR_PHASE_RISE_END_TIME - BONE_WARRIOR_PHASE_PREP_END_TIME)
		height = BONE_WARRIOR_PHASE_JUMP_HEIGHT * math.pow(math.min(riseProgress, 1), BONE_WARRIOR_PHASE_RISE_POWER)
	elseif self.elapsed <= BONE_WARRIOR_PHASE_FALL_START_TIME then
		height = BONE_WARRIOR_PHASE_JUMP_HEIGHT
	else
		local fallProgress = (self.elapsed - BONE_WARRIOR_PHASE_FALL_START_TIME) / BONE_WARRIOR_PHASE_FALL_TIME
		height = BONE_WARRIOR_PHASE_JUMP_HEIGHT
			* (1 - math.pow(math.min(fallProgress, 1), BONE_WARRIOR_PHASE_FALL_POWER))
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetAbsOrigin(Vector(x, y, self.groundZ + height))
end
function modifier_boss_bone_warrior_phase_jump.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() or not self.targetPos then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if self.elapsed < BONE_WARRIOR_PHASE_IMPACT_TIME - FrameTime() * 2 then
		local origin = parent:GetAbsOrigin()
		local currentGroundPos = Vector(origin.x, origin.y, GetGroundHeight(origin, parent) or self.groundZ)
		parent:SetAbsOrigin(currentGroundPos)
		FindClearSpaceForUnit(parent, currentGroundPos, true)
		return
	end
	local groundPos = Vector(self.targetPos.x, self.targetPos.y, self.targetPos.z)
	parent:SetAbsOrigin(groundPos)
	FindClearSpaceForUnit(parent, groundPos, true)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	ability:ResolveSmashImpact(parent, self.roundIndex)
end
function modifier_boss_bone_warrior_phase_jump.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_bone_warrior_phase_jump.prototype.IsHidden(self)
	return true
end
function modifier_boss_bone_warrior_phase_jump.prototype.IsPurgable(self)
	return false
end
modifier_boss_bone_warrior_phase_jump = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_bone_warrior_phase_jump") },
	modifier_boss_bone_warrior_phase_jump
)
return ____exports