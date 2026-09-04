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
local __TS__Delete = ____lualib.__TS__Delete
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_lina_001_dragon_soul
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local ____ability_tag_context = require("shared.ability_tag_context")
local BuildTagContextFromAbilityKv = ____ability_tag_context.BuildTagContextFromAbilityKv
local LINA_001_PARTICLE = "particles/dd/liner_projectile.vpcf"
local LINA_002_PARTICLE = "particles/econ/events/frostivus/frostivus_tree_cast_burst.vpcf"
--- 灼地路径粒子：沿用 lina_004 的燃烧轨迹表现
local LINA_001_BURN_TRAIL_PARTICLE = "particles/hero/lina/lina_burning_trail.vpcf"
local LINA_001_KNOCKBACK_DISTANCE = 80
local LINA_001_KNOCKBACK_DURATION = 0.2
local LINA_001_KNOCKBACK_STUN_DURATION = 0.4
--- 每达到该最大魔法值，龙破斩伤害获得一次比例加成
local LINA_001_MANA_PER_DAMAGE_BONUS_STEP = 100
--- 每 100 点最大魔法值提供的伤害加成百分比
local LINA_001_DAMAGE_BONUS_PCT_PER_MANA_STEP = 5
--- 最大魔法值提供的隐藏伤害加成上限百分比
local LINA_001_MANA_DAMAGE_BONUS_MAX_PCT = 500
--- 宝石开关：>0 时龙破斩会生成持续伤害地面
local LINA_001_BURN_TRAIL_CUSTOM_KEY = "lina_001_burning_trail"
--- 灼地持续时间（秒）
local LINA_001_BURN_TRAIL_DURATION_KEY = "lina_001_burning_trail_duration_sec"
--- 灼地每秒伤害（智力百分比）
local LINA_001_BURN_TRAIL_INT_DAMAGE_PCT_PER_SEC_KEY = "lina_001_burning_trail_int_damage_pct_per_sec"
--- 符印：龙魄叠层（item_G309 等），数值来自 hero_data
local LINA_001_DRAGON_SOUL_ENABLED_KEY = "lina_001_dragon_soul"
local LINA_001_DRAGON_SOUL_PCT_PER_STACK_KEY = "lina_001_dragon_soul_damage_pct_per_stack"
local LINA_001_DRAGON_SOUL_MAX_STACKS_KEY = "lina_001_dragon_soul_max_stacks"
local LINA_001_DRAGON_SOUL_DECAY_INTERVAL_KEY = "lina_001_dragon_soul_decay_interval"
--- 符印：超载龙破重复命中伤害百分比，数值来自 hero_data
local LINA_001_REPEAT_HIT_DAMAGE_PCT_KEY = "lina_001_repeat_hit_damage_pct"
--- 灼地总持续时间（秒）默认值
local LINA_001_BURN_TRAIL_DURATION_SECONDS_DEFAULT = 3
--- 灼地每秒伤害（基于当前智力百分比）默认值
local LINA_001_BURN_TRAIL_INT_DAMAGE_PCT_PER_SECOND_DEFAULT = 100
--- 灼地路径点位间隔
local LINA_001_BURN_TRAIL_STEP = 64
--- 灼地线性搜索半宽（半径）
local LINA_001_BURN_TRAIL_WIDTH = 125
--- 灼地伤害间隔（秒）
local LINA_001_BURN_TRAIL_TICK_INTERVAL = 0.2
--- 是否允许多个燃烧地带对同一目标叠加伤害（默认不叠加）
local LINA_001_BURN_TRAIL_ALLOW_STACK_DAMAGE = false
--- 丽娜技能 001 - 龙破斩
-- 向指定方向释放线性投射物，范围 300，长度 1000，速度 1200。
-- 英雄技能伤害语义：造成智力倍率伤害并附加固定伤害，再根据最大魔法值提高本次伤害。
-- 符印龙魄：每次施法叠层并刷新持续，按层数提高本技能伤害（含本波灼地跳伤）。
____exports.lina_001 = __TS__Class()
local lina_001 = ____exports.lina_001
lina_001.name = "lina_001"
__TS__ClassExtends(lina_001, BaseHeroAbility)
function lina_001.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_001_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context)
	PrecacheResource("particle", LINA_001_BURN_TRAIL_PARTICLE, context)
end
function lina_001.prototype.GetAbilityConfig(self)
	return { castPoint = 0.45, castAnimation = ACT_DOTA_CAST_ABILITY_1, behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function lina_001.prototype.GetCastRange(self, location, target)
	if IsClient() then
		return BaseHeroAbility.prototype.GetCastRange(self, location, target)
	end
	return 9999
end
function lina_001.prototype.PlayEffects(self, pos)
	local caster = self:GetCaster()
	caster:EmitSound("Hero_Lina.DragonSlave")
	local effect_cast1 =
		MyGameHeroParticleManager:CreateParticle(LINA_002_PARTICLE, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(effect_cast1, 0, caster:GetAbsOrigin():__sub(Vector(0, 0, 86)))
	MyGameHeroParticleManager:ReleaseParticleIndex(effect_cast1)
end
function lina_001.prototype.OnSpellStart(self)
	local caster = self._caster
	local cursor = self:GetCursorPosition()
	self:PlayEffects(cursor)
	if not IsServer() then
		return
	end
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, cursor, origin)
	local startPoint = origin
	local projectileDistance = BaseHeroAbility.prototype.GetCastRange(self, origin, nil)
	local projectileSpeed = self:GetSpecialValue("lina_001", "projectile_speed")
	local projectileRange = self:GetSpecialValue("lina_001", "projectile_range")
	local damagePct = self:GetSpecialValue("lina_001", "damage_pct")
	local baseDamage = self:GetSpecialValue("lina_001", "base_damage")
	local endPoint = startPoint:__add(dir:__mul(projectileDistance))
	local ____tonumber_2 = tonumber
	local ____opt_0 = caster.GetCustomValue
	local burnTrailEnabled = ____tonumber_2(____opt_0 and ____opt_0(caster, LINA_001_BURN_TRAIL_CUSTOM_KEY) or 0) > 0
	local ____math_max_6 = math.max
	local ____tonumber_5 = tonumber
	local ____opt_3 = caster.GetCustomValue
	local burnTrailDuration = ____math_max_6(
		0.1,
		____tonumber_5(
			____opt_3 and ____opt_3(caster, LINA_001_BURN_TRAIL_DURATION_KEY)
				or LINA_001_BURN_TRAIL_DURATION_SECONDS_DEFAULT
		) or LINA_001_BURN_TRAIL_DURATION_SECONDS_DEFAULT
	)
	local ____math_max_10 = math.max
	local ____tonumber_9 = tonumber
	local ____opt_7 = caster.GetCustomValue
	local burnTrailIntDamagePctPerSec = ____math_max_10(
		0,
		____tonumber_9(
			____opt_7 and ____opt_7(caster, LINA_001_BURN_TRAIL_INT_DAMAGE_PCT_PER_SEC_KEY)
				or LINA_001_BURN_TRAIL_INT_DAMAGE_PCT_PER_SECOND_DEFAULT
		) or LINA_001_BURN_TRAIL_INT_DAMAGE_PCT_PER_SECOND_DEFAULT
	)
	local dragonSoulDamageMultiplier = 1
	local ____tonumber_13 = tonumber
	local ____opt_11 = caster.GetCustomValue
	local dragonSoulEnabled = ____tonumber_13(____opt_11 and ____opt_11(caster, LINA_001_DRAGON_SOUL_ENABLED_KEY) or 0)
		> 0
	if dragonSoulEnabled then
		local soulMaxStacks = tonumber(caster:GetCustomValue(LINA_001_DRAGON_SOUL_MAX_STACKS_KEY) or 0)
		local soulPctPerStack = tonumber(caster:GetCustomValue(LINA_001_DRAGON_SOUL_PCT_PER_STACK_KEY) or 0)
		local soulDecayInterval = tonumber(caster:GetCustomValue(LINA_001_DRAGON_SOUL_DECAY_INTERVAL_KEY) or 0)
		modifier_lina_001_dragon_soul:applys(
			caster,
			caster,
			self,
			{ max_stacks = soulMaxStacks, decay_interval = soulDecayInterval }
		)
		local soulMod = modifier_lina_001_dragon_soul:find_on(caster)
		local ____soulMod_14
		if soulMod then
			____soulMod_14 = soulMod:GetStackCount()
		else
			____soulMod_14 = 0
		end
		local stacks = ____soulMod_14
		dragonSoulDamageMultiplier = 1 + stacks * soulPctPerStack / 100
	end
	local burnTrailStates = {}
	local projectileHitTables = {}
	--- 全局不叠加模式下：记录单位下一次允许被灼地伤害的时间点
	local burnTrailGlobalNextDamageTime = {}
	local maxMana = math.max(0, MyGameAttribute:GetAttribute(caster, "total_mana") or caster:GetMaxMana())
	local manaDamageBonusPct = math.min(
		LINA_001_MANA_DAMAGE_BONUS_MAX_PCT,
		maxMana / LINA_001_MANA_PER_DAMAGE_BONUS_STEP * LINA_001_DAMAGE_BONUS_PCT_PER_MANA_STEP
	)
	local manaDamageMultiplier = 1 + manaDamageBonusPct / 100
	local damage = (self:GetIntelligence(caster) * damagePct / 100 + baseDamage)
		* manaDamageMultiplier
		* dragonSoulDamageMultiplier
	local extraProjectileCount = self:ResolveDragonSlaveExtraProjectileCount(caster)
	local ____math_max_18 = math.max
	local ____tonumber_17 = tonumber
	local ____opt_15 = caster.GetCustomValue
	local repeatHitDamagePct = ____math_max_18(
		0,
		____tonumber_17(____opt_15 and ____opt_15(caster, LINA_001_REPEAT_HIT_DAMAGE_PCT_KEY) or 0) or 0
	)
	local projectileGlobalHitCounts = {}
	ScreenShake(origin, 5, 5, 0.4, 2000, 0, true)
	self:ApplyDragonSlaveInitialHitCompensations(
		caster,
		startPoint,
		damage,
		projectileHitTables,
		projectileGlobalHitCounts,
		extraProjectileCount,
		repeatHitDamagePct
	)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = LINA_001_PARTICLE,
		target = endPoint,
		start_point = startPoint,
		projectile_type = "linear",
		projectile_speed = projectileSpeed,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		projectile_distance = projectileDistance,
		projectile_range = projectileRange,
		enable_projectile_count_bonus = true,
		break_destructibles = true,
		on_think = function(____, location, extraData)
			local ____temp_21 = extraData and extraData.__think_cb_id
			if ____temp_21 == nil then
				____temp_21 = ""
			end
			local thinkCbId = tostring(____temp_21)
			local projectileIndex = self:GetDragonSlaveProjectileKey(extraData)
			if not burnTrailEnabled then
				return
			end
			local ____temp_22
			if thinkCbId ~= "" then
				____temp_22 = thinkCbId
			else
				____temp_22 = projectileIndex
			end
			local stateKey = ____temp_22
			if not burnTrailStates[stateKey] then
				local firstPos = location:__add(Vector(0, 0, 0))
				burnTrailStates[stateKey] =
					{ lastEffectPos = firstPos, trailPositions = { firstPos }, damageElapsed = 0 }
				self:PlayBurnTrailEffect(firstPos, burnTrailDuration)
				Timers:CreateTimer(LINA_001_BURN_TRAIL_TICK_INTERVAL, function()
					if not IsValid(nil, caster) or not caster:IsAlive() then
						return nil
					end
					local state = burnTrailStates[stateKey]
					if not state then
						return nil
					end
					state.damageElapsed = state.damageElapsed + LINA_001_BURN_TRAIL_TICK_INTERVAL
					if state.damageElapsed > burnTrailDuration then
						__TS__Delete(burnTrailStates, stateKey)
						return nil
					end
					self:ApplyBurnTrailDamageTickByLinearSearch(
						caster,
						state.trailPositions,
						burnTrailGlobalNextDamageTime,
						dragonSoulDamageMultiplier,
						burnTrailIntDamagePctPerSec
					)
					return LINA_001_BURN_TRAIL_TICK_INTERVAL
				end)
			end
			local state = burnTrailStates[stateKey]
			state.lastEffectPos = self:UpdateBurnTrailEffectsByProjectile(
				state.lastEffectPos,
				location,
				state.trailPositions,
				burnTrailDuration
			)
		end,
		on_hit = function(____, hitTarget, _location, extraData)
			if hitTarget then
				self:TryApplyDragonSlaveProjectileHit(
					caster,
					hitTarget,
					damage,
					projectileHitTables,
					projectileGlobalHitCounts,
					self:GetDragonSlaveProjectileKey(extraData),
					repeatHitDamagePct
				)
			end
			return false
		end,
	})
end
function lina_001.prototype.ResolveDragonSlaveExtraProjectileCount(self, caster)
	if not MyGameTagManager or not IsValid(nil, caster) then
		return 0
	end
	local ____opt_23 = self.GetAbilityName
	local abilityName = ____opt_23 and ____opt_23(self)
	local ____abilityName_27
	if abilityName then
		____abilityName_27 = MyGameRulesetManager and MyGameRulesetManager:GetAbilityConfig(abilityName)
	else
		____abilityName_27 = nil
	end
	local abilityKv = ____abilityName_27
	return math.max(
		0,
		math.floor(MyGameTagManager:ResolveNumberForUnit(caster, 0, 13, {
			abilityName = abilityName,
			abilityKv = abilityKv,
			tagContext = BuildTagContextFromAbilityKv(nil, abilityKv),
		}))
	)
end
function lina_001.prototype.GetDragonSlaveProjectileKey(self, extraData)
	local ____temp_30 = extraData and extraData.__ak_projectile_index
	if ____temp_30 == nil then
		____temp_30 = "single"
	end
	return tostring(____temp_30)
end
function lina_001.prototype.ApplyDragonSlaveInitialHitCompensations(
	self,
	caster,
	center,
	damage,
	projectileHitTables,
	projectileGlobalHitCounts,
	extraProjectileCount,
	repeatHitDamagePct
)
	local totalProjectileCount = 1 + extraProjectileCount
	do
		local index = 0
		while index < totalProjectileCount do
			local ____temp_31
			if extraProjectileCount > 0 then
				____temp_31 = tostring(index)
			else
				____temp_31 = "single"
			end
			local projectileKey = ____temp_31
			self:ApplyDragonSlaveInitialHitCompensation(
				caster,
				center,
				damage,
				projectileHitTables,
				projectileGlobalHitCounts,
				projectileKey,
				repeatHitDamagePct
			)
			index = index + 1
		end
	end
end
function lina_001.prototype.ApplyDragonSlaveInitialHitCompensation(
	self,
	caster,
	center,
	damage,
	projectileHitTables,
	projectileGlobalHitCounts,
	projectileKey,
	repeatHitDamagePct
)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		75,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue26
			end
			self:TryApplyDragonSlaveProjectileHit(
				caster,
				enemy,
				damage,
				projectileHitTables,
				projectileGlobalHitCounts,
				projectileKey,
				repeatHitDamagePct
			)
		end
		::__continue26::
	end
end
function lina_001.prototype.TryApplyDragonSlaveProjectileHit(
	self,
	caster,
	target,
	damage,
	projectileHitTables,
	projectileGlobalHitCounts,
	projectileKey,
	repeatHitDamagePct
)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	if projectileHitTables[projectileKey] == nil then
		projectileHitTables[projectileKey] = {}
	end
	local hitTable = projectileHitTables[projectileKey]
	local targetId = target:GetEntityIndex()
	if hitTable[targetId] then
		return
	end
	hitTable[targetId] = true
	local previousHitCount = projectileGlobalHitCounts[targetId] or 0
	projectileGlobalHitCounts[targetId] = previousHitCount + 1
	local ____temp_32
	if previousHitCount > 0 and repeatHitDamagePct > 0 then
		____temp_32 = damage * (repeatHitDamagePct / 100)
	else
		____temp_32 = damage
	end
	local finalDamage = ____temp_32
	target:KnockBack(self:GetCaster(), self, {
		duration = LINA_001_KNOCKBACK_DURATION,
		stun = true,
		destroyTreesType = "onDestroy",
		heightType = "parabola",
		particleName = "",
		distance = LINA_001_KNOCKBACK_DISTANCE,
		height = 0,
		stunDuration = LINA_001_KNOCKBACK_STUN_DURATION,
		removeOnDeath = true,
		origin_pos = caster:GetAbsOrigin(),
	})
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = finalDamage,
		damage_type = 2,
		ability = self,
	})
end
function lina_001.prototype.UpdateBurnTrailEffectsByProjectile(
	self,
	lastEffectPos,
	location,
	trailPositions,
	burnTrailDuration
)
	local last = lastEffectPos:__add(Vector(0, 0, 0))
	local toCurrent = location:__sub(last)
	local distance = toCurrent:Length2D()
	while distance >= LINA_001_BURN_TRAIL_STEP do
		local stepDir = toCurrent:Normalized()
		local newPoint = last:__add(stepDir:__mul(LINA_001_BURN_TRAIL_STEP))
		self:PlayBurnTrailEffect(newPoint, burnTrailDuration)
		trailPositions[#trailPositions + 1] = newPoint:__add(Vector(0, 0, 0))
		last = newPoint:__add(Vector(0, 0, 0))
		toCurrent = location:__sub(last)
		distance = toCurrent:Length2D()
	end
	return last
end
function lina_001.prototype.ApplyBurnTrailDamageTickByLinearSearch(
	self,
	caster,
	trailPositions,
	globalNextDamageTime,
	dragonSoulDamageMultiplier,
	burnTrailIntDamagePctPerSec
)
	if dragonSoulDamageMultiplier == nil then
		dragonSoulDamageMultiplier = 1
	end
	if burnTrailIntDamagePctPerSec == nil then
		burnTrailIntDamagePctPerSec = LINA_001_BURN_TRAIL_INT_DAMAGE_PCT_PER_SECOND_DEFAULT
	end
	if not IsValid(nil, caster) or not caster:IsAlive() then
		return
	end
	if #trailPositions < 2 then
		return
	end
	local damagePerTickMultiplier = burnTrailIntDamagePctPerSec / 100 * LINA_001_BURN_TRAIL_TICK_INTERVAL
	local damage = self:GetIntelligence(caster) * damagePerTickMultiplier * dragonSoulDamageMultiplier
	local hitSet = __TS__New(Set)
	local now = GameRules:GetGameTime()
	do
		local i = 1
		while i < #trailPositions do
			local startPoint = trailPositions[i]
			local endPoint = trailPositions[i + 1]
			local enemies = FindUnitsInLine(
				caster:GetTeamNumber(),
				startPoint,
				endPoint,
				nil,
				LINA_001_BURN_TRAIL_WIDTH,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE
			)
			for ____, enemy in ipairs(enemies) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue38
					end
					local id = enemy:GetEntityIndex()
					if hitSet:has(id) then
						goto __continue38
					end
					if not LINA_001_BURN_TRAIL_ALLOW_STACK_DAMAGE and globalNextDamageTime then
						local nextAllowed = globalNextDamageTime[id] or 0
						if now < nextAllowed then
							goto __continue38
						end
						globalNextDamageTime[id] = now + LINA_001_BURN_TRAIL_TICK_INTERVAL * 0.99
					end
					hitSet:add(id)
					Damage:ApplyDamage({
						attacker = caster,
						victim = enemy,
						damage = damage,
						damage_type = 2,
						ability = self,
					})
				end
				::__continue38::
			end
			i = i + 1
		end
	end
end
function lina_001.prototype.PlayBurnTrailEffect(self, point, duration)
	local caster = self:GetCaster()
	local pid =
		MyGameHeroParticleManager:CreateParticle(LINA_001_BURN_TRAIL_PARTICLE, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, point)
	MyGameHeroParticleManager:SetParticleControl(pid, 1, point)
	MyGameHeroParticleManager:SetParticleControl(pid, 2, Vector(duration, 0, 0))
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
end
lina_001 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_001)
____exports.lina_001 = lina_001
--- 龙魄：每次释放龙破斩叠层（受符印 max_stacks 约束），之后按固定间隔自然流逝 1 层。
modifier_lina_001_dragon_soul = __TS__Class()
modifier_lina_001_dragon_soul.name = "modifier_lina_001_dragon_soul"
__TS__ClassExtends(modifier_lina_001_dragon_soul, BaseHeroModifier)
function modifier_lina_001_dragon_soul.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:StartDecay(params)
end
function modifier_lina_001_dragon_soul.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local maxStacks = math.max(1, math.floor(params.max_stacks))
	local next = math.min(self:GetStackCount() + 1, maxStacks)
	self:SetStackCount(next)
end
function modifier_lina_001_dragon_soul.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStacks = self:GetStackCount() - 1
	if nextStacks <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(nextStacks)
end
function modifier_lina_001_dragon_soul.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_lina_001_dragon_soul.prototype.IsDebuff(self)
	return false
end
function modifier_lina_001_dragon_soul.prototype.IsPurgable(self)
	return true
end
function modifier_lina_001_dragon_soul.prototype.GetTexture(self)
	return "lina_dragon_slave"
end
function modifier_lina_001_dragon_soul.GetLocalizationCN(self)
	return { name = "龙魄", description = "每层使龙破斩伤害提高,并会随时间逐层流逝。" }
end
function modifier_lina_001_dragon_soul.prototype.StartDecay(self, params)
	local decayInterval = tonumber(params.decay_interval)
	if not decayInterval or decayInterval <= 0 then
		self:Destroy()
		return
	end
	self:StartIntervalThink(decayInterval)
end
modifier_lina_001_dragon_soul = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_001_dragon_soul)
return ____exports