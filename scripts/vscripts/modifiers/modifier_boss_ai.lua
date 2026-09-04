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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
local DEBUG_MONSTER_AI_TOGGLE_KEY = "__debug_monster_ai_enabled__"
____exports.default = __TS__Class()
local modifier_boss_ai_test = ____exports.default
modifier_boss_ai_test.name = "modifier_boss_ai_test"
__TS__ClassExtends(modifier_boss_ai_test, BaseModifier)
function modifier_boss_ai_test.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.skills = {}
	self.phaseTransitionSkills = {}
	self.count = 0
end
function modifier_boss_ai_test.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.bossUnit = self:GetParent()
	local Pool = RandomPool:CreatePool()
	self.Pool = Pool
	self:GetBossSkills()
	self.count = math.random(2, 6)
	self:StartIntervalThink(1)
end
function modifier_boss_ai_test.prototype.GetBossSkills(self)
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
				local monsterAb = ability
				local ____opt_0 = monsterAb.IsBossPhaseTransitionAbility
				if ____opt_0 and ____opt_0(monsterAb) then
					phaseTransitionAbilities[#phaseTransitionAbilities + 1] = ability
					goto __continue5
				end
				if ability:IsPassive() then
					goto __continue5
				end
				abilities[#abilities + 1] = ability
			end
			::__continue5::
			i = i + 1
		end
	end
	__TS__ArrayForEach(abilities, function(____, ability, index)
		self.Pool:add(ability, 1000)
	end)
	self.skills = abilities
	self.phaseTransitionSkills = phaseTransitionAbilities
end
function modifier_boss_ai_test.prototype.GetRandomTime(self)
	local min = 3
	local max = 5
	local randomNumber = math.floor(math.random() * (max - min + 1)) + min
	return randomNumber
end
function modifier_boss_ai_test.prototype.RandomCastSkill(self, unit, target)
	local randomSkill = self.Pool:random()
	if not self:IsAbilityHandleValid(randomSkill) then
		return nil
	end
	self:SubSkillWeight(randomSkill)
	local n = 0
	while n < 5 and not self:CanCastSkill(randomSkill, unit, target) do
		n = n + 1
		randomSkill = self.Pool:random()
		if not self:IsAbilityHandleValid(randomSkill) then
			return nil
		end
		self:SubSkillWeight(randomSkill)
	end
	if not randomSkill then
		return nil
	end
	if n >= 5 then
		return nil
	end
	unit:CastAbilityNoTarget(randomSkill, unit:GetPlayerOwnerID())
	local castTime = randomSkill:GetCastPoint()
	local cd = randomSkill:GetCooldown(1)
	local monsterAb = randomSkill
	local ____opt_2 = monsterAb.GetMosnterAbilityConfig
	local cfg = ____opt_2 and ____opt_2(monsterAb)
	if cfg and cfg.castDuration + cfg.castPoint < castTime then
		cd = cfg.castDuration + cfg.castPoint
	end
	self.count = self.count + (cd + math.random(1, 2) + cd * math.random(0.05, 0.15))
	return randomSkill
end
function modifier_boss_ai_test.prototype.TryCastPhaseTransitionSkill(self, unit, target)
	if unit.__greed_cave_session_id__ then
		return nil
	end
	for ____, ability in ipairs(self.phaseTransitionSkills) do
		do
			if not self:CanCastPhaseTransitionSkill(ability, unit, target) then
				goto __continue22
			end
			self:CastSkill(unit, ability, target)
			return ability
		end
		::__continue22::
	end
	return nil
end
function modifier_boss_ai_test.prototype.CanCastPhaseTransitionSkill(self, ability, unit, target)
	if not self:IsAbilityHandleValid(ability) then
		return false
	end
	if not self:SafeIsCooldownReady(ability) then
		return false
	end
	local monsterAb = ability
	local ____opt_4 = monsterAb.IsBossPhaseTransitionAbility
	if not (____opt_4 and ____opt_4(monsterAb)) then
		return false
	end
	local ____opt_6 = monsterAb.CanTriggerBossPhaseTransition
	if not (____opt_6 and ____opt_6(monsterAb, unit)) then
		return false
	end
	local ____opt_8 = monsterAb.GetMosnterAbilityConfig
	local cfg = ____opt_8 and ____opt_8(monsterAb)
	local canCast = cfg and cfg.canCast
	if canCast then
		local ____target_12
		if target then
			____target_12 = { target = target }
		else
			____target_12 = {}
		end
		local result = canCast(nil, ____target_12)
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
		local ____temp_13
		if castRange > 0 then
			____temp_13 = castRange
		else
			____temp_13 = 1500
		end
		local effectiveRange = ____temp_13
		if GetDistance(nil, unit:GetAbsOrigin(), target:GetAbsOrigin()) > effectiveRange then
			return false
		end
	end
	return true
end
function modifier_boss_ai_test.prototype.CastSkill(self, unit, ability, target)
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
function modifier_boss_ai_test.prototype.SubSkillWeight(self, randomSkill)
	local weightPrize = self.Pool:getWeightPrize(randomSkill)
	self.Pool:setWeightPrize(randomSkill, math.max(1, math.floor(weightPrize * 0.618)))
end
function modifier_boss_ai_test.prototype.IsAbilityHandleValid(self, ability)
	if not ability then
		return false
	end
	if not IsValid(nil, ability) then
		return false
	end
	local ok, isNull = pcall(function()
		return ability:IsNull()
	end)
	return ok and isNull ~= true
end
function modifier_boss_ai_test.prototype.SafeIsCooldownReady(self, ability)
	local ok, ready = pcall(function()
		return ability:IsCooldownReady()
	end)
	return ok and ready == true
end
function modifier_boss_ai_test.prototype.SafeGetEffectiveCastRange(self, ability, unit, target)
	local ok, castRange = pcall(function()
		return ability:GetEffectiveCastRange(unit:GetAbsOrigin(), target)
	end)
	if not ok or type(castRange) ~= "number" then
		return nil
	end
	return castRange
end
function modifier_boss_ai_test.prototype.CanCastSkill(self, ability, unit, target)
	if not self:IsAbilityHandleValid(ability) then
		return false
	end
	if not self:SafeIsCooldownReady(ability) then
		return false
	end
	local castRange = self:SafeGetEffectiveCastRange(ability, unit, target)
	if castRange == nil then
		return false
	end
	local ____temp_14
	if castRange > 0 then
		____temp_14 = castRange
	else
		____temp_14 = 1500
	end
	local effectiveRange = ____temp_14
	if GetDistance(nil, unit:GetAbsOrigin(), target:GetAbsOrigin()) > effectiveRange then
		return false
	end
	local monsterAb = ability
	local ____opt_15 = monsterAb.GetMosnterAbilityConfig
	local cfg = ____opt_15 and ____opt_15(monsterAb)
	local canCast = cfg and cfg.canCast
	if not canCast then
		return true
	end
	local result = canCast(nil, { target = target })
	return result == nil or result == UF_SUCCESS
end
function modifier_boss_ai_test.prototype.IsHidden(self)
	return true
end
function modifier_boss_ai_test.prototype.RemoveOnDeath(self)
	return true
end
function modifier_boss_ai_test.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self.Pool:clear()
end
function modifier_boss_ai_test.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if _G[DEBUG_MONSTER_AI_TOGGLE_KEY] == false then
		return
	end
	if #self.skills == 0 and #self.phaseTransitionSkills == 0 then
		self:Destroy()
		return
	end
	if not IsValidAlive(nil, self.bossUnit) then
		return
	end
	if self.bossUnit:IsStunned() then
		return
	end
	if self.bossUnit:IsMonsterCasting() then
		return
	end
	local target = self.bossUnit:GetMinDistanceUnit(3000, self.bossUnit:GetAbsOrigin())
	local phaseTransitionAbility = self:TryCastPhaseTransitionSkill(self.bossUnit, target)
	if phaseTransitionAbility then
		self.count = phaseTransitionAbility:GetCooldown(1) + math.random(-1, 3)
		return
	end
	self.count = self.count - 1
	if self.count > 0 then
		return
	end
	if not target then
		self.count = math.random(1, 4)
		return
	end
	local ability = self:RandomCastSkill(self.bossUnit, target)
	if not ability then
		self.count = math.random(1, 5)
		return
	end
	self.count = ability:GetCooldown(1) + math.random(-1, 3)
end
modifier_boss_ai_test = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_ai_test)
____exports.default = modifier_boss_ai_test
return ____exports