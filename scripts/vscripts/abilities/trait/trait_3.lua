--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_3"
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
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["34"] = 21,
		["35"] = 20,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 19,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 19,
		["55"] = 19,
		["56"] = 31,
		["57"] = 39,
		["58"] = 31,
		["59"] = 39,
		["61"] = 39,
		["62"] = 43,
		["63"] = 31,
		["64"] = 44,
		["65"] = 45,
		["66"] = 46,
		["67"] = 47,
		["68"] = 44,
		["69"] = 49,
		["70"] = 50,
		["71"] = 51,
		["72"] = 52,
		["73"] = 49,
		["74"] = 54,
		["75"] = 55,
		["76"] = 56,
		["77"] = 56,
		["78"] = 56,
		["79"] = 55,
		["80"] = 55,
		["81"] = 58,
		["82"] = 58,
		["83"] = 58,
		["84"] = 55,
		["85"] = 55,
		["86"] = 54,
		["87"] = 61,
		["88"] = 62,
		["89"] = 61,
		["90"] = 64,
		["91"] = 65,
		["92"] = 64,
		["93"] = 67,
		["94"] = 68,
		["95"] = 67,
		["96"] = 39,
		["97"] = 31,
		["98"] = 31,
		["99"] = 31,
		["100"] = 31,
		["101"] = 31,
		["102"] = 31,
		["103"] = 31,
		["104"] = 31,
		["105"] = 39,
		["107"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_3 = c()
local n = g.trait_3
n.name = "trait_3"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_3"
end
n = e({ j(nil) }, n)
g.trait_3 = n
g.modifier_trait_3 = c()
local o = g.modifier_trait_3
o.name = "modifier_trait_3"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_3_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_3_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_3 = o
g.modifier_trait_3_buff = c()
local q = g.modifier_trait_3_buff
q.name = "modifier_trait_3_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.lifesteal = self:GetAbilitySpecialValueFor("lifesteal")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.extra_lifesteal = self:GetAbilitySpecialValueFor("extra_lifesteal")
end
function q.prototype.OnIntervalThink(self)
	local r = self:GetParent()
	Heal(r, self.extra_lifesteal + self.record * self.lifesteal * 0.01, "trait_3", "Ability")
	self.record = 0
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function q.prototype.OnBattleStart(self, p)
	self:StartIntervalThink(self.interval)
end
function q.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function q.prototype.OnCustomTakeDamage(self, s)
	self.record = self.record + s.damage
end
q = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	q
)
g.modifier_trait_3_buff = q
return g