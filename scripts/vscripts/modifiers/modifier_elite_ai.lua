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
require("enhance.CDOTA_BaseNPC")
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
local AI_TICK_INTERVAL = 1
local TARGET_SEARCH_RANGE = 1800
--- 需要排除的通用技能名
local EXCLUDED_ABILITY_NAMES = { "projectile_system_ability", "twin_gate_portal_warp" }
____exports.modifier_elite_ai = __TS__Class()
local modifier_elite_ai = ____exports.modifier_elite_ai
modifier_elite_ai.name = "modifier_elite_ai"
__TS__ClassExtends(modifier_elite_ai, BaseModifier)
function modifier_elite_ai.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.skills = {}
end
function modifier_elite_ai.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self.eliteUnit = self:GetParent()
	self:CacheReleasableSkills()
	if #self.skills == 0 then
		return
	end
	self:StartIntervalThink(AI_TICK_INTERVAL)
end
function modifier_elite_ai.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self.eliteUnit) then
		return
	end
	if
		self.eliteUnit:IsStunned()
		or self.eliteUnit:IsChanneling()
		or self.eliteUnit:IsSilenced()
		or self.eliteUnit:IsMonsterCasting()
	then
		return
	end
	local target = self.eliteUnit:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
	if not target then
		return
	end
	local readySkills = __TS__ArrayFilter(self.skills, function(____, ab)
		return self:CanCastSkill(ab, target)
	end)
	if #readySkills > 0 then
		local ability = readySkills[RandomInt(0, #readySkills - 1) + 1]
		self:CastSkill(ability, target)
	end
end
function modifier_elite_ai.prototype.CanCastSkill(self, ability, target)
	if not ability or not ability:IsCooldownReady() then
		return false
	end
	local behavior = ability:GetBehavior()
	if
		not CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_POINT)
		and not CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)
	then
		return true
	end
	local unitPos = self.eliteUnit:GetAbsOrigin()
	local targetPos = target:GetAbsOrigin()
	local castRange = ability:GetEffectiveCastRange(unitPos, target)
	return castRange <= 0 or GetDistance(nil, unitPos, targetPos) <= castRange
end
function modifier_elite_ai.prototype.CastSkill(self, ability, target)
	local behavior = ability:GetBehavior()
	local playerId = self.eliteUnit:GetPlayerOwnerID()
	if CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_POINT) then
		self.eliteUnit:CastAbilityOnPosition(target:GetAbsOrigin(), ability, playerId)
		return
	end
	if CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
		self.eliteUnit:CastAbilityOnTarget(target, ability, playerId)
		return
	end
	self.eliteUnit:CastAbilityNoTarget(ability, playerId)
end
function modifier_elite_ai.prototype.CacheReleasableSkills(self)
	local abilities = {}
	local abilityCount = self.eliteUnit:GetAbilityCount()
	do
		local i = 0
		while i < abilityCount do
			do
				local ability = self.eliteUnit:GetAbilityByIndex(i)
				if not ability or ability:IsPassive() then
					goto __continue19
				end
				local name = ability:GetAbilityName()
				if __TS__ArrayIncludes(EXCLUDED_ABILITY_NAMES, name) then
					goto __continue19
				end
				abilities[#abilities + 1] = ability
			end
			::__continue19::
			i = i + 1
		end
	end
	self.skills = abilities
end
function modifier_elite_ai.prototype.IsHidden(self)
	return true
end
function modifier_elite_ai.prototype.IsPurgable(self)
	return false
end
function modifier_elite_ai.prototype.RemoveOnDeath(self)
	return true
end
modifier_elite_ai = __TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_ai") }, modifier_elite_ai)
____exports.modifier_elite_ai = modifier_elite_ai
return ____exports