--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_18"
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
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 24,
		["37"] = 28,
		["38"] = 29,
		["39"] = 29,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 29,
		["44"] = 29,
		["45"] = 28,
		["46"] = 34,
		["47"] = 35,
		["48"] = 34,
		["49"] = 37,
		["50"] = 38,
		["51"] = 37,
		["52"] = 40,
		["53"] = 41,
		["54"] = 42,
		["55"] = 42,
		["56"] = 42,
		["57"] = 42,
		["58"] = 42,
		["59"] = 42,
		["60"] = 42,
		["61"] = 40,
		["62"] = 20,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 20,
		["73"] = 20,
		["74"] = 47,
		["75"] = 48,
		["76"] = 47,
		["77"] = 48,
		["78"] = 49,
		["79"] = 50,
		["80"] = 51,
		["81"] = 52,
		["82"] = 52,
		["83"] = 52,
		["84"] = 52,
		["85"] = 52,
		["86"] = 52,
		["87"] = 52,
		["88"] = 49,
		["89"] = 48,
		["90"] = 47,
		["91"] = 48,
		["93"] = 48,
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
g.neutral_talent_18 = c()
local q = g.neutral_talent_18
q.name = "neutral_talent_18"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_18"
end
q = e({ j(nil) }, q)
g.neutral_talent_18 = q
g.modifier_neutral_talent_18 = c()
local r = g.modifier_neutral_talent_18
r.name = "modifier_neutral_talent_18"
d(r, m)
function r.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.injury = self:GetAbilitySpecialValueFor("injury")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnBattleStart(self, s)
	self:StartIntervalThink(self.interval)
end
function r.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
function r.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	AddInjury(t, self.hEnemy, self.injury, self:GetAbility():GetName(), "Ability")
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
g.modifier_neutral_talent_18 = r
g.neutral_ult_18 = c()
local u = g.neutral_ult_18
u.name = "neutral_ult_18"
d(u, o)
function u.prototype.OnSpellStart(self)
	local v = self:GetCaster()
	local w = v:GetEnemy()
	AddInjury(v, w, self:GetSpecialValueFor("injury_stack"), self:GetName(), "Ability")
end
u = e({ p(nil) }, u)
g.neutral_ult_18 = u
return g