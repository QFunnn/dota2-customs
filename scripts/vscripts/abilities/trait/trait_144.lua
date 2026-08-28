--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_144"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Delete
local g = b.__TS__ArrayFilter
local h = b.__TS__ArraySort
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 19,
		["31"] = 12,
		["32"] = 19,
		["34"] = 19,
		["35"] = 21,
		["36"] = 12,
		["37"] = 25,
		["38"] = 26,
		["39"] = 27,
		["40"] = 25,
		["41"] = 30,
		["42"] = 31,
		["43"] = 32,
		["44"] = 33,
		["45"] = 34,
		["46"] = 35,
		["47"] = 36,
		["48"] = 37,
		["49"] = 38,
		["50"] = 39,
		["51"] = 40,
		["52"] = 41,
		["53"] = 41,
		["54"] = 41,
		["55"] = 41,
		["56"] = 41,
		["57"] = 45,
		["58"] = 46,
		["59"] = 47,
		["60"] = 48,
		["61"] = 49,
		["62"] = 50,
		["63"] = 51,
		["64"] = 52,
		["66"] = 54,
		["67"] = 55,
		["69"] = 57,
		["71"] = 41,
		["72"] = 41,
		["73"] = 41,
		["74"] = 41,
		["75"] = 41,
		["76"] = 64,
		["80"] = 30,
		["81"] = 69,
		["82"] = 70,
		["83"] = 71,
		["84"] = 72,
		["85"] = 73,
		["86"] = 74,
		["87"] = 75,
		["88"] = 76,
		["89"] = 77,
		["90"] = 77,
		["91"] = 77,
		["92"] = 78,
		["93"] = 79,
		["97"] = 84,
		["98"] = 85,
		["100"] = 69,
		["101"] = 88,
		["102"] = 89,
		["103"] = 90,
		["104"] = 91,
		["105"] = 92,
		["106"] = 93,
		["107"] = 94,
		["108"] = 95,
		["109"] = 96,
		["110"] = 97,
		["111"] = 99,
		["112"] = 99,
		["113"] = 99,
		["114"] = 99,
		["115"] = 100,
		["116"] = 100,
		["117"] = 100,
		["118"] = 100,
		["120"] = 102,
		["121"] = 102,
		["122"] = 103,
		["123"] = 104,
		["125"] = 105,
		["126"] = 105,
		["127"] = 106,
		["128"] = 105,
		["131"] = 108,
		["133"] = 109,
		["134"] = 109,
		["135"] = 110,
		["136"] = 111,
		["137"] = 112,
		["138"] = 113,
		["139"] = 114,
		["141"] = 109,
		["144"] = 117,
		["145"] = 118,
		["146"] = 118,
		["147"] = 118,
		["148"] = 118,
		["149"] = 118,
		["150"] = 122,
		["151"] = 123,
		["152"] = 124,
		["153"] = 125,
		["155"] = 127,
		["156"] = 128,
		["158"] = 130,
		["159"] = 118,
		["160"] = 132,
		["161"] = 133,
		["163"] = 134,
		["164"] = 134,
		["165"] = 135,
		["166"] = 134,
		["169"] = 137,
		["171"] = 138,
		["172"] = 138,
		["173"] = 139,
		["174"] = 140,
		["175"] = 141,
		["176"] = 142,
		["178"] = 138,
		["181"] = 145,
		["182"] = 118,
		["183"] = 118,
		["184"] = 118,
		["185"] = 118,
		["186"] = 150,
		["187"] = 102,
		["192"] = 88,
		["193"] = 156,
		["194"] = 157,
		["195"] = 158,
		["196"] = 159,
		["197"] = 160,
		["199"] = 162,
		["201"] = 156,
		["202"] = 19,
		["203"] = 12,
		["204"] = 12,
		["205"] = 12,
		["206"] = 12,
		["207"] = 12,
		["208"] = 12,
		["209"] = 12,
		["210"] = 19,
		["212"] = 19,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.trait_144 = c()
local q = j.trait_144
q.name = "trait_144"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_144"
end
q = e({ m(nil) }, q)
j.trait_144 = q
j.modifier_trait_144 = c()
local r = j.modifier_trait_144
r.name = "modifier_trait_144"
d(r, o)
function r.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.equipmentCount = 3
end
function r.prototype.GetAbilitySpecialValue(self)
	self.convert_pct = self:GetAbilitySpecialValueFor("convert_pct")
	self.hero = self:GetAbilitySpecialValueFor("hero")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self.selectionKeys = {}
		local t = self:GetParent():GetPlayerOwnerID()
		local u = PlayerData:getplayerData(t)
		if u then
			local v = u.hero
			local w = PlayerData:getPlayerHeroPool(t)
			ArrayRemove(w, u.heroName)
			local x = PickList(w, self.hero, true)
			if v then
				local y
				y = Selection:AddSpecialSelection(t, "hero", x, function(z, A)
					if IsValid(self) then
						if GameState:isCeaseFireState() then
							self:BeforeChangeHero()
							PlayerData:changeHeroForPlayer(t, A, true, false)
							self:AfterChangeHero()
							f(self.selectionKeys, y)
							return true
						end
						ErrorMessage(t, "#battle_cannotchoose")
						return false
					else
						return true
					end
				end, nil, nil, false)
				self.selectionKeys[y] = true
			end
		end
	end
end
function r.prototype.BeforeChangeHero(self)
	local t = self:GetParent():GetPlayerOwnerID()
	local u = PlayerData:getplayerData(t)
	if u then
		local v = PlayerData:getHero(t)
		local B = 0
		if v then
			local C = v:getAbilityUpgradeData()
			for D, E in pairs(C) do
				local F
				F = E.level
				if F > 0 then
					B = B + KeyValues.AbilityUpgradesKvs[D].cost * F
				end
			end
		end
		u.totalGold = u.gold + u.shardCost
		PlayerData:modifyGold(t, B * self.convert_pct * 0.01)
	end
end
function r.prototype.AfterChangeHero(self)
	local t = self:GetParent():GetPlayerOwnerID()
	local u = PlayerData:getplayerData(t)
	local G = {}
	local H = {}
	if u then
		local v = u.hero
		if v then
			local I = v:getItemList()
			v:resetEquipment()
			I = g(I, function(z, J)
				return KeyValues.EquipmentKv[J] ~= nil
			end)
			I = h(I, function(z, K, L)
				return KeyValues.EquipmentKv[K].ItemLevel - KeyValues.EquipmentKv[L].ItemLevel
			end)
			do
				local M = 0
				while M < #I do
					local N = KeyValues.EquipmentKv[I[M + 1]].ItemLevel
					local O = PlayerData:getEquipmentPoolWithLevel(t, N)
					do
						local P = 0
						while P < #H do
							O:remove(H[P + 1])
							P = P + 1
						end
					end
					local x = {}
					do
						local M = 0
						while M < self.equipmentCount do
							local A = O:random()
							H[#H + 1] = A
							if A then
								x[#x + 1] = A
								O:remove(A)
							end
							M = M + 1
						end
					end
					local Q = M + 1
					local y
					y = Selection:AddSpecialSelection(t, "equipment", x, function(z, A)
						if v then
							v:modifyOverrideItem(A, Q)
							G[#G + 1] = A
						end
						if IsValid(self) then
							f(self.selectionKeys, y)
						end
						return true
					end, function()
						local O = PlayerData:getEquipmentPoolWithLevel(t, N)
						do
							local P = 0
							while P < #G do
								O:remove(G[P + 1])
								P = P + 1
							end
						end
						local x = {}
						do
							local M = 0
							while M < self.equipmentCount do
								local A = O:random()
								if A then
									x[#x + 1] = A
									O:remove(A)
								end
								M = M + 1
							end
						end
						return x
					end, u.equipmentRefreshMax, false)
					self.selectionKeys[y] = true
					M = M + 1
				end
			end
		end
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() then
		local t = self:GetParent():GetPlayerOwnerID()
		for y, R in pairs(self.selectionKeys) do
			Selection:RemoveSpecialSelection(t, y)
		end
		Selection:UpdateNetTables(t)
	end
end
r = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
j.modifier_trait_144 = r
return j