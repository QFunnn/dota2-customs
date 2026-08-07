--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_111"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 24,
		["36"] = 30,
		["37"] = 31,
		["38"] = 30,
		["39"] = 35,
		["40"] = 36,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 39,
		["45"] = 39,
		["46"] = 39,
		["47"] = 40,
		["48"] = 41,
		["49"] = 42,
		["50"] = 42,
		["51"] = 42,
		["52"] = 42,
		["53"] = 42,
		["55"] = 35,
		["56"] = 19,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 19,
		["66"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_111 = c()
local n = g.trait_111
n.name = "trait_111"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_111"
end
n = e({ j(nil) }, n)
g.trait_111 = n
g.modifier_trait_111 = c()
local o = g.modifier_trait_111
o.name = "modifier_trait_111"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.denominator = self:GetAbilitySpecialValueFor("denominator")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.max = self:GetAbilitySpecialValueFor("max")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 } }
end
function o.prototype.OnBattleEndStateEnd(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getGold(q)
	if r >= self.threshold then
		local s = math.min(self.max, math.floor((r - self.threshold) / self.denominator)) * self.count
		PlayerData:ModifyFreeRefresh(q, s)
		PlayerData:ModifyFreeRefreshByKey(q, "trait_111", s)
		PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "AbilityFreeRefreshCount", s)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_111 = o
return g