--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
local i = b.__TS__Delete
local j = b.__TS__ObjectKeys
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
		["19"] = 5,
		["20"] = 6,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 7,
		["25"] = 7,
		["26"] = 6,
		["27"] = 5,
		["28"] = 6,
		["30"] = 6,
		["31"] = 118,
		["32"] = 125,
		["33"] = 118,
		["34"] = 125,
		["36"] = 125,
		["37"] = 127,
		["38"] = 129,
		["39"] = 118,
		["40"] = 131,
		["41"] = 132,
		["42"] = 131,
		["43"] = 139,
		["44"] = 140,
		["47"] = 141,
		["48"] = 143,
		["49"] = 144,
		["50"] = 146,
		["51"] = 147,
		["54"] = 148,
		["55"] = 149,
		["56"] = 150,
		["59"] = 152,
		["60"] = 153,
		["61"] = 154,
		["62"] = 155,
		["63"] = 156,
		["65"] = 157,
		["66"] = 158,
		["67"] = 158,
		["69"] = 159,
		["70"] = 159,
		["72"] = 159,
		["73"] = 160,
		["74"] = 160,
		["76"] = 161,
		["77"] = 162,
		["78"] = 163,
		["79"] = 163,
		["84"] = 167,
		["85"] = 167,
		["86"] = 167,
		["87"] = 167,
		["89"] = 167,
		["90"] = 167,
		["92"] = 167,
		["93"] = 167,
		["94"] = 167,
		["95"] = 168,
		["98"] = 170,
		["99"] = 171,
		["102"] = 172,
		["103"] = 173,
		["106"] = 174,
		["107"] = 175,
		["108"] = 176,
		["109"] = 177,
		["111"] = 178,
		["112"] = 179,
		["113"] = 179,
		["115"] = 180,
		["116"] = 181,
		["117"] = 182,
		["121"] = 186,
		["122"] = 187,
		["123"] = 139,
		["124"] = 190,
		["125"] = 191,
		["128"] = 192,
		["129"] = 193,
		["130"] = 194,
		["131"] = 195,
		["132"] = 200,
		["133"] = 190,
		["134"] = 207,
		["135"] = 208,
		["138"] = 209,
		["139"] = 210,
		["142"] = 211,
		["143"] = 207,
		["144"] = 214,
		["145"] = 215,
		["146"] = 215,
		["148"] = 214,
		["149"] = 218,
		["150"] = 219,
		["153"] = 220,
		["154"] = 221,
		["155"] = 222,
		["157"] = 224,
		["158"] = 225,
		["159"] = 226,
		["160"] = 227,
		["161"] = 228,
		["162"] = 229,
		["163"] = 218,
		["164"] = 125,
		["165"] = 118,
		["166"] = 118,
		["167"] = 118,
		["168"] = 118,
		["169"] = 118,
		["170"] = 118,
		["171"] = 118,
		["172"] = 125,
		["174"] = 125,
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
function t.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.suppressedAbilities = {}
	self.suppressedCardCount = 0
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function t.prototype.OnConfirmBattle(self, u)
	if not IsServer() or u.isNeutral then
		return
	end
	self:RestoreEnemyAbilities()
	local v = self:GetParent()
	local w = v:GetPlayerOwnerID()
	local x = PlayerData:getEnemyPlayerID(w)
	if x == nil or x < 0 then
		return
	end
	local y = PlayerData:getHero(x)
	local z = PlayerData:getplayerData(x)
	if not y or not z then
		return
	end
	local A = AbilityShop:GetRecommendSectByHeroName(z.heroName)
	local B = A == "sect_none" and {} or f(A, "|")
	local C = y:getAbilityUpgradeData(true, true)
	local D = {}
	for E in pairs(C) do
		do
			local F = KeyValues.AbilityUpgradesKvs[E]
			local G = C[E]
			local H = G and G.level or 0
			local I
			if F ~= nil then
				I = F.rarity
			end
			local J = I
			if not F or H <= 0 or J ~= "n" and J ~= "r" or type(F.sect) ~= "string" then
				goto K
			end
			for L, M in ipairs(f(F.sect, "|")) do
				D[M] = D[M] or {}
				local N = D[M]
				N[#N + 1] = E
			end
		end
		::K::
	end
	local O = h(AbilityShop.pickList, function(L, M)
		local P = not g(B, M)
		if P then
			local Q = D[M]
			P = (Q and #Q or 0) > 0
		end
		return P
	end)
	if #O <= 0 then
		return
	end
	local M = GetRandomElement(O)
	if M == nil then
		return
	end
	local R = D[M]
	if not R then
		return
	end
	self.suppressedEnemy = y
	self.suppressedSect = M
	self.suppressedCardCount = 0
	for L, E in ipairs(R) do
		do
			local S = C[E]
			if not S then
				goto T
			end
			self.suppressedCardCount = self.suppressedCardCount + (S.level or 0)
			self.suppressedAbilities[E] = deepcopy(S)
			i(C, E)
		end
		::T::
	end
	y:refreshAbility(true)
	y:syncAbilityData()
end
function t.prototype.OnBattleStart(self)
	if not IsServer() or not self.suppressedEnemy or not self.suppressedSect or self.suppressedCardCount <= 0 then
		return
	end
	local w = self:GetParent():GetPlayerOwnerID()
	local x = self.suppressedEnemy.playerID
	local U = "DOTA_Tooltip_ability_" .. self.suppressedSect
	Notification:combatToPlayer(
		w,
		{ message = "notify_trait_185", string_sect_name = U, int_count = self.suppressedCardCount }
	)
	Notification:combatToPlayer(
		x,
		{ message = "notify_trait_185_enemy", string_sect_name = U, int_count = self.suppressedCardCount }
	)
end
function t.prototype.OnBattleEnd(self, u)
	if not IsServer() then
		return
	end
	local w = self:GetParent():GetPlayerOwnerID()
	if u.winPlayerID ~= w and u.losePlayerID ~= w then
		return
	end
	self:RestoreEnemyAbilities()
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		self:RestoreEnemyAbilities()
	end
end
function t.prototype.RestoreEnemyAbilities(self)
	if not self.suppressedEnemy then
		return
	end
	local C = self.suppressedEnemy:getAbilityUpgradeData(true, true)
	for L, E in ipairs(j(self.suppressedAbilities)) do
		C[E] = self.suppressedAbilities[E]
	end
	self.suppressedEnemy:refreshAbility(true)
	self.suppressedEnemy:syncAbilityData()
	self.suppressedEnemy = nil
	self.suppressedAbilities = {}
	self.suppressedSect = nil
	self.suppressedCardCount = 0
end
t = e(
	{ r(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
l.modifier_trait_185 = t
return l