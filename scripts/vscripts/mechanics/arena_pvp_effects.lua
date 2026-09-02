--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "mechanics/arena_pvp_effects"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ObjectValues
local e = b.__TS__Delete
local f = b.__TS__ArrayIncludes
local g = b.__TS__New
local h = {}
local i = require("abilities.eom_privilege")
local j = i.CreatePrivilegeInstance
local k = i.EOMPrivilege
h.ArenaPvpEffectRuntime = c()
local l = h.ArenaPvpEffectRuntime
l.name = "ArenaPvpEffectRuntime"
function l.prototype.____constructor(self)
	self.unitRecords = {}
	self.pendingBattleEffects = {}
	self.effectHandlers = {
		attributes = function(m, n, o, p, q, r)
			self:ApplyAttributes(n, o, p, q, r)
		end,
		effects = function(m, n, o, p, q, r)
			self:ApplyPrivileges(n, o, p, q, r)
		end,
		myth = function(m, n, o, p, q, r)
			self:ApplyMyths(n, o, p, q, r)
		end,
		ability_upgrade = function(m, n, o, p, q, r)
			self:ApplyAbilityUpgrades(n, o, p, q, r)
		end,
	}
end
function l.prototype.PrepareUnit(self, n, s)
	local t = s.resolvedHeroAttributes[n.heroID] or {}
	local r = { applied = 0, skipped = 0 }
	self:ApplyResolvedEffects(n, t, "spawn", r)
	self.pendingBattleEffects[tostring(n.unit:entindex())] = { context = n, data = t }
end
function l.prototype.OnBattleStart(self)
	for m, u in ipairs(d(self.pendingBattleEffects)) do
		do
			if not IsValid(u.context.unit) then
				goto v
			end
			local r = { applied = 0, skipped = 0 }
			self:ApplyResolvedEffects(u.context, u.data, "battle", r)
		end
		::v::
	end
	self.pendingBattleEffects = {}
end
function l.prototype.RemoveUnit(self, w)
	if not IsValid(w) then
		return
	end
	local x = tostring(w:entindex())
	e(self.pendingBattleEffects, x)
	local y = self.unitRecords[x]
	if y ~= nil then
		for m, z in ipairs(y.propertySources) do
			PropertySystem:RemoveStaticProperty(w:entindex(), z)
		end
		for m, z in ipairs(y.abilityUpgradeSources) do
			AbilityUpgrade:RemoveAbilityUpgradeBySource(w, z)
		end
		for m, A in ipairs(y.privilegeInstances) do
			A:OnDestroy()
		end
		e(self.unitRecords, x)
		AbilityUpgrade:ClearAbilityUpgrades(w)
	elseif #AbilityUpgrade:GetAbilityUpgrades(w) > 0 then
		AbilityUpgrade:ClearAbilityUpgrades(w)
	end
end
function l.prototype.Dispose(self)
	local B = d(self.unitRecords)
	for m, y in ipairs(B) do
		if IsValid(y.unit) then
			self:RemoveUnit(y.unit)
		end
	end
	self.unitRecords = {}
	self.pendingBattleEffects = {}
end
function l.prototype.ApplyResolvedEffects(self, n, s, C, r)
	for D, E in pairs(self.effectHandlers) do
		do
			if D == "attributes" ~= (C == "spawn") then
				goto F
			end
			local q = s[D]
			if q ~= nil and E ~= nil then
				E(nil, n, "resolved", "resolved", q, r)
			end
		end
		::F::
	end
end
function l.prototype.ApplyAttributes(self, n, o, p, G, r)
	local z = (((((("arena_pvp_attribute:" .. n.side) .. ":") .. n.heroID) .. ":") .. o) .. ":") .. p
	local H = false
	for I, J in pairs(G) do
		do
			local K = PropertySystem:GetScopeOfProperty(I)
			if K == nil or K ~= PropertyScope.UNIT then
				r.skipped = r.skipped + 1
				goto L
			end
			local M = toFiniteNumber(J, 0)
			if M == 0 then
				goto L
			end
			if PropertySystem:AddStaticProperty(n.unit:entindex(), I, z, M) then
				r.applied = r.applied + 1
				H = true
			end
		end
		::L::
	end
	if not H then
		return
	end
	local y = self:GetUnitRecord(n.unit)
	if not f(y.propertySources, z) then
		local N = y.propertySources
		N[#N + 1] = z
	end
end
function l.prototype.ApplyPrivileges(self, n, o, p, O, r)
	for P, Q in pairs(O) do
		do
			local R = toFiniteNumber(Q, 0)
			if R <= 0 or math.floor(R) ~= R then
				r.skipped = r.skipped + 1
				goto S
			end
			local T = self:CreatePrivilege(n, P, R)
			if T == nil then
				r.skipped = r.skipped + 1
				goto S
			end
			local y = self:GetUnitRecord(n.unit)
			T:OnCreated()
			local U = y.privilegeInstances
			U[#U + 1] = T
			r.applied = r.applied + 1
		end
		::S::
	end
end
function l.prototype.ApplyMyths(self, n, o, p, V, r)
	for P, M in pairs(V) do
		do
			local W = toFiniteNumber(M, 0)
			if W == 0 then
				r.skipped = r.skipped + 1
				goto X
			end
			local T = self:CreatePrivilege(n, P, 1, { value = W })
			if T == nil then
				r.skipped = r.skipped + 1
				goto X
			end
			local y = self:GetUnitRecord(n.unit)
			T:OnCreated()
			local Y = y.privilegeInstances
			Y[#Y + 1] = T
			r.applied = r.applied + 1
		end
		::X::
	end
end
function l.prototype.CreatePrivilege(self, n, P, R, Z)
	local _ = KeyValues.privilegeKv
	local a0 = _ and _[P]
	if a0 == nil or a0.IsNoScript == 1 then
		return nil
	end
	local a1 = a0.ScriptFile
	if a1 == nil then
		a1 = P
	end
	local a2 = a1
	pcall(function()
		return require("abilities.privilege." .. tostring(a2))
	end)
	return j(nil, a2, P, R, n.unit:GetPlayerOwnerID(), n.unit, Z) or g(k, P, R, n.unit:GetPlayerOwnerID(), n.unit, Z)
end
function l.prototype.ApplyAbilityUpgrades(self, n, o, p, a3, r)
	local z = (
		(
			(
				(
					(((("arena_pvp_effect:ability_upgrade:" .. n.side) .. ":") .. tostring(n.targetUID)) .. ":")
					.. n.heroID
				) .. ":"
			) .. o
		) .. ":"
	) .. p
	local H = false
	for a4, Q in pairs(a3) do
		do
			local R = toFiniteNumber(Q, 0)
			if
				R <= 0
				or math.floor(R) ~= R
				or not AbilityUpgrade:CanApplyAbilityUpgrade(n.unit, a4)
				or AbilityUpgrade:HasAbilityUpgrade(n.unit, a4)
			then
				r.skipped = r.skipped + 1
				goto a5
			end
			AbilityUpgrade:AddAbilityUpgrade(n.unit, a4, R, z)
			r.applied = r.applied + 1
			H = true
		end
		::a5::
	end
	if not H then
		return
	end
	local y = self:GetUnitRecord(n.unit)
	if not f(y.abilityUpgradeSources, z) then
		local a6 = y.abilityUpgradeSources
		a6[#a6 + 1] = z
	end
end
function l.prototype.GetUnitRecord(self, w)
	local x = tostring(w:entindex())
	local y = self.unitRecords[x]
	if y == nil then
		y = { unit = w, propertySources = {}, abilityUpgradeSources = {}, privilegeInstances = {} }
		self.unitRecords[x] = y
	end
	return y
end
return h