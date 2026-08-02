--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_2"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["33"] = 22,
		["34"] = 23,
		["35"] = 22,
		["36"] = 25,
		["37"] = 26,
		["38"] = 25,
		["39"] = 30,
		["40"] = 31,
		["41"] = 32,
		["43"] = 30,
		["44"] = 20,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 20,
		["55"] = 20,
		["56"] = 37,
		["57"] = 38,
		["58"] = 37,
		["59"] = 38,
		["60"] = 39,
		["61"] = 40,
		["62"] = 41,
		["63"] = 41,
		["64"] = 42,
		["65"] = 43,
		["66"] = 44,
		["67"] = 45,
		["68"] = 45,
		["69"] = 45,
		["70"] = 45,
		["71"] = 45,
		["72"] = 46,
		["73"] = 47,
		["74"] = 48,
		["75"] = 48,
		["76"] = 48,
		["77"] = 48,
		["78"] = 48,
		["79"] = 48,
		["80"] = 48,
		["81"] = 39,
		["82"] = 38,
		["83"] = 37,
		["84"] = 38,
		["86"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.neutral_talent_2 = c()
local q = g.neutral_talent_2
q.name = "neutral_talent_2"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_2"
end
q = e({ j(nil) }, q)
g.neutral_talent_2 = q
g.modifier_neutral_talent_2 = c()
local r = g.modifier_neutral_talent_2
r.name = "modifier_neutral_talent_2"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.poison_damage_reduce = self:GetAbilitySpecialValueFor("poison_damage_reduce")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function r.prototype.EOM_GetModifierIncomingDamagePercentage(self, s)
	if s and s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON then
		return -self.poison_damage_reduce
	end
end
r = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	r
)
g.modifier_neutral_talent_2 = r
g.neutral_ult_2 = c()
local t = g.neutral_ult_2
t.name = "neutral_ult_2"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = u:FindModifierByName("modifier_poison_custom")
	local w = v and v:GetStackCount() or 0
	w = w * self:GetSpecialValueFor("factor")
	w = w + self:GetSpecialValueFor("base_poison")
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf",
		PATTACH_ABSORIGIN,
		u
	)
	ParticleManager:SetParticleControl(x, 1, Vector(550, 0, 550))
	ParticleManager:ReleaseParticleIndex(x)
	EmitSoundOn("Greevil.PoisonNova", u)
	AddPoison(u, u:GetEnemy(), w, self:GetName(), "Ability")
end
t = e({ p(nil) }, t)
g.neutral_ult_2 = t
return g