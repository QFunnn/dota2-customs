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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
--- 技能前摇时间
local ABYSSAL_3_CAST_POINT = 0.2
--- 每轮双手展开动作的播放时长。
local ABYSSAL_3_OPEN_ARMS_DURATION = 0.8
--- 每轮腾空飞扑动作的播放时长。
local ABYSSAL_3_BELLY_FLOP_DURATION = 0.7
--- 前两轮落地后到下一轮双手展开之间的停顿时间。
local ABYSSAL_3_ROUND_PAUSE_DURATION = 0.3
--- 双手展开阶段的转向速度，数值越小越容易被玩家走位甩开。
local ABYSSAL_3_AIM_TURN_SPEED = 3
--- 双手展开接腾空飞扑的重复轮数。
local ABYSSAL_3_ROUND_COUNT = 3
--- 搜索最近敌方单位的范围。
local ABYSSAL_3_SEARCH_RANGE = 3500
--- 原生潮汐猎人大招 Ravage 最大扩散半径。
local RAVAGE_RADIUS = 680
--- 原生潮汐猎人大招 Ravage 落地瞬间的内圈宽度（起始半径）。
local RAVAGE_START_RADIUS = 260
--- 原生潮汐猎人大招 Ravage 触手扩散速度（单位/秒）。
local RAVAGE_SPEED = 730
--- 砸地伤害扩散总时长，从起始半径扩散到最大半径。
local ABYSSAL_3_SMASH_EXPAND_DURATION = (RAVAGE_RADIUS - RAVAGE_START_RADIUS) / RAVAGE_SPEED
--- 扩散伤害判定间隔。
local ABYSSAL_3_SMASH_EXPAND_INTERVAL = 0.03
--- 砸地中心相对落点向前偏移的距离。
local ABYSSAL_3_SMASH_CENTER_OFFSET = 100
--- 砸地造成的怪物伤害倍率。
local ABYSSAL_3_SMASH_DAMAGE_RATE = 25
--- Boss 腾空飞行时的贝塞尔控制点高度。
local ABYSSAL_3_LEAP_HEIGHT = 800
--- 单轮双手展开加腾空飞扑的总动作时长。
local ABYSSAL_3_ROUND_DURATION = ABYSSAL_3_OPEN_ARMS_DURATION + ABYSSAL_3_BELLY_FLOP_DURATION
--- 初始前摇结束后，整套三轮连招和两次轮间停顿占用的施法持续时间。
local ABYSSAL_3_TOTAL_CAST_DURATION = ABYSSAL_3_CAST_POINT
	+ ABYSSAL_3_ROUND_DURATION * ABYSSAL_3_ROUND_COUNT
	+ ABYSSAL_3_ROUND_PAUSE_DURATION * (ABYSSAL_3_ROUND_COUNT - 1)
	+ 1
--- 击飞持续时间。
local ABYSSAL_3_KNOCKBACK_DURATION = 0.2
--- 击飞高度
local ABYSSAL_3_KNOCKBACK_HEIGHT = 220
--- Boss 潜入水中时使用的潮汐猎人水花。
local DIVE_SPLASH_PARTICLE =
	"particles/econ/items/tidehunter/tidehunter_divinghelmet/tidehunter_gush_splash_diving_helmet.vpcf"
--- 落点位置短暂显示的昆卡洪流水面。
local LANDING_POOL_PARTICLE = "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash_group_a.vpcf"
--- Boss 在空中出现时使用的水击爆点。
local AIR_APPEAR_PARTICLE = "particles/dd/mk_spring_arcana_water_hit.vpcf"
--- Boss 落地砸击时水波特效。
local SMASH_PARTICLE = "particles/monster/boss_tide_hunter/ak_tide_2021_ravage.vpcf"
--- 潜水水花保留时间。
local DIVE_SPLASH_DURATION = 0.8
--- 落点水面覆盖完整腾空飞行过程。
local LANDING_POOL_DURATION = ABYSSAL_3_BELLY_FLOP_DURATION + 0.15
--- 水波 CP5 控制的持续时间，与扩散波同步。
local SMASH_PARTICLE_DURATION = ABYSSAL_3_SMASH_EXPAND_DURATION
--- 潮汐猎人音效事件文件。
local TIDEHUNTER_SOUND_EVENT_FILE = "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts"
--- 技能1指向阶段的水下锁定音效。
local ABYSSAL_3_AIM_SOUND = "Hero_Tidehunter.DeadInTheWater.Target"
--- Boss 潜入水中时的施法音效。
local ABYSSAL_3_LEAP_START_SOUND = "Hero_Tidehunter.DeadInTheWater.Cast"
--- Boss 在空中出现时的水花冲击音效。
local ABYSSAL_3_AIR_APPEAR_SOUND = "Ability.GushImpact"
--- 落地砸击时与不朽毁灭粒子配套的音效。
local ABYSSAL_3_IMPACT_SOUND = "Ability.Ravage"
--- 鲨鱼恶霸-多重腾空砸击 (tide_hunter_ab5)
-- 技能4前摇后，连续三轮播放技能1接技能2，并在技能2阶段腾空飞向落点后砸地。
____exports.tide_hunter_ab5 = __TS__Class()
local tide_hunter_ab5 = ____exports.tide_hunter_ab5
tide_hunter_ab5.name = "tide_hunter_ab5"
__TS__ClassExtends(tide_hunter_ab5, MonsterAbility_CS)
function tide_hunter_ab5.prototype.Precache(self, context)
	PrecacheResource("particle", DIVE_SPLASH_PARTICLE, context)
	PrecacheResource("particle", LANDING_POOL_PARTICLE, context)
	PrecacheResource("particle", AIR_APPEAR_PARTICLE, context)
	PrecacheResource("particle", SMASH_PARTICLE, context)
	PrecacheResource("soundfile", TIDEHUNTER_SOUND_EVENT_FILE, context)
end
function tide_hunter_ab5.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = ABYSSAL_3_CAST_POINT,
		castDuration = ABYSSAL_3_TOTAL_CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = ABYSSAL_3_SEARCH_RANGE,
		isNotMove = true,
		animationPlaybackRate = 1,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, caster:GetMinDistanceUnit(ABYSSAL_3_SEARCH_RANGE)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:PlayLeapSmashRound(caster, 1)
		end,
	}
end
function tide_hunter_ab5.prototype.PlayLeapSmashRound(self, caster, round)
	if not IsValidAlive(nil, caster) then
		return
	end
	if round > ABYSSAL_3_ROUND_COUNT then
		return
	end
	local currentRound = round
	local isLastRound = currentRound >= ABYSSAL_3_ROUND_COUNT
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.5)
	local aimedTarget = caster:GetMinDistanceUnit(ABYSSAL_3_SEARCH_RANGE)
	if IsValidAlive(nil, aimedTarget) then
		caster:LockTargetForSpeed(aimedTarget, ABYSSAL_3_OPEN_ARMS_DURATION, ABYSSAL_3_AIM_TURN_SPEED)
		EmitSoundOn(ABYSSAL_3_AIM_SOUND, aimedTarget)
	end
	self:Timer(ABYSSAL_3_OPEN_ARMS_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:LeapAndSmash(caster, aimedTarget)
		self:Timer(ABYSSAL_3_BELLY_FLOP_DURATION, function()
			if not IsValidAlive(nil, caster) then
				return
			end
			if not isLastRound then
				self:Timer(ABYSSAL_3_ROUND_PAUSE_DURATION, function()
					if not IsValidAlive(nil, caster) then
						return
					end
					self:PlayLeapSmashRound(caster, currentRound + 1)
				end)
			end
		end)
	end)
end
function tide_hunter_ab5.prototype.LeapAndSmash(self, caster, aimedTarget)
	local ____IsValidAlive_result_1
	if IsValidAlive(nil, aimedTarget) then
		____IsValidAlive_result_1 = aimedTarget
	else
		____IsValidAlive_result_1 = caster:GetMinDistanceUnit(ABYSSAL_3_SEARCH_RANGE)
	end
	local target = ____IsValidAlive_result_1
	if not IsValidAlive(nil, target) then
		return
	end
	local startPos = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local targetPos = self:GetFacingLandingPoint(caster, target, startPos)
	local leapPeak = startPos:__add(Vector(0, 0, ABYSSAL_3_LEAP_HEIGHT))
	local forward = self:GetFlatForward(caster:GetForwardVector())
	local smashCenter = targetPos:__add(forward:__mul(ABYSSAL_3_SMASH_CENTER_OFFSET))
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	caster:SetAnimation("ravage_belly_flop")
	self:PlayLeapStartEffects(startPos, targetPos)
	EmitSoundOnLocationWithCaster(startPos, ABYSSAL_3_LEAP_START_SOUND, caster)
	caster:SetForwardVectorWithoutInterrupt(forward)
	ProjectileManager:ProjectileDodge(caster)
	caster:Bezier2Mover({ startPos, leapPeak, targetPos }, ABYSSAL_3_BELLY_FLOP_DURATION, nil, true, true)
	local airPosition = caster:GetAbsOrigin()
	self:PlayWorldParticle(AIR_APPEAR_PARTICLE, airPosition)
	EmitSoundOnLocationWithCaster(airPosition, ABYSSAL_3_AIR_APPEAR_SOUND, caster)
	self:WarningRingEffect(targetPos, RAVAGE_RADIUS * 0.8, LANDING_POOL_DURATION)
	self:Timer(ABYSSAL_3_BELLY_FLOP_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local landingPos = GetGroundPosition(targetPos, caster)
		FindClearSpaceForUnit(caster, landingPos, true)
		caster:SetForwardVectorWithoutInterrupt(forward)
		self:PlaySmashEffect(smashCenter)
		EmitSoundOnLocationWithCaster(smashCenter, ABYSSAL_3_IMPACT_SOUND, caster)
		self:DamageSmashArea(caster, smashCenter)
		GridNav:DestroyTreesAroundPoint(smashCenter, RAVAGE_RADIUS, false)
		ScreenShake(landingPos, 30, 30, 0.6, 3000, 0, true)
	end)
end
function tide_hunter_ab5.prototype.GetFacingLandingPoint(self, caster, target, startPos)
	local forward = self:GetFlatForward(caster:GetForwardVector())
	if not IsValidAlive(nil, target) then
		return startPos
	end
	local targetPos = GetGroundPosition(target:GetAbsOrigin(), target)
	local toTarget = targetPos:__sub(startPos)
	local projectedDistance =
		math.max(0, math.min(ABYSSAL_3_SEARCH_RANGE, toTarget.x * forward.x + toTarget.y * forward.y))
	local landingPos = startPos:__add(forward:__mul(projectedDistance))
	landingPos.z = GetGroundHeight(landingPos, caster) or targetPos.z
	return landingPos
end
function tide_hunter_ab5.prototype.GetFlatForward(self, forward)
	local flat = Vector(forward.x, forward.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
function tide_hunter_ab5.prototype.PlayLeapStartEffects(self, startPos, targetPos)
	self:PlayDiveSplash(startPos)
	self:PlayTimedWorldParticle(LANDING_POOL_PARTICLE, targetPos:__add(Vector(0, 0, 10)), LANDING_POOL_DURATION)
end
function tide_hunter_ab5.prototype.PlayDiveSplash(self, position)
	local pfx = ParticleManager:CreateParticle(DIVE_SPLASH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:SetParticleControl(pfx, 3, position)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	self:Timer(DIVE_SPLASH_DURATION, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function tide_hunter_ab5.prototype.PlayWorldParticle(self, particleName, position)
	local pfx = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function tide_hunter_ab5.prototype.PlayTimedWorldParticle(self, particleName, position, duration)
	local pfx = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	self:Timer(duration, function()
		ParticleManager:DestroyParticle(pfx, true)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function tide_hunter_ab5.prototype.PlaySmashEffect(self, position)
	local pfx = ParticleManager:CreateParticle(SMASH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:SetParticleControl(pfx, 5, Vector(SMASH_PARTICLE_DURATION, 0, 0))
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	self:Timer(SMASH_PARTICLE_DURATION, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function tide_hunter_ab5.prototype.DamageSmashArea(self, caster, center)
	ExpandCircularSearch(nil, {
		origin = center,
		startRadius = RAVAGE_START_RADIUS,
		endRadius = RAVAGE_RADIUS,
		duration = ABYSSAL_3_SMASH_EXPAND_DURATION,
		interval = ABYSSAL_3_SMASH_EXPAND_INTERVAL,
		teamNumber = caster:GetTeamNumber(),
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
		hitOnce = true,
		onHit = function(____, units)
			for ____, enemy in ipairs(units) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue36
					end
					caster:MonsterDamage({ victim = enemy, damage_rate = ABYSSAL_3_SMASH_DAMAGE_RATE, ability = self })
					enemy:KnockBack(caster, self, {
						duration = ABYSSAL_3_KNOCKBACK_DURATION,
						distance = 50,
						height = ABYSSAL_3_KNOCKBACK_HEIGHT,
						origin_pos = center,
						stun = true,
					})
				end
				::__continue36::
			end
		end,
		cancelCondition = function()
			return not IsValidAlive(nil, caster)
		end,
	})
end
tide_hunter_ab5 = __TS__DecorateLegacy({ registerAbility(nil) }, tide_hunter_ab5)
____exports.tide_hunter_ab5 = tide_hunter_ab5
return ____exports