--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_21"
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
		["43"] = 31,
		["44"] = 30,
		["45"] = 35,
		["46"] = 36,
		["47"] = 35,
		["48"] = 20,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 20,
		["59"] = 20,
		["60"] = 40,
		["61"] = 41,
		["62"] = 40,
		["63"] = 41,
		["64"] = 42,
		["65"] = 43,
		["66"] = 44,
		["67"] = 45,
		["68"] = 46,
		["69"] = 47,
		["70"] = 48,
		["71"] = 49,
		["72"] = 49,
		["73"] = 49,
		["74"] = 49,
		["75"] = 49,
		["76"] = 49,
		["78"] = 42,
		["79"] = 41,
		["80"] = 40,
		["81"] = 41,
		["83"] = 41,
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
g.neutral_talent_21 = c()
local q = g.neutral_talent_21
q.name = "neutral_talent_21"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_21"
end
q = e({ j(nil) }, q)
g.neutral_talent_21 = q
g.modifier_neutral_talent_21 = c()
local r = g.modifier_neutral_talent_21
r.name = "modifier_neutral_talent_21"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.regen_bonus = self:GetAbilitySpecialValueFor("regen_bonus")
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS] = self.regen_bonus }
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), -1 } }
end
function r.prototype.OnHeal(self, s)
	self:IncrementStackCount(s.flHealAmount)
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
g.modifier_neutral_talent_21 = r
g.neutral_ult_21 = c()
local t = g.neutral_ult_21
t.name = "neutral_ult_21"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = u:GetEnemy()
	local w = self:GetSpecialValueFor("damage_pct")
	local x = self:GetSpecialValueFor("base_damage")
	local y = u:FindModifierByName("modifier_neutral_talent_21")
	if IsInjurable(v) then
		u:DealDamage(v, self, x + y:GetStackCount() * w * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	end
end
t = e({ p(nil) }, t)
g.neutral_ult_21 = t
return g