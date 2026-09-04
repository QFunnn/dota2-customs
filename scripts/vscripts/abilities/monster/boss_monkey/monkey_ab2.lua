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
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
local ____monkey_ab1 = require("abilities.monster.boss_monkey.monkey_ab1")
local monkey_ab1_roll_modifer = ____monkey_ab1.monkey_ab1_roll_modifer
local ____monkey_movement = require("abilities.monster.boss_monkey.monkey_movement")
local GetMonkeyGroundPoint = ____monkey_movement.GetMonkeyGroundPoint
local IsMonkeyBlinkPointReachable = ____monkey_movement.IsMonkeyBlinkPointReachable
local ResolveMonkeyBlinkPoint = ____monkey_movement.ResolveMonkeyBlinkPoint
--- 猴子技能 ab2：腾云后滞空、再向地面目标下砸（怪物施法框架）。
--
-- 时间轴与引擎回调（`MonsterAbility_CS`：前摇 = castPoint，持续 = castDuration，禁移动等由 KV 与框架处理）：
-- 1. 前摇阶段 `OnPhaseStart`（至 castPoint 结束）
-- 2. 前摇结束瞬间 `OnSpellStart` 进入 `castDuration`，并触发业务入口 `OnStart`
--
-- 释放流程分两段（与下面对应）：
-- - //腾云跳起// —— 仅发生在前摇内（`OnPhaseStart`）：快速升空、锁朝向、播放云雾与拖尾。
-- - //锁点下砸// —— 发生在 `OnStart` 及之后：跳起后立刻锁定一个敌人，在其脚下生成预警圈并持续轻震；短暂预警后高速砸向预警点，落地时再做一次强反馈。
local MONKEY_AB2_CAST_POINT = 0.35
local MONKEY_AB2_CAST_DURATION = 5.5
local MONKEY_AB2_TREE_JUMP_DISTANCE = 800
local MONKEY_AB2_TREE_HEIGHT = 900
local MONKEY_AB2_TREE_JUMP_TIME = 0.25
local MONKEY_AB2_TARGET_SEARCH_RADIUS = 3000
local MONKEY_AB2_SKY_STAY_DURATION = 5
local MONKEY_AB2_WARNING_DURATION = 0.5
local MONKEY_AB2_DIVE_TIME = 0.25
local MONKEY_AB2_AIR_SHAKE_INTERVAL = 0.12
local MONKEY_AB2_AIR_SHAKE_RADIUS = 3000
local MONKEY_AB2_LAND_RADIUS = 500
local MONKEY_AB2_LAND_DAMAGE = 50
local MONKEY_AB2_SUMMON_COUNT = 5
local MONKEY_AB2_SUMMON_NAME = "monster_11027"
local MONKEY_AB2_SUMMON_RADIUS = 320
local MONKEY_AB2_SUMMON_ANGLE_INTERVAL = 72
local MONKEY_AB2_SUMMON_BORN_DURATION = 0.5
local MONKEY_AB2_SUMMON_SOUND = "Hero_SkywrathMage.AncientSeal.Target"
local MONKEY_AB2_SUMMON_EFFECT = "particles/boss/boss_004debuff.vpcf"
____exports.monkey_ab2 = __TS__Class()
local monkey_ab2 = ____exports.monkey_ab2
monkey_ab2.name = "monkey_ab2"
__TS__ClassExtends(monkey_ab2, BossPhaseTransitionAbility_CS)
function monkey_ab2.prototype.____constructor(self, ...)
	BossPhaseTransitionAbility_CS.prototype.____constructor(self, ...)
	self.airborneSummons = {}
end
function monkey_ab2.prototype.Precache(self, context)
	PrecacheResource("particle", MONKEY_AB2_SUMMON_EFFECT, context)
end
function monkey_ab2.prototype.GetBossPhaseTransitionReturnToSpawnDuration(self)
	return 0
end
function monkey_ab2.prototype.GetBossPhaseTransitionWindowDuration(self)
	return MONKEY_AB2_SKY_STAY_DURATION + MONKEY_AB2_DIVE_TIME
end
function monkey_ab2.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = MONKEY_AB2_CAST_POINT,
		castDuration = MONKEY_AB2_CAST_DURATION,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = self:GetLandingTarget()
			self.lockedLandingPos = self:GetLandingPosition(target)
			if target then
				caster:LockTargetForSpeed(target, MONKEY_AB2_CAST_POINT, 90)
			end
			local treePos = self:GetTreeJumpPosition():__add(Vector(0, 0, 100))
			local safeTreePos = self:ResolveAirMovePosition(treePos)
			self:PlayCloudEffect(safeTreePos)
			____exports.monkey_ab2_tree_modifer:applys(caster, caster, self, { duration = 0.65 })
			caster:Mover(safeTreePos, MONKEY_AB2_TREE_JUMP_TIME, function()
				return nil
			end, true, false, true)
			ScreenShake(caster:GetAbsOrigin(), 3, 10, 0.12, 2200, 0, true)
			self:PlayJumpTrail()
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local landingPos = self.lockedLandingPos or self:GetLandingPosition(self:GetLandingTarget())
			self.lockedLandingPos = landingPos
			self:SummonAirborneMonsters(landingPos)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_MK_SPRING_CAST, 1.35)
			self:PlayChannelEffect()
			self:StartAirborneScreenShake(landingPos, MONKEY_AB2_SKY_STAY_DURATION + MONKEY_AB2_DIVE_TIME)
			local warningPos = landingPos
			self:Timer(MONKEY_AB2_SKY_STAY_DURATION - MONKEY_AB2_WARNING_DURATION, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local lockTarget = caster:GetMinDistanceUnit(2600) or caster
				warningPos = self:GetLandingPosition(lockTarget)
				caster:SetForwardVector(GetDirection(nil, warningPos, caster:GetAbsOrigin()))
				self:WarningRingEffect(warningPos, MONKEY_AB2_LAND_RADIUS, MONKEY_AB2_WARNING_DURATION)
			end)
			self:Timer(MONKEY_AB2_SKY_STAY_DURATION, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local divePos = self:GetLandingPosition(nil, warningPos)
				caster:SetForwardVector(GetDirection(nil, divePos, caster:GetAbsOrigin()))
				self:PlayLandingCastEffect(divePos)
				monkey_ab1_roll_modifer:applys(caster, caster, self, { duration = MONKEY_AB2_DIVE_TIME + 0.15 })
				caster:Mover(divePos, MONKEY_AB2_DIVE_TIME)
				ScreenShake(divePos, 6, 14, 0.12, 2800, 0, true)
				self:PlayJumpTrail()
				self:Timer(MONKEY_AB2_DIVE_TIME, function()
					self:PlayLandingImpact(divePos)
					self.lockedLandingPos = nil
				end)
			end)
		end,
		OnFinish = function()
			local caster = self:GetCaster()
			self.lockedLandingPos = nil
			if not IsValidAlive(nil, caster) then
				self:CleanupAirborneSummons()
			end
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			self.lockedLandingPos = nil
			if not IsValidAlive(nil, caster) then
				self:CleanupAirborneSummons()
			end
		end,
	}
end
function monkey_ab2.prototype.GetTreeJumpPosition(self)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local pos = origin:__add(caster:GetForwardVector():__mul(MONKEY_AB2_TREE_JUMP_DISTANCE))
	pos.z = MONKEY_AB2_TREE_HEIGHT
	return pos
end
function monkey_ab2.prototype.GetLandingTarget(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(MONKEY_AB2_TARGET_SEARCH_RADIUS)
	if target and IsValidAlive(nil, target) then
		return target
	end
	return nil
end
function monkey_ab2.prototype.GetGroundPosition(self, pos)
	local caster = self:GetCaster()
	return GetMonkeyGroundPoint(nil, caster, pos)
end
function monkey_ab2.prototype.GetLandingPosition(self, target, preferredPos)
	local caster = self:GetCaster()
	if preferredPos then
		return ResolveMonkeyBlinkPoint(nil, caster, preferredPos) or self:GetGroundPosition(caster:GetAbsOrigin())
	end
	if target and IsValidAlive(nil, target) then
		return ResolveMonkeyBlinkPoint(nil, caster, target:GetAbsOrigin())
			or self:GetGroundPosition(caster:GetAbsOrigin())
	end
	local origin = caster:GetAbsOrigin()
	local pos = origin:__add(caster:GetForwardVector():__mul(MONKEY_AB2_TREE_JUMP_DISTANCE))
	return ResolveMonkeyBlinkPoint(nil, caster, pos) or self:GetGroundPosition(origin)
end
function monkey_ab2.prototype.ResolveAirMovePosition(self, targetPos)
	local caster = self:GetCaster()
	local origin = self:GetGroundPosition(caster:GetAbsOrigin())
	local targetGround = self:GetGroundPosition(targetPos)
	if not IsMonkeyBlinkPointReachable(nil, origin, targetGround) then
		return caster:GetAbsOrigin()
	end
	return Vector(targetGround.x, targetGround.y, targetPos.z)
end
function monkey_ab2.prototype.StartAirborneScreenShake(self, center, duration)
	local caster = self:GetCaster()
	local elapsed = 0
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) then
			return nil
		end
		ScreenShake(center, 2, 8, 0.08, MONKEY_AB2_AIR_SHAKE_RADIUS, 0, true)
		elapsed = elapsed + MONKEY_AB2_AIR_SHAKE_INTERVAL
		if elapsed >= duration then
			return nil
		end
		return MONKEY_AB2_AIR_SHAKE_INTERVAL
	end)
end
function monkey_ab2.prototype.SummonAirborneMonsters(self, center)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local summonPositions = self:GetSummonPositions(center)
	local roomId = caster:GetRoomId()
	EmitSoundOnLocationWithCaster(center, MONKEY_AB2_SUMMON_SOUND, caster)
	for ____, summonPos in ipairs(summonPositions) do
		local currentSummonPos = summonPos
		self:PlaySummonEffect(currentSummonPos)
		MyGameUnit:CreateSummonedUnitAsync({
			unitName = MONKEY_AB2_SUMMON_NAME,
			position = currentSummonPos,
			roomId = roomId,
			team = caster:GetTeamNumber(),
			owner = caster,
			summoner = caster,
			findClearSpace = true,
			onSpawn = function(____, unit)
				if not unit or not IsValidAlive(nil, unit) then
					return
				end
				if not IsValidAlive(nil, caster) then
					MyGameUnit:DestroyUnit(unit)
					return
				end
				local ____self_airborneSummons_0 = self.airborneSummons
				____self_airborneSummons_0[#____self_airborneSummons_0 + 1] = unit
				unit:AddNewModifier(
					caster,
					self,
					"modifier_monster_born",
					{ duration = MONKEY_AB2_SUMMON_BORN_DURATION }
				)
				unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, center, currentSummonPos))
			end,
		})
	end
end
function monkey_ab2.prototype.CleanupAirborneSummons(self)
	for ____, summon in ipairs(self.airborneSummons) do
		do
			if not IsValid(nil, summon) or summon:IsNull() or summon.__remove then
				goto __continue42
			end
			MyGameUnit:DestroyUnit(summon)
		end
		::__continue42::
	end
	self.airborneSummons = {}
end
function monkey_ab2.prototype.GetSummonPositions(self, center)
	local directions = GetRotateVectors(
		nil,
		self:GetCaster():GetForwardVector(),
		MONKEY_AB2_SUMMON_COUNT,
		MONKEY_AB2_SUMMON_ANGLE_INTERVAL
	)
	return __TS__ArrayMap(directions, function(____, direction)
		local rawPos = center:__add(direction:__mul(MONKEY_AB2_SUMMON_RADIUS))
		return self:GetGroundPosition(rawPos)
	end)
end
function monkey_ab2.prototype.PlaySummonEffect(self, pos)
	local caster = self:GetCaster()
	local effect = ParticleManager:CreateParticle(MONKEY_AB2_SUMMON_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, pos)
	ParticleManager:SetParticleControl(effect, 1, pos)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
function monkey_ab2.prototype.PlayCloudEffect(self, pos)
	local caster = self:GetCaster()
	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/monkey_king/arcana/monkey_arcana_cloud.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle, 0, pos)
	Timers:CreateTimer(MONKEY_AB2_SKY_STAY_DURATION + 1, function()
		ParticleManager:DestroyParticle(particle, true)
		ParticleManager:ReleaseParticleIndex(particle)
		return nil
	end)
end
function monkey_ab2.prototype.PlayChannelEffect(self)
	local caster = self:GetCaster()
	caster:EmitSound("Hero_MonkeyKing.Spring.Channel")
	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire_channel.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end
function monkey_ab2.prototype.PlayJumpTrail(self)
	local caster = self:GetCaster()
	caster:EmitSound("Hero_MonkeyKing.TreeJump.Cast")
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end
function monkey_ab2.prototype.PlayLandingCastEffect(self, pos)
	local caster = self:GetCaster()
	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_cast_arcana_fire.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle, 0, pos)
	ParticleManager:ReleaseParticleIndex(particle)
end
function monkey_ab2.prototype.PlayLandingImpact(self, center)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound("Hero_MonkeyKing.Spring.Impact")
	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle, 0, center)
	ParticleManager:SetParticleControl(particle, 1, Vector(MONKEY_AB2_LAND_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
	ScreenShake(center, 28, 24, 0.18, 3200, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		MONKEY_AB2_LAND_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy == caster or enemy:FindModifierByName("modifier_immune") then
				goto __continue56
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = MONKEY_AB2_LAND_DAMAGE, ability = self })
			enemy:KnockBack(caster, self, {
				origin_pos = center,
				duration = 0.25,
				stun = true,
				stunDuration = 1.1,
				distance = 0,
				height = 140,
			})
		end
		::__continue56::
	end
end
monkey_ab2 = __TS__DecorateLegacy({ registerAbility(nil) }, monkey_ab2)
____exports.monkey_ab2 = monkey_ab2
--- 前摇上树/腾空时覆盖为树上飞行动画（`DOTA_MK_TREE_SOAR`）。
____exports.monkey_ab2_tree_modifer = __TS__Class()
local monkey_ab2_tree_modifer = ____exports.monkey_ab2_tree_modifer
monkey_ab2_tree_modifer.name = "monkey_ab2_tree_modifer"
__TS__ClassExtends(monkey_ab2_tree_modifer, BaseModifier_CS)
function monkey_ab2_tree_modifer.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function monkey_ab2_tree_modifer.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_MK_TREE_SOAR
end
function monkey_ab2_tree_modifer.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	caster:StopAnimation()
end
monkey_ab2_tree_modifer = __TS__DecorateLegacy({ registerModifier(nil) }, monkey_ab2_tree_modifer)
____exports.monkey_ab2_tree_modifer = monkey_ab2_tree_modifer
--- 下砸用弹簧下扑类动画（`DOTA_MK_SPRING_SOAR`）。
-- 本技能在 `OnStart` 中施加的是自 `monkey_ab1` 导入的 `monkey_ab1_roll_modifer`；若仅保留一处定义，可与此类合并或统一脚本名。
____exports.monkey_ab2_roll_modifer = __TS__Class()
local monkey_ab2_roll_modifer = ____exports.monkey_ab2_roll_modifer
monkey_ab2_roll_modifer.name = "monkey_ab2_roll_modifer"
__TS__ClassExtends(monkey_ab2_roll_modifer, BaseModifier_CS)
function monkey_ab2_roll_modifer.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function monkey_ab2_roll_modifer.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_MK_SPRING_SOAR
end
monkey_ab2_roll_modifer = __TS__DecorateLegacy({ registerModifier(nil) }, monkey_ab2_roll_modifer)
____exports.monkey_ab2_roll_modifer = monkey_ab2_roll_modifer
return ____exports