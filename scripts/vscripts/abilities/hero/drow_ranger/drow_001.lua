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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local DROW_001_CAST_POINT = 0.25
--- 命中冰冻视觉（与霜冻之箭一致的全项目冰冻语义）
local DROW_001_FREEZE_EFFECT = "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf"
local DROW_001_FREEZE_STATUS_EFFECT = "particles/status_fx/status_effect_drow_frost_arrow.vpcf"
--- 爆发延迟下限（秒）：极高攻速下保留可见预警窗口
local DROW_001_MIN_IMPACT_DELAY = 0.2
local DROW_001_SHOT_PARTICLE = "particles/bb/st_mainshot.vpcf"
local DROW_001_WARNING_PARTICLE =
	"particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/cm_arcana_pup_lvlup_hit.vpcf"
local DROW_001_IMPACT_PARTICLE = "particles/creatures/aghanim/aghanim_crystal_attack_impact.vpcf"
local DROW_001_EXPLOSION_PARTICLE = "particles/hero/dr/maiden_crystal_nova_cowlofice.vpcf"
--- 宝石开关：>0 时启用 001 箭雨模式
local DROW_001_ARROW_RAIN_ENABLE_KEY = "drow_001_arrow_rain"
--- 符印「霜蚀」：目标每层冰冻对其增伤百分比（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=6/8/10）
local DROW_001_FROST_EROSION_PCT_KEY = "drow_001_dmg_pct_per_freeze_stack"
--- 霜蚀计层封顶：与单实例冰冻上限一致，多施加者实例求和不超过此值
local DROW_001_FROST_EROSION_STACK_CAP = 10
--- 符印「冻魄」：满层触发的魔伤易伤百分比（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=18/25/33，>0 即启用）
local DROW_001_FROZEN_SOUL_AMP_KEY = "drow_001_frozen_soul_magic_amp_pct"
--- 冻魄触发阈值：目标冰冻层数（爆发瞬间快照）达到该值
local DROW_001_FROZEN_SOUL_REQUIRED_STACKS = 10
--- 冻魄冻结时长（秒）
local DROW_001_FROZEN_SOUL_FREEZE_DURATION = 2
--- 冻魄魔伤易伤窗口（秒）
local DROW_001_FROZEN_SOUL_AMP_DURATION = 6
--- 冻魄每目标基础触发间隔（秒），实际间隔按施法者冷却缩减折算
local DROW_001_FROZEN_SOUL_BASE_INTERVAL = 10
--- 冻魄内置冷却下限（秒），防极端冷却缩减把间隔压穿
local DROW_001_FROZEN_SOUL_MIN_INTERVAL = 1
--- 冻结状态特效（rubick 冻结系现役冰封语义，区别于叠层冰冻的 drow_frost）
local DROW_001_FROZEN_SOUL_STATUS_EFFECT = "particles/status_fx/status_effect_frost.vpcf"
--- 符印「繁星」：每束子箭造成主箭伤害的百分比（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=18/25/33，>0 即启用）
local DROW_001_STAR_RAIN_PCT_KEY = "drow_001_star_rain_damage_pct"
--- 繁星攻速门槛：超过该值的攻速部分才折算子箭档
local DROW_001_STAR_RAIN_ATTACK_SPEED_THRESHOLD = 200
--- 繁星攻速档步长：门槛以上每该值攻击速度多降一档子箭
local DROW_001_STAR_RAIN_ATTACK_SPEED_STEP = 100
--- 繁星每档子箭束数
local DROW_001_STAR_RAIN_ARROWS_PER_STEP = 3
--- 繁星子箭上限 CustomValue 键（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=6/9/12）
local DROW_001_STAR_RAIN_MAX_ARROWS_KEY = "drow_001_star_rain_max_arrows"
--- 繁星子箭上限兜底：符印未配上限键时按最低档
local DROW_001_STAR_RAIN_MAX_ARROWS = 6
--- 繁星子箭落点伤害半径
local DROW_001_STAR_RAIN_SUB_RADIUS = 180
--- 繁星子箭预警到落地的时长（秒），短于主箭营造急促雨感
local DROW_001_STAR_RAIN_SUB_DELAY = 0.35
--- 繁星逐束错峰间隔（秒）
local DROW_001_STAR_RAIN_VOLLEY_INTERVAL = 0.08
--- 繁星子箭附加冰冻：层数与持续（与主箭冰冻同语义）
local DROW_001_STAR_RAIN_FREEZE_STACKS = 1
local DROW_001_STAR_RAIN_FREEZE_DURATION = 3
--- 繁星锁定落点的散布偏移：子箭砸向敌人坐标附近该半径内随机点（视觉不完全重叠，180 子圈仍稳盖目标）
local DROW_001_STAR_RAIN_LOCK_SCATTER = 50
--- 箭雨固定随机点数量
local DROW_001_ARROW_RAIN_POINT_COUNT = 5
--- 箭雨随机范围
local DROW_001_ARROW_RAIN_RANDOM_RADIUS = 400
--- 箭雨序列发射间隔（秒）
local DROW_001_ARROW_RAIN_SHOT_INTERVAL = 0.1
--- 卓尔游侠 001 - 寒星射击
____exports.drow_001 = __TS__Class()
local drow_001 = ____exports.drow_001
drow_001.name = "drow_001"
__TS__ClassExtends(drow_001, BaseHeroAbility)
function drow_001.prototype.Precache(self, context)
	PrecacheResource("particle", DROW_001_SHOT_PARTICLE, context)
	PrecacheResource("particle", DROW_001_WARNING_PARTICLE, context)
	PrecacheResource("particle", DROW_001_IMPACT_PARTICLE, context)
	PrecacheResource("particle", DROW_001_EXPLOSION_PARTICLE, context)
end
function drow_001.prototype.OnCastEffect(self)
	local effect = nil
	local hidePreview = false
	return {
		begin = function(____, pos)
			local caster = self:GetCaster()
			local ____tonumber_4 = tonumber
			local ____opt_0 = caster and caster.GetCustomValue
			hidePreview = ____tonumber_4(____opt_0 and ____opt_0(caster, DROW_001_ARROW_RAIN_ENABLE_KEY) or 0) > 0
			if hidePreview then
				return
			end
			effect = ParticleManager:CreateParticle(
				"particles/ui_mouseactions/range_finder_aoe.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(effect, 2, pos)
			local damageR = self:GetSpecialValue("drow_001", "damage_radius")
			ParticleManager:SetParticleControl(effect, 3, Vector(damageR, damageR, damageR))
			ParticleManager:SetParticleControl(effect, 6, Vector(80, 150, 255))
		end,
		update = function(____, pos)
			if hidePreview or effect == nil then
				return
			end
			ParticleManager:SetParticleControl(effect, 2, pos)
		end,
		["end"] = function()
			if hidePreview or effect == nil then
				return
			end
			ParticleManager:DestroyParticle(effect, false)
			ParticleManager:ReleaseParticleIndex(effect)
			effect = nil
		end,
	}
end
function drow_001.prototype.GetAOERadius(self)
	local damageR = self:GetSpecialValue("drow_001", "damage_radius")
	return damageR
end
function drow_001.prototype.GetAbilityConfig(self)
	return {
		castPoint = DROW_001_CAST_POINT,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE,
		animationPlaybackRate = 2,
		castRange = 1200,
	}
end
function drow_001.prototype.OnAbilityPhaseStart(self)
	return true
end
function drow_001.prototype.ComputeImpactDelay(self, caster)
	local baseDelay = self:GetSpecialValue("drow_001", "impact_delay")
	local step = self:GetSpecialValue("drow_001", "impact_delay_attack_speed_step")
	local speedupPct = self:GetSpecialValue("drow_001", "impact_delay_speedup_pct")
	local attackSpeed = math.max(0, MyGameAttribute:GetAttribute(caster, "total_attack_speed") or 0)
	local bonusPct = attackSpeed / step * speedupPct
	return math.max(DROW_001_MIN_IMPACT_DELAY, baseDelay / (1 + bonusPct / 100))
end
function drow_001.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self._caster
	if not IsValidAlive(nil, caster) then
		return
	end
	local impactDelay = self:ComputeImpactDelay(caster)
	local agilityDamagePct = self:GetSpecialValue("drow_001", "agility_damage_pct")
	local damageRadius = self:GetSpecialValue("drow_001", "damage_radius")
	local freezeStacks = math.floor(self:GetSpecialValue("drow_001", "freeze_stacks"))
	local freezeDuration = self:GetSpecialValue("drow_001", "freeze_duration")
	local targetPointRaw = self:GetCursorPosition()
	local targetPoint = targetPointRaw:__add(Vector(0, 0, 0))
	targetPoint.z = GetGroundPosition(targetPoint, caster).z
	local agility = MyGameAttribute:GetAttribute(caster, "total_agility") or 0
	local baseDamage = agility * agilityDamagePct / 100
	local ____tonumber_7 = tonumber
	local ____opt_5 = caster.GetCustomValue
	local arrowRainEnabled = ____tonumber_7(____opt_5 and ____opt_5(caster, DROW_001_ARROW_RAIN_ENABLE_KEY) or 0) > 0
	if not arrowRainEnabled then
		AddFOWViewer(caster:GetTeamNumber(), targetPointRaw, damageRadius + 50, 3, true)
		self:ScheduleImpactAtPoint(
			caster,
			targetPoint,
			impactDelay,
			baseDamage,
			damageRadius,
			freezeStacks,
			freezeDuration
		)
		self:TrySpawnStarRain(caster, targetPoint, damageRadius, baseDamage, impactDelay)
		return
	end
	local rainPoints = self:BuildArrowRainImpactSequence(
		targetPoint,
		DROW_001_ARROW_RAIN_POINT_COUNT,
		DROW_001_ARROW_RAIN_RANDOM_RADIUS
	)
	AddFOWViewer(caster:GetTeamNumber(), targetPointRaw, DROW_001_ARROW_RAIN_RANDOM_RADIUS + damageRadius + 80, 3, true)
	do
		local i = 0
		while i < #rainPoints do
			local point = rainPoints[i + 1]
			Timers:CreateTimer(i * DROW_001_ARROW_RAIN_SHOT_INTERVAL, function()
				if not IsValidAlive(nil, caster) then
					return nil
				end
				self:ScheduleImpactAtPoint(
					caster,
					point,
					impactDelay,
					baseDamage,
					damageRadius,
					freezeStacks,
					freezeDuration
				)
				return nil
			end)
			i = i + 1
		end
	end
	self:TrySpawnStarRain(caster, targetPoint, damageRadius, baseDamage, impactDelay)
end
function drow_001.prototype.TrySpawnStarRain(self, caster, center, radius, mainDamage, mainImpactDelay)
	local ____tonumber_10 = tonumber
	local ____this_9
	____this_9 = caster
	local ____opt_8 = ____this_9.GetCustomValue
	local damagePct = ____tonumber_10(____opt_8 and ____opt_8(____this_9, DROW_001_STAR_RAIN_PCT_KEY) or 0)
	if damagePct <= 0 then
		return
	end
	local attackSpeed = MyGameAttribute:GetAttribute(caster, "total_attack_speed") or 0
	local steps = math.floor(
		math.max(0, attackSpeed - DROW_001_STAR_RAIN_ATTACK_SPEED_THRESHOLD) / DROW_001_STAR_RAIN_ATTACK_SPEED_STEP
	)
	local ____tonumber_13 = tonumber
	local ____this_12
	____this_12 = caster
	local ____opt_11 = ____this_12.GetCustomValue
	local maxArrows = ____tonumber_13(____opt_11 and ____opt_11(____this_12, DROW_001_STAR_RAIN_MAX_ARROWS_KEY) or 0)
		or DROW_001_STAR_RAIN_MAX_ARROWS
	local arrowCount = math.min(maxArrows, steps * DROW_001_STAR_RAIN_ARROWS_PER_STEP)
	if arrowCount <= 0 then
		return
	end
	local subDamage = mainDamage * damagePct / 100
	do
		local i = 0
		while i < arrowCount do
			Timers:CreateTimer(mainImpactDelay + i * DROW_001_STAR_RAIN_VOLLEY_INTERVAL, function()
				if not IsValidAlive(nil, caster) then
					return nil
				end
				local point = self:PickStarRainImpactPoint(caster, center, radius)
				self:ScheduleImpactAtPoint(
					caster,
					point,
					DROW_001_STAR_RAIN_SUB_DELAY,
					subDamage,
					DROW_001_STAR_RAIN_SUB_RADIUS,
					DROW_001_STAR_RAIN_FREEZE_STACKS,
					DROW_001_STAR_RAIN_FREEZE_DURATION,
					false
				)
				return nil
			end)
			i = i + 1
		end
	end
end
function drow_001.prototype.PickStarRainImpactPoint(self, caster, center, radius)
	local enemies = self:FindMonsterEnemies(center, radius) or {}
	local aliveEnemies = {}
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			aliveEnemies[#aliveEnemies + 1] = enemy
		end
	end
	if #aliveEnemies > 0 then
		local target = aliveEnemies[RandomInt(0, #aliveEnemies - 1) + 1]
		return self:BuildRandomImpactPoints(target:GetAbsOrigin(), 1, DROW_001_STAR_RAIN_LOCK_SCATTER)[1]
	end
	return self:BuildRandomImpactPoints(center, 1, radius)[1]
end
function drow_001.prototype.BuildArrowRainImpactSequence(self, center, count, radius)
	local totalCount = math.max(1, math.floor(count))
	local points = {}
	points[#points + 1] = center:__add(Vector(0, 0, 0))
	if totalCount <= 1 then
		return points
	end
	local randomPoints = self:BuildRandomImpactPoints(center, totalCount - 1, radius)
	for ____, point in ipairs(randomPoints) do
		points[#points + 1] = point
	end
	return points
end
function drow_001.prototype.BuildRandomImpactPoints(self, center, count, radius)
	local points = {}
	do
		local i = 0
		while i < count do
			local angle = RandomFloat(0, 360)
			local dist = radius * math.sqrt(RandomFloat(0, 1))
			local dir = self:RotateVector2DLocal(Vector(1, 0, 0), angle)
			local point = center + dir * dist
			point.z = center.z
			points[#points + 1] = point
			i = i + 1
		end
	end
	return points
end
function drow_001.prototype.TryTriggerFrozenSoul(self, caster, enemy, ampPct)
	local existingCd = enemy:FindModifierByName(____exports.modifier_drow_001_frozen_soul_cd.name)
	if existingCd and not existingCd:IsNull() then
		return
	end
	local cdrPct = math.max(0, MyGameAttribute:GetAttribute(caster, "cooldown_reduction_pct") or 0)
	local interval =
		math.max(DROW_001_FROZEN_SOUL_MIN_INTERVAL, DROW_001_FROZEN_SOUL_BASE_INTERVAL * (1 - cdrPct / 100))
	____exports.modifier_drow_001_frozen_soul_cd:applys(enemy, caster, self, { duration = interval })
	AddDeBuffStatus(
		nil,
		enemy,
		caster,
		self,
		DebuffStatusType.STUN,
		{ duration = DROW_001_FROZEN_SOUL_FREEZE_DURATION, status_effect_name = DROW_001_FROZEN_SOUL_STATUS_EFFECT }
	)
	____exports.modifier_drow_001_frozen_soul:applys(
		enemy,
		caster,
		self,
		{ duration = DROW_001_FROZEN_SOUL_AMP_DURATION, amp_pct = ampPct }
	)
end
function drow_001.prototype.GetFreezeStacksForErosion(self, enemy)
	local modifiers = enemy:FindAllModifiersByName("modifier_generic_slow") or {}
	local total = 0
	for ____, modifier in ipairs(modifiers) do
		do
			if not IsValid(nil, modifier) then
				goto __continue41
			end
			total = total + math.max(modifier:GetStackCount(), 0)
		end
		::__continue41::
	end
	return math.min(total, DROW_001_FROST_EROSION_STACK_CAP)
end
function drow_001.prototype.RotateVector2DLocal(self, v, angleDeg)
	local rad = angleDeg * math.pi / 180
	local c = math.cos(rad)
	local s = math.sin(rad)
	return Vector(v.x * c - v.y * s, v.x * s + v.y * c, v.z)
end
function drow_001.prototype.ScheduleImpactAtPoint(
	self,
	caster,
	targetPoint,
	impactDelay,
	damage,
	damageRadius,
	freezeStacks,
	freezeDuration,
	withShotFx
)
	if withShotFx == nil then
		withShotFx = true
	end
	if withShotFx then
		local shotFx = MyGameHeroParticleManager:CreateParticle(
			DROW_001_SHOT_PARTICLE,
			PATTACH_CUSTOMORIGIN_FOLLOW,
			caster,
			caster
		)
		MyGameHeroParticleManager:SetParticleControlEnt(
			shotFx,
			0,
			caster,
			PATTACH_POINT_FOLLOW,
			"attach_mom_l",
			caster:GetAbsOrigin(),
			true
		)
		MyGameHeroParticleManager:SetParticleControl(shotFx, 1, targetPoint)
		MyGameHeroParticleManager:SetParticleControl(shotFx, 5, Vector(impactDelay, 0, 0))
		MyGameHeroParticleManager:ReleaseParticleIndex(shotFx)
	end
	local warningFx =
		MyGameHeroParticleManager:CreateParticle(DROW_001_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil, caster)
	MyGameHeroParticleManager:SetParticleControl(warningFx, 0, targetPoint)
	MyGameHeroParticleManager:SetParticleControl(warningFx, 2, targetPoint)
	Timers:CreateTimer(impactDelay, function()
		MyGameHeroParticleManager:DestroyParticle(warningFx, false)
		MyGameHeroParticleManager:ReleaseParticleIndex(warningFx)
		if not IsValidAlive(nil, caster) then
			return nil
		end
		local impactFx =
			MyGameHeroParticleManager:CreateParticle(DROW_001_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil, caster)
		MyGameHeroParticleManager:SetParticleControl(impactFx, 0, targetPoint)
		MyGameHeroParticleManager:SetParticleControl(impactFx, 1, Vector(1, 1, 1))
		MyGameHeroParticleManager:ReleaseParticleIndex(impactFx)
		local explosionFx =
			MyGameHeroParticleManager:CreateParticle(DROW_001_EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil, caster)
		MyGameHeroParticleManager:SetParticleControl(explosionFx, 0, targetPoint)
		MyGameHeroParticleManager:SetParticleControl(explosionFx, 1, Vector(damageRadius, 2, damageRadius * 3))
		MyGameHeroParticleManager:ReleaseParticleIndex(explosionFx)
		if MyGameDestructibleManager ~= nil then
			MyGameDestructibleManager:BreakCircleForHero(caster, targetPoint, damageRadius, self)
		end
		local enemies = self:FindMonsterEnemies(targetPoint, damageRadius) or {}
		local ____tonumber_18 = tonumber
		local ____this_17
		____this_17 = caster
		local ____opt_16 = ____this_17.GetCustomValue
		local frostErosionPct =
			____tonumber_18(____opt_16 and ____opt_16(____this_17, DROW_001_FROST_EROSION_PCT_KEY) or 0)
		local ____tonumber_21 = tonumber
		local ____this_20
		____this_20 = caster
		local ____opt_19 = ____this_20.GetCustomValue
		local frozenSoulAmpPct =
			____tonumber_21(____opt_19 and ____opt_19(____this_20, DROW_001_FROZEN_SOUL_AMP_KEY) or 0)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue49
				end
				local dist2D = GetDistance(nil, targetPoint, enemy:GetAbsOrigin())
				if dist2D > damageRadius then
					goto __continue49
				end
				local ____temp_22
				if frostErosionPct > 0 or frozenSoulAmpPct > 0 then
					____temp_22 = self:GetFreezeStacksForErosion(enemy)
				else
					____temp_22 = 0
				end
				local snapshotStacks = ____temp_22
				local ____temp_23
				if frostErosionPct > 0 then
					____temp_23 = damage * (1 + frostErosionPct * snapshotStacks / 100)
				else
					____temp_23 = damage
				end
				local finalDamage = ____temp_23
				self:ApplyDamage(enemy, finalDamage, 2)
				if frozenSoulAmpPct > 0 and snapshotStacks >= DROW_001_FROZEN_SOUL_REQUIRED_STACKS then
					self:TryTriggerFrozenSoul(caster, enemy, frozenSoulAmpPct)
				end
				if freezeStacks > 0 then
					AddDeBuffStatus(
						nil,
						enemy,
						caster,
						self,
						DebuffStatusType.ICE_SLOW,
						{
							stack = freezeStacks,
							duration = freezeDuration,
							effect_name = DROW_001_FREEZE_EFFECT,
							status_effect_name = DROW_001_FREEZE_STATUS_EFFECT,
						}
					)
				end
			end
			::__continue49::
		end
		return nil
	end)
end
drow_001 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_001)
____exports.drow_001 = drow_001
--- 符印「冻魄」魔伤易伤 debuff：受到的魔法伤害提高（数值施加时快照，刷新取高）
____exports.modifier_drow_001_frozen_soul = __TS__Class()
local modifier_drow_001_frozen_soul = ____exports.modifier_drow_001_frozen_soul
modifier_drow_001_frozen_soul.name = "modifier_drow_001_frozen_soul"
__TS__ClassExtends(modifier_drow_001_frozen_soul, BaseModifier_CS)
function modifier_drow_001_frozen_soul.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ampPct = 0
end
function modifier_drow_001_frozen_soul.GetLocalizationCN(self)
	return { name = "冻魄", description = "魂魄冻结：受到的魔法伤害提高。" }
end
function modifier_drow_001_frozen_soul.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = true, isPurgeException = false }
end
function modifier_drow_001_frozen_soul.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.ampPct = math.max(0, params.amp_pct or 0)
end
function modifier_drow_001_frozen_soul.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.ampPct = math.max(self.ampPct, params.amp_pct or 0)
	self:RefreshAttributes()
end
function modifier_drow_001_frozen_soul.prototype.GetAttributeBonus(self)
	return { incoming_magical_damage_increase_pct = self.ampPct }
end
function modifier_drow_001_frozen_soul.prototype.GetTexture(self)
	return "drow_01"
end
modifier_drow_001_frozen_soul = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_001_frozen_soul)
____exports.modifier_drow_001_frozen_soul = modifier_drow_001_frozen_soul
--- 符印「冻魄」每目标内置冷却（隐形标记）：存在期间同一目标不再触发冻魄
____exports.modifier_drow_001_frozen_soul_cd = __TS__Class()
local modifier_drow_001_frozen_soul_cd = ____exports.modifier_drow_001_frozen_soul_cd
modifier_drow_001_frozen_soul_cd.name = "modifier_drow_001_frozen_soul_cd"
__TS__ClassExtends(modifier_drow_001_frozen_soul_cd, BaseModifier_CS)
function modifier_drow_001_frozen_soul_cd.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
modifier_drow_001_frozen_soul_cd = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_001_frozen_soul_cd)
____exports.modifier_drow_001_frozen_soul_cd = modifier_drow_001_frozen_soul_cd
return ____exports