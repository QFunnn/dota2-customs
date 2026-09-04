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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_faceless_phase_intro
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_simple_phase_summon = require("abilities.monster.boss.boss_simple_phase_summon")
local boss_simple_phase_summon = ____boss_simple_phase_summon.boss_simple_phase_summon
local SIMPLE_PHASE_SOUND = ____boss_simple_phase_summon.SIMPLE_PHASE_SOUND
local SIMPLE_PHASE_SUMMON_COUNT = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_COUNT
local SIMPLE_PHASE_SUMMON_RADIUS = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_RADIUS
local FACELESS_PHASE_INTRO_DURATION = 1.5
local FACELESS_PHASE_CHARGE_START_EXTRA_DISTANCE = 520
local FACELESS_PHASE_TIME_WALK_EFFECT =
	"particles/econ/items/faceless_void/faceless_void_arcana/faceless_void_arcana_time_walk_combined.vpcf"
local FACELESS_PHASE_OVERLOAD_EFFECT = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
local FACELESS_PHASE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts"
local FACELESS_PHASE_TIME_WALK_SOUND = "Hero_FacelessVoid.TimeWalk"
--- 虚空领主专属转阶段：召唤物从外圈 Time Walk 冲刺入场。
____exports.boss_faceless_phase_summon = __TS__Class()
local boss_faceless_phase_summon = ____exports.boss_faceless_phase_summon
boss_faceless_phase_summon.name = "boss_faceless_phase_summon"
__TS__ClassExtends(boss_faceless_phase_summon, boss_simple_phase_summon)
function boss_faceless_phase_summon.prototype.Precache(self, context)
	boss_simple_phase_summon.prototype.Precache(self, context)
	PrecacheResource("particle", FACELESS_PHASE_TIME_WALK_EFFECT, context)
	PrecacheResource("particle", FACELESS_PHASE_OVERLOAD_EFFECT, context)
	PrecacheResource("soundfile", FACELESS_PHASE_SOUND_EVENTS, context)
end
function boss_faceless_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	local cfg = boss_simple_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	return __TS__ObjectAssign({}, cfg, {
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:StartFacelessPhaseTransition(caster, self:GetSimplePhaseSummonConfig())
		end,
	})
end
function boss_faceless_phase_summon.prototype.GetSimplePhaseSummonConfig(self)
	return {
		summonUnitName = "monster_10091",
		note = "虚空领主：M008 普通怪无技能综合最高之一，虚空唤魔者",
	}
end
function boss_faceless_phase_summon.prototype.StartFacelessPhaseTransition(self, caster, config)
	local center = self:ResolveCenterPoint(caster)
	EmitSoundOnLocationWithCaster(center, SIMPLE_PHASE_SOUND, caster)
	self:SummonFacelessPhaseMonsters(caster, config, center)
	self:StartSummonEffectLoop(caster, center)
end
function boss_faceless_phase_summon.prototype.SummonFacelessPhaseMonsters(self, caster, config, center)
	local roomId = caster:GetRoomId()
	do
		local i = 0
		while i < SIMPLE_PHASE_SUMMON_COUNT do
			local currentIndex = i
			local angle = math.pi * 2 * currentIndex / SIMPLE_PHASE_SUMMON_COUNT
			local offset =
				Vector(math.cos(angle) * SIMPLE_PHASE_SUMMON_RADIUS, math.sin(angle) * SIMPLE_PHASE_SUMMON_RADIUS, 0)
			local summonPos = GetGroundPosition(center:__add(offset), caster)
			local chargeDirection = GetDirection(nil, summonPos, center)
			local chargeStartPos = GetGroundPosition(
				summonPos:__add(chargeDirection:__mul(FACELESS_PHASE_CHARGE_START_EXTRA_DISTANCE)),
				caster
			)
			local currentSummonPos = summonPos
			local currentChargeStartPos = chargeStartPos
			local currentChargeDirection = chargeDirection
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = config.summonUnitName,
				summonTag = "phase_summon_" .. caster:GetUnitName(),
				maxSummons = SIMPLE_PHASE_SUMMON_COUNT,
				position = currentChargeStartPos,
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
					unit:SetForwardVectorWithoutInterrupt(currentChargeDirection:__mul(-1))
					modifier_boss_faceless_phase_intro:applys(
						unit,
						caster,
						self,
						{
							duration = FACELESS_PHASE_INTRO_DURATION,
							target_x = currentSummonPos.x,
							target_y = currentSummonPos.y,
							target_z = currentSummonPos.z,
						}
					)
				end,
			})
			i = i + 1
		end
	end
end
boss_faceless_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_faceless_phase_summon)
____exports.boss_faceless_phase_summon = boss_faceless_phase_summon
modifier_boss_faceless_phase_intro = __TS__Class()
modifier_boss_faceless_phase_intro.name = "modifier_boss_faceless_phase_intro"
__TS__ClassExtends(modifier_boss_faceless_phase_intro, MonsterModifier_CS)
function modifier_boss_faceless_phase_intro.prototype.IsHidden(self)
	return true
end
function modifier_boss_faceless_phase_intro.prototype.IsPurgable(self)
	return false
end
function modifier_boss_faceless_phase_intro.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self.startPos = parent:GetAbsOrigin()
	self.targetPos = GetGroundPosition(
		Vector(
			params.target_x or self.startPos.x,
			params.target_y or self.startPos.y,
			params.target_z or self.startPos.z
		),
		parent
	)
	parent:SetForwardVectorWithoutInterrupt(GetDirection(nil, self.targetPos, self.startPos))
	EmitSoundOn(FACELESS_PHASE_TIME_WALK_SOUND, parent)
	local chargeEffect =
		ParticleManager:CreateParticle(FACELESS_PHASE_TIME_WALK_EFFECT, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(chargeEffect, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_faceless_phase_intro.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not self.startPos or not self.targetPos then
		self:Destroy()
		return
	end
	local duration = math.max(self:GetDuration(), FrameTime())
	local progress = math.min(self:GetElapsedTime() / duration, 1)
	local nextPos = GetGroundPosition(
		Vector(
			self.startPos.x + (self.targetPos.x - self.startPos.x) * progress,
			self.startPos.y + (self.targetPos.y - self.startPos.y) * progress,
			self.startPos.z + (self.targetPos.z - self.startPos.z) * progress
		),
		parent
	)
	parent:SetAbsOrigin(nextPos)
	if progress >= 1 then
		self:Destroy()
	end
end
function modifier_boss_faceless_phase_intro.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if self.targetPos then
		parent:SetAbsOrigin(self.targetPos)
	end
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
	self:PlayLandingEffect(parent:GetAbsOrigin(), parent)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
end
function modifier_boss_faceless_phase_intro.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_boss_faceless_phase_intro.prototype.PlayLandingEffect(self, position, parent)
	local effect = ParticleManager:CreateParticle(FACELESS_PHASE_OVERLOAD_EFFECT, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 1, Vector(180, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
end
modifier_boss_faceless_phase_intro = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_faceless_phase_intro") },
	modifier_boss_faceless_phase_intro
)
return ____exports