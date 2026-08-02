--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_11"
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
		["39"] = 20,
		["40"] = 12,
		["41"] = 12,
		["42"] = 12,
		["43"] = 12,
		["44"] = 12,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 20,
		["50"] = 20,
		["51"] = 32,
		["52"] = 33,
		["53"] = 32,
		["54"] = 33,
		["55"] = 34,
		["56"] = 35,
		["57"] = 36,
		["58"] = 37,
		["59"] = 38,
		["60"] = 38,
		["61"] = 38,
		["62"] = 38,
		["63"] = 38,
		["64"] = 38,
		["65"] = 38,
		["66"] = 40,
		["67"] = 41,
		["68"] = 41,
		["69"] = 41,
		["70"] = 41,
		["71"] = 41,
		["72"] = 42,
		["73"] = 43,
		["74"] = 34,
		["75"] = 33,
		["76"] = 32,
		["77"] = 33,
		["79"] = 33,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.neutral_talent_11 = c()
local q = g.neutral_talent_11
q.name = "neutral_talent_11"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_11"
end
q = e({ j(nil) }, q)
g.neutral_talent_11 = q
g.modifier_neutral_talent_11 = c()
local r = g.modifier_neutral_talent_11
r.name = "modifier_neutral_talent_11"
d(r, m)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_INJURY_PERCENTAGE] = self.chance }
end
r = e(
	{
		l(
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
g.modifier_neutral_talent_11 = r
g.neutral_ult_11 = c()
local s = g.neutral_ult_11
s.name = "neutral_ult_11"
d(s, o)
function s.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local u = t:GetEnemy()
	local v = u:GetMaxHealth() * self:GetSpecialValueFor("factor") * 0.01
	AddInjury(t, u, v, self:GetName(), "Ability")
	local w =
		ParticleManager:CreateParticle("particles/neutral_fx/neutral_prowler_shaman_stomp.vpcf", PATTACH_ABSORIGIN, u)
	ParticleManager:SetParticleControl(w, 1, Vector(275, 0, 275))
	ParticleManager:ReleaseParticleIndex(w)
	EmitSoundOn("n_creep_Spawnlord.Stomp", u)
end
s = e({ p(nil) }, s)
g.neutral_ult_11 = s
return g