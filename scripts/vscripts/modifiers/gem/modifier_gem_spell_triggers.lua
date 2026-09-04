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
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____gem_multicast_feedback = require("modifiers.gem.gem_multicast_feedback")
local PlayGemMulticastFeedback = ____gem_multicast_feedback.PlayGemMulticastFeedback
local DEFAULT_MULTICAST_CHANCE = 20
local DEFAULT_MULTICAST_COUNT = 2
local DEFAULT_ATTACK_CAST_CHANCE = 20
local KEY_MULTICAST_CHANCE = "gem_multicast_chance"
local KEY_MULTICAST_COUNT = "gem_multicast_count"
local KEY_ATTACK_CAST_CHANCE = "gem_attack_cast_chance"
--- 宝石通用触发基类：
-- - 读取 target_ability_name / target_ability_slot
-- - 负责技能匹配与施法命令下发
-- - 负责“由宝石触发的施法事件”抑制，避免递归连锁
local GemSpellTriggerBaseModifier = __TS__Class()
GemSpellTriggerBaseModifier.name = "GemSpellTriggerBaseModifier"
__TS__ClassExtends(GemSpellTriggerBaseModifier, BaseModifier_CS)
function GemSpellTriggerBaseModifier.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.targetAbilityName = self:normalizeAbilityName(params and params.target_ability_name)
	self.targetAbilitySlot = self:normalizeAbilitySlot(params and params.target_ability_slot)
end
function GemSpellTriggerBaseModifier.prototype.IsHidden(self)
	return true
end
function GemSpellTriggerBaseModifier.prototype.IsPurgable(self)
	return false
end
function GemSpellTriggerBaseModifier.prototype.RemoveOnDeath(self)
	return false
end
function GemSpellTriggerBaseModifier.prototype.RollChance(self, chance)
	return RollPercentage(math.max(0, chance))
end
function GemSpellTriggerBaseModifier.prototype.ReadHeroCustomNumber(self, key, defaultValue)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) then
		return defaultValue
	end
	local ____tonumber_6 = tonumber
	local ____opt_4 = parent.GetCustomValue
	local raw = ____tonumber_6(____opt_4 and ____opt_4(parent, key) or defaultValue)
	local ____isFinite_result_7
	if __TS__NumberIsFinite(__TS__Number(raw)) then
		____isFinite_result_7 = raw
	else
		____isFinite_result_7 = defaultValue
	end
	return ____isFinite_result_7
end
function GemSpellTriggerBaseModifier.prototype.MatchAbility(self, ability)
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return false
	end
	if not self.targetAbilityName and not self.targetAbilitySlot then
		return true
	end
	local ____this_9
	____this_9 = ability
	local ____opt_8 = ____this_9.GetAbilityName
	local abilityName = ____opt_8 and ____opt_8(____this_9)
	if not abilityName then
		return false
	end
	local ____table_targetAbilityName_10
	if self.targetAbilityName then
		____table_targetAbilityName_10 = abilityName == self.targetAbilityName
	else
		____table_targetAbilityName_10 = true
	end
	local byName = ____table_targetAbilityName_10
	local ____table_targetAbilitySlot_11
	if self.targetAbilitySlot then
		____table_targetAbilitySlot_11 = self:GetAbilitySlot(ability) == self.targetAbilitySlot
	else
		____table_targetAbilitySlot_11 = true
	end
	local bySlot = ____table_targetAbilitySlot_11
	return byName and bySlot
end
function GemSpellTriggerBaseModifier.prototype.ResolveConfiguredAbility(self, hero)
	if not hero or not IsValid(nil, hero) then
		return nil
	end
	if self.targetAbilityName then
		local byName = hero:FindAbilityByName(self.targetAbilityName)
		if not byName or not IsValid(nil, byName) then
			return nil
		end
		if self.targetAbilitySlot then
			local slot = self:GetAbilitySlot(byName)
			if slot ~= self.targetAbilitySlot then
				return nil
			end
		end
		return byName
	end
	if not self.targetAbilitySlot then
		return nil
	end
	local ability_count = hero:GetAbilityCount()
	do
		local i = 0
		while i < ability_count do
			do
				local ab = hero:GetAbilityByIndex(i)
				if not ab or not IsValid(nil, ab) or ab:IsNull() then
					goto __continue21
				end
				if self:GetAbilitySlot(ab) == self.targetAbilitySlot then
					return ab
				end
			end
			::__continue21::
			i = i + 1
		end
	end
	return nil
end
function GemSpellTriggerBaseModifier.prototype.IsAbilityCastableByGem(self, caster, ability)
	if not caster or not IsValidAlive(nil, caster) then
		return false
	end
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return false
	end
	local ____this_13
	____this_13 = ability
	local ____opt_12 = ____this_13.IsPassive
	if ____opt_12 and ____opt_12(____this_13) then
		return false
	end
	local ____this_15
	____this_15 = ability
	local ____opt_14 = ____this_15.IsToggle
	if ____opt_14 and ____opt_14(____this_15) then
		return false
	end
	local ____this_17
	____this_17 = ability
	local ____opt_16 = ____this_17.GetLevel
	if (____opt_16 and ____opt_16(____this_17)) <= 0 then
		return false
	end
	local ____this_19
	____this_19 = ability
	local ____opt_18 = ____this_19.GetAbilityName
	local abilityName = ____opt_18 and ____opt_18(____this_19) or ""
	if __TS__StringStartsWith(abilityName, "item_") then
		return false
	end
	return true
end
function GemSpellTriggerBaseModifier.prototype.TriggerGemExtraAbilityOnSpellStart(self, caster, ability, options)
	if not self:IsAbilityCastableByGem(caster, ability) then
		return false
	end
	local order = self:BuildCastOrder(caster, ability, options.target, options.position)
	if not order then
		return false
	end
	caster:SetCursorCastTarget(order.target)
	caster:SetCursorPosition(order.position or caster:GetAbsOrigin())
	caster:SetCursorTargetingNothing(order.orderType == DOTA_UNIT_ORDER_CAST_NO_TARGET)
	local castAbility = ability
	if not castAbility.OnSpellStart then
		return false
	end
	local function runCast()
		local ____opt_20 = castAbility.OnSpellStart
		if ____opt_20 ~= nil then
			____opt_20(castAbility, true)
		end
		self:FireAbilityCastEvent(
			BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST,
			caster,
			ability,
			order.target,
			order.position,
			true
		)
	end
	if options.suppressMulticastEvent == true then
		self:RunWithMulticastSuppressed(ability, runCast)
	else
		runCast(nil)
	end
	return true
end
function GemSpellTriggerBaseModifier.prototype.GetCastOrderType(self, ability)
	local behavior = ability:GetBehaviorInt()
	local hasUnitTarget = bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0
	local hasPointTarget = bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0
	if hasUnitTarget then
		return DOTA_UNIT_ORDER_CAST_TARGET
	end
	if hasPointTarget then
		return DOTA_UNIT_ORDER_CAST_POSITION
	end
	return DOTA_UNIT_ORDER_CAST_NO_TARGET
end
function GemSpellTriggerBaseModifier.prototype.ResolveValidUnitTarget(
	self,
	caster,
	ability,
	preferredTarget,
	searchOrigin
)
	if preferredTarget and IsValidAlive(nil, preferredTarget) then
		return preferredTarget
	end
	local center = searchOrigin or caster:GetAbsOrigin()
	local radius = self:GetUnitTargetSearchRadius(caster, ability, center)
	local candidates = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, candidate in ipairs(candidates) do
		do
			if not candidate or not IsValidAlive(nil, candidate) then
				goto __continue43
			end
			if preferredTarget and candidate == preferredTarget then
				goto __continue43
			end
			return candidate
		end
		::__continue43::
	end
	return nil
end
function GemSpellTriggerBaseModifier.prototype.BuildCastOrder(self, caster, ability, target, position)
	local behavior = ability:GetBehaviorInt()
	local hasNoTarget = bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0
	local hasUnitTarget = bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0
	local hasPointTarget = bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0
	if hasUnitTarget then
		if not target or not IsValidAlive(nil, target) then
			return nil
		end
		return {
			orderType = DOTA_UNIT_ORDER_CAST_TARGET,
			target = target,
			position = target:GetAbsOrigin(),
		}
	end
	if hasPointTarget then
		local point = position or target and target:GetAbsOrigin()
		if not point then
			return nil
		end
		return { orderType = DOTA_UNIT_ORDER_CAST_POSITION, position = point }
	end
	if hasNoTarget or not hasUnitTarget and not hasPointTarget then
		return {
			orderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
			position = caster:GetAbsOrigin(),
		}
	end
	local fallbackPoint = position or caster:GetAbsOrigin()
	return { orderType = DOTA_UNIT_ORDER_CAST_POSITION, position = fallbackPoint }
end
function GemSpellTriggerBaseModifier.prototype.GetUnitTargetSearchRadius(self, caster, ability, center)
	local castRange = math.max(ability:GetCastRange(center, caster), 0)
	if castRange > 0 then
		return castRange
	end
	return FIND_UNITS_EVERYWHERE
end
function GemSpellTriggerBaseModifier.prototype.GetAbilitySlot(self, ability)
	local abilityName = ability:GetAbilityName()
	local ____abilityName_28
	if abilityName then
		local ____opt_24 = MyGameRulesetManager and MyGameRulesetManager:GetAbilityConfig(abilityName)
		____abilityName_28 = ____opt_24 and ____opt_24.AbilitySlot
	else
		____abilityName_28 = nil
	end
	local rulesetAbilitySlot = ____abilityName_28
	local ____rulesetAbilitySlot_31 = rulesetAbilitySlot
	if ____rulesetAbilitySlot_31 == nil then
		local ____this_30
		____this_30 = ability
		local ____opt_29 = ____this_30.GetAbilityKeyValues
		____rulesetAbilitySlot_31 = ____opt_29 and ____opt_29(____this_30, "AbilitySlot")
	end
	local raw = ____rulesetAbilitySlot_31
	return self:normalizeAbilitySlot(raw)
end
function GemSpellTriggerBaseModifier.prototype.IsMulticastSuppressedByRuntimeFlag(self, ability)
	local extAbility = ability
	return (extAbility.__gem_multicast_suppress_count or 0) > 0
end
function GemSpellTriggerBaseModifier.prototype.RunWithMulticastSuppressed(self, ability, callback)
	local extAbility = ability
	local oldCount = extAbility.__gem_multicast_suppress_count or 0
	extAbility.__gem_multicast_suppress_count = oldCount + 1
	do
		pcall(function()
			callback(nil)
		end)
		do
			local nextCount = math.max(0, (extAbility.__gem_multicast_suppress_count or 1) - 1)
			if nextCount <= 0 then
				extAbility.__gem_multicast_suppress_count = nil
			else
				extAbility.__gem_multicast_suppress_count = nextCount
			end
		end
	end
end
function GemSpellTriggerBaseModifier.prototype.FireAbilityCastEvent(
	self,
	eventName,
	caster,
	ability,
	target,
	position,
	isTrigger
)
	if not caster or not IsValid(nil, caster) or not ability or not IsValid(nil, ability) then
		return
	end
	MyGameEvent:FireEvent(eventName, {
		ability_index = ability:GetEntityIndex(),
		ability_name = ability:GetAbilityName(),
		caster = caster:GetEntityIndex(),
		target = target and target:GetEntityIndex(),
		pos = position or caster:GetAbsOrigin(),
		is_trigger = isTrigger == true,
	}, { scope = "entity", entity = caster })
end
function GemSpellTriggerBaseModifier.prototype.normalizeAbilityName(self, raw)
	local name = __TS__StringTrim(tostring(raw or ""))
	local ____temp_34
	if #name > 0 then
		____temp_34 = name
	else
		____temp_34 = nil
	end
	return ____temp_34
end
function GemSpellTriggerBaseModifier.prototype.normalizeAbilitySlot(self, raw)
	local slot = string.lower(__TS__StringTrim(tostring(raw or "")))
	if
		slot == ProfessionSkillSlot.Q
		or slot == ProfessionSkillSlot.W
		or slot == ProfessionSkillSlot.E
		or slot == ProfessionSkillSlot.R
		or slot == ProfessionSkillSlot.D
		or slot == ProfessionSkillSlot.F
		or slot == ProfessionSkillSlot.PASSIVE
	then
		return slot
	end
	return nil
end
--- 宝石效果：多重施法
-- - 仅对目标技能名/槽位命中的技能生效
-- - 额外施法临时跳过魔法消耗与施法检测
-- - 多重追加施法会手动派发施法事件
____exports.modifier_gem_multicast = __TS__Class()
local modifier_gem_multicast = ____exports.modifier_gem_multicast
modifier_gem_multicast.name = "modifier_gem_multicast"
__TS__ClassExtends(modifier_gem_multicast, GemSpellTriggerBaseModifier)
function modifier_gem_multicast.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_gem_multicast.prototype.PlayMulticastEffect(self, parent, totalCount, extraCount)
	PlayGemMulticastFeedback(nil, parent, totalCount, extraCount)
end
function modifier_gem_multicast.prototype.OnAfterAbilityFullyCast_CS(self, event)
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
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	if self:IsMulticastSuppressedByRuntimeFlag(castAbility) then
		return
	end
	if not self:MatchAbility(castAbility) then
		return
	end
	if not self:IsAbilityCastableByGem(parent, castAbility) then
		return
	end
	local chance = self:ReadHeroCustomNumber(KEY_MULTICAST_CHANCE, DEFAULT_MULTICAST_CHANCE)
	if not self:RollChance(chance) then
		return
	end
	local totalCountRaw = self:ReadHeroCustomNumber(KEY_MULTICAST_COUNT, DEFAULT_MULTICAST_COUNT)
	local totalCount = math.max(2, math.floor(totalCountRaw))
	local extraCount = totalCount - 1
	local orderType = self:GetCastOrderType(castAbility)
	local ____temp_35
	if event.target ~= nil and (tonumber(event.target) or 0) > 0 then
		____temp_35 = EntIndexToHScript(event.target)
	else
		____temp_35 = nil
	end
	local primaryTarget = ____temp_35
	local fixedPoint = event.pos
	local searchAnchor = fixedPoint or primaryTarget and primaryTarget:GetAbsOrigin() or parent:GetAbsOrigin()
	local lastTarget = primaryTarget
	self:PlayMulticastEffect(parent, totalCount, extraCount)
	do
		local i = 0
		while i < extraCount do
			local delay = 0.45 * (i + 1)
			self:Timer(delay, function()
				if not IsValid(nil, self) or not IsValidAlive(nil, parent) then
					return
				end
				local castTarget
				local castPosition
				if orderType == DOTA_UNIT_ORDER_CAST_TARGET then
					castTarget = self:ResolveValidUnitTarget(parent, castAbility, lastTarget, searchAnchor)
					if not castTarget then
						return
					end
					lastTarget = castTarget
					castPosition = castTarget:GetAbsOrigin()
				elseif orderType == DOTA_UNIT_ORDER_CAST_POSITION then
					castPosition = fixedPoint or primaryTarget and primaryTarget:GetAbsOrigin()
					if not castPosition then
						return
					end
				end
				if
					not self:TriggerGemExtraAbilityOnSpellStart(
						parent,
						castAbility,
						{ target = castTarget, position = castPosition, suppressMulticastEvent = true }
					)
				then
					return
				end
			end)
			i = i + 1
		end
	end
end
modifier_gem_multicast =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_gem_multicast") }, modifier_gem_multicast)
____exports.modifier_gem_multicast = modifier_gem_multicast
--- 宝石效果：攻击命中后概率触发指定技能
-- - 技能目标由 target_ability_name / target_ability_slot 决定
-- - 触发时临时跳过魔法消耗与施法检测，并手动派发施法事件
____exports.modifier_gem_attack_cast = __TS__Class()
local modifier_gem_attack_cast = ____exports.modifier_gem_attack_cast
modifier_gem_attack_cast.name = "modifier_gem_attack_cast"
__TS__ClassExtends(modifier_gem_attack_cast, GemSpellTriggerBaseModifier)
function modifier_gem_attack_cast.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_gem_attack_cast.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValidAlive(nil, parent) then
		return
	end
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local chance = self:ReadHeroCustomNumber(KEY_ATTACK_CAST_CHANCE, DEFAULT_ATTACK_CAST_CHANCE)
	if not self:RollChance(chance) then
		return
	end
	local hero = parent
	local triggerAbility = self:ResolveConfiguredAbility(hero)
	if not triggerAbility then
		return
	end
	if not self:IsAbilityCastableByGem(parent, triggerAbility) then
		return
	end
	if not self:MatchAbility(triggerAbility) then
		return
	end
	local orderType = self:GetCastOrderType(triggerAbility)
	local fixedPoint = target:GetAbsOrigin()
	local castTarget
	local castPosition
	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(nil, self) or not IsValidAlive(nil, parent) then
			return
		end
		if orderType == DOTA_UNIT_ORDER_CAST_TARGET then
			castTarget = self:ResolveValidUnitTarget(parent, triggerAbility, target, fixedPoint)
			if not castTarget then
				return
			end
			castPosition = castTarget:GetAbsOrigin()
		elseif orderType == DOTA_UNIT_ORDER_CAST_POSITION then
			castPosition = fixedPoint
		end
		if
			not self:TriggerGemExtraAbilityOnSpellStart(
				parent,
				triggerAbility,
				{ target = castTarget, position = castPosition, suppressMulticastEvent = true }
			)
		then
			return
		end
	end)
end
modifier_gem_attack_cast =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_gem_attack_cast") }, modifier_gem_attack_cast)
____exports.modifier_gem_attack_cast = modifier_gem_attack_cast
return ____exports