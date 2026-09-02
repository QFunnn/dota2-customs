--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
function q.prototype.AddAbilityUpgrade(self, s, t, u, v)
	if u == nil then
		u = 1
	end
	if v == nil then
		v = ""
	end
	if not IsValid(s) then
		return
	end
	local w = self.kv[t]
	if w == nil then
		w = self.service_kv[t]
	end
	local x = w
	if x == nil then
		return
	end
	local y = s:GetEntityIndex()
	if self.unitUpgrades[y] == nil then
		self.unitUpgrades[y] = { upgrades = {} }
	end
	local z = self.unitUpgrades[y]
	local A = e(z.upgrades, function(B, C)
		return C.name == t
	end)
	if A then
		local D = tonumber(x.max)
		if D ~= nil and A.level >= D then
			return
		end
		if not self:isUpgradeFromSource(y, t, v) then
			return
		end
		if u < A.level then
			return
		end
		A.level = u
	else
		local E = z.upgrades
		E[#E + 1] = { name = t, level = u }
		if self.upgradeSource[v] == nil then
			self.upgradeSource[v] = {}
		end
		if self.upgradeSource[v][y] == nil then
			self.upgradeSource[v][y] = {}
		end
		local F = self.upgradeSource[v][y]
		F[#F + 1] = t
		Event:Fire("ability_upgrade_added", { unit = s, upgradeName = t, level = u })
	end
	self:RefreshAbilityProperty(s, t)
	self:SyncToClient(s)
end
function q.prototype.RemoveAbilityUpgrade(self, s, t, v)
	if not IsValid(s) then
		print("[AbilityUpgrade] 无效的单位")
		return false
	end
	local y = s:GetEntityIndex()
	local z = self.unitUpgrades[y]
	if z == nil or #z.upgrades == 0 then
		print(("[AbilityUpgrade] 单位 " .. tostring(y)) .. " 没有任何技能升级")
		return false
	end
	if v ~= nil and not self:isUpgradeFromSource(y, t, v) then
		print((("[AbilityUpgrade] 升级 " .. t) .. " 不属于来源 ") .. v)
		return false
	end
	do
		local G = 0
		while G < #z.upgrades do
			if z.upgrades[G + 1].name == t then
				local H = v or ""
				local I = self.upgradeSource[H]
				if I and I[y] then
					local J = f(self.upgradeSource[H][y], t)
					if J ~= -1 then
						g(self.upgradeSource[H][y], J, 1)
					end
				end
				g(z.upgrades, G, 1)
				print(
					(
						(
							((("[AbilityUpgrade] 单位 " .. tostring(y)) .. " 移除技能升级: ") .. t)
							.. " (来源: "
						) .. (v or "无")
					) .. ")"
				)
				self:RefreshAbilityProperty(s, t)
				self:SyncToClient(s)
				Event:Fire("ability_upgrade_removed", { unit = s, upgradeName = t })
				return true
			end
			G = G + 1
		end
	end
	print((("[AbilityUpgrade] 单位 " .. tostring(y)) .. " 没有技能升级: ") .. t)
	return false
end
function q.prototype.RemoveAbilityUpgradeBySource(self, s, v)
	if not IsValid(s) then
		return 0
	end
	local y = s:GetEntityIndex()
	local z = self.unitUpgrades[y]
	if z == nil or #z.upgrades == 0 or self.upgradeSource[v] == nil or self.upgradeSource[v][y] == nil then
		return 0
	end
	local K = self.upgradeSource[v][y]
	if not K or #K == 0 then
		return 0
	end
	local L = 0
	local M = {}
	for B, N in ipairs(K) do
		local O = h(z.upgrades, function(B, C)
			return C.name == N
		end)
		if O ~= -1 then
			g(z.upgrades, O, 1)
			M[#M + 1] = N
			L = L + 1
			self:RefreshAbilityProperty(s, N)
			Event:Fire("ability_upgrade_removed", { unit = s, upgradeName = N })
		end
	end
	i(self.upgradeSource[v], y)
	if L > 0 then
		self:SyncToClient(s)
	end
	return L
end
function q.prototype.GetAbilityUpgrades(self, s)
	if not IsValid(s) then
		return {}
	end
	local y = s:GetEntityIndex()
	local z = IsServer() and self.unitUpgrades[y] or CustomNetTables:GetNetData("ability_upgrade", tostring(y))
	return z ~= nil and z.upgrades or {}
end
function q.prototype.HasAbilityUpgrade(self, s, t)
	local P = self:GetAbilityUpgrades(s)
	do
		local G = 0
		while G < #P do
			if P[G + 1].name == t then
				return true
			end
			G = G + 1
		end
	end
	return false
end
function q.prototype.GetAbilityUpgradeCount(self, s, t)
	if not IsValid(s) then
		return 0
	end
	local y = s:GetEntityIndex()
	local z = self.unitUpgrades[y]
	if z == nil or #z.upgrades == 0 then
		return 0
	end
	return j(z.upgrades, function(B, C)
		return C.name == t
	end) and 1 or 0
end
function q.prototype.GetUpgradeLevelSumByAbilityName(self, s, Q)
	if not IsValid(s) then
		return 0
	end
	local P = self:GetAbilityUpgrades(s)
	if #P == 0 then
		return 0
	end
	local R = 0
	do
		local G = 0
		while G < #P do
			local S = self.kv[P[G + 1].name]
			if S ~= nil and S.ability_name == Q then
				R = R + P[G + 1].level
			end
			G = G + 1
		end
	end
	return R
end
function q.prototype.GetUpgradedValue(self, s, Q, T, U, V)
	if not IsValid(s) then
		return V
	end
	local y = s:GetEntityIndex()
	local z = IsServer() and self.unitUpgrades[y] or CustomNetTables:GetNetData("ability_upgrade", tostring(y))
	if z == nil or #z.upgrades == 0 then
		return V
	end
	local W = V
	local X = 0
	for B, Y in ipairs(z.upgrades) do
		local Z = self.kv[Y.name]
		if Z == nil then
			Z = self.service_kv[Y.name]
		end
		local x = Z
		if x ~= nil and x.ability_name == Q and x.AbilityValues ~= nil then
			local _ = x.AbilityValues[U]
			W = W + GetAbilityValues(_, Y.level, s)
			local a0 = x.AbilityValueMultipliers
			if a0 ~= nil then
				a0 = a0[U]
			end
			local a1 = a0
			if a1 ~= nil then
				X = X + GetAbilityValues(x.AbilityValues[a1], Y.level, s)
			end
		end
	end
	return W * (1 + X * 0.01)
end
function q.prototype.ClearAbilityUpgrades(self, s)
	if not IsValid(s) then
		return
	end
	local y = s:GetEntityIndex()
	for v in pairs(self.upgradeSource) do
		i(self.upgradeSource[v], y)
	end
	i(self.unitUpgrades, y)
	CustomNetTables:SetNetData("ability_upgrade", tostring(y), nil)
	Event:Fire("ability_upgrades_cleared", { unit = s })
end
function q.prototype.IsServiceUpgrade(self, t)
	return self.service_kv[t] ~= nil
end
function q.prototype.CanApplyAbilityUpgrade(self, s, t)
	if not IsValid(s) then
		return false
	end
	local a2 = self.kv[t]
	if a2 == nil then
		a2 = self.service_kv[t]
	end
	local S = a2
	if S == nil or S.ability_name == nil then
		return false
	end
	return IsValid(s:FindAbilityByName(S.ability_name))
end
function q.prototype.isUpgradeFromSource(self, y, t, v)
	local a3 = self.upgradeSource[v]
	local K = a3 and a3[y]
	return K ~= nil and k(K, t)
end
function q.prototype.RefreshAbilityProperty(self, s, t)
	local a4 = self.kv[t]
	if a4 == nil then
		a4 = self.service_kv[t]
	end
	local x = a4
	if x ~= nil and x.ability_name ~= nil then
		local a5 = s:FindAbilityByName(x.ability_name)
		if a5 ~= nil then
			a5:RefreshStaticProperty()
			if x.AbilityValues ~= nil and x.AbilityValues.abilitycharges ~= nil then
				a5:RefreshCharges()
			end
		end
	end
end
function q.prototype.SyncToClient(self, s)
	local y = s:GetEntityIndex()
	local z = self.unitUpgrades[y]
	if z ~= nil then
		CustomNetTables:SetNetData("ability_upgrade", tostring(y), { upgrades = z.upgrades })
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