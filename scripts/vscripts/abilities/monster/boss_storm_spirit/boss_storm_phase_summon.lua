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
local modifier_boss_storm_phase_ball, modifier_boss_storm_phase_summon_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_simple_phase_summon = require("abilities.monster.boss.boss_simple_phase_summon")
local boss_simple_phase_summon = ____boss_simple_phase_summon.boss_simple_phase_summon
local SIMPLE_PHASE_SUMMON_COUNT = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_COUNT
local SIMPLE_PHASE_SUMMON_RADIUS = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_RADIUS
local STORM_PHASE_DURATION = 6
local STORM_PHASE_BALL_DURATION = 2.8
local STORM_PHASE_BALL_THINK_INTERVAL = 0.03
local STORM_PHASE_SUMMON_IMPACT_RADIUS = 250
local STORM_PHASE_SUMMON_DAMAGE_RATE = 5
local STORM_PHASE_SUMMON_SLOW_DURATION = 1
local STORM_PHASE_SUMMON_SLOW_MOVESPEED_PCT = -50
local STORM_PHASE_BALL_PARTICLE = "particles/stormspirit_orchid_ball_lightning.vpcf"
local STORM_PHASE_OVERLOAD_PARTICLE = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
local STORM_PHASE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_stormspirit.vsndevts"
local STORM_PHASE_BALL_START_SOUND = "Hero_StormSpirit.BallLightning"
local STORM_PHASE_BALL_LOOP_SOUND = "Hero_StormSpirit.BallLightning.Loop"
local STORM_PHASE_SUMMON_SOUND = "Hero_StormSpirit.StaticRemnantPlant"
--- 风暴之灵专属转阶段：化作球状闪电绕场一圈，并在飞行中逐个生成小怪。
____exports.boss_storm_phase_summon = __TS__Class()
local boss_storm_phase_summon = ____exports.boss_storm_phase_summon
boss_storm_phase_summon.name = "boss_storm_phase_summon"
__TS__ClassExtends(boss_storm_phase_summon, boss_simple_phase_summon)
function boss_storm_phase_summon.prototype.Precache(self, context)
	boss_simple_phase_summon.prototype.Precache(self, context)
	PrecacheResource("particle", STORM_PHASE_BALL_PARTICLE, context)
	PrecacheResource("particle", STORM_PHASE_OVERLOAD_PARTICLE, context)
	PrecacheResource("soundfile", STORM_PHASE_SOUND_EVENTS, context)
end
function boss_storm_phase_summon.prototype.GetBossPhaseTransitionWindowDuration(self)
	return STORM_PHASE_DURATION
end
function boss_storm_phase_summon.prototype.GetBossPhaseTransitionGesture(self)
	return nil
end
function boss_storm_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	local cfg = boss_simple_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	return __TS__ObjectAssign({}, cfg, {
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:StartStormPhaseTransition(caster, self:GetSimplePhaseSummonConfig())
		end,
	})
end
function boss_storm_phase_summon.prototype.GetSimplePhaseSummonConfig(self)
	return {
		summonUnitName = "monster_10075",
		note = "风暴之灵：沿用已确认的 M014 召唤单位，小雷霆蜥蜴",
	}
end
function boss_storm_phase_summon.prototype.StartStormPhaseTransition(self, caster, config)
	local center = self:ResolveCenterPoint(caster)
	local startPos = self:GetStormCirclePosition(center, 0, caster)
	caster:SetAbsOrigin(startPos)
	caster:SetForwardVectorWithoutInterrupt(
		GetDirection(nil, self:GetStormCirclePosition(center, 0.05, caster), startPos)
	)
	FindClearSpaceForUnit(caster, startPos, true)
	EmitSoundOn(STORM_PHASE_BALL_START_SOUND, caster)
	modifier_boss_storm_phase_ball:applys(caster, caster, self, {
		duration = STORM_PHASE_BALL_DURATION,
		center_x = center.x,
		center_y = center.y,
		center_z = center.z,
		radius = SIMPLE_PHASE_SUMMON_RADIUS,
	})
	self:ScheduleStormPhaseSummons(caster, config, center)
end
function boss_storm_phase_summon.prototype.ScheduleStormPhaseSummons(self, caster, config, center)
	do
		local i = 0
		while i < SIMPLE_PHASE_SUMMON_COUNT do
			local currentIndex = i
			local currentProgress = (currentIndex + 1) / SIMPLE_PHASE_SUMMON_COUNT
			local currentDelay = STORM_PHASE_BALL_DURATION * currentProgress
			local currentSummonPos = self:GetStormCirclePosition(center, currentProgress, caster)
			self:Timer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:SummonStormPhaseMonster(caster, config, currentSummonPos)
			end)
			i = i + 1
		end
	end
end
function boss_storm_phase_summon.prototype.SummonStormPhaseMonster(self, caster, config, position)
	local roomId = caster:GetRoomId()
	local summonPos = GetGroundPosition(position, caster)
	self:PlayOverloadEffect(summonPos, caster)
	self:ApplySummonImpact(caster, summonPos)
	EmitSoundOnLocationWithCaster(summonPos, STORM_PHASE_SUMMON_SOUND, caster)
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = config.summonUnitName,
		summonTag = "phase_summon_" .. caster:GetUnitName(),
		maxSummons = SIMPLE_PHASE_SUMMON_COUNT,
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
			unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, summonPos, caster:GetAbsOrigin()))
			unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
		end,
	})
end
function boss_storm_phase_summon.prototype.ApplySummonImpact(self, caster, position)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		STORM_PHASE_SUMMON_IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue19
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = STORM_PHASE_SUMMON_DAMAGE_RATE, ability = self })
			modifier_boss_storm_phase_summon_slow:applys(
				enemy,
				caster,
				self,
				{ duration = STORM_PHASE_SUMMON_SLOW_DURATION }
			)
		end
		::__continue19::
	end
end
function boss_storm_phase_summon.prototype.PlayOverloadEffect(self, position, caster)
	local effect = ParticleManager:CreateParticle(STORM_PHASE_OVERLOAD_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 1, Vector(180, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
end
function boss_storm_phase_summon.prototype.GetStormCirclePosition(self, center, progress, caster)
	local angle = progress * math.pi * 2
	local rawPos = center:__add(
		Vector(math.cos(angle) * SIMPLE_PHASE_SUMMON_RADIUS, math.sin(angle) * SIMPLE_PHASE_SUMMON_RADIUS, 0)
	)
	return GetGroundPosition(rawPos, caster)
end
boss_storm_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_storm_phase_summon)
____exports.boss_storm_phase_summon = boss_storm_phase_summon
modifier_boss_storm_phase_ball = __TS__Class()
modifier_boss_storm_phase_ball.name = "modifier_boss_storm_phase_ball"
__TS__ClassExtends(modifier_boss_storm_phase_ball, MonsterModifier_CS)
function modifier_boss_storm_phase_ball.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.center = Vector(0, 0, 0)
	self.radius = SIMPLE_PHASE_SUMMON_RADIUS
end
function modifier_boss_storm_phase_ball.prototype.IsHidden(self)
	return true
end
function modifier_boss_storm_phase_ball.prototype.IsPurgable(self)
	return false
end
function modifier_boss_storm_phase_ball.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.center = Vector(
		params.center_x or parent:GetAbsOrigin().x,
		params.center_y or parent:GetAbsOrigin().y,
		params.center_z or parent:GetAbsOrigin().z
	)
	self.radius = params.radius or SIMPLE_PHASE_SUMMON_RADIUS
	parent:AddNoDrawWithWearables()
	ProjectileManager:ProjectileDodge(parent)
	parent:EmitSound(STORM_PHASE_BALL_LOOP_SOUND)
	self:CreateBallParticle(parent:GetAbsOrigin())
	self:StartIntervalThink(STORM_PHASE_BALL_THINK_INTERVAL)
	self:OnIntervalThink()
end
function modifier_boss_storm_phase_ball.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local progress = math.min(self:GetElapsedTime() / math.max(self:GetDuration(), FrameTime()), 1)
	local position = self:GetCirclePosition(progress, parent)
	local nextPosition = self:GetCirclePosition(math.min(progress + 0.02, 1), parent)
	parent:SetAbsOrigin(position)
	parent:SetForwardVectorWithoutInterrupt(GetDirection(nil, nextPosition, position))
	self:UpdateBallParticle(position)
	if progress >= 1 then
		self:Destroy()
	end
end
function modifier_boss_storm_phase_ball.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	self:DestroyBallParticle()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:StopSound(STORM_PHASE_BALL_LOOP_SOUND)
		parent:RemoveNoDrawWithWearables()
		if IsValidAlive(nil, parent) then
			local landingPos = self:GetCirclePosition(1, parent)
			parent:SetAbsOrigin(landingPos)
			FindClearSpaceForUnit(parent, landingPos, true)
		end
	end
end
function modifier_boss_storm_phase_ball.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end
function modifier_boss_storm_phase_ball.prototype.GetCirclePosition(self, progress, parent)
	local angle = progress * math.pi * 2
	local rawPos = self.center:__add(Vector(math.cos(angle) * self.radius, math.sin(angle) * self.radius, 0))
	return GetGroundPosition(rawPos, parent)
end
function modifier_boss_storm_phase_ball.prototype.CreateBallParticle(self, position)
	self.pfxBall = ParticleManager:CreateParticle(STORM_PHASE_BALL_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxBall, false)
	self:UpdateBallParticle(position)
end
function modifier_boss_storm_phase_ball.prototype.UpdateBallParticle(self, position)
	if self.pfxBall == nil then
		return
	end
	ParticleManager:SetParticleControl(self.pfxBall, 0, position)
end
function modifier_boss_storm_phase_ball.prototype.DestroyBallParticle(self)
	if self.pfxBall == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxBall, false)
	ParticleManager:ReleaseParticleIndex(self.pfxBall)
	self.pfxBall = nil
end
modifier_boss_storm_phase_ball =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_storm_phase_ball") }, modifier_boss_storm_phase_ball)
modifier_boss_storm_phase_summon_slow = __TS__Class()
modifier_boss_storm_phase_summon_slow.name = "modifier_boss_storm_phase_summon_slow"
__TS__ClassExtends(modifier_boss_storm_phase_summon_slow, MonsterModifier_CS)
function modifier_boss_storm_phase_summon_slow.prototype.IsHidden(self)
	return false
end
function modifier_boss_storm_phase_summon_slow.prototype.IsDebuff(self)
	return true
end
function modifier_boss_storm_phase_summon_slow.prototype.IsPurgable(self)
	return true
end
function modifier_boss_storm_phase_summon_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = STORM_PHASE_SUMMON_SLOW_MOVESPEED_PCT }
end
function modifier_boss_storm_phase_summon_slow.GetLocalizationCN(self)
	return { name = "雷霆爆点减速", description = "移动速度降低。" }
end
modifier_boss_storm_phase_summon_slow = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_phase_summon_slow") },
	modifier_boss_storm_phase_summon_slow
)
return ____exports