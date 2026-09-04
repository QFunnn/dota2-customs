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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____secondary_hero_context = require("my_game_axe.secondary_hero.secondary_hero_context")
local IsPlayerCombatTarget = ____secondary_hero_context.IsPlayerCombatTarget
local WANDER_INTERVAL = 3
local CAST_INTERVAL_MIN = 6
local CAST_INTERVAL_MAX = 12
local TARGET_SEARCH_RANGE = 2000
local EXCLUDED_ABILITY_NAMES = { "projectile_system_ability", "twin_gate_portal_warp" }
local DEBUG_MONSTER_AI_TOGGLE_KEY = "__debug_monster_ai_enabled__"
local WANDER_RANGE_MIN = 500
local WANDER_RANGE_MAX = 1200
local LEASH_RANGE = 1300
____exports.modifier_monster_ai_wander = __TS__Class()
local modifier_monster_ai_wander = ____exports.modifier_monster_ai_wander
modifier_monster_ai_wander.name = "modifier_monster_ai_wander"
__TS__ClassExtends(modifier_monster_ai_wander, MonsterModifier_CS)
function modifier_monster_ai_wander.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.skills = {}
	self.castCountdown = 0
	self.wanderCountdown = 0
end
function modifier_monster_ai_wander.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.unit = self:GetParent()
	self:CacheSkills()
	self.castCountdown = RandomInt(CAST_INTERVAL_MIN, CAST_INTERVAL_MAX)
	self.wanderCountdown = 2
	self:StartIntervalThink(1)
end
function modifier_monster_ai_wander.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self.unit) then
		return
	end
	if _G[DEBUG_MONSTER_AI_TOGGLE_KEY] == false then
		return
	end
	if self.unit:IsStunned() or self.unit:IsChanneling() or self.unit:IsSilenced() then
		return
	end
	self.castCountdown = self.castCountdown - 1
	self.wanderCountdown = self.wanderCountdown - 1
	if self.castCountdown <= 0 then
		if self:TryCastSkill() then
			self.castCountdown = RandomInt(CAST_INTERVAL_MIN, CAST_INTERVAL_MAX)
			self.wanderCountdown = RandomInt(3, WANDER_INTERVAL)
			return
		end
	end
	if self.wanderCountdown <= 0 then
		self:Wander()
		self.wanderCountdown = RandomInt(2, WANDER_INTERVAL)
	end
end
function modifier_monster_ai_wander.prototype.TryCastSkill(self)
	if not IsValidAlive(nil, self.unit) then
		return false
	end
	local target = self.unit:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		return false
	end
	if not target then
		return false
	end
	local unitPos = self.unit:GetAbsOrigin()
	local targetPos = target:GetAbsOrigin()
	local distToTarget = GetDistance(nil, unitPos, targetPos)
	local readySkills = __TS__ArrayFilter(self.skills, function(____, ab)
		if not ab or not ab:IsCooldownReady() then
			return false
		end
		local castRange = ab:GetEffectiveCastRange(unitPos, target)
		local ____temp_0
		if castRange > 0 then
			____temp_0 = castRange
		else
			____temp_0 = TARGET_SEARCH_RANGE
		end
		local effectiveRange = ____temp_0
		if distToTarget > effectiveRange then
			return false
		end
		local monsterAb = ab
		local ____opt_1 = monsterAb.GetMosnterAbilityConfig
		local cfg = ____opt_1 and ____opt_1(monsterAb)
		local canCast = cfg and cfg.canCast
		if not canCast then
			return true
		end
		local result = canCast(nil, { target = target })
		if result == nil or result == UF_SUCCESS then
			return true
		end
		return false
	end)
	if #readySkills == 0 then
		return false
	end
	local ability = readySkills[RandomInt(0, #readySkills - 1) + 1]
	self.unit:Stop()
	self:Timer(0.1, function()
		if not IsValidAlive(nil, self.unit) then
			return
		end
		self.unit:CastAbilityNoTarget(ability, self.unit:GetPlayerOwnerID())
	end)
	return true
end
function modifier_monster_ai_wander.prototype.Wander(self)
	local hero = self:GetNearestHero()
	if not IsValidAlive(nil, hero) then
		return
	end
	if not hero then
		return
	end
	local heroPos = hero:GetAbsOrigin()
	if not IsValidAlive(nil, self.unit) then
		return
	end
	local myPos = self.unit:GetAbsOrigin()
	local distToHero = GetDistance(nil, myPos, heroPos)
	local dest
	if distToHero > LEASH_RANGE then
		local dirToHero = GetDirection(nil, heroPos, myPos)
		local targetDist = RandomInt(WANDER_RANGE_MIN, WANDER_RANGE_MAX)
		dest = heroPos:__add(dirToHero:__mul(-targetDist))
	else
		local angle = math.random() * math.pi * 2
		local radius = RandomInt(WANDER_RANGE_MIN, WANDER_RANGE_MAX)
		local offset = Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0)
		dest = heroPos:__add(offset)
	end
	dest.z = GetGroundHeight(dest, self.unit)
	ExecuteOrderFromTable({
		UnitIndex = self.unit:GetEntityIndex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
		Position = dest,
		Queue = false,
	})
end
function modifier_monster_ai_wander.prototype.GetNearestHero(self)
	if not IsValidAlive(nil, self.unit) then
		return nil
	end
	local list = FindUnitsInRadius(
		self.unit:GetTeamNumber(),
		self.unit:GetAbsOrigin(),
		nil,
		TARGET_SEARCH_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, unit in ipairs(list) do
		if IsPlayerCombatTarget(nil, unit) then
			return unit
		end
	end
	return nil
end
function modifier_monster_ai_wander.prototype.CacheSkills(self)
	local count = self.unit:GetAbilityCount()
	do
		local i = 0
		while i < count do
			do
				local ability = self.unit:GetAbilityByIndex(i)
				if not ability or ability:IsPassive() then
					goto __continue36
				end
				if __TS__ArrayIncludes(EXCLUDED_ABILITY_NAMES, ability:GetAbilityName()) then
					goto __continue36
				end
				local ____self_skills_5 = self.skills
				____self_skills_5[#____self_skills_5 + 1] = ability
			end
			::__continue36::
			i = i + 1
		end
	end
end
function modifier_monster_ai_wander.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_monster_ai_wander.prototype.IsHidden(self)
	return true
end
function modifier_monster_ai_wander.prototype.IsPurgable(self)
	return false
end
function modifier_monster_ai_wander.prototype.RemoveOnDeath(self)
	return true
end
modifier_monster_ai_wander = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monster_ai_wander)
____exports.modifier_monster_ai_wander = modifier_monster_ai_wander
____exports.monster_ai_wander = __TS__Class()
local monster_ai_wander = ____exports.monster_ai_wander
monster_ai_wander.name = "monster_ai_wander"
__TS__ClassExtends(monster_ai_wander, MonsterAbility_CS)
function monster_ai_wander.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function monster_ai_wander.prototype.GetIntrinsicModifierName(self)
	return "modifier_monster_ai_wander"
end
monster_ai_wander = __TS__DecorateLegacy({ registerAbility(nil) }, monster_ai_wander)
____exports.monster_ai_wander = monster_ai_wander
return ____exports