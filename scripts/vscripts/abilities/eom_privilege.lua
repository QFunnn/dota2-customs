--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/eom_privilege"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayIncludes
local e = b.__TS__New
local f = b.__TS__ObjectKeys
local g = {}
local h, i
function h(self, j, k)
	if i[j] then
	end
	i[j] = k
end
local l = {}
local function m(self, n, o, p)
	local q = n.name or tostring(n)
	local r = l[q]
	if r == nil then
		r = {}
		l[q] = r
	end
	local s = -1
	do
		local t = 0
		while t < #r do
			if r[t + 1].propertyKey == o then
				s = t
				break
			end
			t = t + 1
		end
	end
	if s ~= -1 then
		r[s + 1].specialValueKey = p
	else
		r[#r + 1] = { propertyKey = o, specialValueKey = p }
	end
end
function g.collectPrivilegeValueEntries(self, n)
	local u = {}
	local v = n
	while v ~= nil do
		local q = v.name or tostring(v)
		local r = l[q]
		if r ~= nil then
			do
				local t = 0
				while t < #r do
					local w = r[t + 1]
					local x = false
					do
						local y = 0
						while y < #u do
							if u[y + 1].propertyKey == w.propertyKey then
								x = true
								break
							end
							y = y + 1
						end
					end
					if not x then
						u[#u + 1] = w
					end
					t = t + 1
				end
			end
		end
		v = v.____super
	end
	return u
end
function g.PrivilegeValue(self, p)
	return function(z, A, o)
		local B = o
		local C = p or B
		local n = A.constructor
		if n ~= nil then
			m(nil, n, B, C)
		end
	end
end
g.EOMPrivilege = c()
local D = g.EOMPrivilege
D.name = "EOMPrivilege"
function D.prototype.____constructor(self, E, F, G, H, I)
	self.lastUseTime = 0
	self._bAlreadyDestroyed = false
	self._timerInterval = -1
	self._ThinkList = {}
	self.privilegeName = E
	self.playerID = G
	self.level = F
	self.caster = H
	self.specialValueOverrides = I
	self.__PrivilegeValueEntries = g.collectPrivilegeValueEntries(nil, self.constructor)
	local J = self:GetCaster()
	if IsServer() then
		if self.EventListener ~= nil then
			if self.__EventIDList == nil then
				self.__EventIDList = {}
			end
			for K, L in pairs(self:EventListener()) do
				local M = self.__EventIDList
				M[#M + 1] = Event:RegisterWithPriority(K, L, self:GetPriority())
			end
		end
		if J and self.StaticProperty ~= nil then
			for N, O in pairs(self:StaticProperty()) do
				if PROPERTY_MAP_REVERSE[N] then
					PropertySystem:AddStaticProperty(J:entindex(), PROPERTY_MAP_REVERSE[N], self.privilegeName, O)
				end
			end
		end
		if J and self.DynamicProperty ~= nil then
			for N, P in pairs(self:DynamicProperty()) do
				if PROPERTY_MAP_REVERSE[N] then
					PropertySystem:RegisterDynamicProperty(J:entindex(), PROPERTY_MAP_REVERSE[N], self.privilegeName, P)
				end
			end
		end
	end
	self:RefreshPrivilegeValues()
end
function D.prototype.OnCreated(self) end
function D.prototype.OnRefresh(self)
	self:RefreshPrivilegeValues()
end
function D.prototype.RefreshPrivilegeValues(self)
	if self.__PrivilegeValueEntries ~= nil then
		for z, w in ipairs(self.__PrivilegeValueEntries) do
			self[w.propertyKey] = self:GetSpecialValueFor(w.specialValueKey)
		end
	end
end
function D.prototype.OnDestroy(self)
	local H = self:GetCaster()
	if H then
		PropertySystem:RemoveStaticProperty(H:entindex(), self.privilegeName)
		PropertySystem:UnregisterDynamicProperty(H:entindex(), self.privilegeName)
	end
	if self.__EventIDList ~= nil then
		for t, Q in ipairs(self.__EventIDList) do
			Event:Unregister(Q)
		end
		self.__EventIDList = nil
	end
	self:StopAllThinks()
	self._bAlreadyDestroyed = true
end
function D.prototype.StartCooldown(self, R)
	self.lastUseTime = GameRules:GetGameTime() + R
end
function D.prototype.IsCooldownReady(self)
	if self.lastUseTime == 0 then
		return true
	end
	return GameRules:GetGameTime() >= self.lastUseTime
end
function D.prototype.GetCooldownTimeRemaining(self)
	if self.lastUseTime == 0 then
		return 0
	end
	local S = GameRules:GetGameTime()
	local T = self.lastUseTime - S
	return math.max(0, T)
end
function D.prototype.ResetCooldown(self)
	self.lastUseTime = 0
end
function D.prototype.IncrementStackCount(self, U, V)
	if self.__StackCount == nil then
		self.__StackCount = 0
	end
	self.__StackCount = self.__StackCount + (U or 1)
	self:RefreshStaticProperty()
end
function D.prototype.DecrementStackCount(self, U, V)
	if self.__StackCount == nil then
		self.__StackCount = 0
	end
	self.__StackCount = self.__StackCount - (U or 1)
	self:RefreshStaticProperty()
end
function D.prototype.SetStackCount(self, W, V)
	self.__StackCount = W
	self:RefreshStaticProperty()
end
function D.prototype.GetStackCount(self)
	return self.__StackCount or 0
end
function D.prototype.PRD(self, X, Y)
	return PRD(nil, self, X, Y or self.privilegeName)
end
function D.prototype.RefreshStaticProperty(self)
	local H = self:GetCaster()
	if not H then
		return
	end
	if self.StaticProperty ~= nil then
		for N, O in pairs(self:StaticProperty()) do
			if PROPERTY_MAP_REVERSE[N] then
				PropertySystem:AddStaticProperty(H:entindex(), PROPERTY_MAP_REVERSE[N], self.privilegeName, O)
			end
		end
	end
end
function D.prototype.GetCaster(self)
	if self.caster ~= nil and IsValid(self.caster) then
		return self.caster
	end
	return PlayerResource:GetSelectedHeroEntity(self.playerID)
end
function D.prototype.GetPlayerID(self)
	return self.playerID
end
function D.prototype.SetLevel(self, Z)
	self.level = Z
	self:OnRefresh()
end
function D.prototype.GetSpecialValueFor(self, _)
	local a0 = self.specialValueOverrides
	local a1 = a0 and a0[_]
	if a1 ~= nil then
		return a1
	end
	return Privilege:GetPrivilegeSpecialValue(self.privilegeName, self.level, _, self:GetCaster())
end
function D.prototype.IsValidPrivilege(self)
	if self._bAlreadyDestroyed then
		return false
	end
	return true
end
function D.prototype.GetPriority(self)
	local a2 = toFiniteNumber
	local a3 = KeyValues.privilegeKv[self.privilegeName]
	if a3 ~= nil then
		a3 = a3.Priority
	end
	return a2(a3, 100)
end
function D.prototype.GetUnavailableArtifactNames(self)
	local a4 = self:GetCaster()
	if not IsValid(a4) then
		return {}
	end
	local a5 = {}
	for a6, a7 in pairs(KeyValues.items) do
		local a8 = toFiniteNumber(a7.Quantitylimit, 0)
		if a8 > 0 and a4:GetItemCount(a6) >= a8 then
			self:AppendExcludedArtifact(a5, a6)
		end
	end
	local a9 = a4:GetAllItems()
	do
		local t = 0
		while t < #a9 do
			do
				local aa = a9[t + 1]
				if not IsValid(aa) then
					goto ab
				end
				self:AppendUpgradeGroupArtifacts(a5, aa:GetAbilityName())
			end
			::ab::
			t = t + 1
		end
	end
	return a5
end
function D.prototype.AppendUpgradeGroupArtifacts(self, a5, a6)
	local ac = tostring
	local ad = KeyValues.items[a6]
	if ad ~= nil then
		ad = ad.UpgradeGroup
	end
	local ae = ad
	if ae == nil then
		ae = ""
	end
	local af = ac(ae)
	if af == "" then
		return
	end
	for ag, ah in pairs(KeyValues.items) do
		local ai = tostring
		local aj = ah.UpgradeGroup
		if aj == nil then
			aj = ""
		end
		if ai(aj) == af then
			self:AppendExcludedArtifact(a5, ag)
		end
	end
end
function D.prototype.AppendExcludedArtifact(self, a5, a6)
	if not d(a5, a6) then
		a5[#a5 + 1] = a6
	end
end
function D.prototype.StartThink(self, ak, al, am)
	if type(al) == "function" and am == nil then
		am = al
		al = nil
	end
	local an = al or DoUniqueString("PrivilegeThink")
	if ak == -1 then
		if self._ThinkList[an] then
			Timer:StopTimer(self._ThinkList[an])
			self._ThinkList[an] = nil
		end
		return an
	end
	if self._ThinkList[an] ~= nil then
		Timer:StopTimer(self._ThinkList[an])
	end
	local ao = Timer:GameTimer(ak, function()
		if not self:IsValidPrivilege() then
			self._ThinkList[an] = nil
			return
		end
		local ap
		if am ~= nil then
			ap = am(nil, self, an)
		elseif self.OnThink ~= nil then
			ap = self:OnThink(an)
		end
		if ap == -1 then
			Timer:StopTimer(self._ThinkList[an])
			self._ThinkList[an] = nil
			return
		end
		return ap
	end)
	self._ThinkList[an] = ao
	return an
end
function D.prototype.OnThink(self, al) end
function D.prototype.StopAllThinks(self)
	for al, aq in pairs(self._ThinkList) do
		Timer:StopTimer(aq)
	end
	self._ThinkList = {}
end
g.RegisterPrivilege = function(z, j)
	return function(self, k)
		local al = j or k.name
		h(nil, al, k)
		return k
	end
end
i = {}
function g.CreatePrivilegeInstance(self, j, E, F, G, H, I)
	local ar = i[j]
	if not ar then
		print("[PrivilegeDecorator] Class not found: " .. j)
		return nil
	end
	local as = e(ar, E, F, G, H, I)
	return as
end
function g.GetAllRegisteredPrivilegeNames(self)
	return f(i)
end
return g