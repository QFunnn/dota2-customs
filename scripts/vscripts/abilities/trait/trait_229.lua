--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_229"
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
		["60"] = 42,
		["61"] = 43,
		["62"] = 44,
		["63"] = 42,
		["64"] = 46,
		["65"] = 47,
		["66"] = 46,
		["67"] = 49,
		["68"] = 50,
		["69"] = 51,
		["70"] = 51,
		["72"] = 52,
		["73"] = 49,
		["74"] = 39,
		["75"] = 31,
		["76"] = 31,
		["77"] = 31,
		["78"] = 31,
		["79"] = 31,
		["80"] = 31,
		["81"] = 31,
		["82"] = 31,
		["83"] = 39,
		["85"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_229 = c()
local n = g.trait_229
n.name = "trait_229"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_229"
end
n = e({ j(nil) }, n)
g.trait_229 = n
g.modifier_trait_229 = c()
local o = g.modifier_trait_229
o.name = "modifier_trait_229"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_229_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_229_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_229 = o
g.modifier_trait_229_buff = c()
local q = g.modifier_trait_229_buff
q.name = "modifier_trait_229_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.health_per = self:GetAbilitySpecialValueFor("health_per")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE }
end
function q.prototype.EOM_GetModifierOutgoingPhysicalDamagePercentage(self)
	local r = self:GetParent()
	if not r then
		return 0
	end
	return math.floor(r:GetMaxHealth() / self.health_per) * self.damage
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
g.modifier_trait_229_buff = q
return g