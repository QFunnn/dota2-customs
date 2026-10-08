--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_209"
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
		["60"] = 44,
		["61"] = 45,
		["62"] = 46,
		["63"] = 47,
		["64"] = 48,
		["65"] = 44,
		["66"] = 50,
		["67"] = 51,
		["68"] = 50,
		["69"] = 55,
		["70"] = 56,
		["71"] = 57,
		["72"] = 57,
		["73"] = 56,
		["74"] = 55,
		["75"] = 60,
		["76"] = 61,
		["77"] = 60,
		["78"] = 63,
		["79"] = 64,
		["80"] = 65,
		["81"] = 63,
		["82"] = 67,
		["83"] = 68,
		["86"] = 69,
		["87"] = 70,
		["88"] = 70,
		["89"] = 70,
		["90"] = 70,
		["91"] = 70,
		["92"] = 70,
		["93"] = 67,
		["94"] = 39,
		["95"] = 31,
		["96"] = 31,
		["97"] = 31,
		["98"] = 31,
		["99"] = 31,
		["100"] = 31,
		["101"] = 31,
		["102"] = 31,
		["103"] = 39,
		["105"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_209 = c()
local n = g.trait_209
n.name = "trait_209"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_209"
end
n = e({ j(nil) }, n)
g.trait_209 = n
g.modifier_trait_209 = c()
local o = g.modifier_trait_209
o.name = "modifier_trait_209"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_209_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_209_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_209 = o
g.modifier_trait_209_buff = c()
local q = g.modifier_trait_209_buff
q.name = "modifier_trait_209_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.ad_per = self:GetAbilitySpecialValueFor("ad_per")
	self.as_per_attack = self:GetAbilitySpecialValueFor("as_per_attack")
	self.ad_ratio = self:GetAbilitySpecialValueFor("ad_ratio")
end
function q.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE] = self.attackspeed }
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function q.prototype.EOM_GetModifierAttackSpeedBonus(self)
	local r = self:GetParent():GetAttackDamage()
	return math.floor(r / self.ad_per) * self.as_per_attack
end
function q.prototype.OnCustomAttackLanded(self, s)
	if not IsServer() then
		return
	end
	local t = self:GetParent()
	t:DealDamage(
		s.target,
		self:GetAbility(),
		t:GetAttackDamage() * self.ad_ratio * 0.01,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
	)
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
g.modifier_trait_209_buff = q
return g