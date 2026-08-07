--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
function D.prototype.____constructor(self, E, F, G)
	self.lastUseTime = 0
	self._bAlreadyDestroyed = false
	self._timerInterval = -1
	self._ThinkList = {}
	self.privilegeName = E
	self.playerID = G
	self.level = F
	self.__PrivilegeValueEntries = g.collectPrivilegeValueEntries(nil, self.constructor)
	local H = self:GetCaster()
	if IsServer() then
		if self.EventListener ~= nil then
			if self.__EventIDList == nil then
				self.__EventIDList = {}
			end
			for I, J in pairs(self:EventListener()) do
				local K = self.__EventIDList
				K[#K + 1] = Event:RegisterWithPriority(I, J, self:GetPriority())
			end
		end
		if H and self.StaticProperty ~= nil then
			for L, M in pairs(self:StaticProperty()) do
				if PROPERTY_MAP_REVERSE[L] then
					PropertySystem:AddStaticProperty(H:entindex(), PROPERTY_MAP_REVERSE[L], self.privilegeName, M)
				end
			end
		end
		if H and self.DynamicProperty ~= nil then
			for L, N in pairs(self:DynamicProperty()) do
				if PROPERTY_MAP_REVERSE[L] then
					PropertySystem:RegisterDynamicProperty(H:entindex(), PROPERTY_MAP_REVERSE[L], self.privilegeName, N)
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
		for t, O in ipairs(self.__EventIDList) do
			Event:Unregister(O)
		end
		self.__EventIDList = nil
	end
	self:StopAllThinks()
	self._bAlreadyDestroyed = true
end
function D.prototype.StartCooldown(self, P)
	self.lastUseTime = GameRules:GetGameTime() + P
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
	local Q = GameRules:GetGameTime()
	local R = self.lastUseTime - Q
	return math.max(0, R)
end
function D.prototype.ResetCooldown(self)
	self.lastUseTime = 0
end
function D.prototype.IncrementStackCount(self, S, T)
	if self.__StackCount == nil then
		self.__StackCount = 0
	end
	self.__StackCount = self.__StackCount + (S or 1)
	self:RefreshStaticProperty()
end
function D.prototype.DecrementStackCount(self, S, T)
	if self.__StackCount == nil then
		self.__StackCount = 0
	end
	self.__StackCount = self.__StackCount - (S or 1)
	self:RefreshStaticProperty()
end
function D.prototype.SetStackCount(self, U, T)
	self.__StackCount = U
	self:RefreshStaticProperty()
end
function D.prototype.GetStackCount(self)
	return self.__StackCount or 0
end
function D.prototype.PRD(self, V, W)
	return PRD(nil, self, V, W or self.privilegeName)
end
function D.prototype.RefreshStaticProperty(self)
	local H = self:GetCaster()
	if not H then
		return
	end
	if self.StaticProperty ~= nil then
		for L, M in pairs(self:StaticProperty()) do
			if PROPERTY_MAP_REVERSE[L] then
				PropertySystem:AddStaticProperty(H:entindex(), PROPERTY_MAP_REVERSE[L], self.privilegeName, M)
			end
		end
	end
end
function D.prototype.GetCaster(self)
	return PlayerResource:GetSelectedHeroEntity(self.playerID)
end
function D.prototype.GetPlayerID(self)
	return self.playerID
end
function D.prototype.GetSpecialValueFor(self, X)
	return Privilege:GetPrivilegeSpecialValue(self.privilegeName, self.level, X, self:GetCaster())
end
function D.prototype.IsValidPrivilege(self)
	if self._bAlreadyDestroyed then
		return false
	end
	return true
end
function D.prototype.GetPriority(self)
	local Y = toFiniteNumber
	local Z = KeyValues.privilegeKv[self.privilegeName]
	if Z ~= nil then
		Z = Z.Priority
	end
	return Y(Z, 100)
end
function D.prototype.GetUnavailableArtifactNames(self)
	local _ = self:GetCaster()
	if not IsValid(_) then
		return {}
	end
	local a0 = {}
	for a1, a2 in pairs(KeyValues.items) do
		local a3 = toFiniteNumber(a2.Quantitylimit, 0)
		if a3 > 0 and _:GetItemCount(a1) >= a3 then
			self:AppendExcludedArtifact(a0, a1)
		end
	end
	local a4 = _:GetAllItems()
	do
		local t = 0
		while t < #a4 do
			do
				local a5 = a4[t + 1]
				if not IsValid(a5) then
					goto a6
				end
				self:AppendUpgradeGroupArtifacts(a0, a5:GetAbilityName())
			end
			::a6::
			t = t + 1
		end
	end
	return a0
end
function D.prototype.AppendUpgradeGroupArtifacts(self, a0, a1)
	local a7 = tostring
	local a8 = KeyValues.items[a1]
	if a8 ~= nil then
		a8 = a8.UpgradeGroup
	end
	local a9 = a8
	if a9 == nil then
		a9 = ""
	end
	local aa = a7(a9)
	if aa == "" then
		return
	end
	for ab, ac in pairs(KeyValues.items) do
		local ad = tostring
		local ae = ac.UpgradeGroup
		if ae == nil then
			ae = ""
		end
		if ad(ae) == aa then
			self:AppendExcludedArtifact(a0, ab)
		end
	end
end
function D.prototype.AppendExcludedArtifact(self, a0, a1)
	if not d(a0, a1) then
		a0[#a0 + 1] = a1
	end
end
function D.prototype.StartThink(self, af, ag, ah)
	if type(ag) == "function" and ah == nil then
		ah = ag
		ag = nil
	end
	local ai = ag or DoUniqueString("PrivilegeThink")
	if af == -1 then
		if self._ThinkList[ai] then
			Timer:StopTimer(self._ThinkList[ai])
			self._ThinkList[ai] = nil
		end
		return ai
	end
	if self._ThinkList[ai] ~= nil then
		Timer:StopTimer(self._ThinkList[ai])
	end
	local aj = Timer:GameTimer(af, function()
		if not self:IsValidPrivilege() then
			self._ThinkList[ai] = nil
			return
		end
		local ak
		if ah ~= nil then
			ak = ah(nil, self, ai)
		elseif self.OnThink ~= nil then
			ak = self:OnThink(ai)
		end
		if ak == -1 then
			Timer:StopTimer(self._ThinkList[ai])
			self._ThinkList[ai] = nil
			return
		end
		return ak
	end)
	self._ThinkList[ai] = aj
	return ai
end
function D.prototype.OnThink(self, ag) end
function D.prototype.StopAllThinks(self)
	for ag, al in pairs(self._ThinkList) do
		Timer:StopTimer(al)
	end
	self._ThinkList = {}
end
g.RegisterPrivilege = function(z, j)
	return function(self, k)
		local ag = j or k.name
		h(nil, ag, k)
		return k
	end
end
i = {}
function g.CreatePrivilegeInstance(self, j, E, F, G)
	local am = i[j]
	if not am then
		print("[PrivilegeDecorator] Class not found: " .. j)
		return nil
	end
	local an = e(am, E, F, G)
	return an
end
function g.GetAllRegisteredPrivilegeNames(self)
	return f(i)
end
return g