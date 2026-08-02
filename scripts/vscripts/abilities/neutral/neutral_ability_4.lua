--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_4"
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
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 32,
		["46"] = 30,
		["47"] = 20,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 20,
		["58"] = 20,
		["59"] = 37,
		["60"] = 38,
		["61"] = 37,
		["62"] = 38,
		["63"] = 39,
		["64"] = 40,
		["65"] = 41,
		["66"] = 41,
		["67"] = 41,
		["68"] = 41,
		["69"] = 41,
		["70"] = 41,
		["71"] = 42,
		["72"] = 43,
		["73"] = 44,
		["74"] = 39,
		["75"] = 38,
		["76"] = 37,
		["77"] = 38,
		["79"] = 38,
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
g.neutral_talent_4 = c()
local q = g.neutral_talent_4
q.name = "neutral_talent_4"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_4"
end
q = e({ j(nil) }, q)
g.neutral_talent_4 = q
g.modifier_neutral_talent_4 = c()
local r = g.modifier_neutral_talent_4
r.name = "modifier_neutral_talent_4"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function r.prototype.EOM_GetModifierIncomingDamagePercentage(self, s)
	if self:GetParent():GetModifierStackCount("modifier_shield_custom", self:GetParent()) > 0 then
		return -self.damage_reduce
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
g.modifier_neutral_talent_4 = r
g.neutral_ult_4 = c()
local t = g.neutral_ult_4
t.name = "neutral_ult_4"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	AddShield(self:GetCaster(), self:GetSpecialValueFor("shield"), self:GetName(), "Ability")
	local v = ParticleManager:CreateParticle(
		"particles/econ/items/silencer/silencer_ti10_immortal_shield/silencer_ti10_immortal_curse_cast.vpcf",
		PATTACH_CENTER_FOLLOW,
		u
	)
	ParticleManager:ReleaseParticleIndex(v)
	EmitSoundOn("Hero_Silencer.LastWord.Damage", u)
end
t = e({ p(nil) }, t)
g.neutral_ult_4 = t
return g