--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_7"
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
		["35"] = 23,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 28,
		["40"] = 28,
		["41"] = 27,
		["42"] = 29,
		["43"] = 29,
		["44"] = 29,
		["45"] = 27,
		["46"] = 27,
		["47"] = 26,
		["48"] = 32,
		["49"] = 33,
		["50"] = 34,
		["51"] = 35,
		["52"] = 35,
		["53"] = 35,
		["54"] = 35,
		["55"] = 35,
		["56"] = 35,
		["57"] = 35,
		["58"] = 36,
		["60"] = 32,
		["61"] = 39,
		["62"] = 40,
		["63"] = 41,
		["64"] = 42,
		["65"] = 42,
		["66"] = 42,
		["67"] = 42,
		["68"] = 42,
		["69"] = 42,
		["70"] = 43,
		["72"] = 39,
		["73"] = 20,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 20,
		["84"] = 20,
		["85"] = 49,
		["86"] = 50,
		["87"] = 49,
		["88"] = 50,
		["89"] = 51,
		["90"] = 52,
		["91"] = 53,
		["92"] = 54,
		["93"] = 54,
		["94"] = 54,
		["95"] = 54,
		["96"] = 55,
		["97"] = 56,
		["98"] = 57,
		["99"] = 58,
		["100"] = 58,
		["101"] = 58,
		["102"] = 58,
		["103"] = 58,
		["104"] = 59,
		["105"] = 60,
		["106"] = 51,
		["107"] = 50,
		["108"] = 49,
		["109"] = 50,
		["111"] = 50,
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
g.neutral_talent_7 = c()
local q = g.neutral_talent_7
q.name = "neutral_talent_7"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_7"
end
q = e({ j(nil) }, q)
g.neutral_talent_7 = q
g.modifier_neutral_talent_7 = c()
local r = g.modifier_neutral_talent_7
r.name = "modifier_neutral_talent_7"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnIceGained(self, s)
	if s and not self._process and self:PRD(self.chance, "chance") then
		self._process = true
		AddIce(self:GetParent(), self:GetParent():GetEnemy(), s.iStackCount, self:GetAbility():GetName(), "Ability")
		self._process = false
	end
end
function r.prototype.OnFuryGained(self, s)
	if s and not self._process and self:PRD(self.chance, "_process") then
		self._process = true
		AddFury(self:GetParent(), s.iStackCount, self:GetAbility():GetName(), "Ability")
		self._process = false
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
g.modifier_neutral_talent_7 = r
g.neutral_ult_7 = c()
local t = g.neutral_ult_7
t.name = "neutral_ult_7"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = u:GetEnemy()
	local w = u:FindModifierByName("modifier_fury_custom")
	local x = w and w:GetStackCount() or 0
	local y = v:FindModifierByName("modifier_ice_custom")
	local z = x + (y and y:GetStackCount() or 0)
	local A = self:GetSpecialValueFor("damage") + z * self:GetSpecialValueFor("factor")
	u:DealDamage(v, self, A, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	local B = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf",
		PATTACH_ABSORIGIN,
		v
	)
	ParticleManager:SetParticleControl(B, 1, Vector(175, 0, 0))
	ParticleManager:ReleaseParticleIndex(B)
	EmitSoundOn("Hero_Invoker.SunStrike.Ignite", v)
end
t = e({ p(nil) }, t)
g.neutral_ult_7 = t
return g