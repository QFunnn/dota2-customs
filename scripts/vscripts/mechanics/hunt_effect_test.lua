--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/hunt_effect_test"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ObjectKeys
local e = b.__TS__ArrayMap
local f = b.__TS__New
local g = b.__TS__Delete
local h = b.__TS__ArrayFilter
local i = b.__TS__ArraySetLength
local j = b.__TS__ArrayIncludes
local k = {}
local l = require("mechanics.hunt_field_config")
local m = l.HUNT_FIXED_MODIFIERS
local n = l.GetHuntFieldBuffConfig
local o = l.GetHuntFieldEffectError
local p = require("mechanics.hunt_field_effects")
local q = p.CHuntFieldEffects
local r = require("modifiers.hunt_boss.modifier_hunt_potion")
local s = r.GetHuntPotionController
local t = require("class.dungeon_helper")
local u = t.AnalyzeCenterPositions
k.CHuntEffectTestSession = c()
local v = k.CHuntEffectTestSession
v.name = "CHuntEffectTestSession"
function v.prototype.____constructor(self, w, x)
	self.randomEffects = {}
	self.endingEffects = {}
	self.endingPotions = {}
	self.validGridPositions = {}
	self.nextTargetLogAt = 0
	self.hero = w
	self.playerID = x
end
function v.Catalog(self)
	local y = {}
	for z, A in ipairs(d(KeyValues.hunt_field_buff or {})) do
		local B = n(nil, A)
		if B ~= nil and (m[A] ~= nil or A == "potion" or q:Supports(A) and o(nil, A, B.params) == nil) then
			y[#y + 1] = { id = A, level = B.level }
		end
	end
	return y
end
function v.prototype.Has(self, A)
	if A == "potion" then
		return IsValid(self.potion)
	end
	local C = m[A]
	if C ~= nil then
		return IsValid(self.hero) and self.hero:HasModifier(C)
	end
	return self.randomEffects[A] ~= nil
end
function v.prototype.Add(self, A)
	self:Log("add requested id=" .. A)
	if not IsValid(self.hero) or not self.hero:IsAlive() then
		self:Log(("add rejected id=" .. A) .. ": hero invalid or dead")
		return false
	end
	local B = n(nil, A)
	if B == nil then
		self:Log(("add rejected id=" .. A) .. ": config missing or invalid")
		return false
	end
	if B.type == 2 then
		local D = o(nil, A, B.params)
		if D ~= nil then
			self:Log((("add rejected id=" .. A) .. ": ") .. D)
			return false
		end
	end
	if self:Has(A) then
		self:Log(("add ignored id=" .. A) .. ": already added, timer unchanged")
		return true
	end
	self:Log(
		(
			((((("config id=" .. A) .. " type=") .. tostring(B.type)) .. " firstDelay=") .. tostring(B.time))
			.. " params="
		) .. table.concat(
				e(d(B.params), function(z, E)
					return (E .. ":") .. tostring(B.params[E])
				end),
				"|"
			)
	)
	local C = m[A]
	if B.type == 1 and C ~= nil then
		self.hero:AddNewModifier(
			self.hero,
			nil,
			C,
			{ reducePct = B.params.ReducePct or 0, freezePct = B.params.FreezePct or 400 }
		)
		local F = self:Has(A)
		self:Log((((("fixed modifier id=" .. A) .. " name=") .. C) .. " added=") .. tostring(F))
		return F
	end
	if A == "potion" then
		local F = self:AddPotion(B)
		self:Log("potion added=" .. tostring(F))
		return F
	end
	if B.type ~= 2 or not q:Supports(A) then
		self:Log((("add rejected id=" .. A) .. ": unsupported effect type=") .. tostring(B.type))
		return false
	end
	self:EnsurePositions()
	if not self:EnsureTarget() then
		self:Log(("add rejected id=" .. A) .. ": no battle enemy or test target")
		return false
	end
	local G = f(q, { B }, {
		center = self.center,
		validGridPositions = self.validGridPositions,
		heroes = function()
			return IsValid(self.hero) and { self.hero } or {}
		end,
		enemies = function()
			return self:Enemies()
		end,
		debugLog = function(z, H)
			return self:Log((("id=" .. A) .. " ") .. H)
		end,
	})
	self.randomEffects[A] = G
	G:SetPaused(false)
	self:Log(((("controller added id=" .. A) .. ", first trigger after ") .. tostring(B.time)) .. "s of battle time")
	return true
end
function v.prototype.Remove(self, A, I)
	if I == nil then
		I = false
	end
	if self:Has(A) then
		self:Log("remove id=" .. A)
	end
	local C = m[A]
	if C ~= nil and IsValid(self.hero) then
		self.hero:RemoveModifierByName(C)
	end
	if A == "potion" then
		local J = self.potion
		self.potion = nil
		if IsValid(J) then
			if I then
				J:RemoveModifierByName("modifier_hunt_potion")
			else
				local K = s(nil, J)
				if K ~= nil then
					K:SetStackCount(2)
				end
				local L = self.endingPotions
				L[#L + 1] = J
			end
		end
	end
	local G = self.randomEffects[A]
	g(self.randomEffects, A)
	if G ~= nil then
		if I then
			G:Dispose()
		else
			G:Stop()
			if not G:IsDisposed() then
				local M = self.endingEffects
				M[#M + 1] = G
			end
		end
	end
	self:CleanupFinishedEffects()
end
function v.prototype.Clear(self, I)
	if I == nil then
		I = false
	end
	for z, A in ipairs(d(m)) do
		self:Remove(A, I)
	end
	self:Remove("potion", I)
	for z, A in ipairs(d(self.randomEffects)) do
		self:Remove(A, I)
	end
	if I then
		for z, G in ipairs(self.endingEffects) do
			G:Dispose()
		end
		self.endingEffects = {}
		for z, J in ipairs(self.endingPotions) do
			if IsValid(J) then
				J:RemoveModifierByName("modifier_hunt_potion")
			end
		end
		self.endingPotions = {}
	end
	self:CleanupFinishedEffects()
end
function v.prototype.Snapshot(self)
	local N = k.CHuntEffectTestSession:Catalog()
	return {
		hero_ent_index = self.hero:entindex(),
		effects = N,
		active_ids = e(
			h(N, function(z, G)
				return self:Has(G.id)
			end),
			function(z, G)
				return G.id
			end
		),
		target_ent_index = IsValid(self.target) and self.target:entindex() or nil,
	}
end
function v.prototype.Maintain(self)
	self:CleanupFinishedEffects()
	if (#d(self.randomEffects) > 0 or #self.endingEffects > 0) and IsValid(self.hero) and self.hero:IsAlive() then
		self:EnsureTarget()
	end
end
function v.prototype.CleanupFinishedEffects(self)
	self.endingEffects = h(self.endingEffects, function(z, G)
		return not G:IsDisposed()
	end)
	self.endingPotions = h(self.endingPotions, function(z, J)
		return IsValid(J) and J:HasModifier("modifier_hunt_potion")
	end)
	if #d(self.randomEffects) == 0 and #self.endingEffects == 0 then
		self:RemoveTarget()
		if not IsValid(self.potion) and #self.endingPotions == 0 then
			i(self.validGridPositions, 0)
			self.center = nil
		end
	end
end
function v.prototype.Enemies(self)
	if not IsValid(self.hero) or self.center == nil then
		return {}
	end
	return h(
		FindUnitsInRadius(
			self.hero:GetTeamNumber(),
			self.center,
			nil,
			1400,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			FIND_ANY_ORDER,
			false
		),
		function(z, O)
			return IsValid(O)
				and O:IsAlive()
				and (O:GetUnitName() ~= "npc_hunt_effect_test_target" or O == self.target)
				and not j(
					{ "npc_dota_thinker", "npc_hunt_field_totem", "npc_hunt_field_hunter", "npc_hunt_field_auxiliary" },
					O:GetUnitName()
				)
		end
	)
end
function v.prototype.EnsureTarget(self)
	if #self:Enemies() > 0 then
		return true
	end
	if self.center == nil then
		return false
	end
	local P = GetRandomElement(h(self.validGridPositions, function(z, Q)
		local R = CalcDistance(Q, self.hero:GetAbsOrigin())
		return R >= 400 and R <= 700 and GridNav:IsValidPosition(Q)
	end))
	if P == nil then
		self:LogTargetFailure(
			(
				("no valid test target position 400..700 from hero; grids=" .. tostring(#self.validGridPositions))
				.. " heroPosition="
			) .. VectorToString(self.hero:GetAbsOrigin())
		)
		return false
	end
	self:RemoveTarget()
	local S = CreateUnitByName("npc_hunt_effect_test_target", P, true, self.hero, self.hero, DOTA_TEAM_BADGUYS)
	if not IsValid(S) then
		self:LogTargetFailure("CreateUnitByName failed: npc_hunt_effect_test_target position=" .. VectorToString(P))
		return false
	end
	self.target = S
	S:SetControllableByPlayer(self.playerID, false)
	S:AddNewModifier(S, nil, "modifier_ai_disabled", {})
	self:Log((("test target created unit=" .. tostring(S:entindex())) .. " position=") .. VectorToString(P))
	return true
end
function v.prototype.RemoveTarget(self)
	local S = self.target
	self.target = nil
	if IsValid(S) then
		UTIL_Remove(S)
	end
end
function v.prototype.AddPotion(self, B)
	local T = B.params
	if not (T.Interval > 0 and T.Count > 0 and T.Lifetime > 0) then
		return false
	end
	self:EnsurePositions()
	local J = CreateModifierThinker(
		self.hero,
		nil,
		"modifier_hunt_potion",
		{
			firstDelay = B.time,
			interval = T.Interval,
			count = T.Count,
			lifetime = T.Lifetime,
			item_health_potion_1 = T.item_health_potion_1 or 0,
			item_health_potion_2 = T.item_health_potion_2 or 0,
			item_health_potion_3 = T.item_health_potion_3 or 0,
			testPlayerID = self.playerID,
		},
		self.center,
		DOTA_TEAM_NEUTRALS,
		false
	)
	if not IsValid(J) then
		return false
	end
	local U = s(nil, J)
	if U == nil then
		UTIL_Remove(J)
		return false
	end
	U:SetSpawnContext(self.validGridPositions, function()
		return IsValid(self.hero) and { self.hero } or {}
	end)
	self.potion = J
	U:SetStackCount(1)
	return true
end
function v.prototype.EnsurePositions(self)
	if self.center ~= nil then
		return
	end
	local P = self.hero:GetAbsOrigin()
	self.center = Vector(P.x, P.y, P.z)
	self.validGridPositions = u(nil, { center = self.center, rings = 3, gridSize = GRID_SIZE })
	self:Log((("positions center=" .. VectorToString(self.center)) .. " grids=") .. tostring(#self.validGridPositions))
end
function v.prototype.LogTargetFailure(self, H)
	local V = GameRules:GetGameTime()
	if V < self.nextTargetLogAt then
		return
	end
	self.nextTargetLogAt = V + 5
	self:Log("target blocked: " .. H)
end
function v.prototype.Log(self, H)
	print(
		(
			(
				(("[HuntEffectTest] player=" .. tostring(self.playerID)) .. " hero=")
				.. tostring(IsValid(self.hero) and self.hero:entindex() or -1)
			) .. " "
		) .. H
	)
end
return k