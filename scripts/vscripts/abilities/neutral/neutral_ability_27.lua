--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_27"
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
		["38"] = 27,
		["39"] = 27,
		["40"] = 26,
		["41"] = 25,
		["42"] = 30,
		["43"] = 31,
		["44"] = 32,
		["45"] = 33,
		["46"] = 33,
		["47"] = 33,
		["48"] = 33,
		["49"] = 33,
		["50"] = 33,
		["52"] = 30,
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
		["65"] = 38,
		["66"] = 39,
		["67"] = 38,
		["68"] = 39,
		["69"] = 40,
		["70"] = 41,
		["71"] = 42,
		["72"] = 40,
		["73"] = 39,
		["74"] = 38,
		["75"] = 39,
		["77"] = 39,
		["78"] = 46,
		["79"] = 55,
		["80"] = 46,
		["81"] = 55,
		["82"] = 58,
		["83"] = 59,
		["84"] = 60,
		["85"] = 58,
		["86"] = 62,
		["87"] = 63,
		["88"] = 64,
		["90"] = 62,
		["91"] = 67,
		["92"] = 68,
		["93"] = 67,
		["94"] = 70,
		["95"] = 71,
		["96"] = 72,
		["97"] = 72,
		["98"] = 71,
		["99"] = 70,
		["100"] = 75,
		["101"] = 76,
		["102"] = 77,
		["103"] = 78,
		["105"] = 75,
		["106"] = 81,
		["107"] = 82,
		["108"] = 81,
		["109"] = 86,
		["110"] = 87,
		["111"] = 88,
		["113"] = 86,
		["114"] = 55,
		["115"] = 46,
		["116"] = 46,
		["117"] = 46,
		["118"] = 46,
		["119"] = 46,
		["120"] = 46,
		["121"] = 46,
		["122"] = 46,
		["123"] = 46,
		["124"] = 55,
		["126"] = 55,
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
g.neutral_talent_27 = c()
local q = g.neutral_talent_27
q.name = "neutral_talent_27"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_27"
end
q = e({ j(nil) }, q)
g.neutral_talent_27 = q
g.modifier_neutral_talent_27 = c()
local r = g.modifier_neutral_talent_27
r.name = "modifier_neutral_talent_27"
d(r, m)
function r.prototype.GetAbilitySpecialValue(self)
	self.evade_regen = self:GetAbilitySpecialValueFor("evade_regen")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), self:GetParent() } }
end
function r.prototype.OnEvasion(self, s)
	local t = self:GetParent()
	if s.target == t then
		Heal(t, self.evade_regen, self:GetName(), "Ability")
	end
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
g.modifier_neutral_talent_27 = r
g.neutral_ult_27 = c()
local u = g.neutral_ult_27
u.name = "neutral_ult_27"
d(u, o)
function u.prototype.OnSpellStart(self)
	local v = self:GetCaster()
	v:AddNewModifier(v, self, "modifier_neutral_ult_27", nil)
end
u = e({ p(nil) }, u)
g.neutral_ult_27 = u
g.modifier_neutral_ult_27 = c()
local w = g.modifier_neutral_ult_27
w.name = "modifier_neutral_ult_27"
d(w, m)
function w.prototype.GetAbilitySpecialValue(self)
	self.evade_count = self:GetAbilitySpecialValueFor("evade_count")
	self.evade_chance = self:GetAbilitySpecialValueFor("evade_chance")
end
function w.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(self.evade_count)
	end
end
function w.prototype.OnRefresh(self, s)
	self:SetStackCount(self.evade_count)
end
function w.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 } }
end
function w.prototype.OnEvasion(self)
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function w.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function w.prototype.EOM_GetModifierEvasion_Bonus(self)
	if self:GetStackCount() > 0 then
		return self.evade_chance
	end
end
w = e(
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
	w
)
g.modifier_neutral_ult_27 = w
return g