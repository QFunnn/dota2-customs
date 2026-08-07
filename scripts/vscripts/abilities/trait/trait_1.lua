--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_1"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["44"] = 26,
		["45"] = 33,
		["46"] = 34,
		["47"] = 33,
		["48"] = 38,
		["49"] = 39,
		["50"] = 38,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["59"] = 43,
		["60"] = 19,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 19,
		["70"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_1 = c()
local n = g.trait_1
n.name = "trait_1"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_1"
end
n = e({ j(nil) }, n)
g.trait_1 = n
g.modifier_trait_1 = c()
local o = g.modifier_trait_1
o.name = "modifier_trait_1"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.wage = self:GetAbilitySpecialValueFor("wage")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		PlayerData:modifyGold(q, self.gold)
		PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
	end
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES] = self.wage }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_GET_INTEREST] = { self:GetParent() } }
end
function o.prototype.OnGetInterest(self, p)
	if IsServer() then
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.wage)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_1 = o
return g