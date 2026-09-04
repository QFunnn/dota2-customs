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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 符印：每损失 1% 生命值，嗜血斩击伤害额外提高的百分比。
local AXE_011_RUNE_DAMAGE_PCT_PER_MISSING_HEALTH_PCT_KEY = "axe_011_rune_damage_pct_per_missing_health_pct"
--- 符印：按损失生命值获得的嗜血斩击伤害增幅上限。
local AXE_011_RUNE_DAMAGE_BONUS_MAX_PCT_KEY = "axe_011_rune_damage_bonus_max_pct"
--- 符印：覆盖普通攻击触发嗜血斩击的概率百分比。
local AXE_011_ATTACK_TRIGGER_CHANCE_PCT_KEY = "axe_011_attack_trigger_chance_pct"
--- 符印：嗜血斩击造成伤害时附加流血的概率百分比。
local AXE_011_BLEED_ON_DAMAGE_CHANCE_PCT_KEY = "axe_011_bleed_on_damage_chance_pct"
--- 符印：嗜血斩击每次触发消耗的当前生命值百分比。
local AXE_011_HEALTH_COST_CURRENT_PCT_KEY = "axe_011_health_cost_current_pct"
--- 符印：嗜血斩击命中时额外施加 1 层易伤的概率百分比。
local AXE_011_EXTRA_VULNERABLE_CHANCE_PCT_KEY = "axe_011_extra_vulnerable_chance_pct"
local AXE_011_INTRINSIC_MODIFIER = "modifier_axe_011_intrinsic"
____exports.axe_011 = __TS__Class()
local axe_011 = ____exports.axe_011
axe_011.name = "axe_011"
__TS__ClassExtends(axe_011, BaseHeroAbility)
function axe_011.prototype.GetIntrinsicModifierName(self)
	return AXE_011_INTRINSIC_MODIFIER
end
function axe_011.prototype.GetAOERadius(self)
	return self:GetSpecialValue("axe_011", "damage_radius")
end
function axe_011.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function axe_011.prototype.GetAttackTriggerChancePct(self, caster)
	local baseChancePct = math.max(0, self:GetSpecialValue("axe_011", "trigger_chance_pct"))
	local ____math_max_3 = math.max
	local ____tonumber_2 = tonumber
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetCustomValue
	local overrideChancePct = ____math_max_3(
		0,
		____tonumber_2(____opt_0 and ____opt_0(____this_1, AXE_011_ATTACK_TRIGGER_CHANCE_PCT_KEY) or 0) or 0
	)
	local ____temp_4
	if overrideChancePct > 0 then
		____temp_4 = overrideChancePct
	else
		____temp_4 = baseChancePct
	end
	return ____temp_4
end
function axe_011.prototype.GetAttackTriggerCooldown(self)
	return math.max(0, self:GetCooldown(math.max(0, self:GetLevel() - 1)))
end
function axe_011.prototype.TriggerByAttack(self, target)
	if not IsServer() then
		return false
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValid(nil, target) or not IsValidEntity(target) then
		return false
	end
	local casterPos = caster:GetAbsOrigin()
	local toTarget = target:GetAbsOrigin() - casterPos
	toTarget.z = 0
	if toTarget:Length2D() <= 1 then
		return false
	end
	caster:FaceTowards(target:GetAbsOrigin())
	self:PerformBloodSlash(toTarget:Normalized())
	return true
end
function axe_011.prototype.PerformBloodSlash(self, castForward)
	local caster = self:GetCaster()
	self:ConsumeTriggerHealthCost(caster)
	local casterPos = caster:GetAbsOrigin()
	local damageRadius = self:GetSpecialValue("axe_011", "damage_radius")
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakHalfCircleForHero(caster, casterPos, damageRadius, castForward, self)
	end
	local enemies = self:FindMonsterEnemies(casterPos, damageRadius) or {}
	local damage = self:CalculateSlashDamage(caster)
	local vulnerableDuration = math.max(0.1, self:GetSpecialValue("axe_011", "vulnerable_duration"))
	local hitCount = 0
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue12
			end
			local toEnemy = enemy:GetAbsOrigin() - casterPos
			toEnemy.z = 0
			if toEnemy:Length2D() > damageRadius then
				goto __continue12
			end
			local enemyDir = toEnemy:Normalized()
			local dot = castForward.x * enemyDir.x + castForward.y * enemyDir.y
			if dot < 0 then
				goto __continue12
			end
			hitCount = hitCount + 1
			local vulnerableStack = self:GetVulnerableStackCount(caster)
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.VULNERABLE,
				{ duration = vulnerableDuration, stack = vulnerableStack }
			)
			local damageResult = Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage,
				damage_type = 1,
				ability = self,
			})
			self:TryApplyBleedOnDamage(caster, enemy, damageResult.final_damage)
		end
		::__continue12::
	end
	self:PlayCastFeedback(casterPos, castForward, hitCount > 0)
end
function axe_011.prototype.GetVulnerableStackCount(self, caster)
	local ____math_max_10 = math.max
	local ____tonumber_9 = tonumber
	local ____this_8
	____this_8 = caster
	local ____opt_7 = ____this_8.GetCustomValue
	local extraChancePct = ____math_max_10(
		0,
		____tonumber_9(____opt_7 and ____opt_7(____this_8, AXE_011_EXTRA_VULNERABLE_CHANCE_PCT_KEY) or 0)
	)
	return extraChancePct > 0 and RollPercentage(math.min(100, extraChancePct)) and 2 or 1
end
function axe_011.prototype.CalculateSlashDamage(self, caster)
	local damageMultiplierPct = math.max(0, self:GetSpecialValue("axe_011", "attack_damage_multiplier_pct"))
	local maxHealth = math.max(1, caster:GetMaxHealth())
	local currentHealth = math.max(0, caster:GetHealth())
	local missingHealthPct = math.max(0, math.min(100, (maxHealth - currentHealth) / maxHealth * 100))
	local ____tonumber_13 = tonumber
	local ____this_12
	____this_12 = caster
	local ____opt_11 = ____this_12.GetCustomValue
	local bonusDamagePctPerMissingHealthPct = ____tonumber_13(
		____opt_11 and ____opt_11(____this_12, AXE_011_RUNE_DAMAGE_PCT_PER_MISSING_HEALTH_PCT_KEY) or 0
	) or 0
	local ____math_max_17 = math.max
	local ____tonumber_16 = tonumber
	local ____this_15
	____this_15 = caster
	local ____opt_14 = ____this_15.GetCustomValue
	local damageBonusMaxPct = ____math_max_17(
		0,
		____tonumber_16(____opt_14 and ____opt_14(____this_15, AXE_011_RUNE_DAMAGE_BONUS_MAX_PCT_KEY) or 0)
	)
	local uncappedDamageBonusPct = math.max(0, missingHealthPct * bonusDamagePctPerMissingHealthPct)
	local ____temp_18
	if bonusDamagePctPerMissingHealthPct > 0 then
		____temp_18 = math.min(uncappedDamageBonusPct, damageBonusMaxPct)
	else
		____temp_18 = 0
	end
	local damageBonusPct = ____temp_18
	local damageBonusMultiplier = 1 + damageBonusPct / 100
	return self:GetAllAttackDamage(caster) * damageMultiplierPct / 100 * damageBonusMultiplier
end
function axe_011.prototype.ConsumeTriggerHealthCost(self, caster)
	local ____math_max_22 = math.max
	local ____tonumber_21 = tonumber
	local ____this_20
	____this_20 = caster
	local ____opt_19 = ____this_20.GetCustomValue
	local healthCostPct = ____math_max_22(
		0,
		____tonumber_21(____opt_19 and ____opt_19(____this_20, AXE_011_HEALTH_COST_CURRENT_PCT_KEY) or 0)
	)
	if healthCostPct <= 0 then
		return
	end
	local healthCost = caster:GetHealth() * (healthCostPct / 100)
	if healthCost <= 0 then
		return
	end
	caster:CostHeal(
		healthCost,
		{
			attacker = caster,
			ability = self,
			source = { custom_tag = "axe_011_trigger_health_cost", source_name = "axe_011_blood_slash" },
			reserve_min_health = 1,
		}
	)
end
function axe_011.prototype.TryApplyBleedOnDamage(self, caster, target, finalDamage)
	local ____tonumber_25 = tonumber
	local ____this_24
	____this_24 = caster
	local ____opt_23 = ____this_24.GetCustomValue
	local bleedChancePct =
		____tonumber_25(____opt_23 and ____opt_23(____this_24, AXE_011_BLEED_ON_DAMAGE_CHANCE_PCT_KEY) or 0)
	if bleedChancePct <= 0 then
		return
	end
	if finalDamage <= 0 then
		return
	end
	if not RollPercentage(math.min(100, bleedChancePct)) then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		caster,
		self,
		DebuffStatusType.BLEED,
		{ source_final_damage = math.max(0, finalDamage) }
	)
end
function axe_011.prototype.PlayCastFeedback(self, pos, direction, didHitEnemy)
	local caster = self:GetCaster()
	local pfx =
		MyGameHeroParticleManager:CreateParticle("particles/bb/g1_attack2.vpcf", PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, pos)
	MyGameHeroParticleManager:SetParticleControl(pfx, 3, pos:__add(direction:__mul(20)))
	MyGameHeroParticleManager:SetParticleControlTransformForward(pfx, 3, pos:__add(direction:__mul(80)), direction)
	Timers:CreateTimer(0.1, function()
		MyGameHeroParticleManager:SetParticleControl(pfx, 3, pos:__add(direction:__mul(30)))
		MyGameHeroParticleManager:SetParticleControlTransformForward(pfx, 3, pos:__add(direction:__mul(100)), direction)
		MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	end)
	ScreenShake(pos, 8, 8, 0.2, 1500, 0, true)
	caster:EmitSound("Hero_Axe.Culling_Blade_Success")
end
axe_011 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_011)
____exports.axe_011 = axe_011
____exports.modifier_axe_011_intrinsic = __TS__Class()
local modifier_axe_011_intrinsic = ____exports.modifier_axe_011_intrinsic
modifier_axe_011_intrinsic.name = "modifier_axe_011_intrinsic"
__TS__ClassExtends(modifier_axe_011_intrinsic, BaseHeroModifier)
function modifier_axe_011_intrinsic.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_011_intrinsic.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_axe_011_intrinsic.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	local target = event.target
	if not target or not IsValid(nil, target) or not IsValidEntity(target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	if ability:GetLevel() <= 0 then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local chancePct = ability:GetAttackTriggerChancePct(parent)
	if not RollPseudoRandomPercentage(math.max(0, chancePct), DOTA_PSEUDO_RANDOM_AXE_HELIX_ATTACK, parent) then
		return
	end
	if not ability:TriggerByAttack(target) then
		return
	end
	ability:StartCooldown(ability:GetAttackTriggerCooldown())
end
modifier_axe_011_intrinsic = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_011_intrinsic)
____exports.modifier_axe_011_intrinsic = modifier_axe_011_intrinsic
____exports.modifier_axe_011 = __TS__Class()
local modifier_axe_011 = ____exports.modifier_axe_011
modifier_axe_011.name = "modifier_axe_011"
__TS__ClassExtends(modifier_axe_011, BaseHeroModifier)
function modifier_axe_011.prototype.OnCreated(self)
	local caster = self:GetCaster()
	local pfx_name = "particles/bb/aoe_dmg_ult_hit_corei_2.vpcf"
	local pfx = MyGameHeroParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster, caster)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_axe_011.prototype.GetEffectName(self)
	return "particles/hero/axe/axe_armora0.vpcf"
end
modifier_axe_011 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_011)
____exports.modifier_axe_011 = modifier_axe_011
return ____exports