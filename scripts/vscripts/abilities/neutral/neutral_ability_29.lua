--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_29"
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
		["59"] = 34,
		["60"] = 33,
		["61"] = 32,
		["62"] = 33,
		["64"] = 33,
		["65"] = 41,
		["66"] = 51,
		["67"] = 41,
		["68"] = 51,
		["69"] = 53,
		["70"] = 54,
		["71"] = 53,
		["72"] = 56,
		["73"] = 57,
		["74"] = 58,
		["76"] = 56,
		["77"] = 61,
		["78"] = 62,
		["79"] = 63,
		["80"] = 64,
		["81"] = 64,
		["82"] = 64,
		["83"] = 64,
		["84"] = 64,
		["85"] = 64,
		["86"] = 61,
		["87"] = 51,
		["88"] = 41,
		["89"] = 41,
		["90"] = 41,
		["91"] = 41,
		["92"] = 41,
		["93"] = 41,
		["94"] = 41,
		["95"] = 41,
		["96"] = 41,
		["97"] = 41,
		["98"] = 51,
		["100"] = 51,
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
g.neutral_talent_29 = c()
local q = g.neutral_talent_29
q.name = "neutral_talent_29"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_29"
end
q = e({ j(nil) }, q)
g.neutral_talent_29 = q
g.modifier_neutral_talent_29 = c()
local r = g.modifier_neutral_talent_29
r.name = "modifier_neutral_talent_29"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.regen_bonus_pct = self:GetAbilitySpecialValueFor("regen_bonus_pct")
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY] = self.regen_bonus_pct }
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
g.modifier_neutral_talent_29 = r
g.neutral_ult_29 = c()
local s = g.neutral_ult_29
s.name = "neutral_ult_29"
d(s, o)
function s.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local u = self:GetSpecialValueFor("duration")
	t:AddNewModifier(t, self, "modifier_neutral_ult_29", { duration = u })
end
s = e({ p(nil) }, s)
g.neutral_ult_29 = s
g.modifier_neutral_ult_29 = c()
local v = g.modifier_neutral_ult_29
v.name = "modifier_neutral_ult_29"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.regen_ps = self:GetAbilitySpecialValueFor("regen_ps")
end
function v.prototype.OnCreated(self, w)
	if IsServer() then
		self:StartIntervalThink(1)
	end
end
function v.prototype.OnIntervalThink(self)
	local x = self:GetParent()
	local y = self:GetAbility()
	Heal(x, self.regen_ps, y:GetAbilityName(), "Ability")
end
v = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	v
)
g.modifier_neutral_ult_29 = v
return g