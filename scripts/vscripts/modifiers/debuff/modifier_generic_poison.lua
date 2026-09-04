--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local POISON_TICK_INTERVAL = 0.25
local POISON_STACK_DECAY_INTERVAL = 3
local POISON_STACK_DECAY_PCT = 20
local POISON_STACK_CURVE_A = 50
local POISON_STACK_CURVE_B = 0.4
local POISON_TOTAL_STACK_CURVE_A = 120
local POISON_TOTAL_STACK_CURVE_B = 1
local POISON_DAMAGE_SCALE = 0.25
local POISON_DAMAGE_MULTIPLIER = 1.3
local POISON_DEFAULT_EFFECT = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf"
local POISON_DEBUG_LOG = false
local function FindPoisonModifiers(self, unit, isHeroSource)
	if not IsValid(nil, unit) or not unit.FindAllModifiers then
		return {}
	end
	local modifiers = __TS__ArrayFilter(unit:FindAllModifiers(), function(____, modifier)
		return modifier:GetName() == "modifier_generic_poison"
	end)
	if isHeroSource == nil then
		return modifiers
	end
	return __TS__ArrayFilter(modifiers, function(____, modifier)
		local ____this_1
		____this_1 = modifier
		local ____opt_0 = ____this_1.IsSamePoisonSourceKind
		return (____opt_0 and ____opt_0(____this_1, isHeroSource)) == true
	end)
end
local function RefreshAllPoisonModifiers(self, unit)
	for ____, modifier in ipairs(FindPoisonModifiers(nil, unit)) do
		local ____opt_2 = modifier.RecalculatePoisonDamage
		if ____opt_2 ~= nil then
			____opt_2(modifier)
		end
	end
end
____exports.modifier_generic_poison = __TS__Class()
local modifier_generic_poison = ____exports.modifier_generic_poison
modifier_generic_poison.name = "modifier_generic_poison"
__TS__ClassExtends(modifier_generic_poison, BaseModifier_CS)
function modifier_generic_poison.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.sourceAllStats = 0
	self.sourceIsHero = false
	self.poisonDamagePerSecond = 0
	self.currentTickInterval = POISON_TICK_INTERVAL
	self.nextStackDecayTime = 0
end
function modifier_generic_poison.GetLocalizationCN(self)
	return {
		name = "中毒",
		description = "周期性受到魔法伤害。伤害基于施加者全属性，所有层数共同参与总中毒伤害计算。",
	}
end
function modifier_generic_poison.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name
	self.statusEffectName = params.status_effect_name
	self.sourceAllStats = math.max(params.source_all_stats or self:GetUnitAllStats(self:GetCaster()), 0)
	local ____temp_8 = params.source_is_hero == 1
	if not ____temp_8 then
		local ____opt_6 = self:GetCaster()
		local ____opt_4 = ____opt_6 and ____opt_6.IsHero
		____temp_8 = (____opt_4 and ____opt_4(____opt_6)) == true
	end
	self.sourceIsHero = ____temp_8
	self:SetStackCount(math.max(math.floor(params.stack or 1), 1))
	self:SetDuration(-1, false)
	self.nextStackDecayTime = GameRules:GetGameTime() + POISON_STACK_DECAY_INTERVAL
	self:DebugPoisonLog(
		(
			(
				(
					(
						(
							(
								(("OnCreated params_stack=" .. tostring(params.stack)) .. " params_source_all_stats=")
								.. tostring(params.source_all_stats)
							) .. " sourceAllStats="
						) .. tostring(self.sourceAllStats)
					) .. " sourceIsHero="
				) .. tostring(self.sourceIsHero)
			) .. " nextDecay="
		) .. tostring(self.nextStackDecayTime)
	)
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
	self:RecalculatePoisonDamage()
	if self:GetCaster():HasModifier("item_0402_modifier") then
		self:DebugPoisonLog("OnCreated item_0402_modifier 触发立即结算")
		self:OnIntervalThink()
	end
	self:UpdateTickInterval()
	self:DebugPoisonLog(
		(("OnCreated StartIntervalThink interval=" .. tostring(self.currentTickInterval)) .. " dps=")
			.. tostring(self.poisonDamagePerSecond)
	)
	self:StartIntervalThink(self.currentTickInterval)
end
function modifier_generic_poison.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:DebugPoisonLog(
		(
			(
				(
					(
						(("OnRefresh before stack=" .. tostring(self:GetStackCount())) .. " params_stack=")
						.. tostring(params.stack)
					) .. " params_source_all_stats="
				) .. tostring(params.source_all_stats)
			) .. " nextDecay="
		) .. tostring(self.nextStackDecayTime)
	)
	self:AddExternalStacks(params.stack or 1, params.source_all_stats or self:GetUnitAllStats(self:GetCaster()))
	self.effectName = params.effect_name or self.effectName
	self.statusEffectName = params.status_effect_name or self.statusEffectName
	if self:GetCaster():HasModifier("item_0402_modifier") then
		self:DebugPoisonLog("OnRefresh item_0402_modifier 触发立即结算")
		self:OnIntervalThink()
	end
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_poison.prototype.AddExternalStacks(self, stack, source_all_stats)
	if not IsServer() then
		return
	end
	local add = math.max(math.floor(stack), 1)
	self.sourceAllStats = math.max(source_all_stats, 0)
	local oldStack = self:GetStackCount()
	self:DebugPoisonLog(
		(
			(
				(
					(
						(
							((("AddExternalStacks before oldStack=" .. tostring(oldStack)) .. " add=") .. tostring(add))
							.. " inputStack="
						) .. tostring(stack)
					) .. " source_all_stats="
				) .. tostring(source_all_stats)
			) .. " nextDecay="
		) .. tostring(self.nextStackDecayTime)
	)
	self:SetStackCount(self:GetStackCount() + add)
	self:SetDuration(-1, false)
	if self.nextStackDecayTime <= 0 then
		self.nextStackDecayTime = GameRules:GetGameTime() + POISON_STACK_DECAY_INTERVAL
	end
	self:DebugPoisonLog(
		(("AddExternalStacks after stack=" .. tostring(self:GetStackCount())) .. " nextDecay=")
			.. tostring(self.nextStackDecayTime)
	)
	RefreshAllPoisonModifiers(nil, self:GetParent())
end
function modifier_generic_poison.prototype.OnStackCountChanged(self, oldStackCount)
	if not IsServer() then
		return
	end
	self:DebugPoisonLog(
		(("OnStackCountChanged old=" .. tostring(oldStackCount)) .. " new=") .. tostring(self:GetStackCount())
	)
	RefreshAllPoisonModifiers(nil, self:GetParent())
end
function modifier_generic_poison.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local victim = self:GetParent()
	local attacker = self:GetCaster()
	local victimValid = IsValidAlive(nil, victim)
	local attackerValid = IsValidAlive(nil, attacker)
	local ____victimValid_9
	if victimValid then
		____victimValid_9 = self:IsHeroPoisonTarget(victim)
	else
		____victimValid_9 = false
	end
	local isHeroDamageTarget = ____victimValid_9
	self:DebugPoisonLog(
		(
			(
				(
					(
						(
							(
								(
									(
										(
											(
												(
													("OnIntervalThink enter victimValid=" .. tostring(victimValid))
													.. " attackerValid="
												) .. tostring(attackerValid)
											) .. " targetPath="
										) .. (isHeroDamageTarget and "hero_hp_pct" or "monster_attribute_dot")
									) .. " stack="
								) .. tostring(self:GetStackCount())
							) .. " dps="
						) .. tostring(self.poisonDamagePerSecond)
					) .. " sourceAllStats="
				) .. tostring(self.sourceAllStats)
			) .. " nextDecay="
		) .. tostring(self.nextStackDecayTime)
	)
	if not victimValid or not attackerValid then
		self:DebugPoisonLog(
			(("OnIntervalThink Destroy reason=单位无效 victimValid=" .. tostring(victimValid)) .. " attackerValid=")
				.. tostring(attackerValid)
		)
		self:Destroy()
		return
	end
	if self:ApplyStackDecay() then
		return
	end
	if not isHeroDamageTarget and self.poisonDamagePerSecond <= 0 then
		self:DebugPoisonLog(
			"OnIntervalThink Destroy reason=怪物路径属性毒伤为0 dps=" .. tostring(self.poisonDamagePerSecond)
		)
		self:Destroy()
		return
	end
	if victim.IsMagicImmune and victim:IsMagicImmune() then
		self:DebugPoisonLog("OnIntervalThink skip reason=目标魔免")
		return
	end
	local intervalChanged = self:UpdateTickInterval(attacker)
	if isHeroDamageTarget then
		self:DebugPoisonLog(
			(
				(
					(
						(
							"OnIntervalThink damage path=HeroHealthPct damage_rate="
							.. tostring(self:GetStackCount() * POISON_TICK_INTERVAL * POISON_DAMAGE_MULTIPLIER)
						) .. " sourceValue="
					) .. tostring(self.sourceAllStats)
				) .. " interval="
			) .. tostring(self.currentTickInterval)
		)
		attacker:MonsterDamage({
			victim = victim,
			damage_rate = self:GetStackCount() * POISON_TICK_INTERVAL * POISON_DAMAGE_MULTIPLIER,
			attack_damage_override = self.sourceAllStats,
			damage_type = 2,
			ability = self:GetAbility(),
			expected_damage_health_pct = 0.3,
		}, {
			damage_tags = DamageTag.DOT,
			debuff_status = DebuffStatusType.POISON,
			source_name = self:GetName(),
		})
	else
		self:DebugPoisonLog(
			(
				(
					"OnIntervalThink damage path=MonsterAttributeDot damage="
					.. tostring(self.poisonDamagePerSecond * POISON_TICK_INTERVAL * 0.5)
				) .. " interval="
			) .. tostring(self.currentTickInterval)
		)
		Damage:ApplyDamage({
			attacker = attacker,
			victim = victim,
			damage = self.poisonDamagePerSecond * POISON_TICK_INTERVAL * 0.5,
			damage_type = 2,
			ability = self:GetAbility(),
			extra_data = {
				damage_tags = DamageTag.DOT,
				debuff_status = DebuffStatusType.POISON,
				source_name = self:GetName(),
			},
		})
	end
	if intervalChanged then
		self:DebugPoisonLog("OnIntervalThink interval changed next=" .. tostring(self.currentTickInterval))
		self:StartIntervalThink(self.currentTickInterval)
	end
end
function modifier_generic_poison.prototype.GetPoisonTickInterval(self, attacker)
	local base = POISON_TICK_INTERVAL
	if not attacker or not IsValid(nil, attacker) or not MyGameAttribute:HasAttributes(attacker) then
		return base
	end
	local fasterPct = MyGameAttribute:GetAttribute(attacker, "poison_damage_faster_pct") or 0
	local speedMult = 1 + fasterPct / 100
	local clampedSpeedMult = math.min(math.max(speedMult, 0.05), 10)
	local interval = base / clampedSpeedMult
	return math.min(math.max(interval, 0.03), POISON_STACK_DECAY_INTERVAL)
end
function modifier_generic_poison.prototype.ApplyStackDecay(self)
	local now = GameRules:GetGameTime()
	if self.nextStackDecayTime <= 0 then
		self.nextStackDecayTime = now + POISON_STACK_DECAY_INTERVAL
		return false
	end
	if now < self.nextStackDecayTime then
		return false
	end
	local currentStacks = self:GetStackCount()
	local decayStacks = math.max(1, math.floor(currentStacks * POISON_STACK_DECAY_PCT / 100))
	local nextStacks = currentStacks - decayStacks
	self.nextStackDecayTime = now + POISON_STACK_DECAY_INTERVAL
	self:DebugPoisonLog(
		(((("ApplyStackDecay current=" .. tostring(currentStacks)) .. " decay=") .. tostring(decayStacks)) .. " next=")
			.. tostring(nextStacks)
	)
	if nextStacks <= 0 then
		self:Destroy()
		return true
	end
	self:SetStackCount(nextStacks)
	self:RecalculatePoisonDamage()
	return false
end
function modifier_generic_poison.prototype.UpdateTickInterval(self, attacker)
	local next = self:GetPoisonTickInterval(attacker or self:GetCaster())
	return self:SetTickInterval(next, "UpdateTickInterval")
end
function modifier_generic_poison.prototype.SetTickInterval(self, next, reason)
	local changed = math.abs((self.currentTickInterval or POISON_TICK_INTERVAL) - next) > 0.0001
	if changed then
		self:DebugPoisonLog((((reason .. " old=") .. tostring(self.currentTickInterval)) .. " next=") .. tostring(next))
	end
	self.currentTickInterval = next
	return changed
end
function modifier_generic_poison.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local parentValid = IsValid(nil, parent)
	if not parentValid then
		return
	end
end
function modifier_generic_poison.prototype.RecalculatePoisonDamage(self)
	if not IsServer() then
		return
	end
	if self.sourceAllStats <= 0 then
		self.sourceAllStats = self:GetUnitAllStats(self:GetCaster())
	end
	local selfStacks = self:GetStackCount()
	local totalStacks = __TS__ArrayReduce(
		FindPoisonModifiers(nil, self:GetParent(), self.sourceIsHero),
		function(____, sum, modifier)
			return sum + modifier:GetStackCount()
		end,
		0
	)
	local basePoisonDamage = POISON_STACK_CURVE_B
			* (selfStacks - 1)
			/ (POISON_STACK_CURVE_B * (selfStacks - 1) + POISON_STACK_CURVE_A)
			* 80
		+ 1
	local multiplierPoisonDamage = POISON_TOTAL_STACK_CURVE_B
			* (totalStacks - 1)
			/ (POISON_TOTAL_STACK_CURVE_B * (selfStacks - 1) + POISON_TOTAL_STACK_CURVE_A)
			* 4
		+ 1
	local poisonDamagePerSecond = basePoisonDamage * multiplierPoisonDamage * self.sourceAllStats
	self.poisonDamagePerSecond = math.floor(poisonDamagePerSecond * POISON_DAMAGE_SCALE * POISON_DAMAGE_MULTIPLIER)
	self:DebugPoisonLog(
		(
			(
				(
					(
						(
							(
								(
									(
										(
											(
												(
													("RecalculatePoisonDamage selfStacks=" .. tostring(selfStacks))
													.. " totalStacks="
												) .. tostring(totalStacks)
											) .. " sourceAllStats="
										) .. tostring(self.sourceAllStats)
									) .. " base="
								) .. tostring(basePoisonDamage)
							) .. " mult="
						) .. tostring(multiplierPoisonDamage)
					) .. " rawDps="
				) .. tostring(poisonDamagePerSecond)
			) .. " finalDps="
		) .. tostring(self.poisonDamagePerSecond)
	)
end
function modifier_generic_poison.prototype.IsSamePoisonSourceKind(self, isHeroSource)
	return self.sourceIsHero == isHeroSource
end
function modifier_generic_poison.prototype.GetUnitAllStats(self, unit)
	if not unit or not IsValid(nil, unit) then
		return 0
	end
	local strength = MyGameAttribute:GetAttribute(unit, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(unit, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(unit, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_generic_poison.prototype.IsHeroPoisonTarget(self, unit)
	if not unit or not IsValid(nil, unit) then
		return false
	end
	local ____this_11
	____this_11 = unit
	local ____opt_10 = ____this_11.GetUnitType
	local unitType = ____opt_10 and ____opt_10(____this_11)
	local ____temp_12
	if unitType ~= nil then
		____temp_12 = unitType == UnitType.HERO or unitType == UnitType.SECONDARY_HERO
	else
		____temp_12 = unit:IsHero()
	end
	return ____temp_12
end
function modifier_generic_poison.prototype.DebugPoisonLog(self, message)
	if not POISON_DEBUG_LOG then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	print(
		(
			(
				(
					(
						(
							((("[modifier_generic_poison][" .. tostring(GameRules:GetGameTime())) .. "] ") .. message)
							.. " parent="
						) .. self:GetUnitDebugName(parent)
					) .. " caster="
				) .. self:GetUnitDebugName(caster)
			) .. " ability="
		) .. self:GetAbilityDebugName()
	)
end
function modifier_generic_poison.prototype.GetUnitDebugName(self, unit)
	if not unit or not IsValid(nil, unit) then
		return "nil"
	end
	local ____this_14
	____this_14 = unit
	local ____opt_13 = ____this_14.GetUnitName
	local ____temp_17 = ____opt_13 and ____opt_13(____this_14) or "unknown"
	local ____this_16
	____this_16 = unit
	local ____opt_15 = ____this_16.entindex
	return (____temp_17 .. "#") .. tostring(____opt_15 and ____opt_15(____this_16) or -1)
end
function modifier_generic_poison.prototype.GetAbilityDebugName(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return "nil"
	end
	local ____opt_18 = ability.GetAbilityName
	return ____opt_18 and ____opt_18(ability) or "unknown"
end
function modifier_generic_poison.prototype.AddCustomTransmitterData(self)
	return { effectName = self.effectName, statusEffectName = self.statusEffectName }
end
function modifier_generic_poison.prototype.HandleCustomTransmitterData(self, data)
	self.effectName = data.effectName
	self.statusEffectName = data.statusEffectName
end
function modifier_generic_poison.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_generic_poison.prototype.IsHidden(self)
	return false
end
function modifier_generic_poison.prototype.IsDebuff(self)
	return true
end
function modifier_generic_poison.prototype.IsPurgable(self)
	return true
end
function modifier_generic_poison.prototype.GetEffectName(self)
	return self.effectName or POISON_DEFAULT_EFFECT
end
function modifier_generic_poison.prototype.GetStatusEffectName(self)
	return self.statusEffectName or ""
end
function modifier_generic_poison.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_generic_poison.prototype.GetTexture(self)
	return "venomancer_poison_sting"
end
modifier_generic_poison = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_poison)
____exports.modifier_generic_poison = modifier_generic_poison
return ____exports