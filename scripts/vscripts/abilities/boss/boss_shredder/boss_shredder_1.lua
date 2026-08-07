--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_shredder/boss_shredder_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__ArrayFilter
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.eom_ability")
local m = l.EOMAbility
local n = l.registerEOMAbility
local o = c()
o.name = "boss_shredder_1"
d(o, m)
function o.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.treeList = {}
	self.summonRecords = {}
end
function o.prototype.OnAbilityPhaseStart(self)
	self:GetCaster():EmitSound("Hero_Furion.Sprout")
	return true
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	local q = self:GetSpecialValueFor("tree_limit")
	local r = q - #self.treeList
	do
		local s = 0
		while s < r do
			local t = self:FindTreePosition(p)
			if t ~= nil then
				self:CreateTree(t)
			end
			s = s + 1
		end
	end
end
function o.prototype.FindTreePosition(self, p)
	local u = p:GetAbsOrigin()
	local v = p:GetHullRadius()
	do
		local w = 0
		while w < 16 do
			local t = u + RandomVector(RandomInt(400, 1200))
			if GridNav:IsValidPosition(t) and not GridNav:IsNearbyTree(t, v, true) and GridNav:CanFindPath(u, t) then
				return t
			end
			w = w + 1
		end
	end
	return nil
end
function o.prototype.CreateTree(self, t)
	local x = self:GetCaster()
	local y = x:SummonUnit("shredder_tree", t)
	if IsValid(y) then
		y:AddNewModifier(x, self, "modifier_boss_shredder_1_thinker", {})
		y:SetForwardVector(RandomVector(1))
		local z = self.treeList
		z[#z + 1] = y
	end
end
function o.prototype.RemoveTree(self, A)
	ArrayRemove(self.treeList, A)
	A:SafeRemoveUnit()
end
function o.prototype.CutDownTree(self, A, B)
	if B == nil then
		B = true
	end
	if not e(self.treeList, A) then
		return
	end
	self:RemoveTree(A)
	if not B then
		return
	end
	local C = self:GetSpecialValueFor("treant_limit")
	self.summonRecords = f(self.summonRecords, function(D, E)
		return IsValid(E) and E:IsAlive()
	end)
	if #self.summonRecords >= C then
		return
	end
	local p = self:GetCaster()
	local F = A:GetAbsOrigin()
	local G = p:SummonUnit("shredder_treant", F)
	if G ~= nil then
		local H = DungeonManager:GetCurrentRoom()
		if H ~= nil then
			H:ApplyDifficultyModifiers(G)
		end
		FindClearSpaceForUnit(G, F, true)
		local I = self.summonRecords
		I[#I + 1] = G
	end
	return G
end
function o.prototype.EventListener(self)
	return {
		entity_killed = function(D, J)
			if J.victim == self:GetCaster() then
				self:OnDestroy()
			end
		end,
	}
end
function o.prototype.OnDestroy(self)
	local p = self:GetCaster()
	for s, A in ipairs(self.treeList) do
		if IsValid(A) then
			A:SafeRemoveUnit()
		end
	end
	self.treeList = {}
	for D, G in ipairs(self.summonRecords) do
		if IsValid(G) then
			G:Kill(self, p)
		end
	end
	self.summonRecords = {}
end
o = g(
	{ n(nil, {
		funcCondition = function(D, K)
			return #K.treeList < K:GetSpecialValueFor("tree_limit")
		end,
	}) },
	o
)
local L = c()
L.name = "modifier_boss_shredder_1_thinker"
d(L, j)
function L.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function L.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
L = g(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	L
)
return h