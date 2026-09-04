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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____ability_tag_context = require("shared.ability_tag_context")
local ResolveAbilityTags = ____ability_tag_context.ResolveAbilityTags
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local PA_001_PARTICLE = "particles/phantom_assassin_stifling_dagger.vpcf"
local PA_001_LIGHTNING_PARTICLE = "particles/items_fx/chain_lightning.vpcf"
local PA_001_CAST_SOUND = "Hero_PhantomAssassin.Dagger.Cast"
local PA_001_HIT_SOUND = "Hero_PhantomAssassin.Dagger.Target"
local PA_001_LIGHTNING_SOUND = "Item.Maelstrom.Chain_Lightning"
local PA_001_LIGHTNING_JUMP_SOUND = "Item.Maelstrom.Chain_Lightning.Jump"
--- 暗袭强化：额外匕首数量（投射物数量 + 该值）
local PA_001_EXTRA_PROJECTILE_COUNT_KEY = "pa_001_extra_projectile_count"
--- 旧版符印键名兼容：历史配置曾使用 pa_001_shot
local PA_001_LEGACY_EXTRA_PROJECTILE_COUNT_KEY = "pa_001_shot"
--- 窒息之刃：毒性（投射物命中附加中毒概率）
local PA_001_POISON_CHANCE_PCT_KEY = "pa_001_poison_chance_pct"
--- 窒息之刃：毒性（触发后附加的中毒层数）
local PA_001_POISON_STACK_PER_HIT_KEY = "pa_001_poison_stack_per_hit"
--- 窒息之刃：快手（攻速阈值换匕首数量）
local PA_001_QUICKHAND_KEY = "pa_001_quickhand"
local PA_001_QUICKHAND_ATTACK_SPEED_THRESHOLD = 150
local PA_001_QUICKHAND_ATTACK_SPEED_THRESHOLD_KEY = "pa_001_quickhand_attack_speed_threshold"
local PA_001_QUICKHAND_ATTACK_SPEED_PER_DAGGER = 80
--- 窒息之刃：快手（每额外多少攻速获得1枚匕首）
local PA_001_QUICKHAND_ATTACK_SPEED_PER_DAGGER_KEY = "pa_001_quickhand_attack_speed_per_dagger"
--- 窒息之刃：快手（最多通过攻速额外获得的匕首数量）
local PA_001_QUICKHAND_MAX_EXTRA_PROJECTILE_KEY = "pa_001_quickhand_max_extra_projectile"
local PA_001_QUICKHAND_DEFAULT_MAX_EXTRA_PROJECTILE = 5
--- 窒息之刃：闪电镖，飞镖数量修正
local PA_001_LIGHTNING_DAGGER_PROJECTILE_DELTA_KEY = "pa_001_lightning_dagger_projectile_delta"
--- 窒息之刃：闪电镖，命中后最多弹射次数
local PA_001_LIGHTNING_DAGGER_BOUNCE_COUNT_KEY = "pa_001_lightning_dagger_bounce_count"
--- 窒息之刃：闪电镖，每次闪电造成的总敏捷魔法伤害百分比
local PA_001_LIGHTNING_DAGGER_AGILITY_DAMAGE_PCT_KEY = "pa_001_lightning_dagger_agility_damage_pct"
--- 窒息之刃：弹射镖，命中后继续弹射匕首的次数
local PA_001_BOUNCE_DAGGER_BOUNCE_COUNT_KEY = "pa_001_bounce_dagger_bounce_count"
local PA_001_MOVEMENT_SKILL_DAGGER_COUNT_PCT_KEY = "pa_001_movement_skill_dagger_count_pct"
--- 无目标时失败落地点半径（固定值）
local PA_001_FAIL_RADIUS = 180
--- 命中眩晕时长（固定值）
local PA_001_STUN_DURATION = 0.1
--- 隐藏规则：基础匕首数量与对应眩晕概率
local PA_001_STUN_BASE_PROJECTILE_COUNT = 3
local PA_001_STUN_REDUCTION_PER_EXTRA_PROJECTILE = 5
local PA_001_STUN_MIN_CHANCE_PCT = 10
--- 幻影刺客技能 001 - 窒息之刃
-- 主动技能：向目标单位发射投射物，命中时造成物理伤害并触发一次攻击。若击杀敌人则刷新冷却时间
____exports.pa_001 = __TS__Class()
local pa_001 = ____exports.pa_001
pa_001.name = "pa_001"
__TS__ClassExtends(pa_001, BaseHeroAbility)
function pa_001.prototype.Precache(self, context)
	PrecacheResource("particle", PA_001_PARTICLE, context)
	PrecacheResource("particle", PA_001_LIGHTNING_PARTICLE, context)
end
function pa_001.prototype.GetAbilityConfig(self)
	return { castPoint = 0.15, castAnimation = ACT_DOTA_CAST_ABILITY_4, behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function pa_001.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pa_001_movement_skill_dagger.name
end
function pa_001.prototype.GetCastRange(self, location, target)
	return self:GetSpecialValue("pa_001", "search_radius")
end
function pa_001.prototype.PlayEffects(self)
	local caster = self:GetCaster()
	local effect = MyGameHeroParticleManager:CreateParticle(
		"particles/blink_dagger_ti9_steam.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		effect,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(effect)
end
function pa_001.prototype.OnSpellStart(self)
	self:FireDaggers({ playCastSound = true, playCastEffect = true, createFailProjectile = true })
end
function pa_001.prototype.FireDaggers(self, options)
	if options == nil then
		options = {}
	end
	local caster = self._caster or self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local resolvedConfig = self:ResolveDaggerConfig(caster)
	local externalStartPoint = options.startPoint
	local fallbackStartPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 96))
	local projectileCount = math.max(1, math.floor(options.projectileCountOverride or resolvedConfig.projectileCount))
	local config = __TS__ObjectAssign(
		{},
		resolvedConfig,
		{
			stunProbability = options.disableStun and 0
				or self:ResolveStunProbability(resolvedConfig.stunProbability, projectileCount),
		}
	)
	local launchInterval = math.max(0, options.launchInterval or 0.06)
	local ____options_createFailProjectile_0 = options.createFailProjectile
	if ____options_createFailProjectile_0 == nil then
		____options_createFailProjectile_0 = true
	end
	local createFailProjectile = ____options_createFailProjectile_0
	local enemies = self:ResolveDaggerTargets(caster, config.searchRadius, options.targets)
	local ____options_playCastEffect_1 = options.playCastEffect
	if ____options_playCastEffect_1 == nil then
		____options_playCastEffect_1 = false
	end
	if ____options_playCastEffect_1 == true then
		self:PlayEffects()
	end
	local ____options_playCastSound_2 = options.playCastSound
	if ____options_playCastSound_2 == nil then
		____options_playCastSound_2 = false
	end
	if ____options_playCastSound_2 == true then
		caster:EmitSound(PA_001_CAST_SOUND)
	end
	local index = 0
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) then
			return nil
		end
		if index >= projectileCount then
			return nil
		end
		if #enemies > 0 then
			local target = enemies[index % #enemies + 1]
			if target and IsValid(nil, target) then
				local perDaggerStart = externalStartPoint or self:ComputeDaggerStartPoint(caster, target)
				self:CreateTrackingDagger(caster, perDaggerStart, target, config)
			end
		elseif createFailProjectile then
			self:CreateFailDagger(caster, externalStartPoint or fallbackStartPoint, config.projectileSpeed)
		end
		index = index + 1
		local ____temp_3
		if index < projectileCount then
			____temp_3 = launchInterval
		else
			____temp_3 = nil
		end
		return ____temp_3
	end)
end
function pa_001.prototype.GetCurrentDaggerProjectileCount(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	return self:ResolveDaggerConfig(caster).projectileCount
end
function pa_001.prototype.ResolveDaggerConfig(self, caster)
	local projectileSpeed = self:GetSpecialValue("pa_001", "projectile_speed")
	local searchRadius = self:GetSpecialValue("pa_001", "search_radius")
	local baseProjectileCount = self:GetSpecialValue("pa_001", "projectile_count")
	local fixedDamage = self:GetSpecialValue("pa_001", "fixed_damage")
	local agilityDamagePct = self:GetSpecialValue("pa_001", "agility_damage_pct")
	local stunProbability = self:GetSpecialValue("pa_001", "stun_chance_pct")
	local ____this_5
	____this_5 = caster
	local ____opt_4 = ____this_5.GetCustomValue
	local extraProjectileCountRaw = ____opt_4 and ____opt_4(____this_5, PA_001_EXTRA_PROJECTILE_COUNT_KEY) or 0
	local ____this_7
	____this_7 = caster
	local ____opt_6 = ____this_7.GetCustomValue
	local legacyExtraProjectileCountRaw = ____opt_6 and ____opt_6(____this_7, PA_001_LEGACY_EXTRA_PROJECTILE_COUNT_KEY)
		or 0
	local extraProjectileCount = (tonumber(extraProjectileCountRaw or 0) or 0)
		+ (tonumber(legacyExtraProjectileCountRaw) or 0) * 2
	local ____tonumber_10 = tonumber
	local ____this_9
	____this_9 = caster
	local ____opt_8 = ____this_9.GetCustomValue
	local quickhandEnabled = ____tonumber_10(____opt_8 and ____opt_8(____this_9, PA_001_QUICKHAND_KEY) or 0) > 0
	if quickhandEnabled then
		local attackSpeed = MyGameAttribute:GetAttribute(caster, "total_attack_speed") or 0
		local ____math_max_14 = math.max
		local ____tonumber_13 = tonumber
		local ____this_12
		____this_12 = caster
		local ____opt_11 = ____this_12.GetCustomValue
		local attackSpeedThreshold = ____math_max_14(
			0,
			____tonumber_13(
				____opt_11 and ____opt_11(____this_12, PA_001_QUICKHAND_ATTACK_SPEED_THRESHOLD_KEY)
					or PA_001_QUICKHAND_ATTACK_SPEED_THRESHOLD
			) or PA_001_QUICKHAND_ATTACK_SPEED_THRESHOLD
		)
		local ____math_max_18 = math.max
		local ____tonumber_17 = tonumber
		local ____this_16
		____this_16 = caster
		local ____opt_15 = ____this_16.GetCustomValue
		local attackSpeedPerDagger = ____math_max_18(
			1,
			____tonumber_17(
				____opt_15 and ____opt_15(____this_16, PA_001_QUICKHAND_ATTACK_SPEED_PER_DAGGER_KEY)
					or PA_001_QUICKHAND_ATTACK_SPEED_PER_DAGGER
			) or PA_001_QUICKHAND_ATTACK_SPEED_PER_DAGGER
		)
		local ____math_max_22 = math.max
		local ____tonumber_21 = tonumber
		local ____this_20
		____this_20 = caster
		local ____opt_19 = ____this_20.GetCustomValue
		local maxExtraProjectileFromQuickhand = ____math_max_22(
			0,
			____tonumber_21(
				____opt_19 and ____opt_19(____this_20, PA_001_QUICKHAND_MAX_EXTRA_PROJECTILE_KEY)
					or PA_001_QUICKHAND_DEFAULT_MAX_EXTRA_PROJECTILE
			) or PA_001_QUICKHAND_DEFAULT_MAX_EXTRA_PROJECTILE
		)
		if attackSpeed > attackSpeedThreshold then
			local extraFromAttackSpeed = math.floor((attackSpeed - attackSpeedThreshold) / attackSpeedPerDagger)
			extraProjectileCount = extraProjectileCount
				+ math.min(maxExtraProjectileFromQuickhand, math.max(0, extraFromAttackSpeed))
		end
	end
	local ____math_max_27 = math.max
	local ____math_min_26 = math.min
	local ____tonumber_25 = tonumber
	local ____this_24
	____this_24 = caster
	local ____opt_23 = ____this_24.GetCustomValue
	local poisonChancePct = ____math_max_27(
		0,
		____math_min_26(
			100,
			____tonumber_25(____opt_23 and ____opt_23(____this_24, PA_001_POISON_CHANCE_PCT_KEY) or 0) or 0
		)
	)
	local ____math_max_32 = math.max
	local ____math_floor_31 = math.floor
	local ____tonumber_30 = tonumber
	local ____this_29
	____this_29 = caster
	local ____opt_28 = ____this_29.GetCustomValue
	local poisonStacksPerHit = ____math_max_32(
		0,
		____math_floor_31(
			____tonumber_30(____opt_28 and ____opt_28(____this_29, PA_001_POISON_STACK_PER_HIT_KEY) or 0) or 0
		)
	)
	local ____math_floor_36 = math.floor
	local ____tonumber_35 = tonumber
	local ____this_34
	____this_34 = caster
	local ____opt_33 = ____this_34.GetCustomValue
	local lightningDaggerProjectileDelta = ____math_floor_36(
		____tonumber_35(____opt_33 and ____opt_33(____this_34, PA_001_LIGHTNING_DAGGER_PROJECTILE_DELTA_KEY) or 0) or 0
	)
	local ____math_max_41 = math.max
	local ____math_floor_40 = math.floor
	local ____tonumber_39 = tonumber
	local ____this_38
	____this_38 = caster
	local ____opt_37 = ____this_38.GetCustomValue
	local lightningDaggerBounceCount = ____math_max_41(
		0,
		____math_floor_40(
			____tonumber_39(____opt_37 and ____opt_37(____this_38, PA_001_LIGHTNING_DAGGER_BOUNCE_COUNT_KEY) or 0) or 0
		)
	)
	local ____math_max_45 = math.max
	local ____tonumber_44 = tonumber
	local ____this_43
	____this_43 = caster
	local ____opt_42 = ____this_43.GetCustomValue
	local lightningDaggerAgilityDamagePct = ____math_max_45(
		0,
		____tonumber_44(____opt_42 and ____opt_42(____this_43, PA_001_LIGHTNING_DAGGER_AGILITY_DAMAGE_PCT_KEY) or 0)
			or 0
	)
	local ____math_max_50 = math.max
	local ____math_floor_49 = math.floor
	local ____tonumber_48 = tonumber
	local ____this_47
	____this_47 = caster
	local ____opt_46 = ____this_47.GetCustomValue
	local bounceDaggerBounceCount = ____math_max_50(
		0,
		____math_floor_49(
			____tonumber_48(____opt_46 and ____opt_46(____this_47, PA_001_BOUNCE_DAGGER_BOUNCE_COUNT_KEY) or 0) or 0
		)
	)
	return {
		projectileSpeed = projectileSpeed,
		searchRadius = searchRadius,
		projectileCount = math.max(
			1,
			baseProjectileCount + math.floor(extraProjectileCount) + lightningDaggerProjectileDelta
		),
		fixedDamage = fixedDamage,
		agilityDamagePct = agilityDamagePct,
		stunProbability = stunProbability,
		poisonChancePct = poisonChancePct,
		poisonStacksPerHit = poisonStacksPerHit,
		lightningDaggerBounceCount = lightningDaggerBounceCount,
		lightningDaggerAgilityDamagePct = lightningDaggerAgilityDamagePct,
		bounceDaggerBounceCount = bounceDaggerBounceCount,
	}
end
function pa_001.prototype.ResolveStunProbability(self, baseStunProbability, projectileCount)
	local extraProjectileCount = math.max(0, math.floor(projectileCount) - PA_001_STUN_BASE_PROJECTILE_COUNT)
	local reducedProbability = baseStunProbability - extraProjectileCount * PA_001_STUN_REDUCTION_PER_EXTRA_PROJECTILE
	return math.max(PA_001_STUN_MIN_CHANCE_PCT, reducedProbability)
end
function pa_001.prototype.ResolveDaggerTargets(self, caster, searchRadius, externalTargets)
	if externalTargets and #externalTargets > 0 then
		return __TS__ArrayFilter(externalTargets, function(____, target)
			return IsValidAlive(nil, target)
		end)
	end
	return self:FindMonsterEnemies(caster:GetAbsOrigin(), searchRadius)
end
function pa_001.prototype.ComputeDaggerStartPoint(self, caster, target)
	local attackDir = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	local forwardDir = Vector(attackDir.x, attackDir.y, 0):Normalized()
	local rightDir = RotateVector2D(nil, forwardDir, 90):Normalized()
	local upDir = Vector(0, 0, 1)
	local radius = 75
	local theta = RandomFloat(0, 360) * math.pi / 180
	return caster:GetAbsOrigin():__add(Vector(0, 0, 100))
		+ rightDir * (radius * math.cos(theta))
		+ upDir * (radius * math.sin(theta))
end
function pa_001.prototype.CreateTrackingDagger(self, caster, startPoint, target, config, bounceRemaining, hitTargets)
	if bounceRemaining == nil then
		bounceRemaining = config.bounceDaggerBounceCount
	end
	if hitTargets == nil then
		hitTargets = {}
	end
	local pfx_name = caster:GetModelName() == "models/heroes/phantom_assassin/pa_arcana.vmdl"
			and "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_arcana.vpcf"
		or PA_001_PARTICLE
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = pfx_name,
		target = target,
		start_point = startPoint,
		projectile_type = "tracking",
		projectile_speed = config.projectileSpeed,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValid(nil, hitTarget) then
				self:OnDaggerHit(caster, hitTarget, config, bounceRemaining, hitTargets)
			end
			return false
		end,
	})
end
function pa_001.prototype.OnDaggerHit(self, caster, hitTarget, config, bounceRemaining, hitTargets)
	if not IsValid(nil, hitTarget) then
		return
	end
	local hitLocation = hitTarget:GetAbsOrigin()
	hitTarget:EmitSound(PA_001_HIT_SOUND)
	if config.poisonChancePct > 0 and config.poisonStacksPerHit > 0 and RollPercentage(config.poisonChancePct) then
		AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.POISON, { stack = config.poisonStacksPerHit })
	end
	if RandomFloat(0, 100) < config.stunProbability then
		AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.STUN, { duration = PA_001_STUN_DURATION })
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = hitTarget,
		damage = config.fixedDamage
			+ MyGameAttribute:GetAttribute(caster, "total_agility") * config.agilityDamagePct / 100,
		damage_type = 1,
		ability = self,
	})
	self:LaunchLightningDagger(caster, hitTarget, config)
	MyGameAttack:PerformAttack(caster, hitTarget, { use_projectile = false })
	self:LaunchBounceDagger(caster, hitTarget, hitLocation, config, bounceRemaining, hitTargets)
end
function pa_001.prototype.LaunchBounceDagger(
	self,
	caster,
	sourceTarget,
	sourceLocation,
	config,
	bounceRemaining,
	hitTargets
)
	if bounceRemaining <= 0 or not IsValidAlive(nil, caster) then
		return
	end
	local ____array_51 = __TS__SparseArrayNew(unpack(hitTargets))
	__TS__SparseArrayPush(____array_51, sourceTarget)
	local nextHitTargets = { __TS__SparseArraySpread(____array_51) }
	local nextTarget = self:FindNextBounceDaggerTarget(caster, sourceLocation, config.searchRadius, nextHitTargets)
	if not nextTarget then
		return
	end
	local startPoint = sourceLocation:__add(Vector(0, 0, 96))
	self:CreateTrackingDagger(caster, startPoint, nextTarget, config, bounceRemaining - 1, nextHitTargets)
end
function pa_001.prototype.LaunchLightningDagger(self, caster, firstTarget, config)
	if config.lightningDaggerBounceCount <= 0 or config.lightningDaggerAgilityDamagePct <= 0 then
		return
	end
	local damage = (MyGameAttribute:GetAttribute(caster, "total_agility") or 0)
			* config.lightningDaggerAgilityDamagePct
			/ 100
		+ 10
	if damage <= 0 then
		return
	end
	local hitTargets = {}
	if not IsValidAlive(nil, firstTarget) then
		return
	end
	local currentTarget = firstTarget
	local currentSourceLocation = firstTarget:GetAbsOrigin()
	local bounceCount = 0
	local doBounce
	doBounce = function()
		if not IsValidAlive(nil, caster) then
			return
		end
		if IsValid(nil, currentTarget) then
			hitTargets[#hitTargets + 1] = currentTarget
		end
		if IsValidAlive(nil, currentTarget) then
			currentSourceLocation = currentTarget:GetAbsOrigin()
			self:ApplyLightningDaggerDamage(caster, currentTarget, damage)
			EmitSoundOn(PA_001_LIGHTNING_SOUND, currentTarget)
		end
		if bounceCount >= config.lightningDaggerBounceCount then
			return
		end
		local nextTarget =
			self:FindNextLightningDaggerTarget(caster, currentSourceLocation, config.searchRadius, hitTargets)
		if not IsValidAlive(nil, nextTarget) then
			return
		end
		local ____IsValidAlive_result_52
		if IsValidAlive(nil, currentTarget) then
			____IsValidAlive_result_52 = currentTarget
		else
			____IsValidAlive_result_52 = self:CreateLightningDaggerEffectAnchor(caster, currentSourceLocation)
		end
		local sourceForEffect = ____IsValidAlive_result_52
		self:PlayLightningDaggerEffects(caster, sourceForEffect, nextTarget)
		currentTarget = nextTarget
		currentSourceLocation = nextTarget:GetAbsOrigin()
		bounceCount = bounceCount + 1
		Timers:CreateTimer(0.12, doBounce)
	end
	doBounce(nil)
end
function pa_001.prototype.ApplyLightningDaggerDamage(self, caster, target, damage)
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = damage,
		damage_type = 2,
		ability = self,
	})
end
function pa_001.prototype.FindNextLightningDaggerTarget(self, caster, sourceLocation, searchRadius, hitTargets)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		sourceLocation,
		nil,
		searchRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue50
			end
			if enemy:GetTeamNumber() == caster:GetTeamNumber() then
				goto __continue50
			end
			if __TS__ArrayIncludes(hitTargets, enemy) then
				goto __continue50
			end
			return enemy
		end
		::__continue50::
	end
	return nil
end
function pa_001.prototype.FindNextBounceDaggerTarget(self, caster, sourceLocation, searchRadius, hitTargets)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		sourceLocation,
		nil,
		searchRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue57
			end
			if enemy:GetTeamNumber() == caster:GetTeamNumber() then
				goto __continue57
			end
			if __TS__ArrayIncludes(hitTargets, enemy) then
				goto __continue57
			end
			return enemy
		end
		::__continue57::
	end
	return nil
end
function pa_001.prototype.CreateLightningDaggerEffectAnchor(self, caster, sourceLocation)
	return CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = 0.3 },
		sourceLocation,
		caster:GetTeamNumber(),
		false
	)
end
function pa_001.prototype.PlayLightningDaggerEffects(self, caster, source, target)
	if not IsValidAlive(nil, target) then
		return
	end
	if not IsValidAlive(nil, source) then
		return
	end
	local particle =
		MyGameHeroParticleManager:CreateParticle(PA_001_LIGHTNING_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, source, caster)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		source:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn(PA_001_LIGHTNING_JUMP_SOUND, target)
end
function pa_001.prototype.CreateFailDagger(self, caster, startPoint, projectileSpeed)
	local failPoint = caster:GetAbsOrigin():__add(RandomVector(PA_001_FAIL_RADIUS))
	failPoint.z = GetGroundPosition(failPoint, caster).z
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PA_001_PARTICLE,
		target = failPoint,
		start_point = startPoint,
		projectile_type = "collideground",
		projectile_speed = projectileSpeed,
		on_hit = function(____, _hitTarget, _location)
			return true
		end,
	})
end
pa_001 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_001)
____exports.pa_001 = pa_001
--- 窒息之刃减速 debuff：buff 结束时若目标已死亡则刷新 pa_001 冷却。
-- 被攻击时视为背刺（见 pa_003）。
____exports.modifier_pa_001_movement_skill_dagger = __TS__Class()
local modifier_pa_001_movement_skill_dagger = ____exports.modifier_pa_001_movement_skill_dagger
modifier_pa_001_movement_skill_dagger.name = "modifier_pa_001_movement_skill_dagger"
__TS__ClassExtends(modifier_pa_001_movement_skill_dagger, BaseHeroModifier)
function modifier_pa_001_movement_skill_dagger.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_pa_001_movement_skill_dagger.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_pa_001_movement_skill_dagger.prototype.IsPermanent(self)
	return true
end
function modifier_pa_001_movement_skill_dagger.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local ____math_max_56 = math.max
	local ____tonumber_55 = tonumber
	local ____opt_53 = parent.GetCustomValue
	local daggerCountPct = ____math_max_56(
		0,
		____tonumber_55(____opt_53 and ____opt_53(parent, PA_001_MOVEMENT_SKILL_DAGGER_COUNT_PCT_KEY) or 0) or 0
	)
	if daggerCountPct <= 0 then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_57 = castAbility.IsItem
	if ____opt_57 and ____opt_57(castAbility) then
		return
	end
	local ____opt_59 = castAbility.IsToggle
	if ____opt_59 and ____opt_59(castAbility) then
		return
	end
	if castAbility:GetAbilityName() == ability:GetAbilityName() then
		return
	end
	if not self:IsMovementAbility(castAbility) then
		return
	end
	local daggerCount = math.floor(ability:GetCurrentDaggerProjectileCount(parent) * daggerCountPct / 100)
	if daggerCount <= 0 then
		return
	end
	ability:FireDaggers({
		projectileCountOverride = daggerCount,
		playCastSound = true,
		playCastEffect = false,
		createFailProjectile = false,
		disableStun = true,
	})
end
function modifier_pa_001_movement_skill_dagger.prototype.IsMovementAbility(self, ability)
	local tags = ResolveAbilityTags(
		nil,
		MyGameRulesetManager and MyGameRulesetManager:GetAbilityConfig(ability:GetAbilityName())
	)
	return bit.band(tags, 4) ~= 0
end
modifier_pa_001_movement_skill_dagger =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_001_movement_skill_dagger)
____exports.modifier_pa_001_movement_skill_dagger = modifier_pa_001_movement_skill_dagger
____exports.modifier_pa_001_slow = __TS__Class()
local modifier_pa_001_slow = ____exports.modifier_pa_001_slow
modifier_pa_001_slow.name = "modifier_pa_001_slow"
__TS__ClassExtends(modifier_pa_001_slow, MonsterModifier_CS)
function modifier_pa_001_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -50 }
end
function modifier_pa_001_slow.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger_debuff.vpcf"
end
function modifier_pa_001_slow.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		local ____opt_63 = self._ability
		if ____opt_63 ~= nil then
			____opt_63:EndCooldown()
		end
	end
end
modifier_pa_001_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_001_slow)
____exports.modifier_pa_001_slow = modifier_pa_001_slow
return ____exports