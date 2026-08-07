--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_26"
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
		["58"] = 34,
		["59"] = 33,
		["60"] = 32,
		["61"] = 33,
		["63"] = 33,
		["64"] = 40,
		["65"] = 49,
		["66"] = 40,
		["67"] = 49,
		["68"] = 52,
		["69"] = 53,
		["70"] = 54,
		["71"] = 52,
		["72"] = 56,
		["73"] = 57,
		["74"] = 58,
		["76"] = 56,
		["77"] = 61,
		["78"] = 62,
		["79"] = 61,
		["80"] = 64,
		["81"] = 65,
		["82"] = 66,
		["83"] = 66,
		["84"] = 65,
		["85"] = 64,
		["86"] = 69,
		["87"] = 70,
		["88"] = 71,
		["89"] = 72,
		["91"] = 69,
		["92"] = 75,
		["93"] = 76,
		["94"] = 75,
		["95"] = 80,
		["96"] = 81,
		["97"] = 82,
		["99"] = 80,
		["100"] = 49,
		["101"] = 40,
		["102"] = 40,
		["103"] = 40,
		["104"] = 40,
		["105"] = 40,
		["106"] = 40,
		["107"] = 40,
		["108"] = 40,
		["109"] = 40,
		["110"] = 49,
		["112"] = 49,
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
g.neutral_talent_26 = c()
local q = g.neutral_talent_26
q.name = "neutral_talent_26"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_26"
end
q = e({ j(nil) }, q)
g.neutral_talent_26 = q
g.modifier_neutral_talent_26 = c()
local r = g.modifier_neutral_talent_26
r.name = "modifier_neutral_talent_26"
d(r, m)
function r.prototype.GetAbilitySpecialValue(self)
	self.crit_damage_bonus = self:GetAbilitySpecialValueFor("crit_damage_bonus")
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE] = self.crit_damage_bonus }
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
g.modifier_neutral_talent_26 = r
g.neutral_ult_26 = c()
local s = g.neutral_ult_26
s.name = "neutral_ult_26"
d(s, o)
function s.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	t:AddNewModifier(t, self, "modifier_neutral_ult_26", nil)
end
s = e({ p(nil) }, s)
g.neutral_ult_26 = s
g.modifier_neutral_ult_26 = c()
local u = g.modifier_neutral_ult_26
u.name = "modifier_neutral_ult_26"
d(u, m)
function u.prototype.GetAbilitySpecialValue(self)
	self.crit_count = self:GetAbilitySpecialValueFor("crit_count")
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
end
function u.prototype.OnCreated(self, v)
	if IsServer() then
		self:SetStackCount(self.crit_count)
	end
end
function u.prototype.OnRefresh(self, v)
	self:SetStackCount(self.crit_count)
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function u.prototype.OnCritical(self, v)
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function u.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function u.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	if self:GetStackCount() > 0 then
		return self.crit_chance
	end
end
u = e(
	{
		l(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	u
)
g.modifier_neutral_ult_26 = u
return g