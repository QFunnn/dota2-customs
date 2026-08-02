--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_15"
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
		["48"] = 35,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["52"] = 35,
		["53"] = 35,
		["54"] = 34,
		["55"] = 34,
		["57"] = 32,
		["58"] = 20,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 20,
		["69"] = 20,
		["70"] = 41,
		["71"] = 42,
		["72"] = 41,
		["73"] = 42,
		["74"] = 43,
		["75"] = 44,
		["76"] = 45,
		["77"] = 46,
		["78"] = 46,
		["79"] = 46,
		["80"] = 46,
		["81"] = 46,
		["82"] = 46,
		["83"] = 47,
		["84"] = 47,
		["85"] = 47,
		["86"] = 48,
		["87"] = 48,
		["88"] = 48,
		["89"] = 48,
		["90"] = 48,
		["91"] = 48,
		["92"] = 49,
		["93"] = 50,
		["94"] = 50,
		["95"] = 50,
		["96"] = 50,
		["97"] = 50,
		["98"] = 50,
		["99"] = 50,
		["100"] = 50,
		["101"] = 50,
		["102"] = 51,
		["103"] = 47,
		["104"] = 47,
		["105"] = 53,
		["106"] = 54,
		["107"] = 43,
		["108"] = 42,
		["109"] = 41,
		["110"] = 42,
		["112"] = 42,
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
g.neutral_talent_15 = c()
local q = g.neutral_talent_15
q.name = "neutral_talent_15"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_15"
end
q = e({ j(nil) }, q)
g.neutral_talent_15 = q
g.modifier_neutral_talent_15 = c()
local r = g.modifier_neutral_talent_15
r.name = "modifier_neutral_talent_15"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.factor = self:GetAbilitySpecialValueFor("factor")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), -1 } }
end
function r.prototype.OnHeal(self, s)
	if s and self:PRD(self.chance) then
		EachWisp(self:GetParent(), function(t)
			t:ModifyHealth(t:GetHealth() + s.flHealAmount * self.factor, self:GetAbility(), false, 0)
		end)
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
g.modifier_neutral_talent_15 = r
g.neutral_ult_15 = c()
local u = g.neutral_ult_15
u.name = "neutral_ult_15"
d(u, o)
function u.prototype.OnSpellStart(self)
	local v = self:GetCaster()
	local w = self:GetSpecialValueFor("hp_regen_pct")
	Heal(v, v:GetMaxHealth() * w * 0.01, self:GetName(), "Ability")
	EachWisp(v, function(t)
		t:ModifyHealth(t:GetHealth() + t:GetMaxHealth() * w * 0.01, self, false, 0)
		local x = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity.vpcf",
			PATTACH_CENTER_FOLLOW,
			v
		)
		ParticleManager:SetParticleControlEnt(x, 1, t, PATTACH_CENTER_FOLLOW, "attach_hitloc", vec3_invalid, false)
		ParticleManager:ReleaseParticleIndex(x)
	end)
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_omniknight/omniknight_shard_hammer_of_purity_impact_rays.vpcf",
		PATTACH_CENTER_FOLLOW,
		v
	)
	ParticleManager:ReleaseParticleIndex(x)
end
u = e({ p(nil) }, u)
g.neutral_ult_15 = u
return g