--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_13"
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
		["42"] = 32,
		["43"] = 32,
		["44"] = 32,
		["45"] = 32,
		["46"] = 32,
		["47"] = 32,
		["49"] = 30,
		["50"] = 20,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 20,
		["61"] = 20,
		["62"] = 37,
		["63"] = 38,
		["64"] = 37,
		["65"] = 38,
		["66"] = 39,
		["67"] = 40,
		["68"] = 41,
		["69"] = 42,
		["70"] = 43,
		["71"] = 43,
		["72"] = 43,
		["73"] = 43,
		["74"] = 43,
		["75"] = 43,
		["76"] = 43,
		["77"] = 44,
		["78"] = 45,
		["79"] = 45,
		["80"] = 45,
		["81"] = 45,
		["82"] = 45,
		["83"] = 46,
		["84"] = 47,
		["85"] = 39,
		["86"] = 38,
		["87"] = 37,
		["88"] = 38,
		["90"] = 38,
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
g.neutral_talent_13 = c()
local q = g.neutral_talent_13
q.name = "neutral_talent_13"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_13"
end
q = e({ j(nil) }, q)
g.neutral_talent_13 = q
g.modifier_neutral_talent_13 = c()
local r = g.modifier_neutral_talent_13
r.name = "modifier_neutral_talent_13"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.poison = self:GetAbilitySpecialValueFor("poison")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { -1, -1 } }
end
function r.prototype.OnCustomAbilityFullyCast(self, s)
	if s and s.unit == self:GetParent():GetEnemy() then
		AddPoison(self:GetParent(), s.unit, self.poison, self:GetAbility():GetName(), "Ability")
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
g.modifier_neutral_talent_13 = r
g.neutral_ult_13 = c()
local t = g.neutral_ult_13
t.name = "neutral_ult_13"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = u:GetEnemy()
	local w = self:GetSpecialValueFor("poison") + v:GetMaxHealth() * self:GetSpecialValueFor("factor") * 0.01
	AddPoison(u, v, w, self:GetName(), "Ability")
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf",
		PATTACH_ABSORIGIN,
		u
	)
	ParticleManager:SetParticleControl(x, 1, Vector(550, 0, 550))
	ParticleManager:ReleaseParticleIndex(x)
	EmitSoundOn("Hero_Venomancer.PoisonNova", v)
end
t = e({ p(nil) }, t)
g.neutral_ult_13 = t
return g