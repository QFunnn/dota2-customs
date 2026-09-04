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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
--- 技能4动作作为整套连招的初始前摇时长。
local ABYSSAL_3_CAST_ABILITY_4_DURATION = 1.13
--- 每轮技能1指向动作的播放时长。
local ABYSSAL_3_CAST_ABILITY_1_DURATION = 1.13
--- 每轮技能2下砸动作的播放时长。
local ABYSSAL_3_CAST_ABILITY_2_DURATION = 0.9
--- 技能1指向阶段的转向速度，数值越小越容易被玩家走位甩开。
local ABYSSAL_3_AIM_TURN_SPEED = 3
--- 技能1接技能2的重复轮数。
local ABYSSAL_3_ROUND_COUNT = 3
--- 搜索最近敌方单位的范围。
local ABYSSAL_3_SEARCH_RANGE = 2000
--- 砸地伤害和破树的圆形范围。
local ABYSSAL_3_SMASH_RADIUS = 540
--- 砸地中心相对落点向前偏移的距离。
local ABYSSAL_3_SMASH_CENTER_OFFSET = 100
--- 砸地造成的怪物伤害倍率。
local ABYSSAL_3_SMASH_DAMAGE_RATE = 25
--- Boss 传送到目标点上方的高度。
local ABYSSAL_3_AIR_TELEPORT_HEIGHT = 500
--- Boss 出现在目标点上方后，延迟播放技能2下劈动作的时间。
local ABYSSAL_3_AIR_ABILITY_2_DELAY = 0.1
--- Boss 在目标点上方出现后的停顿时间。
local ABYSSAL_3_AIR_HOVER_DURATION = 0.3
--- 从目标上方下砸到地面的位移时间。
local ABYSSAL_3_SMASH_DELAY = 0.15
--- 旧版 Thinker 闪电球移动速度，当前效果已暂时隐藏。
local ABYSSAL_3_LIGHTNING_MOVE_SPEED = 3500
--- 旧版 Thinker 闪电球到达终点后的清理余量。
local ABYSSAL_3_LIGHTNING_THINKER_CLEANUP_DELAY = 0.1
--- 技能1结束后，需要覆盖技能2动作和空中下砸完整流程中较长的一个。
local ABYSSAL_3_CAST_ABILITY_2_TOTAL_DURATION = math.max(
	ABYSSAL_3_AIR_ABILITY_2_DELAY + ABYSSAL_3_CAST_ABILITY_2_DURATION,
	ABYSSAL_3_AIR_HOVER_DURATION + ABYSSAL_3_SMASH_DELAY
)
--- 单轮技能1加技能2的总动作时长。
local ABYSSAL_3_ROUND_DURATION = ABYSSAL_3_CAST_ABILITY_1_DURATION + ABYSSAL_3_CAST_ABILITY_2_TOTAL_DURATION
--- 初始前摇结束后，整套三轮连招占用的施法持续时间。
local ABYSSAL_3_TOTAL_CAST_DURATION = ABYSSAL_3_ROUND_DURATION * ABYSSAL_3_ROUND_COUNT
--- 旧版 Thinker 闪电球粒子，当前效果已暂时隐藏。
local ABYSSAL_3_LIGHTNING_PARTICLE = "particles/boss/lightball_lightning_sphere.vpcf"
--- 瞬移落点后的正面砸地粒子。
local ABYSSAL_3_SMASH_PARTICLE = "particles/unit/monster_12010showin.vpcf"
--- 瞬移起点的深渊领主消失粒子。
local ABYSSAL_3_BLINK_START_PARTICLE = "particles/units/heroes/heroes_underlord/abyssal_underlord_darkrift_target.vpcf"
--- 瞬移地面终点的出现粒子。
local ABYSSAL_3_BLINK_END_PARTICLE = "particles/econ/events/ti8/blink_dagger_ti8_end_lvl2.vpcf"
--- 连接瞬移起点和终点的路径粒子，CP0 为起点，CP1 为终点。
local ABYSSAL_3_BLINK_PATH_PARTICLE = "particles/dd/blink.vpcf"
--- 目标点上方的深渊领主传送门粒子。
local ABYSSAL_3_AIR_RIFT_PARTICLE = "particles/units/heroes/heroes_underlord/underlord_debut_riftend.vpcf"
--- 技能1指向阶段开始的音效。
local ABYSSAL_3_AIM_SOUND = "Hero_AbyssalUnderlord.DarkRift.Target"
--- Boss 从原地消失的传送音效。
local ABYSSAL_3_BLINK_START_SOUND = "Hero_AbyssalUnderlord.DarkRift.Cast"
--- Boss 在空中出现的传送完成音效。
local ABYSSAL_3_AIR_APPEAR_SOUND = "Hero_AbyssalUnderlord.DarkRift.Complete"
--- 空中播放技能2下劈动作的音效。
local ABYSSAL_3_SLASH_SOUND = "Hero_AbyssalUnderlord.Firestorm.Start"
--- 从空中开始下砸的音效。
local ABYSSAL_3_DROP_SOUND = "Hero_AbyssalUnderlord.Firestorm.Cast"
--- 落地砸击命中的音效。
local ABYSSAL_3_IMPACT_SOUND = "DOTA_Item.MeteorHammer.Impact"
--- 深渊领主-多重闪烁 (boss_abyssal_3)
-- 技能4前摇后，连续三轮播放技能1接技能2，并在技能2砸下时闪烁砸地。
____exports.boss_abyssal_3 = __TS__Class()
local boss_abyssal_3 = ____exports.boss_abyssal_3
boss_abyssal_3.name = "boss_abyssal_3"
__TS__ClassExtends(boss_abyssal_3, MonsterAbility_CS)
function boss_abyssal_3.prototype.Precache(self, context)
	PrecacheResource("particle", ABYSSAL_3_SMASH_PARTICLE, context)
	PrecacheResource("particle", ABYSSAL_3_BLINK_START_PARTICLE, context)
	PrecacheResource("particle", ABYSSAL_3_BLINK_END_PARTICLE, context)
	PrecacheResource("particle", ABYSSAL_3_BLINK_PATH_PARTICLE, context)
	PrecacheResource("particle", ABYSSAL_3_AIR_RIFT_PARTICLE, context)
end
function boss_abyssal_3.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = ABYSSAL_3_CAST_ABILITY_4_DURATION,
		castDuration = ABYSSAL_3_TOTAL_CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = 1000,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
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
			caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
			self:PlayBlinkSmashRound(caster, 1)
		end,
	}
end
function boss_abyssal_3.prototype.PlayBlinkSmashRound(self, caster, round)
	if not IsValidAlive(nil, caster) then
		return
	end
	if round > ABYSSAL_3_ROUND_COUNT then
		return
	end
	local currentRound = round
	local isLastRound = currentRound >= ABYSSAL_3_ROUND_COUNT
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	local aimedTarget = caster:GetMinDistanceUnit(ABYSSAL_3_SEARCH_RANGE)
	if IsValidAlive(nil, aimedTarget) then
		caster:LockTargetForSpeed(aimedTarget, ABYSSAL_3_CAST_ABILITY_1_DURATION, ABYSSAL_3_AIM_TURN_SPEED)
		EmitSoundOn(ABYSSAL_3_AIM_SOUND, caster)
	end
	self:Timer(ABYSSAL_3_CAST_ABILITY_1_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
		self:BlinkAndSmash(caster, aimedTarget)
		self:Timer(ABYSSAL_3_CAST_ABILITY_2_TOTAL_DURATION, function()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
			if not isLastRound then
				self:PlayBlinkSmashRound(caster, currentRound + 1)
			end
		end)
	end)
end
function boss_abyssal_3.prototype.BlinkAndSmash(self, caster, aimedTarget)
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
	local airPos = targetPos:__add(Vector(0, 0, ABYSSAL_3_AIR_TELEPORT_HEIGHT))
	local forward = self:GetFlatForward(caster:GetForwardVector())
	local smashCenter = targetPos:__add(forward:__mul(ABYSSAL_3_SMASH_CENTER_OFFSET))
	self:PlayBlinkTransitionEffects(startPos, airPos, targetPos)
	EmitSoundOnLocationWithCaster(startPos, ABYSSAL_3_BLINK_START_SOUND, caster)
	EmitSoundOnLocationWithCaster(airPos, ABYSSAL_3_AIR_APPEAR_SOUND, caster)
	caster:SetForwardVectorWithoutInterrupt(forward)
	ProjectileManager:ProjectileDodge(caster)
	caster:SetAbsOrigin(airPos)
	caster:SetForwardVectorWithoutInterrupt(forward)
	self:Timer(ABYSSAL_3_AIR_ABILITY_2_DELAY, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
		EmitSoundOn(ABYSSAL_3_SLASH_SOUND, caster)
	end)
	self:Timer(ABYSSAL_3_AIR_HOVER_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:SetAbsOrigin(airPos)
		caster:SetForwardVectorWithoutInterrupt(forward)
		EmitSoundOn(ABYSSAL_3_DROP_SOUND, caster)
		local hasSmashed = false
		self:WarningRingEffect(airPos, ABYSSAL_3_SMASH_RADIUS, ABYSSAL_3_SMASH_DELAY + 0.1)
		caster:Mover(targetPos, ABYSSAL_3_SMASH_DELAY, function(____, _position, elapsedTime)
			if hasSmashed or elapsedTime < ABYSSAL_3_SMASH_DELAY then
				return
			end
			hasSmashed = true
			if not IsValidAlive(nil, caster) then
				return true
			end
			local landingPos = GetGroundPosition(targetPos, caster)
			FindClearSpaceForUnit(caster, landingPos, true)
			caster:SetForwardVectorWithoutInterrupt(forward)
			self:PlaySmashEffect(smashCenter, forward)
			EmitSoundOnLocationWithCaster(smashCenter, ABYSSAL_3_IMPACT_SOUND, caster)
			self:Timer(0.1, function()
				self:DamageSmashArea(caster, smashCenter)
			end)
			GridNav:DestroyTreesAroundPoint(smashCenter, ABYSSAL_3_SMASH_RADIUS, false)
			ScreenShake(landingPos, 12, 12, 0.15, 1200, 0, true)
			return true
		end, true, false, true, "inQuad")
	end)
end
function boss_abyssal_3.prototype.GetFacingLandingPoint(self, caster, target, startPos)
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
function boss_abyssal_3.prototype.GetFlatForward(self, forward)
	local flat = Vector(forward.x, forward.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
function boss_abyssal_3.prototype.PlayBlinkTransitionEffects(self, startPos, airPos, targetPos)
	self:PlayWorldParticle(ABYSSAL_3_BLINK_START_PARTICLE, startPos)
	self:PlayWorldParticle(ABYSSAL_3_BLINK_END_PARTICLE, targetPos)
	self:PlayWorldParticle(ABYSSAL_3_AIR_RIFT_PARTICLE, airPos)
	self:PlayBlinkPathEffect(startPos, targetPos)
end
function boss_abyssal_3.prototype.PlayBlinkPathEffect(self, startPos, targetPos)
	local pfx = ParticleManager:CreateParticle(ABYSSAL_3_BLINK_PATH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, startPos)
	ParticleManager:SetParticleControl(pfx, 1, targetPos)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_abyssal_3.prototype.PlayWorldParticle(self, particleName, position)
	local pfx = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position + Vector(0, 0, 125))
	Timers:CreateTimer(0.1, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function boss_abyssal_3.prototype.PlaySmashEffect(self, position, forward)
	local pfx = ParticleManager:CreateParticle(ABYSSAL_3_SMASH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(pfx, 0, position, forward)
	ParticleManager:SetParticleControl(pfx, 1, Vector(ABYSSAL_3_SMASH_RADIUS, 1, 1))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_abyssal_3.prototype.DamageSmashArea(self, caster, center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		ABYSSAL_3_SMASH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		if not IsValidAlive(nil, enemy) then
			return
		end
		caster:MonsterDamage({ victim = enemy, damage_rate = ABYSSAL_3_SMASH_DAMAGE_RATE, ability = self })
	end)
end
boss_abyssal_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_abyssal_3)
____exports.boss_abyssal_3 = boss_abyssal_3
return ____exports