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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local DEBUG_MONSTER_AI_TOGGLE_KEY = "__debug_monster_ai_enabled__"
local PRIORITY_ABILITY_NAME = "boss_brewmaster_1"
--- 酒仙专属 Boss AI：保留通用 Boss 的随机施法规则，并优先施放醇酒壮胆。
____exports.modifier_boss_brewmaster_ai = __TS__Class()
local modifier_boss_brewmaster_ai = ____exports.modifier_boss_brewmaster_ai
modifier_boss_brewmaster_ai.name = "modifier_boss_brewmaster_ai"
__TS__ClassExtends(modifier_boss_brewmaster_ai, BaseModifier)
function modifier_boss_brewmaster_ai.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.skills = {}
	self.phaseTransitionSkills = {}
	self.count = 0
end
function modifier_boss_brewmaster_ai.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self.bossUnit = self:GetParent()
	self.pool = RandomPool:CreatePool()
	self:GetBossSkills()
	self.count = math.random(2, 6)
	self:StartIntervalThink(1)
end
function modifier_boss_brewmaster_ai.prototype.GetBossSkills(self)
	local abilities = {}
	local phaseTransitionAbilities = {}
	local abilityCount = self.bossUnit:GetAbilityCount()
	do
		local i = 0
		while i < abilityCount do
			do
				local ability = self.bossUnit:GetAbilityByIndex(i)
				if not ability then
					goto __continue5
				end
				if ability:GetAbilityName() == "projectile_system_ability" then
					goto __continue5
				end
				if ability:GetAbilityName() == "twin_gate_portal_warp" then
					goto __continue5
				end
				local monsterAbility = ability
				local ____opt_0 = monsterAbility.IsBossPhaseTransitionAbility
				if ____opt_0 and ____opt_0(monsterAbility) then
					phaseTransitionAbilities[#phaseTransitionAbilities + 1] = ability
					goto __continue5
				end
				if ability:IsPassive() then
					goto __continue5
				end
				if ability:GetAbilityName() == PRIORITY_ABILITY_NAME then
					goto __continue5
				end
				abilities[#abilities + 1] = ability
			end
			::__continue5::
			i = i + 1
		end
	end
	for ____, ability in ipairs(abilities) do
		self.pool:add(ability, 1000)
	end
	self.skills = abilities
	self.phaseTransitionSkills = phaseTransitionAbilities
end
function modifier_boss_brewmaster_ai.prototype.GetRandomTime(self)
	return RandomInt(3, 5)
end
function modifier_boss_brewmaster_ai.prototype.TryCastPrioritySkill(self, unit, target)
	local ability = unit:FindAbilityByName(PRIORITY_ABILITY_NAME)
	if not self:CanCastSkill(ability, unit, target) then
		return nil
	end
	self:CastSkill(unit, ability, target)
	return ability
end
function modifier_boss_brewmaster_ai.prototype.RandomCastSkill(self, unit, target)
	local randomSkill = self.pool:random()
	if not self:IsAbilityHandleValid(randomSkill) then
		return nil
	end
	self:SubSkillWeight(randomSkill)
	local attempts = 0
	while attempts < 5 and not self:CanCastSkill(randomSkill, unit, target) do
		attempts = attempts + 1
		randomSkill = self.pool:random()
		if not self:IsAbilityHandleValid(randomSkill) then
			return nil
		end
		self:SubSkillWeight(randomSkill)
	end
	if attempts >= 5 or not randomSkill then
		return nil
	end
	self:CastSkill(unit, randomSkill, target)
	return randomSkill
end
function modifier_boss_brewmaster_ai.prototype.TryCastPhaseTransitionSkill(self, unit, target)
	if unit.__greed_cave_session_id__ then
		return nil
	end
	for ____, ability in ipairs(self.phaseTransitionSkills) do
		do
			if not self:CanCastPhaseTransitionSkill(ability, unit, target) then
				goto __continue24
			end
			self:CastSkill(unit, ability, target)
			return ability
		end
		::__continue24::
	end
	return nil
end
function modifier_boss_brewmaster_ai.prototype.CanCastPhaseTransitionSkill(self, ability, unit, target)
	if not self:IsAbilityHandleValid(ability) or not self:SafeIsCooldownReady(ability) then
		return false
	end
	local monsterAbility = ability
	local ____opt_2 = monsterAbility.IsBossPhaseTransitionAbility
	if not (____opt_2 and ____opt_2(monsterAbility)) then
		return false
	end
	local ____opt_4 = monsterAbility.CanTriggerBossPhaseTransition
	if not (____opt_4 and ____opt_4(monsterAbility, unit)) then
		return false
	end
	local ____opt_6 = monsterAbility.GetMosnterAbilityConfig
	local config = ____opt_6 and ____opt_6(monsterAbility)
	local canCast = config and config.canCast
	if canCast then
		local ____target_10
		if target then
			____target_10 = { target = target }
		else
			____target_10 = {}
		end
		local result = canCast(nil, ____target_10)
		if result ~= nil and result ~= UF_SUCCESS then
			return false
		end
	end
	local behavior = ability:GetBehavior()
	if
		CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_POINT)
		or CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)
	then
		if not target or not IsValidAlive(nil, target) then
			return false
		end
		local castRange = self:SafeGetEffectiveCastRange(ability, unit, target)
		if castRange == nil then
			return false
		end
		local ____temp_11
		if castRange > 0 then
			____temp_11 = castRange
		else
			____temp_11 = 1500
		end
		local effectiveRange = ____temp_11
		if GetDistance(nil, unit:GetAbsOrigin(), target:GetAbsOrigin()) > effectiveRange then
			return false
		end
	end
	return true
end
function modifier_boss_brewmaster_ai.prototype.CastSkill(self, unit, ability, target)
	local behavior = ability:GetBehavior()
	local playerId = unit:GetPlayerOwnerID()
	if target and CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_POINT) then
		unit:CastAbilityOnPosition(target:GetAbsOrigin(), ability, playerId)
		return
	end
	if target and CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
		unit:CastAbilityOnTarget(target, ability, playerId)
		return
	end
	unit:CastAbilityNoTarget(ability, playerId)
end
function modifier_boss_brewmaster_ai.prototype.SubSkillWeight(self, ability)
	local weight = self.pool:getWeightPrize(ability)
	self.pool:setWeightPrize(ability, math.max(1, math.floor(weight * 0.618)))
end
function modifier_boss_brewmaster_ai.prototype.IsAbilityHandleValid(self, ability)
	if not ability or not IsValid(nil, ability) then
		return false
	end
	local ok, isNull = pcall(function()
		return ability:IsNull()
	end)
	return ok and isNull ~= true
end
function modifier_boss_brewmaster_ai.prototype.SafeIsCooldownReady(self, ability)
	local ok, ready = pcall(function()
		return ability:IsCooldownReady()
	end)
	return ok and ready == true
end
function modifier_boss_brewmaster_ai.prototype.SafeGetEffectiveCastRange(self, ability, unit, target)
	local ok, castRange = pcall(function()
		return ability:GetEffectiveCastRange(unit:GetAbsOrigin(), target)
	end)
	if not ok or type(castRange) ~= "number" then
		return nil
	end
	return castRange
end
function modifier_boss_brewmaster_ai.prototype.CanCastSkill(self, ability, unit, target)
	if not self:IsAbilityHandleValid(ability) or not self:SafeIsCooldownReady(ability) then
		return false
	end
	local castRange = self:SafeGetEffectiveCastRange(ability, unit, target)
	if castRange == nil then
		return false
	end
	local ____temp_12
	if castRange > 0 then
		____temp_12 = castRange
	else
		____temp_12 = 1500
	end
	local effectiveRange = ____temp_12
	if GetDistance(nil, unit:GetAbsOrigin(), target:GetAbsOrigin()) > effectiveRange then
		return false
	end
	local monsterAbility = ability
	local ____opt_13 = monsterAbility.GetMosnterAbilityConfig
	local canCast = ____opt_13 and ____opt_13(monsterAbility).canCast
	if not canCast then
		return true
	end
	local result = canCast(nil, { target = target })
	return result == nil or result == UF_SUCCESS
end
function modifier_boss_brewmaster_ai.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_ai.prototype.RemoveOnDeath(self)
	return true
end
function modifier_boss_brewmaster_ai.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self.pool:clear()
end
function modifier_boss_brewmaster_ai.prototype.OnIntervalThink(self)
	if not IsServer() or _G[DEBUG_MONSTER_AI_TOGGLE_KEY] == false then
		return
	end
	if #self.skills == 0 and #self.phaseTransitionSkills == 0 then
		self:Destroy()
		return
	end
	if not IsValidAlive(nil, self.bossUnit) or self.bossUnit:IsStunned() or self.bossUnit:IsMonsterCasting() then
		return
	end
	local target = self.bossUnit:GetMinDistanceUnit(3000, self.bossUnit:GetAbsOrigin())
	local phaseTransitionAbility = self:TryCastPhaseTransitionSkill(self.bossUnit, target)
	if phaseTransitionAbility then
		self.count = phaseTransitionAbility:GetCooldown(1) + RandomInt(-1, 3)
		return
	end
	if not target then
		self.count = RandomInt(1, 4)
		return
	end
	local priorityAbility = self:TryCastPrioritySkill(self.bossUnit, target)
	if priorityAbility then
		self.count = self:GetRandomTime()
		return
	end
	self.count = self.count - 1
	if self.count > 0 then
		return
	end
	local ability = self:RandomCastSkill(self.bossUnit, target)
	if not ability then
		self.count = RandomInt(1, 5)
		return
	end
	self.count = ability:GetCooldown(1) + RandomInt(-1, 3)
end
modifier_boss_brewmaster_ai = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_brewmaster_ai)
____exports.modifier_boss_brewmaster_ai = modifier_boss_brewmaster_ai
--- 为酒仙 BOSS 提供独立的施法 AI。
____exports.boss_brewmaster_ai = __TS__Class()
local boss_brewmaster_ai = ____exports.boss_brewmaster_ai
boss_brewmaster_ai.name = "boss_brewmaster_ai"
__TS__ClassExtends(boss_brewmaster_ai, MonsterAbility_CS)
function boss_brewmaster_ai.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function boss_brewmaster_ai.prototype.GetIntrinsicModifierName(self)
	return "modifier_boss_brewmaster_ai"
end
boss_brewmaster_ai = __TS__DecorateLegacy({ registerAbility(nil) }, boss_brewmaster_ai)
____exports.boss_brewmaster_ai = boss_brewmaster_ai
return ____exports