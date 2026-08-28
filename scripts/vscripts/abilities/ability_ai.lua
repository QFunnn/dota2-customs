--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/ability_ai"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("abilities.eom_ability")
local g = f.EOMAbility
e.EOMAbilityAI = c()
local h = e.EOMAbilityAI
h.name = "EOMAbilityAI"
d(h, g)
function h.prototype.SortAITargets(self, i)
	local j = self:GetCaster():GetAbsOrigin()
	table.sort(i, function(k, l)
		local m = k:IsBreakable()
		local n = l:IsBreakable()
		if m ~= n then
			return n
		end
		if self.funcSortFunction ~= nil then
			return self:funcSortFunction(k, l)
		end
		if self.orderType == FIND_CLOSEST then
			return (k:GetAbsOrigin() - j):Length2D() < (l:GetAbsOrigin() - j):Length2D()
		end
		if self.orderType == FIND_FARTHEST then
			return (k:GetAbsOrigin() - j):Length2D() > (l:GetAbsOrigin() - j):Length2D()
		end
		return false
	end)
	return i
end
function h.prototype.Spawn(self)
	if IsServer() then
		self:ParseBehavior()
		self:_StartThink()
	end
end
function h.prototype.GetThinkInterval(self)
	return AI_TIMER_TICK_TIME
end
function h.prototype.ParseBehavior(self)
	if not self:IsPassive() and self.behavior == nil then
		local o = tonumber(tostring(self:GetBehavior()))
		if bit.band(o, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
			self.behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET
		elseif bit.band(o, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
			self.behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
		elseif bit.band(o, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
			self.behavior = DOTA_ABILITY_BEHAVIOR_POINT
		end
	end
	self.targetTeam = self.targetTeam or self:GetAbilityTargetTeam()
	self.targetType = self.targetType or self:GetAbilityTargetType()
	self.targetFlags = self.targetFlags or self:GetAbilityTargetFlags()
	if self.targetTeam == DOTA_UNIT_TARGET_TEAM_NONE then
		self.targetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
	end
	if self.targetType == DOTA_UNIT_TARGET_NONE then
		self.targetType = DOTA_UNIT_TARGET_HEROES_AND_CREEPS
	end
	if bit.band(self.targetType, DOTA_UNIT_TARGET_BUILDING) == DOTA_UNIT_TARGET_BUILDING then
		self.targetType = self.targetType - DOTA_UNIT_TARGET_BUILDING
	end
end
function h.prototype._StartThink(self)
	self:_StopThink()
	local p = self:GetCaster()
	if p:HasState(StateEnum.AI_DISABLED) then
		return self:GetThinkInterval()
	end
	if self.behavior == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		self.aiTimer = self:GameTimer(0, function()
			if self:_IsReady() then
				if self.funcCondition ~= nil and self:funcCondition(self) ~= true then
					return self:GetThinkInterval()
				end
				local q = self:GetAOERadius()
				if q > 0 then
					local i = FindUnitsInRadius(
						p:GetTeamNumber(),
						p:GetAbsOrigin(),
						nil,
						self:GetAOERadius(),
						self.targetTeam,
						self.targetType,
						self.targetFlags,
						self.orderType,
						false
					)
					if IsValid(i[1]) then
						self:_CastAbilityNoTarget()
					end
				else
					self:_CastAbilityNoTarget()
				end
			end
			return self:GetThinkInterval()
		end)
	elseif self.behavior == DOTA_ABILITY_BEHAVIOR_POINT then
		self.aiTimer = self:GameTimer(0, function()
			if self:_IsReady() then
				if self.funcCondition ~= nil and self:funcCondition(self) ~= true then
					return self:GetThinkInterval()
				end
				local r = self:GetAICastRange()
				local s = vec3_invalid
				if self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE then
					local i = self:SortAITargets(
						FindUnitsInRadius(
							p:GetTeamNumber(),
							p:GetAbsOrigin(),
							nil,
							r,
							self.targetTeam,
							self.targetType,
							self.targetFlags,
							self.orderType,
							false
						)
					)
					if IsValid(i[1]) then
						s = i[1]:GetAbsOrigin()
					end
				elseif self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET then
					s = GetAOEMostTargetsPosition(
						p:GetAbsOrigin(),
						r,
						p:GetTeamNumber(),
						self:GetAOERadius(),
						self.targetTeam,
						self.targetType,
						self.targetFlags,
						self.orderType
					)
				elseif self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET then
					s = GetLinearMostTargetsPosition(
						p:GetAbsOrigin(),
						r,
						p:GetTeamNumber(),
						self:GetLinearStartWidth(),
						self:GetLinearEndWidth(),
						self.targetTeam,
						self.targetType,
						self.targetFlags,
						self.orderType,
						{}
					)
				end
				if s ~= vec3_invalid then
					self:_CastAbilityOnPosition(s)
				end
			end
			return self:GetThinkInterval()
		end)
	elseif self.behavior == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		self.aiTimer = self:GameTimer(0, function()
			if self:_IsReady() then
				if self.funcCondition ~= nil and self:funcCondition(self) ~= true then
					return self:GetThinkInterval()
				end
				local r = self:GetAICastRange()
				local t
				if self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE then
					local i = self:SortAITargets(
						FindUnitsInRadius(
							p:GetTeamNumber(),
							p:GetAbsOrigin(),
							nil,
							r,
							self.targetTeam,
							self.targetType,
							self.targetFlags,
							self.orderType,
							false
						)
					)
					if self.funcUnitsCallback ~= nil then
						i = self:funcUnitsCallback(i)
					end
					if IsValid(i[1]) then
						t = i[1]
					end
				elseif self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET then
					t = GetAOEMostTargetsSpellTarget(
						p:GetAbsOrigin(),
						r,
						p:GetTeamNumber(),
						self:GetAOERadius(),
						self.targetTeam,
						self.targetType,
						self.targetFlags,
						self.orderType
					)
				end
				if t then
					self:_CastAbilityOnTarget(t)
				end
			end
			return self:GetThinkInterval()
		end)
	end
end
function h.prototype._StopThink(self)
	if self.aiTimer then
		self:StopTimer(self.aiTimer)
		self.aiTimer = nil
	end
end
function h.prototype._CastAbilityNoTarget(self)
	self:GetCaster():ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, self)
end
function h.prototype._CastAbilityOnPosition(self, s)
	self:GetCaster():ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, s)
end
function h.prototype._CastAbilityOnTarget(self, t)
	self:GetCaster():ExecuteOrder(DOTA_UNIT_ORDER_CAST_TARGET, self, t)
end
function h.prototype._IsReady(self)
	if self:IsAbilityReady() then
		return true
	end
	return false
end
function h.prototype.GetAOERadius(self)
	return self.aoeRadius or 0
end
function h.prototype.GetAICastRange(self)
	return self:GetEffectiveCastRange(vec3_invalid, nil)
end
function h.prototype.GetLinearStartWidth(self)
	return self.startWidth or 0
end
function h.prototype.GetLinearEndWidth(self)
	return self.endWidth or 0
end
return e