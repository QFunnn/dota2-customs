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
	self:ApplyHeroSkillRunes(n, s.heroSkillOutsideAttributes[n.heroID])
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
		for m, A in ipairs(y.abilityPropertySources) do
			if IsValid(A.ability) then
				PropertySystem:RemoveAbilityStaticProperty(A.ability, A.sourceID)
			end
		end
		for m, B in ipairs(y.runeEffectItems) do
			if IsValid(B) then
				w:RemoveItem(B)
			end
		end
		e(w, "__ArenaPvpRuneEffectItems")
		for m, z in ipairs(y.abilityUpgradeSources) do
			AbilityUpgrade:RemoveAbilityUpgradeBySource(w, z)
		end
		for m, C in ipairs(y.privilegeInstances) do
			C:OnDestroy()
		end
		e(self.unitRecords, x)
		AbilityUpgrade:ClearAbilityUpgrades(w)
	elseif #AbilityUpgrade:GetAbilityUpgrades(w) > 0 then
		AbilityUpgrade:ClearAbilityUpgrades(w)
	end
end
function l.prototype.Dispose(self)
	local D = d(self.unitRecords)
	for m, y in ipairs(D) do
		if IsValid(y.unit) then
			self:RemoveUnit(y.unit)
		end
	end
	self.unitRecords = {}
	self.pendingBattleEffects = {}
end
function l.prototype.ApplyResolvedEffects(self, n, s, E, r)
	for F, G in pairs(self.effectHandlers) do
		do
			if F == "attributes" ~= (E == "spawn") then
				goto H
			end
			local q = s[F]
			if q ~= nil and G ~= nil then
				G(nil, n, "resolved", "resolved", q, r)
			end
		end
		::H::
	end
end
function l.prototype.ApplyHeroSkillRunes(self, n, I)
	if I == nil then
		return
	end
	for J, K in pairs(I) do
		do
			local L = tonumber(J)
			local M = K.data
			local N = M and M.hero_skill_rune
			if L == nil or L < AbilityTag.Attack or L > AbilityTag.Ultimate or N == nil then
				goto O
			end
			local P = n.unit:GetAbilityByTag(L)
			if not IsValid(P) then
				goto O
			end
			local y = self:GetUnitRecord(n.unit)
			local Q = 0
			local R = 0
			for S, T in pairs(N.attributes or {}) do
				do
					local U = toFiniteNumber(T, 0)
					if U == 0 or PropertySystem:GetScopeOfProperty(S) ~= PropertyScope.UNIT then
						goto V
					end
					local z = (
						(
							(
								((((("arena_pvp_rune:" .. n.side) .. ":") .. tostring(n.targetUID)) .. ":") .. n.heroID)
								.. ":"
							) .. tostring(L)
						) .. ":"
					) .. S
					if PropertySystem:AddAbilityStaticProperty(P, S, z, U, { source = "arena_pvp_rune" }) then
						local W = y.abilityPropertySources
						W[#W + 1] = { ability = P, sourceID = z }
						Q = Q + 1
					end
				end
				::V::
			end
			local X = {}
			for Y, Z in pairs(N.effects or {}) do
				do
					local _ = toFiniteNumber(Z, 0)
					if _ <= 0 or math.floor(_) ~= _ then
						goto a0
					end
					local B = n.unit:AddItemByName(Y, _)
					if B == nil or not IsValid(B) then
						goto a0
					end
					B.abilityTag = L
					local a1 = y.runeEffectItems
					a1[#a1 + 1] = B
					X[#X + 1] = B
					R = R + 1
				end
				::a0::
			end
			for m, B in ipairs(X) do
				if B.RefreshConfigData ~= nil then
					B:RefreshConfigData()
				end
			end
		end
		::O::
	end
end
function l.prototype.ApplyAttributes(self, n, o, p, Q, r)
	local z = (((((("arena_pvp_attribute:" .. n.side) .. ":") .. n.heroID) .. ":") .. o) .. ":") .. p
	local a2 = false
	for S, T in pairs(Q) do
		do
			local a3 = PropertySystem:GetScopeOfProperty(S)
			if a3 == nil or a3 ~= PropertyScope.UNIT then
				r.skipped = r.skipped + 1
				goto a4
			end
			local U = toFiniteNumber(T, 0)
			if U == 0 then
				goto a4
			end
			if PropertySystem:AddStaticProperty(n.unit:entindex(), S, z, U) then
				r.applied = r.applied + 1
				a2 = true
			end
		end
		::a4::
	end
	if not a2 then
		return
	end
	local y = self:GetUnitRecord(n.unit)
	if not f(y.propertySources, z) then
		local a5 = y.propertySources
		a5[#a5 + 1] = z
	end
end
function l.prototype.ApplyPrivileges(self, n, o, p, a6, r)
	for a7, Z in pairs(a6) do
		do
			local _ = toFiniteNumber(Z, 0)
			if _ <= 0 or math.floor(_) ~= _ then
				r.skipped = r.skipped + 1
				goto a8
			end
			local a9 = self:CreatePrivilege(n, a7, _)
			if a9 == nil then
				r.skipped = r.skipped + 1
				goto a8
			end
			local y = self:GetUnitRecord(n.unit)
			a9:OnCreated()
			local aa = y.privilegeInstances
			aa[#aa + 1] = a9
			r.applied = r.applied + 1
		end
		::a8::
	end
end
function l.prototype.ApplyMyths(self, n, o, p, ab, r)
	for a7, U in pairs(ab) do
		do
			local ac = toFiniteNumber(U, 0)
			if ac == 0 then
				r.skipped = r.skipped + 1
				goto ad
			end
			local a9 = self:CreatePrivilege(n, a7, 1, { value = ac })
			if a9 == nil then
				r.skipped = r.skipped + 1
				goto ad
			end
			local y = self:GetUnitRecord(n.unit)
			a9:OnCreated()
			local ae = y.privilegeInstances
			ae[#ae + 1] = a9
			r.applied = r.applied + 1
		end
		::ad::
	end
end
function l.prototype.CreatePrivilege(self, n, a7, _, af)
	local ag = KeyValues.privilegeKv
	local ah = ag and ag[a7]
	if ah == nil or ah.IsNoScript == 1 then
		return nil
	end
	local ai = ah.ScriptFile
	if ai == nil then
		ai = a7
	end
	local aj = ai
	pcall(function()
		return require("abilities.privilege." .. tostring(aj))
	end)
	return j(nil, aj, a7, _, n.unit:GetPlayerOwnerID(), n.unit, af) or g(
		k,
		a7,
		_,
		n.unit:GetPlayerOwnerID(),
		n.unit,
		af
	)
end
function l.prototype.ApplyAbilityUpgrades(self, n, o, p, ak, r)
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
	local a2 = false
	for al, Z in pairs(ak) do
		do
			local _ = toFiniteNumber(Z, 0)
			if
				_ <= 0
				or math.floor(_) ~= _
				or not AbilityUpgrade:CanApplyAbilityUpgrade(n.unit, al)
				or AbilityUpgrade:HasAbilityUpgrade(n.unit, al)
			then
				r.skipped = r.skipped + 1
				goto am
			end
			AbilityUpgrade:AddAbilityUpgrade(n.unit, al, _, z)
			r.applied = r.applied + 1
			a2 = true
		end
		::am::
	end
	if not a2 then
		return
	end
	local y = self:GetUnitRecord(n.unit)
	if not f(y.abilityUpgradeSources, z) then
		local an = y.abilityUpgradeSources
		an[#an + 1] = z
	end
end
function l.prototype.GetUnitRecord(self, w)
	local x = tostring(w:entindex())
	local y = self.unitRecords[x]
	if y == nil then
		y = {
			unit = w,
			propertySources = {},
			abilityPropertySources = {},
			runeEffectItems = {},
			abilityUpgradeSources = {},
			privilegeInstances = {},
		}
		self.unitRecords[x] = y
		w.__ArenaPvpRuneEffectItems = y.runeEffectItems
	end
	return y
end
return h