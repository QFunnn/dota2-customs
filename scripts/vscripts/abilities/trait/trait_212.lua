--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_212"
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
		["72"] = 51,
		["73"] = 51,
		["74"] = 50,
		["75"] = 52,
		["76"] = 52,
		["77"] = 52,
		["78"] = 50,
		["79"] = 50,
		["80"] = 50,
		["81"] = 49,
		["82"] = 56,
		["83"] = 57,
		["84"] = 56,
		["85"] = 59,
		["86"] = 60,
		["87"] = 61,
		["89"] = 59,
		["90"] = 64,
		["91"] = 65,
		["94"] = 66,
		["97"] = 67,
		["98"] = 68,
		["99"] = 69,
		["100"] = 70,
		["102"] = 64,
		["103"] = 39,
		["104"] = 31,
		["105"] = 31,
		["106"] = 31,
		["107"] = 31,
		["108"] = 31,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 39,
		["114"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_212 = c()
local n = g.trait_212
n.name = "trait_212"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_212"
end
n = e({ j(nil) }, n)
g.trait_212 = n
g.modifier_trait_212 = c()
local o = g.modifier_trait_212
o.name = "modifier_trait_212"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_212_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_212_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_212 = o
g.modifier_trait_212_buff = c()
local q = g.modifier_trait_212_buff
q.name = "modifier_trait_212_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.lastDamageTime = -1
end
function q.prototype.GetAbilitySpecialValue(self)
	self.mana = self:GetAbilitySpecialValueFor("mana")
	self.window = self:GetAbilitySpecialValueFor("window")
	self.mana_extra = self:GetAbilitySpecialValueFor("mana_extra")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_KILLED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	self.lastDamageTime = -1
end
function q.prototype.OnCustomTakeDamage(self, r)
	if r.attacker == self:GetParent() then
		self.lastDamageTime = GameRules:GetGameTime()
	end
end
function q.prototype.OnKilled(self, p)
	if not IsServer() then
		return
	end
	if p.attacker ~= self:GetParent() then
		return
	end
	local s = self:GetParent()
	Restore(s, self.mana)
	if self.lastDamageTime >= 0 and GameRules:GetGameTime() - self.lastDamageTime <= self.window then
		Restore(s, self.mana_extra)
	end
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
g.modifier_trait_212_buff = q
return g