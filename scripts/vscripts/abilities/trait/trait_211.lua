--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_211"
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
		["62"] = 42,
		["63"] = 31,
		["64"] = 43,
		["65"] = 44,
		["66"] = 45,
		["67"] = 43,
		["68"] = 47,
		["69"] = 48,
		["70"] = 48,
		["71"] = 50,
		["72"] = 50,
		["73"] = 50,
		["74"] = 48,
		["75"] = 51,
		["76"] = 51,
		["77"] = 51,
		["78"] = 48,
		["79"] = 48,
		["80"] = 47,
		["81"] = 54,
		["82"] = 55,
		["83"] = 56,
		["84"] = 54,
		["85"] = 58,
		["86"] = 59,
		["87"] = 60,
		["88"] = 61,
		["90"] = 58,
		["91"] = 64,
		["92"] = 65,
		["95"] = 66,
		["98"] = 67,
		["99"] = 68,
		["100"] = 68,
		["101"] = 68,
		["102"] = 68,
		["103"] = 68,
		["104"] = 68,
		["105"] = 69,
		["106"] = 70,
		["107"] = 64,
		["108"] = 39,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 31,
		["113"] = 31,
		["114"] = 31,
		["115"] = 31,
		["116"] = 31,
		["117"] = 39,
		["119"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_211 = c()
local n = g.trait_211
n.name = "trait_211"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_211"
end
n = e({ j(nil) }, n)
g.trait_211 = n
g.modifier_trait_211 = c()
local o = g.modifier_trait_211
o.name = "modifier_trait_211"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_211_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_211_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_211 = o
g.modifier_trait_211_buff = c()
local q = g.modifier_trait_211_buff
q.name = "modifier_trait_211_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.butterfly = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.max_butterfly = self:GetAbilitySpecialValueFor("max_butterfly")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	self.butterfly = 0
	self:SetStackCount(0)
end
function q.prototype.OnCustomAbilityFullyCast(self, r)
	if self.butterfly < self.max_butterfly then
		self.butterfly = self.butterfly + 1
		self:SetStackCount(self.butterfly)
	end
end
function q.prototype.OnCustomAttackLanded(self, r)
	if not IsServer() then
		return
	end
	if self.butterfly < self.max_butterfly then
		return
	end
	local s = self:GetParent()
	s:DealDamage(r.target, self:GetAbility(), self.butterfly * self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	self.butterfly = 0
	self:SetStackCount(0)
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
g.modifier_trait_211_buff = q
return g