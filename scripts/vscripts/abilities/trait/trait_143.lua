--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_143"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayFilter
local g = b.__TS__ArraySort
local h = b.__TS__StringSplit
local i = b.__TS__New
local j = b.__TS__ArrayIncludes
local k = b.__TS__Delete
local l = b.__TS__SourceMapTraceBack
l(
	debug.getinfo(1).short_src,
	{
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
		["22"] = 6,
		["23"] = 7,
		["24"] = 6,
		["25"] = 7,
		["26"] = 8,
		["27"] = 9,
		["28"] = 8,
		["29"] = 7,
		["30"] = 6,
		["31"] = 7,
		["33"] = 7,
		["34"] = 13,
		["35"] = 20,
		["36"] = 13,
		["37"] = 20,
		["39"] = 20,
		["40"] = 22,
		["41"] = 13,
		["42"] = 24,
		["43"] = 25,
		["44"] = 26,
		["45"] = 27,
		["46"] = 28,
		["47"] = 29,
		["48"] = 30,
		["49"] = 31,
		["50"] = 32,
		["51"] = 33,
		["52"] = 34,
		["53"] = 35,
		["54"] = 36,
		["55"] = 38,
		["56"] = 38,
		["57"] = 38,
		["58"] = 38,
		["59"] = 39,
		["60"] = 39,
		["61"] = 39,
		["62"] = 39,
		["63"] = 40,
		["64"] = 41,
		["65"] = 42,
		["66"] = 43,
		["67"] = 44,
		["70"] = 46,
		["71"] = 46,
		["72"] = 47,
		["73"] = 48,
		["74"] = 49,
		["75"] = 50,
		["76"] = 51,
		["77"] = 52,
		["78"] = 53,
		["79"] = 54,
		["80"] = 55,
		["82"] = 53,
		["83"] = 58,
		["84"] = 59,
		["85"] = 60,
		["86"] = 61,
		["87"] = 62,
		["88"] = 63,
		["93"] = 67,
		["94"] = 67,
		["95"] = 68,
		["96"] = 69,
		["97"] = 70,
		["98"] = 71,
		["100"] = 67,
		["103"] = 74,
		["104"] = 75,
		["105"] = 76,
		["106"] = 76,
		["107"] = 76,
		["108"] = 76,
		["109"] = 76,
		["110"] = 80,
		["111"] = 81,
		["112"] = 82,
		["114"] = 84,
		["115"] = 85,
		["117"] = 87,
		["118"] = 76,
		["119"] = 89,
		["120"] = 90,
		["121"] = 91,
		["123"] = 92,
		["124"] = 92,
		["125"] = 93,
		["126"] = 94,
		["127"] = 95,
		["128"] = 96,
		["130"] = 92,
		["133"] = 100,
		["134"] = 76,
		["135"] = 76,
		["136"] = 76,
		["137"] = 76,
		["138"] = 105,
		["139"] = 46,
		["145"] = 24,
		["146"] = 111,
		["147"] = 112,
		["148"] = 113,
		["149"] = 114,
		["150"] = 115,
		["152"] = 117,
		["154"] = 111,
		["155"] = 20,
		["156"] = 13,
		["157"] = 13,
		["158"] = 13,
		["159"] = 13,
		["160"] = 13,
		["161"] = 13,
		["162"] = 13,
		["163"] = 20,
		["165"] = 20,
	}
)
local m = {}
local n = require("class.weight_pool")
local o = n.CWeightPool
local p = require("lib.dota_ts_adapter")
local q = p.BaseAbility
local r = p.registerAbility
local s = require("modifiers.eom_modifier")
local t = s.EOMModifier
local u = s.registerEOMModifier
m.trait_143 = c()
local v = m.trait_143
v.name = "trait_143"
d(v, q)
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_143"
end
v = e({ r(nil) }, v)
m.trait_143 = v
m.modifier_trait_143 = c()
local w = m.modifier_trait_143
w.name = "modifier_trait_143"
d(w, t)
function w.prototype.____constructor(self, ...)
	t.prototype.____constructor(self, ...)
	self.selectionCount = 3
end
function w.prototype.OnCreated(self, x)
	if IsServer() then
		self.selectionKeys = {}
		local y = self:GetParent():GetPlayerOwnerID()
		local z = PlayerData:getplayerData(y)
		if z then
			local A = z.hero
			if A then
				local B = A:getItemList()
				A.itemList = {}
				A.overrideItemList = {}
				A:addItem(A.hero)
				A:updateItemNetTable()
				B = f(B, function(C, D)
					return KeyValues.EquipmentKv[D] ~= nil
				end)
				B = g(B, function(C, E, F)
					return KeyValues.EquipmentKv[E].ItemLevel - KeyValues.EquipmentKv[F].ItemLevel
				end)
				local G = {}
				local H = A.unitName
				local I = AbilityShop:GetRecommendSectByHeroName(H)
				if I ~= "sect_none" then
					G = h(I, "|")
				end
				do
					local J = 0
					while J < #B do
						local K = KeyValues.EquipmentKv[B[J + 1]].ItemLevel
						local L = PlayerData:getEquipmentPoolWithLevel(y, K)
						local M = {}
						local N = self.selectionCount
						if #G > 0 then
							local O = i(o, {})
							L:each(function(C, D)
								if KeyValues.EquipmentKv[D].Sect and j(G, KeyValues.EquipmentKv[D].Sect) then
									O:set(D, 1)
								end
							end)
							if O:count() > 0 then
								local P = O:random()
								if P then
									M[#M + 1] = P
									O:remove(P)
									N = N - 1
								end
							end
						end
						do
							local J = 0
							while J < N do
								local Q = L:random()
								if Q then
									M[#M + 1] = Q
									L:remove(Q)
								end
								J = J + 1
							end
						end
						ShuffledList(M, true)
						local R = J + 1
						local S
						S = Selection:AddSpecialSelection(y, "equipment", M, function(C, Q)
							if A then
								A:modifyOverrideItem(Q, R)
							end
							if IsValid(self) then
								k(self.selectionKeys, S)
							end
							return true
						end, function()
							local L = PlayerData:getEquipmentPoolWithLevel(y, K)
							local M = {}
							do
								local J = 0
								while J < self.selectionCount do
									local Q = L:random()
									if Q then
										M[#M + 1] = Q
										L:remove(Q)
									end
									J = J + 1
								end
							end
							return M
						end, z.equipmentRefreshMax, false)
						self.selectionKeys[S] = L
						J = J + 1
					end
				end
			end
		end
	end
end
function w.prototype.OnDestroy(self)
	if IsServer() then
		local y = self:GetParent():GetPlayerOwnerID()
		for S, T in pairs(self.selectionKeys) do
			Selection:RemoveSpecialSelection(y, S)
		end
		Selection:UpdateNetTables(y)
	end
end
w = e(
	{ u(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	w
)
m.modifier_trait_143 = w
return m