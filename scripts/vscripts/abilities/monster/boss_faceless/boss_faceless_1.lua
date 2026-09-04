--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local DamageBossFacelessDashArea, HIT_RADIUS, DAMAGE_RATE, STUN_SOUND, LONG_STUN_DURATION, modifier_boss_faceless_1_effect
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____boss_faceless_2 = require("abilities.monster.boss_faceless.boss_faceless_2")
local modifier_boss_faceless_2_stun = ____boss_faceless_2.modifier_boss_faceless_2_stun
function DamageBossFacelessDashArea(self, parent, ability, p, damagedEnemyIds, stunDurationMultiplier)
	if stunDurationMultiplier == nil then
		stunDurationMultiplier = 1
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		p,
		nil,
		HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local hasDamaged = false
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy == parent then
				goto __continue13
			end
			local enemyId = enemy:entindex()
			if damagedEnemyIds and __TS__ArrayIncludes(damagedEnemyIds, enemyId) then
				goto __continue13
			end
			local ____opt_6 = damagedEnemyIds
			if ____opt_6 ~= nil then
				damagedEnemyIds[#damagedEnemyIds + 1] = enemyId
			end
			parent:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			MyGameAttack:PerformAttack(parent, enemy)
			local longStunDuration = LONG_STUN_DURATION * stunDurationMultiplier
			local shortStunDuration = 0.35 * stunDurationMultiplier
			AddDeBuffStatus(nil, enemy, parent, ability, DebuffStatusType.STUN, { duration = longStunDuration })
			modifier_boss_faceless_2_stun:applys(enemy, enemy, ability, { duration = shortStunDuration })
			AddDeBuffStatus(nil, enemy, parent, ability, DebuffStatusType.STUN, { duration = shortStunDuration })
			enemy:EmitSound(STUN_SOUND)
			hasDamaged = true
		end
		::__continue13::
	end
	return hasDamaged
end
local PRECAST_TIME = 0.6
local DASH_DURATION = 0.3
local DASH_MAX_DISTANCE = 900
local DASH_SEARCH_RANGE = 2500
HIT_RADIUS = 180
DAMAGE_RATE = 15
local TRAIL_PFX = "particles/econ/items/faceless_void/faceless_void_jewel_of_aeons/fv_time_walk_jewel.vpcf"
local CAST_SOUND = "Hero_FacelessVoid.TimeWalk"
STUN_SOUND = "Hero_FacelessVoid.TimeLockImpact"
LONG_STUN_DURATION = 1.3
function ____exports.StartBossFacelessDash(self, ability, options)
	if options == nil then
		options = {}
	end
	local caster = options.dashUnit or ability:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local direction = options.direction or caster:GetForwardVector()
	local distance = options.distance or DASH_MAX_DISTANCE
	local duration = options.duration or 0.35
	local ____options_stopOnHit_0 = options.stopOnHit
	if ____options_stopOnHit_0 == nil then
		____options_stopOnHit_0 = true
	end
	local stopOnHit = ____options_stopOnHit_0
	local stunDurationMultiplier = options.stunDurationMultiplier or 1
	local damageOverTime = 0
	local damagedEnemyIds = {}
	caster:SetForwardVector(direction)
	local pfx = ParticleManager:CreateParticle(TRAIL_PFX, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	Timers:CreateTimer(0.25, function()
		if IsValidAlive(nil, caster) then
			caster:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
		end
	end)
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
	ScreenShake(caster:GetAbsOrigin(), 5, 2, 0.2, 2000, 0, true)
	caster:EmitSound(CAST_SOUND)
	modifier_boss_faceless_1_effect:applys(caster, caster, ability, { duration = duration })
	caster:Mover(origin:__add(direction:__mul(distance)), duration, function(____, pos)
		if not IsValidAlive(nil, caster) then
			return true
		end
		if stopOnHit and damageOverTime == 1 then
			if GetDistance(nil, pos, origin) > 300 then
				caster:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
				local ____this_2
				____this_2 = options
				local ____opt_1 = ____this_2.onFinished
				if ____opt_1 ~= nil then
					____opt_1(____this_2)
				end
				return true
			end
			return
		end
		local damagePoint = pos:__add(caster:GetForwardVector():__mul(80))
		local ____DamageBossFacelessDashArea_5 = DamageBossFacelessDashArea
		local ____ability_4 = ability
		local ____stopOnHit_3
		if stopOnHit then
			____stopOnHit_3 = nil
		else
			____stopOnHit_3 = damagedEnemyIds
		end
		if
			____DamageBossFacelessDashArea_5(
				nil,
				caster,
				____ability_4,
				damagePoint,
				____stopOnHit_3,
				stunDurationMultiplier
			)
		then
			damageOverTime = 1
		end
	end)
end
--- 虚空假面冲刺
-- 虚空假面在经过1.2秒蓄力后，向目标方向冲刺最短1200码，最多2000码距离，冲刺过程中无敌且对碰撞到的单位施放一次虚空碎击
-- 粒子特效：particles/econ/items/faceless_void/faceless_void_jewel_of_aeons/fv_time_walk_jewel.vpcf
-- 音效：Hero_FacelessVoid.TimeWalk
____exports.boss_faceless_1 = __TS__Class()
local boss_faceless_1 = ____exports.boss_faceless_1
boss_faceless_1.name = "boss_faceless_1"
__TS__ClassExtends(boss_faceless_1, MonsterAbility_CS)
function boss_faceless_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = PRECAST_TIME,
		castDuration = DASH_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.95,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(DASH_SEARCH_RANGE)
			local forward = caster:GetForwardVector()
			if target then
				forward = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:LockTargetForSpeed(target, 0.3)
			end
			self:WarningEffect(
				caster:GetAbsOrigin(),
				caster:GetAbsOrigin():__add(forward:__mul(DASH_MAX_DISTANCE + 100)),
				0.4,
				{
					startWidth = 255,
					endWidth = 255,
					getDirection = function()
						return caster:GetForwardVector()
					end,
					follow = true,
				}
			)
		end,
		OnStart = function()
			____exports.StartBossFacelessDash(nil, self)
		end,
	}
end
function boss_faceless_1.prototype.getTexture(self)
	return "textures/items/faceless_void_jewel_of_aeons/fv_time_walk_jewel.vpcf"
end
boss_faceless_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_faceless_1)
____exports.boss_faceless_1 = boss_faceless_1
modifier_boss_faceless_1_effect = __TS__Class()
modifier_boss_faceless_1_effect.name = "modifier_boss_faceless_1_effect"
__TS__ClassExtends(modifier_boss_faceless_1_effect, BaseModifier_CS)
function modifier_boss_faceless_1_effect.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test3.vpcf"
end
modifier_boss_faceless_1_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_faceless_1_effect)
return ____exports