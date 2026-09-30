--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/ability_upgrade"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFind
local f = b.__TS__ArrayIndexOf
local g = b.__TS__ArraySplice
local h = b.__TS__ArrayFindIndex
local i = b.__TS__Delete
local j = b.__TS__ArraySome
local k = b.__TS__ArrayIncludes
local l = b.__TS__DecorateLegacy
local m = b.__TS__New
local n = {}
local o = require("lib.tstl-utils")
local p = o.reloadable
local q = c()
q.name = "CAbilityUpgrade"
d(q, CModule)
function q.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.unitUpgrades = {}
	self.upgradeSource = {}
end
function q.prototype.init(self, r)
	if not r then
		self.unitUpgrades = {}
	end
	self.kv = LoadKeyValues("scripts/npc/abilities/ability_upgrades.kv")
	self.service_kv = LoadKeyValues("scripts/npc/abilities/ability_upgrades_service.kv")
end
function q.prototype.CanAddAbilityUpgrade(self, s, t, u)
	if u == nil then
		u = ""
	end
	if not IsValid(s) then
		return false
	end
	local v = self.kv[t]
	if v == nil then
		v = self.service_kv[t]
	end
	local w = v
	if w == nil then
		return false
	end
	local x = s:GetEntityIndex()
	local y = self.unitUpgrades[x]
	if y ~= nil then
		local z = self.unitUpgrades[x]
		y = e(z and z.upgrades, function(A, B)
			return B.name == t
		end)
	end
	local C = y
	if C == nil then
		return true
	end
	local D = tonumber(w.max)
	return (D == nil or C.level < D) and self:isUpgradeFromSource(x, t, u)
end
function q.prototype.AddAbilityUpgrade(self, s, t, E, u)
	if E == nil then
		E = 1
	end
	if u == nil then
		u = ""
	end
	if not self:CanAddAbilityUpgrade(s, t, u) then
		return false
	end
	local x = s:GetEntityIndex()
	if self.unitUpgrades[x] == nil then
		self.unitUpgrades[x] = { upgrades = {} }
	end
	local F = self.unitUpgrades[x]
	local C = e(F.upgrades, function(A, B)
		return B.name == t
	end)
	local G = false
	if C then
		if E < C.level then
			return false
		end
		G = E > C.level
		C.level = E
	else
		local H = F.upgrades
		H[#H + 1] = { name = t, level = E }
		G = true
		if self.upgradeSource[u] == nil then
			self.upgradeSource[u] = {}
		end
		if self.upgradeSource[u][x] == nil then
			self.upgradeSource[u][x] = {}
		end
		local I = self.upgradeSource[u][x]
		I[#I + 1] = t
		Event:Fire("ability_upgrade_added", { unit = s, upgradeName = t, level = E })
	end
	self:RefreshAbilityProperty(s, t)
	self:SyncToClient(s)
	return G
end
function q.prototype.RemoveAbilityUpgrade(self, s, t, u)
	if not IsValid(s) then
		print("[AbilityUpgrade] 无效的单位")
		return false
	end
	local x = s:GetEntityIndex()
	local F = self.unitUpgrades[x]
	if F == nil or #F.upgrades == 0 then
		print(("[AbilityUpgrade] 单位 " .. tostring(x)) .. " 没有任何技能升级")
		return false
	end
	if u ~= nil and not self:isUpgradeFromSource(x, t, u) then
		print((("[AbilityUpgrade] 升级 " .. t) .. " 不属于来源 ") .. u)
		return false
	end
	do
		local J = 0
		while J < #F.upgrades do
			if F.upgrades[J + 1].name == t then
				local K = u or ""
				local L = self.upgradeSource[K]
				if L and L[x] then
					local M = f(self.upgradeSource[K][x], t)
					if M ~= -1 then
						g(self.upgradeSource[K][x], M, 1)
					end
				end
				g(F.upgrades, J, 1)
				print(
					(
						(
							((("[AbilityUpgrade] 单位 " .. tostring(x)) .. " 移除技能升级: ") .. t)
							.. " (来源: "
						) .. (u or "无")
					) .. ")"
				)
				self:RefreshAbilityProperty(s, t)
				self:SyncToClient(s)
				Event:Fire("ability_upgrade_removed", { unit = s, upgradeName = t })
				return true
			end
			J = J + 1
		end
	end
	print((("[AbilityUpgrade] 单位 " .. tostring(x)) .. " 没有技能升级: ") .. t)
	return false
end
function q.prototype.RemoveAbilityUpgradeBySource(self, s, u)
	if not IsValid(s) then
		return 0
	end
	local x = s:GetEntityIndex()
	local F = self.unitUpgrades[x]
	if F == nil or #F.upgrades == 0 or self.upgradeSource[u] == nil or self.upgradeSource[u][x] == nil then
		return 0
	end
	local N = self.upgradeSource[u][x]
	if not N or #N == 0 then
		return 0
	end
	local O = 0
	local P = {}
	for A, Q in ipairs(N) do
		local R = h(F.upgrades, function(A, B)
			return B.name == Q
		end)
		if R ~= -1 then
			g(F.upgrades, R, 1)
			P[#P + 1] = Q
			O = O + 1
			self:RefreshAbilityProperty(s, Q)
			Event:Fire("ability_upgrade_removed", { unit = s, upgradeName = Q })
		end
	end
	i(self.upgradeSource[u], x)
	if O > 0 then
		self:SyncToClient(s)
	end
	return O
end
function q.prototype.GetAbilityUpgrades(self, s)
	if not IsValid(s) then
		return {}
	end
	local x = s:GetEntityIndex()
	local F = IsServer() and self.unitUpgrades[x] or CustomNetTables:GetNetData("ability_upgrade", tostring(x))
	return F ~= nil and F.upgrades or {}
end
function q.prototype.HasAbilityUpgrade(self, s, t)
	local S = self:GetAbilityUpgrades(s)
	do
		local J = 0
		while J < #S do
			if S[J + 1].name == t then
				return true
			end
			J = J + 1
		end
	end
	return false
end
function q.prototype.GetAbilityUpgradeCount(self, s, t)
	if not IsValid(s) then
		return 0
	end
	local x = s:GetEntityIndex()
	local F = self.unitUpgrades[x]
	if F == nil or #F.upgrades == 0 then
		return 0
	end
	return j(F.upgrades, function(A, B)
		return B.name == t
	end) and 1 or 0
end
function q.prototype.GetUpgradeLevelSumByAbilityName(self, s, T)
	if not IsValid(s) then
		return 0
	end
	local S = self:GetAbilityUpgrades(s)
	if #S == 0 then
		return 0
	end
	local U = 0
	do
		local J = 0
		while J < #S do
			local V = self.kv[S[J + 1].name]
			if V ~= nil and V.ability_name == T then
				U = U + S[J + 1].level
			end
			J = J + 1
		end
	end
	return U
end
function q.prototype.GetUpgradedValue(self, s, T, W, X, Y)
	if not IsValid(s) then
		return Y
	end
	local x = s:GetEntityIndex()
	local F = IsServer() and self.unitUpgrades[x] or CustomNetTables:GetNetData("ability_upgrade", tostring(x))
	if F == nil or #F.upgrades == 0 then
		return Y
	end
	local Z = Y
	local _ = 0
	for A, a0 in ipairs(F.upgrades) do
		local a1 = self.kv[a0.name]
		if a1 == nil then
			a1 = self.service_kv[a0.name]
		end
		local w = a1
		if w ~= nil and w.ability_name == T and w.AbilityValues ~= nil then
			local a2 = w.AbilityValues[X]
			Z = Z + GetAbilityValues(a2, a0.level, s)
			local a3 = w.AbilityValueMultipliers
			if a3 ~= nil then
				a3 = a3[X]
			end
			local a4 = a3
			if a4 ~= nil then
				_ = _ + GetAbilityValues(w.AbilityValues[a4], a0.level, s)
			end
		end
	end
	return Z * (1 + _ * 0.01)
end
function q.prototype.ClearAbilityUpgrades(self, s)
	if not IsValid(s) then
		return
	end
	local x = s:GetEntityIndex()
	for u in pairs(self.upgradeSource) do
		i(self.upgradeSource[u], x)
	end
	i(self.unitUpgrades, x)
	CustomNetTables:SetNetData("ability_upgrade", tostring(x), nil)
	Event:Fire("ability_upgrades_cleared", { unit = s })
end
function q.prototype.IsServiceUpgrade(self, t)
	return self.service_kv[t] ~= nil
end
function q.prototype.CanApplyAbilityUpgrade(self, s, t)
	if not IsValid(s) then
		return false
	end
	local a5 = self.kv[t]
	if a5 == nil then
		a5 = self.service_kv[t]
	end
	local V = a5
	if V == nil or V.ability_name == nil then
		return false
	end
	return IsValid(s:FindAbilityByName(V.ability_name))
end
function q.prototype.isUpgradeFromSource(self, x, t, u)
	local a6 = self.upgradeSource[u]
	local N = a6 and a6[x]
	return N ~= nil and k(N, t)
end
function q.prototype.RefreshAbilityProperty(self, s, t)
	local a7 = self.kv[t]
	if a7 == nil then
		a7 = self.service_kv[t]
	end
	local w = a7
	if w ~= nil and w.ability_name ~= nil then
		local a8 = s:FindAbilityByName(w.ability_name)
		if a8 ~= nil then
			a8:RefreshStaticProperty()
			if w.AbilityValues ~= nil and w.AbilityValues.abilitycharges ~= nil then
				a8:RefreshCharges()
			end
		end
	end
end
function q.prototype.SyncToClient(self, s)
	local x = s:GetEntityIndex()
	local F = self.unitUpgrades[x]
	if F ~= nil then
		CustomNetTables:SetNetData("ability_upgrade", tostring(x), { upgrades = F.upgrades })
	end
end
function q.prototype.reset(self)
	self.unitUpgrades = {}
	self.upgradeSource = {}
end
q = l({ p }, q)
if AbilityUpgrade == nil then
	AbilityUpgrade = m(q)
end
return n