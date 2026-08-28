--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_140"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectKeys
local f = b.__TS__ArraySlice
local g = b.__TS__ArrayIncludes
local h = b.__TS__ArrayFilter
local i = b.__TS__ArraySort
local j = b.__TS__ArrayFind
local k = b.__TS__DecorateLegacy
local l = b.__TS__SourceMapTraceBack
l(
	debug.getinfo(1).short_src,
	{
		["14"] = 1,
		["15"] = 1,
		["16"] = 1,
		["17"] = 2,
		["18"] = 2,
		["19"] = 2,
		["20"] = 4,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 6,
		["27"] = 4,
		["28"] = 7,
		["29"] = 8,
		["30"] = 9,
		["32"] = 7,
		["33"] = 12,
		["34"] = 13,
		["35"] = 12,
		["36"] = 15,
		["37"] = 16,
		["40"] = 17,
		["41"] = 18,
		["42"] = 19,
		["45"] = 22,
		["46"] = 23,
		["47"] = 24,
		["48"] = 25,
		["49"] = 25,
		["50"] = 26,
		["51"] = 26,
		["53"] = 27,
		["54"] = 27,
		["55"] = 27,
		["56"] = 27,
		["57"] = 28,
		["60"] = 31,
		["61"] = 32,
		["62"] = 32,
		["63"] = 32,
		["64"] = 32,
		["65"] = 33,
		["66"] = 33,
		["67"] = 33,
		["68"] = 33,
		["69"] = 33,
		["70"] = 34,
		["71"] = 35,
		["72"] = 35,
		["74"] = 36,
		["75"] = 37,
		["76"] = 38,
		["77"] = 39,
		["78"] = 40,
		["79"] = 40,
		["82"] = 42,
		["85"] = 43,
		["86"] = 44,
		["87"] = 45,
		["88"] = 46,
		["89"] = 47,
		["90"] = 47,
		["91"] = 47,
		["93"] = 48,
		["94"] = 48,
		["97"] = 50,
		["98"] = 51,
		["99"] = 51,
		["101"] = 52,
		["102"] = 53,
		["103"] = 54,
		["104"] = 54,
		["107"] = 56,
		["108"] = 57,
		["109"] = 58,
		["110"] = 59,
		["111"] = 60,
		["112"] = 60,
		["113"] = 60,
		["114"] = 60,
		["115"] = 61,
		["116"] = 62,
		["117"] = 63,
		["118"] = 64,
		["120"] = 66,
		["121"] = 67,
		["122"] = 15,
		["123"] = 69,
		["124"] = 70,
		["125"] = 70,
		["126"] = 70,
		["128"] = 71,
		["129"] = 71,
		["130"] = 71,
		["132"] = 72,
		["133"] = 69,
		["134"] = 74,
		["135"] = 74,
		["136"] = 74,
		["137"] = 5,
		["138"] = 4,
		["139"] = 5,
		["141"] = 5,
		["142"] = 77,
		["143"] = 86,
		["144"] = 77,
		["145"] = 86,
		["147"] = 86,
		["148"] = 87,
		["149"] = 77,
		["150"] = 88,
		["151"] = 89,
		["152"] = 88,
		["153"] = 91,
		["154"] = 92,
		["155"] = 91,
		["156"] = 94,
		["157"] = 95,
		["158"] = 94,
		["159"] = 86,
		["160"] = 77,
		["161"] = 77,
		["162"] = 77,
		["163"] = 77,
		["164"] = 77,
		["165"] = 77,
		["166"] = 77,
		["167"] = 77,
		["168"] = 77,
		["169"] = 86,
		["171"] = 86,
	}
)
local m = {}
local n = require("lib.dota_ts_adapter")
local o = n.BaseItem
local p = n.registerAbility
local q = require("modifiers.eom_modifier")
local r = q.EOMModifier
local s = q.registerEOMModifier
m.item_artifact_140 = c()
local t = m.item_artifact_140
t.name = "item_artifact_140"
d(t, o)
function t.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.lastUsedRound = -1
end
function t.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("charges"))
	end
end
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_140"
end
function t.prototype.OnSpellStart(self)
	if self.lastUsedRound >= 0 and self.lastUsedRound == Rounds:getCurrentRound() then
		return
	end
	local u = self:GetCaster():GetPlayerOwnerID()
	local v = PlayerData:getHero(u)
	if not v then
		return
	end
	local w = v:getAbilityData(false, true)
	local x = e(w)
	local y = f(AbilityShop.banList)
	local z = PlayerData:getplayerData(u)
	local A = z and z.bannedSect
	if A then
		y[#y + 1] = A
	end
	local B = h(x, function(C, D)
		return not g(y, D)
	end)
	if #B == 0 then
		return
	end
	local E = v:getLevel()
	i(B, function(C, F, G)
		return w[F].level == w[G].level and w[G].exp - w[F].exp or w[G].level - w[F].level
	end)
	local H = f(B, 0, self:GetSpecialValueFor("top_count"))
	local I = {}
	for C, D in ipairs(H) do
		I[D] = w[D].level
	end
	local J = 0
	for C, D in ipairs(x) do
		local K = w[D].exp
		J = J + K
		if K > 0 then
			v:modifyAbilityData(w, D, -K)
		end
	end
	if J <= 0 or #H == 0 then
		return
	end
	local L = math.floor(J / #H)
	local M = J - L * #H
	for C, D in ipairs(H) do
		local N = L
		if M > 0 then
			N = N + 1
			M = M - 1
		end
		if N > 0 then
			v:modifyAbilityData(w, D, N)
		end
	end
	local O = 0
	for C, D in ipairs(H) do
		O = O + math.max(0, w[D].level - I[D])
	end
	if v.isPrePurchase then
		local P = v:getAbilityData(true, true)
		for C, D in ipairs(x) do
			P[D] = deepcopy(w[D])
		end
	end
	v:fixAbilityLevel(v.hero)
	v:syncAbilityData()
	v:fixHeroLevel(v.hero)
	local Q = self:GetCaster():FindAllModifiersByName("modifier_item_artifact_140")
	local R = j(Q, function(C, S)
		return IsValid(S) and S:GetAbility() == self
	end)
	local T = E + O
	if R and v:getLevel() < T then
		R:AddLevelBonus(T - v:getLevel())
		v:fixHeroLevel(v.hero)
	end
	self.lastUsedRound = Rounds:getCurrentRound()
	self:SpendCharge()
end
function t.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() <= 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	if self.lastUsedRound >= 0 and self.lastUsedRound == Rounds:getCurrentRound() then
		self.error = "error_artifact_used_this_round"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function t.prototype.GetCustomCastError(self)
	return self.error
end
t = k({ p(nil) }, t)
m.item_artifact_140 = t
m.modifier_item_artifact_140 = c()
local U = m.modifier_item_artifact_140
U.name = "modifier_item_artifact_140"
d(U, r)
function U.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.levelBonus = 0
end
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_DEFAULT_LEVEL_BONUS }
end
function U.prototype.EOM_GetModifierDefaultLevelBonus(self)
	return self.levelBonus
end
function U.prototype.AddLevelBonus(self, S)
	self.levelBonus = self.levelBonus + S
end
U = k(
	{
		s(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	U
)
m.modifier_item_artifact_140 = U
return m