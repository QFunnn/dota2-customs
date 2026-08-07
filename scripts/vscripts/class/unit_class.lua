--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "class/unit_class"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__StringSplit
local e = b.__TS__ArraySort
local f = b.__TS__ArrayIndexOf
local g = b.__TS__StringReplace
local h = b.__TS__Number
local i = b.__TS__ObjectKeys
local j = b.__TS__ArrayReduce
local k = b.__TS__Delete
local l = b.__TS__ArrayForEach
local m = b.__TS__DecorateLegacy
local n = b.__TS__SourceMapTraceBack
n(
	debug.getinfo(1).short_src,
	{
		["16"] = 1,
		["17"] = 1,
		["19"] = 13,
		["20"] = 14,
		["21"] = 13,
		["22"] = 61,
		["23"] = 40,
		["24"] = 54,
		["25"] = 62,
		["26"] = 63,
		["27"] = 64,
		["28"] = 65,
		["29"] = 66,
		["30"] = 67,
		["31"] = 68,
		["32"] = 69,
		["33"] = 70,
		["34"] = 71,
		["35"] = 72,
		["36"] = 61,
		["37"] = 79,
		["38"] = 80,
		["39"] = 81,
		["41"] = 79,
		["42"] = 85,
		["43"] = 86,
		["44"] = 87,
		["45"] = 88,
		["46"] = 88,
		["47"] = 88,
		["48"] = 88,
		["49"] = 88,
		["50"] = 88,
		["51"] = 88,
		["52"] = 88,
		["53"] = 88,
		["54"] = 89,
		["55"] = 90,
		["56"] = 89,
		["57"] = 92,
		["58"] = 93,
		["59"] = 94,
		["60"] = 95,
		["61"] = 96,
		["63"] = 85,
		["64"] = 100,
		["65"] = 101,
		["66"] = 102,
		["67"] = 102,
		["68"] = 102,
		["69"] = 102,
		["70"] = 102,
		["71"] = 102,
		["72"] = 103,
		["73"] = 103,
		["74"] = 103,
		["75"] = 103,
		["76"] = 103,
		["77"] = 103,
		["78"] = 104,
		["79"] = 104,
		["80"] = 104,
		["81"] = 104,
		["82"] = 104,
		["83"] = 104,
		["84"] = 105,
		["85"] = 105,
		["86"] = 105,
		["87"] = 105,
		["88"] = 105,
		["89"] = 105,
		["90"] = 106,
		["91"] = 106,
		["92"] = 106,
		["93"] = 106,
		["94"] = 106,
		["95"] = 106,
		["96"] = 107,
		["97"] = 108,
		["98"] = 109,
		["100"] = 111,
		["101"] = 112,
		["102"] = 100,
		["103"] = 123,
		["104"] = 123,
		["105"] = 123,
		["107"] = 123,
		["108"] = 123,
		["110"] = 124,
		["111"] = 125,
		["112"] = 126,
		["113"] = 128,
		["116"] = 133,
		["117"] = 134,
		["118"] = 134,
		["119"] = 136,
		["120"] = 138,
		["121"] = 139,
		["122"] = 140,
		["123"] = 140,
		["124"] = 141,
		["126"] = 123,
		["127"] = 147,
		["128"] = 148,
		["129"] = 149,
		["130"] = 150,
		["131"] = 151,
		["132"] = 152,
		["134"] = 154,
		["135"] = 155,
		["137"] = 157,
		["138"] = 158,
		["141"] = 161,
		["142"] = 162,
		["143"] = 163,
		["144"] = 164,
		["145"] = 165,
		["146"] = 167,
		["147"] = 167,
		["148"] = 167,
		["149"] = 167,
		["150"] = 167,
		["151"] = 167,
		["152"] = 167,
		["153"] = 165,
		["154"] = 147,
		["155"] = 182,
		["156"] = 183,
		["157"] = 184,
		["158"] = 185,
		["159"] = 186,
		["160"] = 187,
		["161"] = 188,
		["164"] = 191,
		["165"] = 191,
		["166"] = 191,
		["167"] = 192,
		["168"] = 191,
		["169"] = 191,
		["170"] = 195,
		["171"] = 196,
		["172"] = 197,
		["174"] = 199,
		["176"] = 201,
		["178"] = 203,
		["179"] = 204,
		["180"] = 204,
		["181"] = 204,
		["182"] = 204,
		["183"] = 204,
		["184"] = 204,
		["185"] = 204,
		["187"] = 205,
		["188"] = 205,
		["189"] = 206,
		["190"] = 207,
		["191"] = 208,
		["192"] = 209,
		["193"] = 211,
		["195"] = 205,
		["198"] = 214,
		["199"] = 214,
		["200"] = 214,
		["201"] = 214,
		["202"] = 214,
		["203"] = 215,
		["204"] = 215,
		["205"] = 215,
		["206"] = 215,
		["207"] = 215,
		["208"] = 182,
		["209"] = 218,
		["210"] = 219,
		["212"] = 220,
		["213"] = 220,
		["214"] = 221,
		["215"] = 223,
		["216"] = 225,
		["217"] = 226,
		["218"] = 227,
		["219"] = 228,
		["222"] = 231,
		["223"] = 231,
		["224"] = 231,
		["225"] = 232,
		["226"] = 233,
		["227"] = 234,
		["228"] = 231,
		["229"] = 231,
		["230"] = 236,
		["232"] = 220,
		["235"] = 240,
		["236"] = 241,
		["237"] = 242,
		["238"] = 243,
		["239"] = 244,
		["240"] = 245,
		["241"] = 247,
		["242"] = 218,
		["243"] = 260,
		["244"] = 261,
		["245"] = 261,
		["247"] = 262,
		["248"] = 262,
		["249"] = 263,
		["250"] = 264,
		["251"] = 265,
		["253"] = 262,
		["256"] = 270,
		["257"] = 270,
		["258"] = 270,
		["259"] = 271,
		["260"] = 270,
		["261"] = 270,
		["262"] = 270,
		["263"] = 273,
		["265"] = 260,
		["266"] = 281,
		["267"] = 282,
		["268"] = 282,
		["269"] = 284,
		["270"] = 286,
		["272"] = 286,
		["274"] = 281,
		["275"] = 290,
		["276"] = 291,
		["277"] = 291,
		["278"] = 294,
		["279"] = 294,
		["280"] = 294,
		["281"] = 294,
		["282"] = 294,
		["283"] = 290,
		["284"] = 298,
		["285"] = 299,
		["286"] = 300,
		["287"] = 301,
		["288"] = 302,
		["291"] = 305,
		["292"] = 305,
		["293"] = 305,
		["294"] = 305,
		["295"] = 305,
		["296"] = 298,
		["297"] = 309,
		["298"] = 310,
		["299"] = 310,
		["300"] = 310,
		["301"] = 311,
		["302"] = 312,
		["304"] = 310,
		["305"] = 310,
		["306"] = 309,
		["307"] = 317,
		["308"] = 318,
		["309"] = 318,
		["310"] = 318,
		["311"] = 319,
		["312"] = 320,
		["314"] = 318,
		["315"] = 318,
		["316"] = 317,
		["317"] = 330,
		["318"] = 331,
		["319"] = 330,
		["320"] = 334,
		["321"] = 335,
		["322"] = 334,
		["323"] = 338,
		["324"] = 339,
		["325"] = 338,
		["326"] = 345,
		["327"] = 345,
		["328"] = 345,
		["330"] = 345,
		["331"] = 356,
		["332"] = 357,
		["333"] = 356,
		["334"] = 360,
		["335"] = 361,
		["336"] = 360,
		["337"] = 364,
		["338"] = 365,
		["339"] = 365,
		["340"] = 365,
		["341"] = 365,
		["342"] = 365,
		["343"] = 365,
		["344"] = 365,
		["345"] = 365,
		["346"] = 365,
		["347"] = 365,
		["348"] = 365,
		["349"] = 365,
		["350"] = 365,
		["351"] = 365,
		["352"] = 365,
		["353"] = 366,
		["354"] = 364,
		["355"] = 13,
		["356"] = 14,
	}
)
local o = {}
local p = require("lib.tstl-utils")
local q = p.reloadable
o.CUnitBase = c()
local r = o.CUnitBase
r.name = "CUnitBase"
function r.prototype.____constructor(self, s, t)
	self.prePurchaseAbilityData = {}
	self.customAbility = {}
	self.playerID = s
	self.unitName = t
	self.level = 1
	self.sectData = {}
	self.abilityData = {}
	self.talentBranch = {}
	self.itemList = {}
	self.itemCharges = {}
	self.savedData = {}
	self:initAbility()
	self:createUnit()
end
function r.prototype.initAbility(self)
	for u, v in pairs(KeyValues.SectAbilitiesKv) do
		self.sectData[u] = { level = 0, exp = 0, count = 0 }
	end
end
function r.prototype.createUnit(self)
	local w = PlayerResource:GetSelectedHeroEntity(self.playerID)
	if w then
		self.unit = CreateUnitByNameWithNewData(
			self.unitName,
			PlayerData:getPlayerHomeHeroPosition(self.playerID),
			true,
			w,
			w,
			w:GetTeamNumber(),
			nil
		)
		self.unit.GetUnitBase = function()
			return self
		end
		self.unit:SetForwardVector(vec3_bottom)
		self.unit:SetUnitCanRespawn(true)
		self:resetUnit()
		PlayerData.playerData[self.playerID].heroEntIndex = self.unit:entindex()
		PlayerData:updateNetTable(self.playerID)
	end
end
function r.prototype.resetUnit(self)
	self.unit:RemoveAllModifiers(0, false, true, true)
	self.unit:AddNewModifier(self.unit, self.unit:GetDummyAbility(), "modifier_common", nil)
	self.unit:AddNewModifier(self.unit, self.unit:GetDummyAbility(), "modifier_ultra", nil)
	self.unit:AddNewModifier(self.unit, self.unit:GetDummyAbility(), "modifier_hero", nil)
	self.unit:AddNewModifier(self.unit, self.unit:GetDummyAbility(), "modifier_invulnerable", nil)
	self.unit:AddNewModifier(self.unit, self.unit:GetDummyAbility(), "modifier_custom_no_health_bar", nil)
	for u, v in pairs(KeyValues.SectAbilitiesKv) do
		self.unit:RemoveAbility(u)
		self.unit:AddAbility(u, 1)
	end
	local x = Wearable:serviceGetEquipWearable(self.playerID, self.unitName)
	Wearable:equipWearable(self.unit, x)
end
function r.prototype.learnAbility(self, y, z, A)
	if z == nil then
		z = false
	end
	if A == nil then
		A = true
	end
	local B = KeyValues.AbilityUpgradesKvs[y]
	local C = SECT_ABILITY_LEVEL[B.rarity]
	if self.abilityData[y] ~= nil and self.abilityData[y].level >= C then
		ErrorMessage(self.playerID, "等级已达上限")
		return
	end
	self.abilityData[y] = self.abilityData[y] or { level = 0 }
	local D, E = self.abilityData[y], "level"
	D[E] = D[E] + 1
	local F = SECT_EXP[B.rarity]
	local G = d(B.sect, "|")
	for H, u in ipairs(G) do
		local I, J = self.sectData[u], "count"
		I[J] = I[J] + 1
		self:addSectExp(u, F)
	end
end
function r.prototype.perPurchaseAbility(self, y)
	local K = KeyValues.AbilityUpgradesKvs[y]
	local C = SECT_ABILITY_LEVEL[K.rarity]
	local L = 0
	if self.abilityData[y] ~= nil and self.abilityData[y].level then
		L = L + self.abilityData[y].level
	end
	if self.prePurchaseAbilityData[y] ~= nil then
		L = L + self.prePurchaseAbilityData[y]
	end
	if L >= C then
		ErrorMessage(self.playerID, "等级已达上限")
		return
	end
	self.prePurchaseAbilityData[y] = (self.prePurchaseAbilityData[y] or 0) + 1
	self:syncAbilityData()
	local M = PlayerResource:GetSelectedHeroEntity(self.playerID)
	local G = d(K.sect, "|")
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN,
		{
			abilityname = y,
			playerhero = M,
			heroclass = self,
			abilityUpgradeInfo = K,
			currentSectList = G,
			bFirstLearn = false,
			bGift = false,
		},
		M,
		self.unit
	)
end
function r.prototype.refreshSectParticle(self, N)
	local G = {}
	for u in pairs(self.sectData) do
		local O = self.sectData[u]
		local P = O.level
		if P >= 3 then
			G[#G + 1] = { sectName = u, level = P, exp = O.exp }
		end
	end
	e(G, function(H, Q, R)
		return R.exp - Q.exp
	end)
	if LoadData(N, "_SectSurroundParticle") == nil then
		local S = ParticleManager:CreateParticle("particles/pak/main.vpcf", PATTACH_ABSORIGIN_FOLLOW, N)
		SaveData(N, "_SectSurroundParticle", S)
	end
	local S = LoadData(N, "_SectSurroundParticle")
	local T = { 0, 0, 0 }
	local U = { 0, 0, 0 }
	local V = { 0, 0, 0, 3, 3 }
	do
		local W = 0
		while W < 3 do
			if G[W + 1] then
				local X = self:getSectParticleIndex(G[W + 1].sectName)
				local Y = G[W + 1].level
				T[W + 1] = X
				U[W + 1] = V[Y]
			end
			W = W + 1
		end
	end
	ParticleManager:SetParticleControl(S, 1, Vector(T[1], T[2], T[3]))
	ParticleManager:SetParticleControl(S, 2, Vector(U[1], U[2], U[3]))
end
function r.prototype.leveUP(self)
	local P = self:getLevel()
	do
		local W = self.level + 1
		while W <= P do
			if f(TALENT_REQUIRE_LEVEL, W + 1) ~= -1 then
				PlayerData:modifyTalentPoint(self.playerID, 1)
				local Z = {}
				for _, a0 in pairs(KeyValues.HeroTalentKv) do
					if a0.Hero == self.unitName and a0.RequiredLevel == W + 1 then
						Z[#Z + 1] = _
					end
				end
				e(Z, function(H, Q, R)
					local a1 = h(g(Q, self.unitName .. "_talent_", "")) or 0
					local a2 = h(g(R, self.unitName .. "_talent_", "")) or 0
					return a1 - a2
				end)
				PlayerData:addTalentSelection(self.playerID, Z)
			end
			W = W + 1
		end
	end
	local a3 = PlayerData:getplayerData(self.playerID)
	PlayerData:adjustPlayerDamage(self.playerID, false)
	a3.heroLevel = P + 1
	a3.shopHeroLevel = P + 1
	a3:updateAbilityShopWightData()
	PlayerData:updateNetTable(self.playerID)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP,
		{ player_id = self.playerID, up_lvl = P - self.level, lvl = P + 1 },
		self.unit
	)
end
function r.prototype.addSectExp(self, u, a4)
	local a5, a6 = self.sectData[u], "exp"
	a5[a6] = a5[a6] + a4
	do
		local W = 0
		while W < #SECT_MAX_EXP do
			local a7 = PlayerData:getMaxSectExp(self.playerID, W, u)
			if self.sectData[u].exp >= a7 then
				self.sectData[u].level = W + 1
			end
			W = W + 1
		end
	end
	local a8 = j(i(self.sectData), function(H, a9, aa)
		return a9 + self.sectData[aa].level
	end, 1)
	if a8 > self.level then
	end
end
function r.prototype.addItem(self, ab)
	local ac = self.itemList
	ac[#ac + 1] = { itemName = ab }
	self.unit:AddItemByName(ab)
	local ad = self.unit:FindModifierByName("modifier_hero")
	if ad ~= nil then
		ad:RefreshInventory()
	end
end
function r.prototype.learnTalent(self, _)
	local ae = self.talentBranch
	ae[#ae + 1] = _
	CustomNetTables:SetTableValue("common", "hero_talent_" .. tostring(self.playerID), self.talentBranch)
end
function r.prototype.setCustomAbility(self, af, u)
	self.customAbility[af] = u
	for ag, v in pairs(self.customAbility) do
		if ag ~= af and self.customAbility[ag] == self.customAbility[af] then
			k(self.customAbility, ag)
		end
	end
	CustomNetTables:SetTableValue("sect_data", "sect_merge_" .. tostring(self.playerID), self.customAbility)
end
function r.prototype.modifyItemCharge(self, ab, ah)
	l(self.itemList, function(H, ai)
		if ai.itemName == ab then
			ai.charge = (ai.charge or 0) + ah
		end
	end)
end
function r.prototype.setItemCharge(self, ab, ah)
	l(self.itemList, function(H, ai)
		if ai.itemName == ab then
			ai.charge = ah
		end
	end)
end
function r.prototype.getLevel(self)
	return self.level
end
function r.prototype.getUnit(self)
	return self.unit
end
function r.prototype.getUnitEntIndex(self)
	return self.unit:entindex()
end
function r.prototype.syncAbilityData(self, aj)
	if aj == nil then
		aj = false
	end
end
function r.prototype.saveData(self, ak, al)
	self.savedData[ak] = al
end
function r.prototype.loadData(self, ak)
	return self.savedData[ak]
end
function r.prototype.getSectParticleIndex(self, u)
	local am = {
		"sect_none",
		"sect_attack",
		"sect_evade",
		"sect_crit",
		"sect_health",
		"sect_regen",
		"sect_ulti",
		"sect_poison",
		"sect_ice",
		"sect_fury",
		"sect_shield",
		"sect_injury",
		"sect_wisp",
	}
	return f(am, u)
end
r = m({ q }, r)
o.CUnitBase = r
return o