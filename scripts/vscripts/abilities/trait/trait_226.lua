--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_226"
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
		["71"] = 50,
		["72"] = 52,
		["73"] = 52,
		["74"] = 52,
		["75"] = 50,
		["76"] = 50,
		["77"] = 49,
		["78"] = 55,
		["79"] = 56,
		["80"] = 55,
		["81"] = 58,
		["82"] = 59,
		["85"] = 60,
		["86"] = 61,
		["89"] = 62,
		["90"] = 63,
		["91"] = 63,
		["92"] = 63,
		["93"] = 63,
		["94"] = 63,
		["95"] = 63,
		["96"] = 64,
		["97"] = 64,
		["98"] = 64,
		["99"] = 64,
		["100"] = 64,
		["101"] = 64,
		["102"] = 58,
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
		["115"] = 68,
		["116"] = 75,
		["117"] = 68,
		["118"] = 75,
		["119"] = 77,
		["120"] = 78,
		["121"] = 77,
		["122"] = 80,
		["123"] = 81,
		["124"] = 80,
		["125"] = 75,
		["126"] = 68,
		["127"] = 68,
		["128"] = 68,
		["129"] = 68,
		["130"] = 68,
		["131"] = 68,
		["132"] = 68,
		["133"] = 75,
		["135"] = 75,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_226 = c()
local n = g.trait_226
n.name = "trait_226"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_226"
end
n = e({ j(nil) }, n)
g.trait_226 = n
g.modifier_trait_226 = c()
local o = g.modifier_trait_226
o.name = "modifier_trait_226"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_226_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_226_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_226 = o
g.modifier_trait_226_buff = c()
local q = g.modifier_trait_226_buff
q.name = "modifier_trait_226_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.attack_count = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	self.attack_count = 0
end
function q.prototype.OnCustomAttackLanded(self, r)
	if not IsServer() then
		return
	end
	self.attack_count = self.attack_count + 1
	if self.attack_count % self.count ~= 0 then
		return
	end
	local s = self:GetParent()
	s:DealDamage(r.target, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	r.target:AddNewModifier(s, self:GetAbility(), "modifier_trait_226_debuff", { duration = self.duration })
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
g.modifier_trait_226_buff = q
g.modifier_trait_226_debuff = c()
local t = g.modifier_trait_226_debuff
t.name = "modifier_trait_226_debuff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.as_reduce = self:GetAbilitySpecialValueFor("as_reduce")
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE] = -self.as_reduce }
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_226_debuff = t
return g