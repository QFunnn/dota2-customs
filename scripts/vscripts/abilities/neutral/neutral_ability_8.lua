--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_8"
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
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 23,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 29,
		["41"] = 28,
		["42"] = 27,
		["43"] = 32,
		["44"] = 33,
		["45"] = 34,
		["46"] = 34,
		["47"] = 34,
		["48"] = 34,
		["49"] = 34,
		["50"] = 34,
		["51"] = 34,
		["53"] = 32,
		["54"] = 20,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 20,
		["65"] = 20,
		["66"] = 39,
		["67"] = 40,
		["68"] = 39,
		["69"] = 40,
		["70"] = 41,
		["71"] = 42,
		["72"] = 43,
		["73"] = 44,
		["74"] = 45,
		["75"] = 46,
		["76"] = 46,
		["77"] = 46,
		["78"] = 46,
		["79"] = 46,
		["80"] = 46,
		["81"] = 46,
		["83"] = 49,
		["84"] = 50,
		["85"] = 50,
		["86"] = 50,
		["87"] = 50,
		["88"] = 50,
		["89"] = 51,
		["90"] = 52,
		["91"] = 41,
		["92"] = 40,
		["93"] = 39,
		["94"] = 40,
		["96"] = 40,
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
g.neutral_talent_8 = c()
local q = g.neutral_talent_8
q.name = "neutral_talent_8"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_8"
end
q = e({ j(nil) }, q)
g.neutral_talent_8 = q
g.modifier_neutral_talent_8 = c()
local r = g.modifier_neutral_talent_8
r.name = "modifier_neutral_talent_8"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.injury = self:GetAbilitySpecialValueFor("injury")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function r.prototype.OnCustomTakeDamage(self, s)
	if s and self:PRD(self.chance) then
		AddInjury(self:GetParent(), s.attacker, self.injury, self:GetAbility():GetName(), "Ability")
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
g.modifier_neutral_talent_8 = r
g.neutral_ult_8 = c()
local t = g.neutral_ult_8
t.name = "neutral_ult_8"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = u:GetEnemy()
	if IsServer() then
		local w = u:GetHealthDeficit() * self:GetSpecialValueFor("factor")
		AddInjury(u, v, w, self:GetName(), "Ability")
	end
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf",
		PATTACH_ABSORIGIN,
		v
	)
	ParticleManager:SetParticleControl(x, 1, Vector(175, 0, 0))
	ParticleManager:ReleaseParticleIndex(x)
	EmitSoundOn("Hero_Invoker.SunStrike.Ignite", v)
end
t = e({ p(nil) }, t)
g.neutral_ult_8 = t
return g