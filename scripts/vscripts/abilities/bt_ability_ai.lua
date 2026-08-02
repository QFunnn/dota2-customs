--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bt_ability_ai"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("abilities.eom_ability")
local g = f.EOMAbility
local h = { 50 }
e.EOMBTAbilityAI = c()
local i = e.EOMBTAbilityAI
i.name = "EOMBTAbilityAI"
d(i, g)
function i.prototype.____constructor(self, ...)
	g.prototype.____constructor(self, ...)
	self.warnParticleId = {}
end
function i.prototype.SortAITargets(self, j)
	table.sort(j, function(k, l)
		local m = k:IsBreakable()
		local n = l:IsBreakable()
		if m ~= n then
			return n
		end
		if self.funcSortFunction ~= nil then
			return self:funcSortFunction(k, l)
		end
		return false
	end)
	return j
end
function i.prototype.Spawn(self)
	if IsServer() then
		self:ParseBehavior()
	end
end
function i.prototype.CreateSectorWarningParticle(self, o, p, q)
	local r = ParticleManager:CreateParticle("particles/warning/sector.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(r, 0, o, p)
	ParticleManager:SetParticleControl(r, 1, Vector(self:GetAOERadius(), q, self:GetCastPoint()))
	local s = self.warnParticleId
	s[#s + 1] = r
end
function i.prototype.CreateRadiusWarningParticle(self, t, u)
	local v = self:GetCaster()
	if t == nil then
		t = self:GetCursorPosition()
		if self.behavior == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
			t = v:GetAbsOrigin()
		end
	end
	local w = self:GetAOERadius()
	local r = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, v)
	ParticleManager:SetParticleControl(r, 0, t)
	ParticleManager:SetParticleControl(r, 1, t)
	ParticleManager:SetParticleControl(r, 2, Vector(w, u or self:GetCastPoint(), 0))
	local x = self.warnParticleId
	x[#x + 1] = r
end
function i.prototype.CreateLinerWarningParticle(self, y, z, u)
	local r = ParticleManager:CreateParticle("particles/warning/linear.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(r, 0, y)
	ParticleManager:SetParticleControl(r, 1, z)
	ParticleManager:SetParticleControl(r, 2, Vector(self:GetLinearStartWidth(), u or self:GetCastPoint(), 0))
	local A = self.warnParticleId
	A[#A + 1] = r
end
function i.prototype.DestroyWarningParticle(self, B)
	if B == nil then
		B = false
	end
	for C, D in ipairs(self.warnParticleId) do
		ParticleManager:DestroyParticle(D, B)
		ParticleManager:ReleaseParticleIndex(D)
	end
	self.warnParticleId = {}
end
function i.prototype.ParseBehavior(self)
	if not self:IsPassive() and self.behavior == nil then
		local E = self:GetBehaviorInt()
		if bit.band(E, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
			self.behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET
		elseif bit.band(E, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
			self.behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
		elseif bit.band(E, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
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
		self.targetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	end
end
function i.prototype.AutoSpell(self)
	local v = self:GetCaster()
	if v:HasState(StateEnum.AI_DISABLED) then
		return false
	end
	if v:IsChanneling() then
		return false
	end
	if self.behavior == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		if self:_IsReady() then
			if self.funcCondition ~= nil and self:funcCondition() ~= true then
				return false
			end
			local F = self:GetAOERadius()
			if F > 0 then
				local j = FindUnitsInRadius(
					v:GetTeamNumber(),
					v:GetAbsOrigin(),
					nil,
					self:GetAOERadius(),
					self.targetTeam,
					self.targetType,
					self.targetFlags,
					self.orderType,
					false
				)
				if IsValid(j[1]) then
					self:_CastAbilityNoTarget()
					return true
				end
			else
				self:_CastAbilityNoTarget()
				return true
			end
		end
	elseif self.behavior == DOTA_ABILITY_BEHAVIOR_POINT then
		if self:_IsReady() then
			if self.funcCondition ~= nil and self:funcCondition() ~= true then
				return false
			end
			local G = self:GetEffectiveCastRange(vec3_invalid, nil)
			local H = vec3_invalid
			if self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE then
				local j = self:SortAITargets(
					FindUnitsInRadius(
						v:GetTeamNumber(),
						v:GetAbsOrigin(),
						nil,
						G,
						self.targetTeam,
						self.targetType,
						self.targetFlags,
						self.orderType,
						false
					)
				)
				if IsValid(j[1]) then
					H = j[1]:GetAbsOrigin()
				end
			elseif self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET then
				H = GetAOEMostTargetsPosition(
					v:GetAbsOrigin(),
					G,
					v:GetTeamNumber(),
					self:GetAOERadius(),
					self.targetTeam,
					self.targetType,
					self.targetFlags,
					self.orderType
				)
			elseif self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_LINE_TARGET then
				H = GetLinearMostTargetsPosition(
					v:GetAbsOrigin(),
					G,
					v:GetTeamNumber(),
					self:GetLinearStartWidth(),
					self:GetLinearEndWidth(),
					self.targetTeam,
					self.targetType,
					self.targetFlags,
					self.orderType,
					{}
				)
			end
			if H ~= vec3_invalid then
				self:_CastAbilityOnPosition(H)
				return true
			end
		end
	elseif self.behavior == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		if self:_IsReady() then
			if self.funcCondition ~= nil and self:funcCondition() ~= true then
				return false
			end
			local G = self:GetEffectiveCastRange(vec3_invalid, nil)
			local I
			if self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE then
				local j = self:SortAITargets(
					FindUnitsInRadius(
						v:GetTeamNumber(),
						v:GetAbsOrigin(),
						nil,
						G,
						self.targetTeam,
						self.targetType,
						self.targetFlags,
						self.orderType,
						false
					)
				)
				if self.funcUnitsCallback ~= nil then
					j = self:funcUnitsCallback(j)
				end
				if IsValid(j[1]) then
					I = j[1]
				end
			elseif self.searchBehavior == AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET then
				I = GetAOEMostTargetsSpellTarget(
					v:GetAbsOrigin(),
					G,
					v:GetTeamNumber(),
					self:GetAOERadius(),
					self.targetTeam,
					self.targetType,
					self.targetFlags,
					self.orderType
				)
			end
			if I then
				self:_CastAbilityOnTarget(I)
				return true
			end
		end
	end
	return false
end
function i.prototype.CheckLevelUpgrade(self)
	local J = self:GetLevel()
	local K = #h
	if K == 0 or J <= 0 or J > K then
		return
	end
	local L = self:GetCaster():GetHealthPercent()
	if L > h[J] then
		return
	end
	do
		local M = K - 1
		while M >= 0 do
			if L <= h[M + 1] then
				self:SetLevel(M + 2)
				break
			end
			M = M - 1
		end
	end
end
function i.prototype._CastAbilityNoTarget(self)
	self:GetCaster():RemoveModifierByName("modifier_face_move")
	self:CheckLevelUpgrade()
	self:GetCaster():ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, self)
end
function i.prototype._CastAbilityOnPosition(self, H)
	self:GetCaster():RemoveModifierByName("modifier_face_move")
	self:CheckLevelUpgrade()
	self:GetCaster():ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, H)
end
function i.prototype._CastAbilityOnTarget(self, I)
	self:GetCaster():RemoveModifierByName("modifier_face_move")
	self:CheckLevelUpgrade()
	self:GetCaster():ExecuteOrder(DOTA_UNIT_ORDER_CAST_TARGET, self, I)
end
function i.prototype._IsReady(self)
	if self:IsAbilityReady() then
		return true
	end
	return false
end
function i.prototype.GetAOERadius(self)
	return self.aoeRadius or 0
end
function i.prototype.GetLinearStartWidth(self)
	return self.startWidth or 0
end
function i.prototype.GetLinearEndWidth(self)
	return self.endWidth or 0
end
return e