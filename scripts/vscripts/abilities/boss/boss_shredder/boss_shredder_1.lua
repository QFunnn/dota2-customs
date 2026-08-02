--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
			local t = p:GetAbsOrigin() + RandomVector(RandomInt(400, 1200))
			self:CreateTree(t)
			s = s + 1
		end
	end
end
function o.prototype.CreateTree(self, t)
	local u = self:GetCaster()
	local v = u:SummonUnit("shredder_tree", t)
	if IsValid(v) then
		v:AddNewModifier(u, self, "modifier_boss_shredder_1_thinker", {})
		v:SetForwardVector(RandomVector(1))
		local w = self.treeList
		w[#w + 1] = v
	end
end
function o.prototype.RemoveTree(self, x)
	ArrayRemove(self.treeList, x)
	x:SafeRemoveUnit()
end
function o.prototype.CutDownTree(self, x, y)
	if y == nil then
		y = true
	end
	if not e(self.treeList, x) then
		return
	end
	self:RemoveTree(x)
	if not y then
		return
	end
	local z = self:GetSpecialValueFor("treant_limit")
	self.summonRecords = f(self.summonRecords, function(A, B)
		return IsValid(B) and B:IsAlive()
	end)
	if #self.summonRecords >= z then
		return
	end
	local p = self:GetCaster()
	local C = x:GetAbsOrigin()
	local D = p:SummonUnit("shredder_treant", C)
	if D ~= nil then
		local E = DungeonManager:GetCurrentRoom()
		if E ~= nil then
			E:ApplyDifficultyModifiers(D)
		end
		FindClearSpaceForUnit(D, C, true)
		local F = self.summonRecords
		F[#F + 1] = D
	end
	return D
end
function o.prototype.EventListener(self)
	return {
		entity_killed = function(A, G)
			if G.victim == self:GetCaster() then
				self:OnDestroy()
			end
		end,
	}
end
function o.prototype.OnDestroy(self)
	local p = self:GetCaster()
	for s, x in ipairs(self.treeList) do
		if IsValid(x) then
			x:SafeRemoveUnit()
		end
	end
	self.treeList = {}
	for A, D in ipairs(self.summonRecords) do
		if IsValid(D) then
			D:Kill(self, p)
		end
	end
	self.summonRecords = {}
end
o = g(
	{ n(nil, {
		funcCondition = function(A, H)
			return #H.treeList < H:GetSpecialValueFor("tree_limit")
		end,
	}) },
	o
)
local I = c()
I.name = "modifier_boss_shredder_1_thinker"
d(I, j)
function I.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function I.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
I = g(
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
	I
)
return h