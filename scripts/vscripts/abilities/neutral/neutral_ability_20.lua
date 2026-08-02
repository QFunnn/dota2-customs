--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_20"
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
		["46"] = 35,
		["47"] = 37,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["52"] = 38,
		["53"] = 38,
		["54"] = 38,
		["55"] = 38,
		["56"] = 38,
		["57"] = 38,
		["60"] = 32,
		["61"] = 20,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 20,
		["72"] = 20,
		["73"] = 45,
		["74"] = 46,
		["75"] = 45,
		["76"] = 46,
		["77"] = 47,
		["78"] = 48,
		["79"] = 49,
		["80"] = 50,
		["81"] = 51,
		["82"] = 51,
		["83"] = 51,
		["84"] = 51,
		["85"] = 51,
		["86"] = 51,
		["87"] = 51,
		["88"] = 47,
		["89"] = 46,
		["90"] = 45,
		["91"] = 46,
		["93"] = 46,
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
g.neutral_talent_20 = c()
local q = g.neutral_talent_20
q.name = "neutral_talent_20"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_20"
end
q = e({ j(nil) }, q)
g.neutral_talent_20 = q
g.modifier_neutral_talent_20 = c()
local r = g.modifier_neutral_talent_20
r.name = "modifier_neutral_talent_20"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.poison = self:GetAbilitySpecialValueFor("poison")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), self:GetParent() } }
end
function r.prototype.OnCustomTakeDamage(self, s)
	local t = s.attacker
	local u = s.target
	if t == self:GetParent() then
		if self:PRD(self.chance) then
			local v = AddPoison
			local w = self.poison
			local x = self:GetAbility()
			v(t, u, w, x and x:GetAbilityName(), "Ability")
		end
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
g.modifier_neutral_talent_20 = r
g.neutral_ult_20 = c()
local y = g.neutral_ult_20
y.name = "neutral_ult_20"
d(y, o)
function y.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local u = t:GetEnemy()
	local z = self:GetSpecialValueFor("poison_stack")
	AddPoison(t, u, z, self:GetAbilityName(), "Ability")
end
y = e({ p(nil) }, y)
g.neutral_ult_20 = y
return g