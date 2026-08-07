--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_193"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 12,
		["28"] = 11,
		["29"] = 12,
		["30"] = 15,
		["31"] = 16,
		["32"] = 17,
		["33"] = 15,
		["34"] = 19,
		["35"] = 20,
		["36"] = 19,
		["37"] = 22,
		["38"] = 23,
		["39"] = 22,
		["40"] = 25,
		["41"] = 26,
		["42"] = 25,
		["43"] = 28,
		["44"] = 29,
		["47"] = 30,
		["48"] = 31,
		["51"] = 32,
		["52"] = 33,
		["53"] = 34,
		["54"] = 35,
		["55"] = 36,
		["57"] = 28,
		["58"] = 12,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 12,
		["68"] = 12,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_193 = c()
local n = g.trait_193
n.name = "trait_193"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_193"
end
n = e({ j(nil) }, n)
g.trait_193 = n
g.modifier_trait_193 = c()
local o = g.modifier_trait_193
o.name = "modifier_trait_193"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.freeRefreshCount = self:GetAbilitySpecialValueFor("free_refresh_count")
	self.interestLimit = self:GetAbilitySpecialValueFor("interest_limit")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT }
end
function o.prototype.EOM_GetModifierExtraInterest_Limit(self)
	return self:GetStackCount() * self.interestLimit
end
function o.prototype.OnBattleEnd(self, p)
	if not IsServer() or p.isNeutral then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if p.illusionPlayerID == q then
		return
	end
	if p.losePlayerID == q then
		PlayerData:ModifyFreeRefresh(q, self.freeRefreshCount)
		PlayerData:ModifyFreeRefreshByKey(q, "trait_193", self.freeRefreshCount)
	elseif p.winPlayerID == q then
		self:IncrementStackCount()
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_193 = o
return g