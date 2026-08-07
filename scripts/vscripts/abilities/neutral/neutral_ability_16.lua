--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_16"
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
		["52"] = 32,
		["53"] = 20,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 20,
		["64"] = 20,
		["65"] = 39,
		["66"] = 40,
		["67"] = 39,
		["68"] = 40,
		["69"] = 41,
		["70"] = 42,
		["71"] = 43,
		["72"] = 43,
		["73"] = 43,
		["74"] = 43,
		["75"] = 43,
		["76"] = 43,
		["77"] = 41,
		["78"] = 40,
		["79"] = 39,
		["80"] = 40,
		["82"] = 40,
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
g.neutral_talent_16 = c()
local q = g.neutral_talent_16
q.name = "neutral_talent_16"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_16"
end
q = e({ j(nil) }, q)
g.neutral_talent_16 = q
g.modifier_neutral_talent_16 = c()
local r = g.modifier_neutral_talent_16
r.name = "modifier_neutral_talent_16"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.factor = self:GetAbilitySpecialValueFor("factor")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomAttackLanded(self, s)
	if s and IsInjurable(s.target) then
		self:GetParent():DealDamage(
			s.target,
			self:GetAbility(),
			self.base_damage + GetFury(self:GetParent()) * self.factor * 0.01,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		)
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
g.modifier_neutral_talent_16 = r
g.neutral_ult_16 = c()
local t = g.neutral_ult_16
t.name = "neutral_ult_16"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	AddFury(u, self:GetSpecialValueFor("fury_stack"), self:GetName(), "Ability")
end
t = e({ p(nil) }, t)
g.neutral_ult_16 = t
return g