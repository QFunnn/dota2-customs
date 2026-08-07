--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_22"
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
		["60"] = 39,
		["61"] = 41,
		["62"] = 42,
		["63"] = 43,
		["64"] = 43,
		["65"] = 43,
		["66"] = 43,
		["67"] = 43,
		["68"] = 43,
		["70"] = 34,
		["71"] = 33,
		["72"] = 32,
		["73"] = 33,
		["75"] = 33,
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
g.neutral_talent_22 = c()
local q = g.neutral_talent_22
q.name = "neutral_talent_22"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_22"
end
q = e({ j(nil) }, q)
g.neutral_talent_22 = q
g.modifier_neutral_talent_22 = c()
local r = g.modifier_neutral_talent_22
r.name = "modifier_neutral_talent_22"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.health_bonus = self:GetAbilitySpecialValueFor("health_bonus")
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS] = self.health_bonus }
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
g.modifier_neutral_talent_22 = r
g.neutral_ult_22 = c()
local s = g.neutral_ult_22
s.name = "neutral_ult_22"
d(s, o)
function s.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local u = t:GetEnemy()
	local v = self:GetSpecialValueFor("stun_duration")
	local w = self:GetSpecialValueFor("base_damage")
	local x = self:GetSpecialValueFor("health_pct")
	AddStun(t, u, self, v)
	if IsInjurable(u) then
		t:DealDamage(u, self, w + t:GetMaxHealth() * x * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	end
end
s = e({ p(nil) }, s)
g.neutral_ult_22 = s
return g