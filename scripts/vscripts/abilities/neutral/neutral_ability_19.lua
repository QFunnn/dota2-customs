--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_19"
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
		["41"] = 30,
		["42"] = 20,
		["43"] = 12,
		["44"] = 12,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 20,
		["53"] = 20,
		["54"] = 36,
		["55"] = 37,
		["56"] = 36,
		["57"] = 37,
		["58"] = 38,
		["59"] = 39,
		["60"] = 40,
		["61"] = 41,
		["62"] = 42,
		["63"] = 43,
		["64"] = 44,
		["66"] = 47,
		["68"] = 38,
		["69"] = 37,
		["70"] = 36,
		["71"] = 37,
		["73"] = 37,
		["74"] = 52,
		["75"] = 61,
		["76"] = 52,
		["77"] = 61,
		["78"] = 63,
		["79"] = 64,
		["80"] = 63,
		["81"] = 66,
		["82"] = 67,
		["83"] = 68,
		["85"] = 66,
		["86"] = 71,
		["87"] = 72,
		["88"] = 73,
		["89"] = 74,
		["90"] = 75,
		["91"] = 76,
		["92"] = 76,
		["93"] = 76,
		["94"] = 77,
		["95"] = 77,
		["96"] = 77,
		["97"] = 77,
		["98"] = 77,
		["99"] = 77,
		["100"] = 76,
		["101"] = 76,
		["103"] = 80,
		["106"] = 71,
		["107"] = 61,
		["108"] = 52,
		["109"] = 52,
		["110"] = 52,
		["111"] = 52,
		["112"] = 52,
		["113"] = 52,
		["114"] = 52,
		["115"] = 52,
		["116"] = 52,
		["117"] = 61,
		["119"] = 61,
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
g.neutral_talent_19 = c()
local q = g.neutral_talent_19
q.name = "neutral_talent_19"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_19"
end
q = e({ j(nil) }, q)
g.neutral_talent_19 = q
g.modifier_neutral_talent_19 = c()
local r = g.modifier_neutral_talent_19
r.name = "modifier_neutral_talent_19"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.wisp_health = self:GetAbilitySpecialValueFor("wisp_health")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS }
end
function r.prototype.EOM_GetModifierWispHealthBonus(self)
	return self.wisp_health
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
g.modifier_neutral_talent_19 = r
g.neutral_ult_19 = c()
local s = g.neutral_ult_19
s.name = "neutral_ult_19"
d(s, o)
function s.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local u = self:GetSpecialValueFor("duration")
	local v = self:GetSpecialValueFor("base_health")
	local w = t:FindModifierByName("modifier_sect_wisp")
	if IsValid(w) and w:GetStackCount() > 0 then
		t:AddNewModifier(t, self, "modifier_neutral_ult_19", { duration = u })
	else
		SummonWisp(t, v)
	end
end
s = e({ p(nil) }, s)
g.neutral_ult_19 = s
g.modifier_neutral_ult_19 = c()
local x = g.modifier_neutral_ult_19
x.name = "modifier_neutral_ult_19"
d(x, l)
function x.prototype.GetAbilitySpecialValue(self)
	self.wisp_regen = self:GetAbilitySpecialValueFor("wisp_regen")
end
function x.prototype.OnCreated(self, y)
	if IsServer() then
		self:StartIntervalThink(1)
	end
end
function x.prototype.OnIntervalThink(self)
	if IsServer() then
		local z = self:GetParent()
		local w = z:FindModifierByName("modifier_sect_wisp")
		if IsValid(w) and w:GetStackCount() > 0 then
			EachWisp(self:GetParent(), function(A)
				A:ModifyHealth(A:GetHealth() + self.wisp_regen, self:GetAbility(), false, 0)
			end)
		else
			self:Destroy()
		end
	end
end
x = e(
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
			}
		),
	},
	x
)
g.modifier_neutral_ult_19 = x
return g