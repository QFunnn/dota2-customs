--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_228"
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
		["60"] = 45,
		["61"] = 46,
		["62"] = 47,
		["63"] = 48,
		["64"] = 49,
		["65"] = 50,
		["66"] = 45,
		["67"] = 52,
		["68"] = 53,
		["69"] = 54,
		["70"] = 54,
		["72"] = 55,
		["73"] = 55,
		["74"] = 55,
		["75"] = 55,
		["76"] = 56,
		["77"] = 52,
		["78"] = 58,
		["79"] = 59,
		["80"] = 58,
		["81"] = 64,
		["82"] = 65,
		["83"] = 64,
		["84"] = 67,
		["85"] = 68,
		["86"] = 67,
		["87"] = 39,
		["88"] = 31,
		["89"] = 31,
		["90"] = 31,
		["91"] = 31,
		["92"] = 31,
		["93"] = 31,
		["94"] = 31,
		["95"] = 31,
		["96"] = 39,
		["98"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_228 = c()
local n = g.trait_228
n.name = "trait_228"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_228"
end
n = e({ j(nil) }, n)
g.trait_228 = n
g.modifier_trait_228 = c()
local o = g.modifier_trait_228
o.name = "modifier_trait_228"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_228_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_228_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_228 = o
g.modifier_trait_228_buff = c()
local q = g.modifier_trait_228_buff
q.name = "modifier_trait_228_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.physical_reduce = self:GetAbilitySpecialValueFor("physical_reduce")
	self.magic_reduce = self:GetAbilitySpecialValueFor("magic_reduce")
	self.health_per = self:GetAbilitySpecialValueFor("health_per")
	self.per_health = self:GetAbilitySpecialValueFor("per_health")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
end
function q.prototype.GetHealthBonusReduce(self)
	local r = self:GetParent()
	if not r then
		return 0
	end
	local s = math.min(self.max_stack, math.floor(r:GetMaxHealth() / self.health_per))
	return s * self.per_health
end
function q.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE,
	}
end
function q.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self)
	return -(self.physical_reduce + self:GetHealthBonusReduce())
end
function q.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	return -(self.magic_reduce + self:GetHealthBonusReduce())
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
g.modifier_trait_228_buff = q
return g