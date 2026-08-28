--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_185"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__ArrayIncludes
local h = b.__TS__ArrayFilter
local i = b.__TS__ObjectKeys
local j = b.__TS__Delete
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 11,
		["20"] = 12,
		["21"] = 11,
		["22"] = 12,
		["23"] = 13,
		["24"] = 13,
		["25"] = 13,
		["26"] = 12,
		["27"] = 11,
		["28"] = 12,
		["30"] = 12,
		["31"] = 15,
		["32"] = 22,
		["33"] = 15,
		["34"] = 22,
		["35"] = 23,
		["36"] = 24,
		["37"] = 25,
		["38"] = 25,
		["39"] = 24,
		["40"] = 23,
		["41"] = 28,
		["42"] = 29,
		["45"] = 30,
		["46"] = 31,
		["47"] = 31,
		["48"] = 31,
		["49"] = 31,
		["50"] = 31,
		["51"] = 31,
		["52"] = 28,
		["53"] = 22,
		["54"] = 15,
		["55"] = 15,
		["56"] = 15,
		["57"] = 15,
		["58"] = 15,
		["59"] = 15,
		["60"] = 15,
		["61"] = 22,
		["63"] = 22,
		["64"] = 35,
		["65"] = 42,
		["66"] = 35,
		["67"] = 42,
		["69"] = 42,
		["70"] = 44,
		["71"] = 46,
		["72"] = 47,
		["73"] = 35,
		["74"] = 49,
		["75"] = 50,
		["76"] = 49,
		["77"] = 57,
		["78"] = 58,
		["81"] = 59,
		["84"] = 60,
		["85"] = 61,
		["88"] = 65,
		["89"] = 66,
		["90"] = 67,
		["91"] = 68,
		["94"] = 70,
		["95"] = 71,
		["98"] = 72,
		["99"] = 73,
		["100"] = 74,
		["103"] = 75,
		["106"] = 77,
		["107"] = 79,
		["110"] = 83,
		["111"] = 84,
		["112"] = 84,
		["114"] = 85,
		["115"] = 86,
		["116"] = 86,
		["118"] = 89,
		["119"] = 90,
		["120"] = 91,
		["121"] = 92,
		["122"] = 94,
		["123"] = 95,
		["124"] = 95,
		["125"] = 95,
		["126"] = 95,
		["127"] = 96,
		["128"] = 97,
		["131"] = 100,
		["132"] = 100,
		["134"] = 101,
		["135"] = 101,
		["137"] = 102,
		["138"] = 103,
		["140"] = 57,
		["141"] = 107,
		["142"] = 108,
		["143"] = 109,
		["146"] = 111,
		["147"] = 112,
		["148"] = 113,
		["149"] = 114,
		["150"] = 115,
		["152"] = 116,
		["153"] = 117,
		["154"] = 117,
		["156"] = 118,
		["157"] = 118,
		["159"] = 118,
		["160"] = 119,
		["161"] = 119,
		["163"] = 120,
		["164"] = 121,
		["165"] = 122,
		["166"] = 122,
		["171"] = 126,
		["172"] = 127,
		["173"] = 128,
		["175"] = 129,
		["176"] = 130,
		["177"] = 130,
		["179"] = 131,
		["180"] = 131,
		["182"] = 131,
		["183"] = 132,
		["184"] = 132,
		["186"] = 133,
		["187"] = 134,
		["188"] = 135,
		["189"] = 135,
		["194"] = 139,
		["195"] = 139,
		["196"] = 139,
		["197"] = 139,
		["198"] = 140,
		["201"] = 141,
		["202"] = 142,
		["205"] = 144,
		["206"] = 145,
		["207"] = 146,
		["208"] = 147,
		["209"] = 148,
		["210"] = 149,
		["211"] = 150,
		["213"] = 151,
		["216"] = 152,
		["217"] = 153,
		["218"] = 153,
		["220"] = 154,
		["221"] = 155,
		["222"] = 156,
		["223"] = 157,
		["228"] = 161,
		["229"] = 107,
		["230"] = 164,
		["231"] = 165,
		["232"] = 166,
		["234"] = 167,
		["236"] = 167,
		["238"] = 167,
		["239"] = 167,
		["241"] = 168,
		["245"] = 170,
		["246"] = 164,
		["247"] = 173,
		["248"] = 174,
		["249"] = 175,
		["251"] = 176,
		["253"] = 177,
		["254"] = 177,
		["256"] = 177,
		["257"] = 177,
		["259"] = 178,
		["260"] = 179,
		["261"] = 180,
		["262"] = 181,
		["264"] = 183,
		["265"] = 184,
		["266"] = 185,
		["267"] = 186,
		["268"] = 187,
		["269"] = 188,
		["271"] = 190,
		["272"] = 191,
		["276"] = 173,
		["277"] = 195,
		["278"] = 196,
		["279"] = 197,
		["280"] = 198,
		["281"] = 199,
		["282"] = 200,
		["284"] = 201,
		["285"] = 202,
		["286"] = 202,
		["288"] = 203,
		["289"] = 204,
		["290"] = 205,
		["291"] = 206,
		["292"] = 207,
		["293"] = 207,
		["298"] = 209,
		["299"] = 210,
		["300"] = 211,
		["302"] = 195,
		["303"] = 215,
		["304"] = 216,
		["307"] = 217,
		["310"] = 218,
		["311"] = 219,
		["312"] = 220,
		["313"] = 221,
		["314"] = 226,
		["315"] = 215,
		["316"] = 233,
		["317"] = 234,
		["320"] = 235,
		["321"] = 236,
		["324"] = 237,
		["325"] = 238,
		["326"] = 233,
		["327"] = 241,
		["328"] = 242,
		["329"] = 243,
		["330"] = 244,
		["332"] = 241,
		["333"] = 248,
		["334"] = 249,
		["337"] = 250,
		["338"] = 251,
		["339"] = 252,
		["341"] = 254,
		["342"] = 255,
		["343"] = 256,
		["345"] = 258,
		["346"] = 259,
		["347"] = 260,
		["348"] = 261,
		["349"] = 248,
		["350"] = 42,
		["351"] = 35,
		["352"] = 35,
		["353"] = 35,
		["354"] = 35,
		["355"] = 35,
		["356"] = 35,
		["357"] = 35,
		["358"] = 42,
		["360"] = 42,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
l.trait_185 = c()
local s = l.trait_185
s.name = "trait_185"
d(s, n)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_185"
end
s = e({ o(nil) }, s)
l.trait_185 = s
l.modifier_trait_185 = c()
local t = l.modifier_trait_185
t.name = "modifier_trait_185"
d(t, q)
function t.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function t.prototype.OnTraitInit(self, u)
	if u.hero:IsCustomIllusion() then
		return
	end
	u.hero:RemoveModifierByName("modifier_trait_185_buff")
	u.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_185_buff", {})
end
t = e(
	{ r(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
l.modifier_trait_185 = t
l.modifier_trait_185_buff = c()
local v = l.modifier_trait_185_buff
v.name = "modifier_trait_185_buff"
d(v, q)
function v.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.suppressedAbilities = {}
	self.suppressedCardCount = 0
	self.suppressionHandled = false
end
function v.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function v.prototype.OnConfirmBattle(self, u)
	if not IsServer() or u.isNeutral then
		return
	end
	if self:GetParent():IsCustomIllusion() then
		return
	end
	if self.suppressionHandled then
		self.suppressionHandled = false
		return
	end
	local w = self:GetParent()
	local x = w:GetPlayerOwnerID()
	local y = w:GetEnemy()
	if not IsValid(y) or y:IsNeutral() then
		return
	end
	local z = PlayerData:getEnemyPlayerID(x)
	if z == nil or z < 0 then
		return
	end
	local A = PlayerData:getHero(z)
	local B = PlayerData:getHero(x)
	if not A or not B then
		return
	end
	if A:isIllusion(y) or y:IsCustomIllusion() then
		return
	end
	local C = y:FindModifierByName("modifier_trait_185_buff")
	if C and x > z then
		return
	end
	self.suppressionHandled = true
	if C then
		C.suppressionHandled = true
	end
	self:RestoreEnemyAbilities()
	if C then
		C:RestoreEnemyAbilities()
	end
	local D = self:CreateSuppressionPlan(B, A)
	if C then
		local E = C:CreateSuppressionPlan(A, B)
		if D and E and D.sect == E.sect then
			for F, G in ipairs({ "n", "r" }) do
				local H = math.min(self:GetSuppressedCardCount(D, G), C:GetSuppressedCardCount(E, G))
				self:LimitSuppressionPlan(D, H, G)
				C:LimitSuppressionPlan(E, H, G)
			end
		end
		if D then
			self:ApplySuppressionPlan(A, D)
		end
		if E then
			C:ApplySuppressionPlan(B, E)
		end
	elseif D then
		self:ApplySuppressionPlan(A, D)
	end
end
function v.prototype.CreateSuppressionPlan(self, I, J)
	local K = PlayerData:getplayerData(J.playerID)
	if not K then
		return
	end
	local L = AbilityShop:GetRecommendSectByHeroName(K.heroName)
	local M = L == "sect_none" and {} or f(L, "|")
	local N = I:getAbilityUpgradeData(true, true)
	local O = {}
	for P in pairs(N) do
		do
			local Q = KeyValues.AbilityUpgradesKvs[P]
			local R = N[P]
			local S = R and R.level or 0
			local T
			if Q ~= nil then
				T = Q.rarity
			end
			local G = T
			if not Q or S <= 0 or G ~= "n" and G ~= "r" or type(Q.sect) ~= "string" then
				goto U
			end
			for F, V in ipairs(f(Q.sect, "|")) do
				O[V] = O[V] or { n = 0, r = 0 }
				local W, X = O[V], G
				W[X] = W[X] + S
			end
		end
		::U::
	end
	local Y = J:getAbilityUpgradeData(true, true)
	local Z = {}
	for P in pairs(Y) do
		do
			local Q = KeyValues.AbilityUpgradesKvs[P]
			local _ = Y[P]
			local S = _ and _.level or 0
			local a0
			if Q ~= nil then
				a0 = Q.rarity
			end
			local G = a0
			if not Q or S <= 0 or G ~= "n" and G ~= "r" or type(Q.sect) ~= "string" then
				goto a1
			end
			for F, V in ipairs(f(Q.sect, "|")) do
				Z[V] = Z[V] or { n = {}, r = {} }
				local a2 = Z[V][G]
				a2[#a2 + 1] = P
			end
		end
		::a1::
	end
	local a3 = h(AbilityShop.pickList, function(F, V)
		return not g(M, V)
	end)
	if #a3 <= 0 then
		return
	end
	local V = GetRandomElement(a3)
	if V == nil then
		return
	end
	local a4 = Z[V] or { n = {}, r = {} }
	local a5 = O[V] or { n = 0, r = 0 }
	local a6 = {}
	local a7 = {}
	for F, G in ipairs({ "n", "r" }) do
		local a8 = a5[G]
		for F, P in ipairs(a4[G]) do
			do
				if a8 <= 0 then
					break
				end
				local a9 = Y[P]
				if not a9 or (a9.level or 0) <= 0 then
					goto aa
				end
				local ab = math.min(a9.level or 0, a8)
				a6[P] = deepcopy(a9)
				a7[P] = ab
				a8 = a8 - ab
			end
			::aa::
		end
	end
	return { sect = V, suppressedAbilities = a6, suppressedLevels = a7 }
end
function v.prototype.GetSuppressedCardCount(self, ac, G)
	local ad = 0
	for F, P in ipairs(i(ac.suppressedLevels)) do
		do
			local ae = KeyValues.AbilityUpgradesKvs[P]
			if ae ~= nil then
				ae = ae.rarity
			end
			if ae ~= G then
				goto af
			end
			ad = ad + (ac.suppressedLevels[P] or 0)
		end
		::af::
	end
	return ad
end
function v.prototype.LimitSuppressionPlan(self, ac, ag, G)
	local ah = ag
	for F, P in ipairs(i(ac.suppressedLevels)) do
		do
			local Q = KeyValues.AbilityUpgradesKvs[P]
			local ai
			if Q ~= nil then
				ai = Q.rarity
			end
			if ai ~= G then
				goto aj
			end
			if ah <= 0 then
				j(ac.suppressedLevels, P)
				j(ac.suppressedAbilities, P)
				goto aj
			end
			local ab = ac.suppressedLevels[P] or 0
			local ak = math.min(ab, ah)
			if ak <= 0 then
				j(ac.suppressedLevels, P)
				j(ac.suppressedAbilities, P)
				goto aj
			end
			ac.suppressedLevels[P] = ak
			ah = ah - ak
		end
		::aj::
	end
end
function v.prototype.ApplySuppressionPlan(self, J, ac)
	local al = J:getAbilityUpgradeData(true, true)
	self.suppressedEnemy = J
	self.suppressedSect = ac.sect
	self.suppressedCardCount = 0
	for F, P in ipairs(i(ac.suppressedAbilities)) do
		do
			local a9 = al[P]
			if not a9 then
				goto am
			end
			local ab = ac.suppressedLevels[P] or 0
			self.suppressedAbilities[P] = ac.suppressedAbilities[P]
			self.suppressedCardCount = self.suppressedCardCount + ab
			a9.level = a9.level - ab
			if a9.level <= 0 then
				j(al, P)
			end
		end
		::am::
	end
	if self.suppressedCardCount > 0 then
		J:refreshAbility(true)
		J:syncAbilityData()
	end
end
function v.prototype.OnBattleStart(self)
	if not IsServer() or self:GetParent():IsCustomIllusion() then
		return
	end
	if not self.suppressedEnemy or not self.suppressedSect then
		return
	end
	local x = self:GetParent():GetPlayerOwnerID()
	local z = self.suppressedEnemy.playerID
	local an = "DOTA_Tooltip_ability_" .. self.suppressedSect
	Notification:combatToPlayer(
		x,
		{ message = "notify_trait_185", string_sect_name = an, int_count = self.suppressedCardCount }
	)
	Notification:combatToPlayer(
		z,
		{ message = "notify_trait_185_enemy", string_sect_name = an, int_count = self.suppressedCardCount }
	)
end
function v.prototype.OnBattleEnd(self, u)
	if not IsServer() then
		return
	end
	local x = self:GetParent():GetPlayerOwnerID()
	if u.winPlayerID ~= x and u.losePlayerID ~= x then
		return
	end
	self.suppressionHandled = false
	self:RestoreEnemyAbilities()
end
function v.prototype.OnDestroy(self)
	if IsServer() then
		self.suppressionHandled = false
		self:RestoreEnemyAbilities()
	end
end
function v.prototype.RestoreEnemyAbilities(self)
	if not self.suppressedEnemy then
		return
	end
	local al = self.suppressedEnemy:getAbilityUpgradeData(true, true)
	for F, P in ipairs(i(self.suppressedAbilities)) do
		al[P] = self.suppressedAbilities[P]
	end
	if #i(self.suppressedAbilities) > 0 then
		self.suppressedEnemy:refreshAbility(true)
		self.suppressedEnemy:syncAbilityData()
	end
	self.suppressedEnemy = nil
	self.suppressedAbilities = {}
	self.suppressedSect = nil
	self.suppressedCardCount = 0
end
v = e(
	{ r(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	v
)
l.modifier_trait_185_buff = v
return l