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
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local LINA_005_METEOR_WARN = "particles/hero/warlock_rain_of_chaos_start.vpcf"
--- 陨石下落：CP0=目标点且 Z+1500，CP1=目标地面原点，CP2.x=缩放
local LINA_005_METEOR_FLY = "particles/hero/lina/ability/invoker_chaos_meteor_fly.vpcf"
--- 落地爆炸：CP0=原点，CP1.xyz=作用范围
local LINA_005_METEOR_EXPLODE = "particles/hero/lina/ability_chao.vpcf"
--- 符印·流星：预警阶段额外特效
local LINA_005_GEM_TRAIL_WARN_VPCF = "particles/hero/lina/lina001.vpcf"
local LINA_005_GEM_METEOR_TRAIL = "lina_005_gem_meteor_trail"
local LINA_005_GEM_METEOR_TRAIL_DAMAGE_PCT = "lina_005_gem_meteor_trail_damage_pct"
local LINA_005_GEM_CD_RUNE = "lina_005_gem_cd_rune"
local LINA_005_GEM_CD_RUNE_REDUCE_SEC = "lina_005_gem_cd_rune_reduce_sec"
local LINA_005_GEM_RANDOM_METEOR = "lina_005_gem_random_meteor"
local LINA_005_GEM_RANDOM_METEOR_CHANCE_PCT = "lina_005_gem_random_meteor_chance_pct"
local LINA_005_GEM_METEOR_RAIN = "lina_005_gem_meteor_rain"
local LINA_005_GEM_METEOR_RAIN_MANA_PER_METEOR = "lina_005_gem_meteor_rain_mana_per_meteor"
local LINA_005_GEM_METEOR_RAIN_DAMAGE_PCT = "lina_005_gem_meteor_rain_damage_pct"
local LINA_005_METEOR_DROP_DELAY = 0.3
local LINA_005_METEOR_RAIN_INTERVAL = 0.1
local LINA_005_METEOR_RAIN_SCATTER_RADIUS = 200
--- 丽娜 R 火陨术：点地，固定延迟后陨石落地，眩晕 + 智力×(int_damage_pct/100) 魔法伤害。
-- 符印（凝咒/天坠）逻辑由本技能自带的隐藏 intrinsic modifier 监听施法完成事件，仅读取英雄 CustomValue。
____exports.lina_005 = __TS__Class()
local lina_005 = ____exports.lina_005
lina_005.name = "lina_005"
__TS__ClassExtends(lina_005, BaseHeroAbility)
function lina_005.prototype.GetIntrinsicModifierName(self)
	return "modifier_lina_005_intrinsic"
end
function lina_005.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_005_METEOR_WARN, context)
	PrecacheResource("particle", LINA_005_METEOR_FLY, context)
	PrecacheResource("particle", LINA_005_METEOR_EXPLODE, context)
	PrecacheResource("particle", LINA_005_GEM_TRAIL_WARN_VPCF, context)
end
function lina_005.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.4,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE,
	}
end
function lina_005.prototype.GetAOERadius(self)
	return self:GetSpecialValue("lina_005", "impact_radius")
end
function lina_005.prototype.OnAbilityPhaseStart(self)
	if not IsServer() then
		return false
	end
	return true
end
function lina_005.prototype.OnSpellStart(self, is_trigger)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local cursor = self:GetCursorPosition()
	local groundZ = GetGroundHeight(cursor, caster) or cursor.z
	local impactPoint = Vector(cursor.x, cursor.y, groundZ)
	self:GetCaster():EmitSound("Hero_Warlock.RainOfChaos_buildup")
	local radius = self:GetSpecialValue("lina_005", "impact_radius")
	local intDamagePct = self:GetSpecialValue("lina_005", "int_damage_pct")
	local stunDuration = self:GetSpecialValue("lina_005", "stun_duration")
	local burnDuration = self:GetSpecialValue("lina_005", "burn_duration")
	local ____tonumber_2 = tonumber
	local ____opt_0 = caster.GetCustomValue
	local meteorTrailOn = ____tonumber_2(____opt_0 and ____opt_0(caster, LINA_005_GEM_METEOR_TRAIL) or 0) > 0
	local ____tonumber_5 = tonumber
	local ____opt_3 = caster.GetCustomValue
	if ____tonumber_5(____opt_3 and ____opt_3(caster, LINA_005_GEM_CD_RUNE) or 0) > 0 then
		stunDuration = stunDuration * 0.5
	end
	local hero = caster
	local intellect = hero:GetIntellect(false)
	local damage = intellect * intDamagePct / 100
	local trailDamage = 0
	if meteorTrailOn then
		local ____opt_6 = caster.GetCustomValue
		local trailPctRaw = ____opt_6 and ____opt_6(caster, LINA_005_GEM_METEOR_TRAIL_DAMAGE_PCT) or 0
		local trailPct = tonumber(trailPctRaw)
		if __TS__NumberIsFinite(__TS__Number(trailPct)) and trailPct > 0 then
			trailDamage = damage * trailPct / 100
		end
	end
	local totalDamage = damage + trailDamage
	local applyStun = not is_trigger
	self:ScheduleMeteorDrop({
		caster = hero,
		impactPoint = impactPoint,
		radius = radius,
		damage = totalDamage,
		stunDuration = stunDuration,
		burnDuration = burnDuration,
		applyStun = applyStun,
		applyBurn = meteorTrailOn,
		playTrailWarn = meteorTrailOn,
		playChaosSound = true,
		playGroundEffect = true,
	}, 0)
	if is_trigger then
		return
	end
	local extraMeteorCount = self:GetMeteorRainExtraCount(hero)
	if extraMeteorCount <= 0 then
		return
	end
	local secondaryDamagePct = self:GetMeteorRainSecondaryDamagePct(hero)
	local secondaryDamage = totalDamage * secondaryDamagePct / 100
	if secondaryDamage <= 0 then
		return
	end
	local rainPoints = self:BuildMeteorRainImpactPoints(impactPoint, extraMeteorCount)
	do
		local i = 0
		while i < #rainPoints do
			self:ScheduleMeteorDrop({
				caster = hero,
				impactPoint = rainPoints[i + 1],
				radius = radius,
				damage = secondaryDamage,
				stunDuration = stunDuration,
				burnDuration = burnDuration,
				applyStun = applyStun,
				applyBurn = meteorTrailOn,
				playTrailWarn = false,
				playChaosSound = false,
				playGroundEffect = false,
			}, LINA_005_METEOR_RAIN_INTERVAL * (i + 1))
			i = i + 1
		end
	end
end
function lina_005.prototype.ScheduleMeteorDrop(self, payload, startDelay)
	local function beginDrop()
		local ____temp_11 = not IsValid(nil, self)
		if not ____temp_11 then
			local ____opt_8 = self.IsNull
			local ____temp_10 = ____opt_8 and ____opt_8(self)
			if ____temp_10 == nil then
				____temp_10 = false
			end
			____temp_11 = ____temp_10
		end
		if ____temp_11 then
			return
		end
		if not IsValidAlive(nil, payload.caster) then
			return
		end
		if payload.playTrailWarn then
			self:PlayGemMeteorTrailWarn(payload.impactPoint, payload.radius)
		end
		if payload.playChaosSound then
			EmitSoundOnLocationWithCaster(payload.impactPoint, "Hero_Warlock.RainOfChaos", payload.caster)
		end
		self:PlayMeteorFly(payload.impactPoint)
		Timers:CreateTimer(LINA_005_METEOR_DROP_DELAY, function()
			self:ResolveMeteorImpact(payload)
		end)
	end
	if startDelay > 0 then
		Timers:CreateTimer(startDelay, function()
			beginDrop(nil)
		end)
		return
	end
	beginDrop(nil)
end
function lina_005.prototype.ResolveMeteorImpact(self, payload)
	local ____temp_15 = not IsValid(nil, self)
	if not ____temp_15 then
		local ____opt_12 = self.IsNull
		local ____temp_14 = ____opt_12 and ____opt_12(self)
		if ____temp_14 == nil then
			____temp_14 = false
		end
		____temp_15 = ____temp_14
	end
	if ____temp_15 then
		return
	end
	if not IsValidAlive(nil, payload.caster) then
		return
	end
	self:PlayMeteorExplode(payload.impactPoint, payload.radius)
	if payload.playGroundEffect then
		self:PlayWarningRing(payload.impactPoint, payload.radius)
	end
	ScreenShake(payload.impactPoint, 5, 5, 0.1, 3000, 0, true)
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(payload.caster, payload.impactPoint, payload.radius, self)
	end
	local enemies = self:FindMonsterEnemies(payload.impactPoint, payload.radius)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue30
			end
			local ____opt_18 = enemy.GetUnitType
			local ut = ____opt_18 and ____opt_18(enemy)
			if ut == UnitType.BUILDING or ut == UnitType.DESTRUCTIBLE then
				goto __continue30
			end
			if payload.damage > 0 then
				Damage:ApplyDamage({
					attacker = payload.caster,
					victim = enemy,
					damage = payload.damage,
					damage_type = 2,
					ability = self,
					extra_data = { source_name = self:GetAbilityName() },
				})
			end
			if payload.applyStun then
				AddDeBuffStatus(
					nil,
					enemy,
					payload.caster,
					self,
					DebuffStatusType.STUN,
					{ duration = payload.stunDuration }
				)
			end
			if payload.applyBurn then
				AddDeBuffStatus(
					nil,
					enemy,
					payload.caster,
					self,
					DebuffStatusType.BURN,
					{ duration = payload.burnDuration }
				)
			end
		end
		::__continue30::
	end
end
function lina_005.prototype.GetMeteorRainExtraCount(self, caster)
	local ____tonumber_22 = tonumber
	local ____this_21
	____this_21 = caster
	local ____opt_20 = ____this_21.GetCustomValue
	local enabled = ____tonumber_22(____opt_20 and ____opt_20(____this_21, LINA_005_GEM_METEOR_RAIN) or 0)
	if enabled <= 0 then
		return 0
	end
	local ____tonumber_25 = tonumber
	local ____this_24
	____this_24 = caster
	local ____opt_23 = ____this_24.GetCustomValue
	local manaPerMeteorRaw =
		____tonumber_25(____opt_23 and ____opt_23(____this_24, LINA_005_GEM_METEOR_RAIN_MANA_PER_METEOR) or 100)
	local ____temp_26
	if __TS__NumberIsFinite(__TS__Number(manaPerMeteorRaw)) and manaPerMeteorRaw > 0 then
		____temp_26 = manaPerMeteorRaw
	else
		____temp_26 = 100
	end
	local manaPerMeteor = ____temp_26
	local manaCost = self:GetManaCost(math.max(0, self:GetLevel() - 1))
	if not __TS__NumberIsFinite(__TS__Number(manaCost)) or manaCost < manaPerMeteor then
		return 0
	end
	return math.max(0, math.floor(manaCost / manaPerMeteor))
end
function lina_005.prototype.GetMeteorRainSecondaryDamagePct(self, caster)
	local ____tonumber_29 = tonumber
	local ____this_28
	____this_28 = caster
	local ____opt_27 = ____this_28.GetCustomValue
	local raw = ____tonumber_29(____opt_27 and ____opt_27(____this_28, LINA_005_GEM_METEOR_RAIN_DAMAGE_PCT) or 60)
	if not __TS__NumberIsFinite(__TS__Number(raw)) then
		return 60
	end
	return math.max(0, raw)
end
function lina_005.prototype.BuildMeteorRainImpactPoints(self, center, count)
	local points = {}
	do
		local i = 0
		while i < count do
			local rawPoint = center:__add(RandomVector(RandomFloat(0, LINA_005_METEOR_RAIN_SCATTER_RADIUS)))
			local groundPoint = GetGroundPosition(rawPoint, self:GetCaster())
			points[#points + 1] = Vector(rawPoint.x, rawPoint.y, groundPoint.z)
			i = i + 1
		end
	end
	return points
end
function lina_005.prototype.PlayGemMeteorTrailWarn(self, center, radius)
	local caster = self:GetCaster()
	local pid =
		MyGameHeroParticleManager:CreateParticle(LINA_005_GEM_TRAIL_WARN_VPCF, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, center)
	MyGameHeroParticleManager:SetParticleControl(pid, 4, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
end
function lina_005.prototype.PlayWarningRing(self, center, radius)
	self:ClearWarningParticle()
	local caster = self:GetCaster()
	local pid = MyGameHeroParticleManager:CreateParticle(LINA_005_METEOR_WARN, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, center)
	MyGameHeroParticleManager:SetParticleControl(pid, 1, Vector(radius, 0, 0))
	self._warningParticle = pid
	self:ClearWarningParticle()
end
function lina_005.prototype.PlayMeteorFly(self, groundTarget)
	local caster = self:GetCaster()
	local cp0 = Vector(groundTarget.x, groundTarget.y, groundTarget.z + 1500)
	local pid = MyGameHeroParticleManager:CreateParticle(LINA_005_METEOR_FLY, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, cp0)
	MyGameHeroParticleManager:SetParticleControl(pid, 1, groundTarget)
	MyGameHeroParticleManager:SetParticleControl(pid, 2, Vector(0.3, 0, 0))
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
end
function lina_005.prototype.PlayMeteorExplode(self, origin, radius)
	local caster = self:GetCaster()
	local pid = MyGameHeroParticleManager:CreateParticle(LINA_005_METEOR_EXPLODE, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, origin)
	MyGameHeroParticleManager:SetParticleControl(pid, 1, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
end
function lina_005.prototype.ClearWarningParticle(self)
	local pid = self._warningParticle
	if pid ~= nil then
		MyGameHeroParticleManager:DestroyParticle(pid, false)
		MyGameHeroParticleManager:ReleaseParticleIndex(pid)
		self._warningParticle = nil
	end
end
lina_005 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_005)
____exports.lina_005 = lina_005
local function lina005FindMeteorProcTargets(self, hero, origin, radius)
	local units = FindUnitsInRadius(
		hero:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_CAN_BE_SEEN + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
	local out = {}
	for ____, u in ipairs(units) do
		do
			if not IsValidAlive(nil, u) then
				goto __continue51
			end
			local ____opt_30 = u.GetUnitType
			local ut = ____opt_30 and ____opt_30(u)
			if ut == UnitType.BUILDING or ut == UnitType.DESTRUCTIBLE then
				goto __continue51
			end
			out[#out + 1] = u
		end
		::__continue51::
	end
	return out
end
--- 火陨术自带隐藏 modifier：监听「其它技能」施法完成，按 CustomValue 执行凝咒减 CD / 天坠概率触发。
-- 不通过宝石 modifier 列挂载，避免与 PlayerGem 重复叠加。
____exports.modifier_lina_005_intrinsic = __TS__Class()
local modifier_lina_005_intrinsic = ____exports.modifier_lina_005_intrinsic
modifier_lina_005_intrinsic.name = "modifier_lina_005_intrinsic"
__TS__ClassExtends(modifier_lina_005_intrinsic, BaseModifier_CS)
function modifier_lina_005_intrinsic.prototype.IsHidden(self)
	return true
end
function modifier_lina_005_intrinsic.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_lina_005_intrinsic.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local hero = parent
	local ____tonumber_34 = tonumber
	local ____opt_32 = hero.GetCustomValue
	local hasCdRune = ____tonumber_34(____opt_32 and ____opt_32(hero, LINA_005_GEM_CD_RUNE) or 0) > 0
	local ____tonumber_37 = tonumber
	local ____opt_35 = hero.GetCustomValue
	local hasRandomMeteor = ____tonumber_37(____opt_35 and ____opt_35(hero, LINA_005_GEM_RANDOM_METEOR) or 0) > 0
	if not hasCdRune and not hasRandomMeteor then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	if castAbility:GetAbilityName() == "lina_005" then
		return
	end
	local ability = self:GetAbility()
	if hasCdRune then
		local ____opt_38 = hero.GetCustomValue
		local reduceRaw = ____opt_38 and ____opt_38(hero, LINA_005_GEM_CD_RUNE_REDUCE_SEC) or 0
		local reduceSec = tonumber(reduceRaw)
		if __TS__NumberIsFinite(__TS__Number(reduceSec)) and reduceSec > 0 then
			local rem = ability:GetCooldownTimeRemaining()
			if rem > 0 then
				ability:EndCooldown()
				ability:StartCooldown(math.max(0, rem - reduceSec))
			end
		end
	end
	if hasRandomMeteor then
		local ____opt_40 = hero.GetCustomValue
		local chanceRaw = ____opt_40 and ____opt_40(hero, LINA_005_GEM_RANDOM_METEOR_CHANCE_PCT) or 0
		local chance = tonumber(chanceRaw)
		if
			__TS__NumberIsFinite(__TS__Number(chance))
			and chance > 0
			and RollPseudoRandomPercentage(
				math.min(100, math.floor(chance)),
				DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1,
				self._caster
			)
		then
			local castRange = ability:GetCastRange(hero:GetAbsOrigin(), nil)
			local candidates = lina005FindMeteorProcTargets(nil, hero, hero:GetAbsOrigin(), castRange)
			if #candidates > 0 then
				local pick = candidates[RandomInt(0, #candidates - 1) + 1]
				if pick and IsValidAlive(nil, pick) then
					self._caster:SetCursorPosition(pick:GetAbsOrigin())
					ability:OnSpellStart(true)
				end
			end
		end
	end
end
modifier_lina_005_intrinsic =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_lina_005_intrinsic") }, modifier_lina_005_intrinsic)
____exports.modifier_lina_005_intrinsic = modifier_lina_005_intrinsic
return ____exports