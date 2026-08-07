--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/eom_ability"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("lib.dota_ts_adapter")
local g = f.BaseAbility
local h = f.BaseItem
local i = f.toDotaClassInstance
local j = {}
local function k(self, l, m, n)
	local o = l.name or tostring(l)
	local p = j[o]
	if p == nil then
		p = {}
		j[o] = p
	end
	local q = -1
	do
		local r = 0
		while r < #p do
			if p[r + 1].propertyKey == m then
				q = r
				break
			end
			r = r + 1
		end
	end
	if q ~= -1 then
		p[q + 1].specialValueKey = n
	else
		p[#p + 1] = { propertyKey = m, specialValueKey = n }
	end
end
function e.collectAbilityValueEntries(self, l)
	local s = {}
	local t = l
	while t ~= nil do
		local o = t.name or tostring(t)
		local p = j[o]
		if p ~= nil then
			do
				local r = 0
				while r < #p do
					local u = p[r + 1]
					local v = false
					do
						local w = 0
						while w < #s do
							if s[w + 1].propertyKey == u.propertyKey then
								v = true
								break
							end
							w = w + 1
						end
					end
					if not v then
						s[#s + 1] = u
					end
					r = r + 1
				end
			end
		end
		t = t.____super
	end
	return s
end
function e.AbilityValue(self, n)
	return function(x, y, m)
		local z = m
		local A = n or z
		local l = y.constructor
		if l ~= nil then
			k(nil, l, z, A)
		end
	end
end
e.registerEOMAbility = function(x, B)
	local C = B and B.name
	return function(x, D)
		if C ~= nil then
			D.name = C
		else
			C = D.name
		end
		local E = _G
		E[C] = {}
		i(nil, E[C], D)
		local F = e.collectAbilityValueEntries(nil, D)
		local G = E[C].Spawn
		E[C].Spawn = function(self)
			self.__AbilityValueEntries = F
			self.behavior = B and B.behavior
			self.searchBehavior = B and B.searchBehavior or AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE
			self.aoeRadius = B and B.aoeRadius
			self.startWidth = B and B.startWidth
			self.endWidth = B and B.endWidth
			self.targetTeam = B and B.targetTeam
			self.targetType = B and B.targetType
			self.targetFlags = B and B.targetFlags
			self.funcSortFunction = B and B.funcSortFunction
			self.funcCondition = B and B.funcCondition
			self.funcUnitsCallback = B and B.funcUnitsCallback
			self.isNotPassive = B and B.isNotPassive
			self.orderType = B and B.orderType or FIND_ANY_ORDER
			EntityConstructor(self)
			self.__AbilityValueEntries = F
			if self.__AbilityValueEntries ~= nil then
				do
					local r = 0
					while r < #self.__AbilityValueEntries do
						local u = self.__AbilityValueEntries[r + 1]
						self[u.propertyKey] = self:GetSpecialValueFor(u.specialValueKey)
						r = r + 1
					end
				end
			end
			if IsServer() then
				if (B and B.startLevel) ~= nil then
					if type(B.startLevel) == "function" then
						self:SetLevel(B:startLevel(self))
					else
						self:SetLevel(B.startLevel)
					end
				end
				if (B and B.startCooldown) ~= nil then
					if type(B.startCooldown) == "function" then
						self:StartCooldown(B:startCooldown(self))
					else
						self:StartCooldown(B.startCooldown)
					end
				else
					local H = KeyValues.abilities[self:GetAbilityName()]
					local I
					if H ~= nil then
						I = H.AbilityStartCooldown
					end
					if I ~= nil then
						self:StartCooldown(toFiniteNumber(H.AbilityStartCooldown, 1))
					end
				end
			end
			self:____constructor()
			if G then
				G(self)
			end
		end
		local J = E[C].OnUpgrade
		E[C].OnUpgrade = function(self)
			self.__AbilityValueEntries = F
			if self.__AbilityValueEntries ~= nil then
				do
					local r = 0
					while r < #self.__AbilityValueEntries do
						local u = self.__AbilityValueEntries[r + 1]
						self[u.propertyKey] = self:GetSpecialValueFor(u.specialValueKey)
						r = r + 1
					end
				end
			end
			if J ~= nil then
				J(self)
			end
		end
		local K = E[C].OnSpellStart
		E[C].OnSpellStart = function(self)
			self.__AbilityValueEntries = F
			if self.__AbilityValueEntries ~= nil then
				do
					local r = 0
					while r < #self.__AbilityValueEntries do
						local u = self.__AbilityValueEntries[r + 1]
						self[u.propertyKey] = self:GetSpecialValueFor(u.specialValueKey)
						r = r + 1
					end
				end
			end
			if K ~= nil then
				K(self)
			end
		end
	end
end
e.EOMAbility = c()
local L = e.EOMAbility
L.name = "EOMAbility"
d(L, g)
e.EOMItem = c()
local M = e.EOMItem
M.name = "EOMItem"
d(M, h)
return e