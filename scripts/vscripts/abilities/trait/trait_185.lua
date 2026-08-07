--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
		["35"] = 126,
		["36"] = 127,
		["37"] = 128,
		["38"] = 128,
		["39"] = 127,
		["40"] = 126,
		["41"] = 131,
		["42"] = 132,
		["45"] = 133,
		["46"] = 134,
		["47"] = 134,
		["48"] = 134,
		["49"] = 134,
		["50"] = 134,
		["51"] = 134,
		["52"] = 131,
		["53"] = 125,
		["54"] = 118,
		["55"] = 118,
		["56"] = 118,
		["57"] = 118,
		["58"] = 118,
		["59"] = 118,
		["60"] = 118,
		["61"] = 125,
		["63"] = 125,
		["64"] = 138,
		["65"] = 145,
		["66"] = 138,
		["67"] = 145,
		["69"] = 145,
		["70"] = 147,
		["71"] = 149,
		["72"] = 138,
		["73"] = 151,
		["74"] = 152,
		["75"] = 151,
		["76"] = 159,
		["77"] = 160,
		["80"] = 161,
		["83"] = 162,
		["84"] = 164,
		["85"] = 165,
		["86"] = 166,
		["87"] = 167,
		["90"] = 169,
		["91"] = 170,
		["94"] = 171,
		["95"] = 172,
		["96"] = 173,
		["99"] = 174,
		["102"] = 176,
		["103"] = 177,
		["104"] = 178,
		["105"] = 179,
		["106"] = 180,
		["108"] = 181,
		["109"] = 182,
		["110"] = 182,
		["112"] = 183,
		["113"] = 183,
		["115"] = 183,
		["116"] = 184,
		["117"] = 184,
		["119"] = 185,
		["120"] = 186,
		["121"] = 187,
		["122"] = 187,
		["127"] = 191,
		["128"] = 191,
		["129"] = 191,
		["130"] = 191,
		["132"] = 191,
		["133"] = 191,
		["135"] = 191,
		["136"] = 191,
		["137"] = 191,
		["138"] = 192,
		["141"] = 194,
		["142"] = 195,
		["145"] = 196,
		["146"] = 197,
		["149"] = 198,
		["150"] = 199,
		["151"] = 200,
		["152"] = 201,
		["154"] = 202,
		["155"] = 203,
		["156"] = 203,
		["158"] = 204,
		["159"] = 205,
		["160"] = 206,
		["164"] = 210,
		["165"] = 211,
		["166"] = 159,
		["167"] = 214,
		["168"] = 215,
		["171"] = 216,
		["174"] = 217,
		["175"] = 218,
		["176"] = 219,
		["177"] = 220,
		["178"] = 225,
		["179"] = 214,
		["180"] = 232,
		["181"] = 233,
		["184"] = 234,
		["185"] = 235,
		["188"] = 236,
		["189"] = 232,
		["190"] = 239,
		["191"] = 240,
		["192"] = 240,
		["194"] = 239,
		["195"] = 243,
		["196"] = 244,
		["199"] = 245,
		["200"] = 246,
		["201"] = 247,
		["203"] = 249,
		["204"] = 250,
		["205"] = 251,
		["206"] = 252,
		["207"] = 253,
		["208"] = 254,
		["209"] = 243,
		["210"] = 145,
		["211"] = 138,
		["212"] = 138,
		["213"] = 138,
		["214"] = 138,
		["215"] = 138,
		["216"] = 138,
		["217"] = 138,
		["218"] = 145,
		["220"] = 145,
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
	self:RestoreEnemyAbilities()
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
	local B = PlayerData:getplayerData(z)
	if not A or not B then
		return
	end
	if A:isIllusion(y) or y:IsCustomIllusion() then
		return
	end
	local C = AbilityShop:GetRecommendSectByHeroName(B.heroName)
	local D = C == "sect_none" and {} or f(C, "|")
	local E = A:getAbilityUpgradeData(true, true)
	local F = {}
	for G in pairs(E) do
		do
			local H = KeyValues.AbilityUpgradesKvs[G]
			local I = E[G]
			local J = I and I.level or 0
			local K
			if H ~= nil then
				K = H.rarity
			end
			local L = K
			if not H or J <= 0 or L ~= "n" and L ~= "r" or type(H.sect) ~= "string" then
				goto M
			end
			for N, O in ipairs(f(H.sect, "|")) do
				F[O] = F[O] or {}
				local P = F[O]
				P[#P + 1] = G
			end
		end
		::M::
	end
	local Q = h(AbilityShop.pickList, function(N, O)
		local R = not g(D, O)
		if R then
			local S = F[O]
			R = (S and #S or 0) > 0
		end
		return R
	end)
	if #Q <= 0 then
		return
	end
	local O = GetRandomElement(Q)
	if O == nil then
		return
	end
	local T = F[O]
	if not T then
		return
	end
	self.suppressedEnemy = A
	self.suppressedSect = O
	self.suppressedCardCount = 0
	for N, G in ipairs(T) do
		do
			local U = E[G]
			if not U then
				goto V
			end
			self.suppressedCardCount = self.suppressedCardCount + (U.level or 0)
			self.suppressedAbilities[G] = deepcopy(U)
			i(E, G)
		end
		::V::
	end
	A:refreshAbility(true)
	A:syncAbilityData()
end
function v.prototype.OnBattleStart(self)
	if not IsServer() or self:GetParent():IsCustomIllusion() then
		return
	end
	if not self.suppressedEnemy or not self.suppressedSect or self.suppressedCardCount <= 0 then
		return
	end
	local x = self:GetParent():GetPlayerOwnerID()
	local z = self.suppressedEnemy.playerID
	local W = "DOTA_Tooltip_ability_" .. self.suppressedSect
	Notification:combatToPlayer(
		x,
		{ message = "notify_trait_185", string_sect_name = W, int_count = self.suppressedCardCount }
	)
	Notification:combatToPlayer(
		z,
		{ message = "notify_trait_185_enemy", string_sect_name = W, int_count = self.suppressedCardCount }
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
	self:RestoreEnemyAbilities()
end
function v.prototype.OnDestroy(self)
	if IsServer() then
		self:RestoreEnemyAbilities()
	end
end
function v.prototype.RestoreEnemyAbilities(self)
	if not self.suppressedEnemy then
		return
	end
	local E = self.suppressedEnemy:getAbilityUpgradeData(true, true)
	for N, G in ipairs(j(self.suppressedAbilities)) do
		E[G] = self.suppressedAbilities[G]
	end
	self.suppressedEnemy:refreshAbility(true)
	self.suppressedEnemy:syncAbilityData()
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