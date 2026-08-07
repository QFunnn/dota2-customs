--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_119"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["35"] = 24,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["40"] = 32,
		["41"] = 32,
		["42"] = 32,
		["43"] = 32,
		["44"] = 32,
		["46"] = 34,
		["47"] = 35,
		["48"] = 35,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["52"] = 35,
		["54"] = 29,
		["55"] = 19,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 19,
		["65"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_119 = c()
local n = g.trait_119
n.name = "trait_119"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_119"
end
n = e({ j(nil) }, n)
g.trait_119 = n
g.modifier_trait_119 = c()
local o = g.modifier_trait_119
o.name = "modifier_trait_119"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function o.prototype.OnBattleStartBefore(self, p)
	local q = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	if q.illusion and IsValid(q.illusion) then
		AddStateImmunity(self:GetParent(), q.illusion, self:GetAbility(), self.duration)
	end
	if q.hero and IsValid(q.hero) then
		AddStateImmunity(self:GetParent(), q.hero, self:GetAbility(), self.duration)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_119 = o
return g