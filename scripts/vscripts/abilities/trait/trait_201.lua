--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_201"
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
		["60"] = 43,
		["61"] = 44,
		["62"] = 45,
		["63"] = 46,
		["64"] = 43,
		["65"] = 48,
		["66"] = 49,
		["67"] = 48,
		["68"] = 51,
		["69"] = 52,
		["70"] = 53,
		["71"] = 54,
		["73"] = 51,
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
g.trait_201 = c()
local n = g.trait_201
n.name = "trait_201"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_201"
end
n = e({ j(nil) }, n)
g.trait_201 = n
g.modifier_trait_201 = c()
local o = g.modifier_trait_201
o.name = "modifier_trait_201"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_201_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_201_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_201 = o
g.modifier_trait_201_buff = c()
local q = g.modifier_trait_201_buff
q.name = "modifier_trait_201_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
	self.attackspeed_per = self:GetAbilitySpecialValueFor("attackspeed_per")
	self.attackspeed_convert = self:GetAbilitySpecialValueFor("attackspeed_convert")
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE }
end
function q.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, p)
	if p and p.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		local r = self:GetParent():GetAttackSpeed(false)
		return self.crit_damage + math.floor(r / self.attackspeed_per) * self.attackspeed_convert
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
g.modifier_trait_201_buff = q
return g