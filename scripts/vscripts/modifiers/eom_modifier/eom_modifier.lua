--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/eom_modifier/eom_modifier"
local b = require("lualib_bundle")
local c = b.__TS__ArrayIncludes
local d = b.__TS__Class
local e = b.__TS__ClassExtends
local f = {}
local g = require("abilities.eom_ability")
local h = g.collectAbilityValueEntries
local i = require("lib.dota_ts_adapter")
local j = i.BaseModifier
local k = i.BaseModifierMotionBoth
local l = i.BaseModifierMotionHorizontal
local m = i.BaseModifierMotionVertical
local n = i.toDotaClassInstance
local o = {}
local function p(self, q, r)
	local s = q.name or tostring(q)
	local t = o[s]
	if t == nil then
		t = {}
		o[s] = t
	end
	if not c(t, r) then
		t[#t + 1] = r
	end
end
local function u(self, q)
	local v = {}
	local w = q
	while w ~= nil do
		local s = w.name or tostring(w)
		local t = o[s]
		if t ~= nil then
			for x, y in ipairs(t) do
				if not c(v, y) then
					v[#v + 1] = y
				end
			end
		end
		w = w.____super
	end
	return v
end
function f.TransmitterData(self)
	return function(x, z, r)
		local A = z.constructor
		if A ~= nil then
			p(nil, A, r)
		end
	end
end
f.registerEOMModifier = function(self, B)
	local y = B and B.name
	local C = self
	return function(x, D)
		if y ~= nil then
			D.name = y
		else
			y = D.name
		end
		local E = _G
		E[y] = {}
		n(nil, E[y], D)
		local F = h(nil, D)
		local G = false
		local H = LUA_MODIFIER_MOTION_NONE
		local I = D.____super
		while I do
			if
				not G
				and (
					I == f.EOMModifier
					or I == f.EOMModifierMotionBoth
					or I == f.EOMModifierMotionHorizontal
					or I == f.EOMModifierMotionVertical
				)
			then
				G = true
			end
			if I == f.EOMModifierMotionBoth or I == k then
				H = LUA_MODIFIER_MOTION_BOTH
				break
			elseif I == f.EOMModifierMotionHorizontal or I == l then
				H = LUA_MODIFIER_MOTION_HORIZONTAL
				break
			elseif I == f.EOMModifierMotionVertical or I == m then
				H = LUA_MODIFIER_MOTION_VERTICAL
				break
			end
			I = I.____super
		end
		local J = E[y]
		local K = u(nil, D)
		local L = J.GetAbilitySpecialValue
		local M = J.OnCreated
		J.OnCreated = function(self, N)
			self:____constructor()
			self.__AbilityValueEntries = F
			self.parent = self:GetParent()
			self.caster = self:GetCaster()
			self.ability = self:GetAbility()
			self.name = y
			if #K > 0 and IsServer() then
				self:SetHasCustomTransmitterData(true)
			end
			if self.__AbilityValueEntries ~= nil then
				do
					local O = 0
					while O < #self.__AbilityValueEntries do
						local P = self.__AbilityValueEntries[O + 1]
						self[P.propertyKey] = self:GetAbilitySpecialValueFor(P.specialValueKey)
						O = O + 1
					end
				end
			end
			if L ~= nil then
				L(self)
			end
			if M ~= nil then
				M(self, N)
			end
			if G and M ~= f.EOMModifier.prototype.OnCreated then
				f.EOMModifier.prototype.OnCreated(self, N)
			end
		end
		local Q = J.OnRefresh
		J.OnRefresh = function(self, N)
			self.caster = self:GetCaster()
			self.ability = self:GetAbility()
			if self.__AbilityValueEntries ~= nil then
				do
					local O = 0
					while O < #self.__AbilityValueEntries do
						local P = self.__AbilityValueEntries[O + 1]
						self[P.propertyKey] = self:GetAbilitySpecialValueFor(P.specialValueKey)
						O = O + 1
					end
				end
			end
			if L ~= nil then
				L(self)
			end
			if Q ~= nil then
				Q(self, N)
			end
			if G and Q ~= f.EOMModifier.prototype.OnRefresh then
				f.EOMModifier.prototype.OnRefresh(self, N)
			end
		end
		local R = J.OnStackCountChanged
		J.OnStackCountChanged = function(self, N)
			if self.__AbilityValueEntries ~= nil then
				do
					local O = 0
					while O < #self.__AbilityValueEntries do
						local P = self.__AbilityValueEntries[O + 1]
						self[P.propertyKey] = self:GetAbilitySpecialValueFor(P.specialValueKey)
						O = O + 1
					end
				end
			end
			if L ~= nil then
				L(self)
			end
			if R ~= nil then
				R(self, N)
			end
			if G and R ~= f.EOMModifier.prototype.OnStackCountChanged then
				f.EOMModifier.prototype.OnStackCountChanged(self, N)
			end
		end
		local S = J.OnDestroy
		J.OnDestroy = function(self)
			if S ~= nil then
				S(self)
			end
			if G and S ~= f.EOMModifier.prototype.OnDestroy then
				f.EOMModifier.prototype.OnDestroy(self)
			end
		end
		local T = J.GetTexture
		J.GetTexture = function(self)
			if T ~= nil then
				return T(self)
			end
			return f.EOMModifier.prototype.GetTexture(self)
		end
		for s, U in pairs(B) do
			if s ~= "name" and type(J[s]) ~= "function" then
				J[s] = function()
					return U
				end
			end
		end
		if #K > 0 then
			local V = J.AddCustomTransmitterData
			J.AddCustomTransmitterData = function(self)
				local W
				if V ~= nil then
					W = V(self)
				else
					W = nil
				end
				local X = W
				if X == nil then
					X = {}
				end
				for x, Y in ipairs(K) do
					X[Y] = self[Y]
				end
				return X
			end
			local Z = J.HandleCustomTransmitterData
			J.HandleCustomTransmitterData = function(self, _)
				if _ ~= nil then
					for x, Y in ipairs(K) do
						if _[Y] ~= nil then
							if type(_[Y]) == "userdata" then
								local a0 = tonumber(tostring(_[Y])) or 0
								self[Y] = a0
								if self.OnTransmitterDataUpdated ~= nil then
									self:OnTransmitterDataUpdated(Y, a0)
								end
							else
								self[Y] = _[Y]
								if self.OnTransmitterDataUpdated ~= nil then
									self:OnTransmitterDataUpdated(Y, _[Y])
								end
							end
						end
					end
				end
				if Z ~= nil then
					Z(self, _)
				end
			end
		end
		local a1 = {}
		local a2 = J.DeclareFunctions
		local function a3(self, a4, a5)
			for a6, U in pairs(a4) do
				do
					local a7 = MODIFIER_FUNCTION_MAP[a6]
					if a7 == nil then
						goto a8
					end
					a1[#a1 + 1] = a6
					local a9 = J[a7]
					if type(a9) ~= "function" then
						if a5 and type(U) == "function" then
							J[a7] = function(self, aa)
								return U:call(self, aa)
							end
						else
							J[a7] = function()
								return U
							end
						end
					end
				end
				::a8::
			end
		end
		if J.StaticDeclare ~= nil then
			local ab = J:StaticDeclare()
			a3(nil, ab, false)
		end
		if J.DynamicDeclare ~= nil then
			local ac = J:DynamicDeclare()
			a3(nil, ac, true)
		end
		if #a1 > 0 or a2 ~= nil then
			J.DeclareFunctions = function(self)
				local a0 = a2 ~= nil and (a2(self) or {}) or {}
				do
					local O = 0
					while O < #a1 do
						local ad = a1[O + 1]
						local ae = false
						do
							local af = 0
							while af < #a0 do
								if a0[af + 1] == ad then
									ae = true
									break
								end
								af = af + 1
							end
						end
						if not ae then
							a0[#a0 + 1] = ad
						end
						O = O + 1
					end
				end
				return a0
			end
		end
		if C and #C > 0 then
			LinkLuaModifier(y, C, H)
		end
	end
end
f.EOMModifier = d()
local ag = f.EOMModifier
ag.name = "EOMModifier"
e(ag, j)
function ag.prototype.RegisterStaticProperties(self)
	if self.StaticProperty == nil then
		return
	end
	local ah = self:GetParent():entindex()
	local ai = self:GetName()
	local aj = self:StaticProperty()
	for ak, U in pairs(aj) do
		if PROPERTY_MAP_REVERSE[ak] then
			PropertySystem:AddStaticProperty(ah, PROPERTY_MAP_REVERSE[ak], ai, U)
		end
	end
end
function ag.prototype.RegisterDynamicStates(self)
	if self.DynamicState == nil then
		return
	end
	local ah = self:GetParent():entindex()
	local ai = self:GetName()
	local al = self:DynamicState()
	for am, an in pairs(al) do
		StateSystem:RegisterDynamicState(ah, am, ai, an)
	end
end
function ag.prototype.RegisterStaticStates(self)
	if self.StaticState == nil then
		return
	end
	local ah = self:GetParent():entindex()
	local ai = self:GetName()
	local ao = self:StaticState()
	for am, U in pairs(ao) do
		StateSystem:AddStaticState(ah, am, ai, U, self:GetPriority())
	end
end
function ag.prototype.OnCreated(self, aa)
	if self._bDestroyed == true then
		return
	end
	local ap = false
	local ah = self:GetParent():entindex()
	local ai = self:GetName()
	if self.DynamicProperty ~= nil then
		local aq = self:DynamicProperty()
		for ak, an in pairs(aq) do
			if PROPERTY_MAP_REVERSE[ak] then
				PropertySystem:RegisterDynamicProperty(ah, PROPERTY_MAP_REVERSE[ak], ai, an)
			end
		end
	end
	self:RegisterStaticProperties()
	self:RegisterDynamicStates()
	self:RegisterStaticStates()
	if IsServer() then
		if ap then
			local ar = self:GetParent()
			local as
			if ar:IsHero() then
				as = ar:CalculateStatBonus(true)
			else
				as = ar:CalculateGenericBonuses()
			end
		end
		if self.EventListener ~= nil then
			if self.__EventIDList == nil then
				self.__EventIDList = {}
			end
			for at, au in pairs(self:EventListener()) do
				local av = self.__EventIDList
				av[#av + 1] = Event:RegisterForOwner(at, au, self:GetParent())
			end
		end
	end
end
function ag.prototype.OnRefresh(self, aa)
	if self._bDestroyed == true then
		return
	end
	local ap = false
	local ai = self:GetName()
	self:RegisterStaticProperties()
	self:RegisterStaticStates()
	if IsServer() then
		if ap then
			local ar = self:GetParent()
			local aw
			if ar:IsHero() then
				aw = ar:CalculateStatBonus(true)
			else
				aw = ar:CalculateGenericBonuses()
			end
		end
	end
end
function ag.prototype.OnStackCountChanged(self, ax)
	if self._bDestroyed == true then
		return
	end
	local ap = false
	local ai = self:GetName()
	self:RegisterStaticProperties()
	self:RegisterStaticStates()
	if IsServer() then
		if ap then
			local ar = self:GetParent()
			local ay
			if ar:IsHero() then
				ay = ar:CalculateStatBonus(true)
			else
				ay = ar:CalculateGenericBonuses()
			end
		end
	end
end
function ag.prototype.OnDestroy(self)
	self._bDestroyed = true
	local ap = false
	local ar = self:GetParent()
	local ai = self:GetName()
	local ah = self:GetParent():entindex()
	PropertySystem:RemoveStaticProperty(ah, ai)
	PropertySystem:UnregisterDynamicProperty(ah, ai)
	StateSystem:RemoveStaticState(ah, ai)
	StateSystem:UnregisterDynamicState(ah, ai)
	if IsServer() then
		if ap and IsValid(ar) then
			local az
			if ar:IsHero() then
				az = ar:CalculateStatBonus(true)
			else
				az = ar:CalculateGenericBonuses()
			end
		end
		if self.__EventIDList ~= nil then
			for O, aA in ipairs(self.__EventIDList) do
				Event:Unregister(aA)
			end
			self.__EventIDList = nil
		end
	end
end
f.EOMModifierMotionHorizontal = d()
local aB = f.EOMModifierMotionHorizontal
aB.name = "EOMModifierMotionHorizontal"
e(aB, f.EOMModifier)
f.EOMModifierMotionVertical = d()
local aC = f.EOMModifierMotionVertical
aC.name = "EOMModifierMotionVertical"
e(aC, f.EOMModifier)
f.EOMModifierMotionBoth = d()
local aD = f.EOMModifierMotionBoth
aD.name = "EOMModifierMotionBoth"
e(aD, f.EOMModifier)
return f