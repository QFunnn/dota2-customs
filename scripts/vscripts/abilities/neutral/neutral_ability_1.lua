--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_1"
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
		["71"] = 42,
		["72"] = 42,
		["73"] = 42,
		["74"] = 42,
		["75"] = 42,
		["76"] = 41,
		["77"] = 40,
		["78"] = 39,
		["79"] = 40,
		["81"] = 40,
		["82"] = 48,
		["83"] = 56,
		["84"] = 48,
		["85"] = 56,
		["86"] = 59,
		["87"] = 60,
		["88"] = 61,
		["89"] = 59,
		["90"] = 63,
		["91"] = 64,
		["92"] = 63,
		["93"] = 68,
		["94"] = 69,
		["95"] = 70,
		["96"] = 70,
		["97"] = 70,
		["98"] = 70,
		["99"] = 70,
		["100"] = 70,
		["101"] = 70,
		["103"] = 68,
		["104"] = 73,
		["105"] = 74,
		["106"] = 73,
		["107"] = 76,
		["108"] = 77,
		["109"] = 76,
		["110"] = 56,
		["111"] = 48,
		["112"] = 48,
		["113"] = 48,
		["114"] = 48,
		["115"] = 48,
		["116"] = 48,
		["117"] = 48,
		["118"] = 48,
		["119"] = 56,
		["121"] = 56,
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
g.neutral_talent_1 = c()
local q = g.neutral_talent_1
q.name = "neutral_talent_1"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_1"
end
q = e({ j(nil) }, q)
g.neutral_talent_1 = q
g.modifier_neutral_talent_1 = c()
local r = g.modifier_neutral_talent_1
r.name = "modifier_neutral_talent_1"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomTakeDamage(self, s)
	if s and s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and self:PRD(self.chance) then
		Heal(self:GetParent(), self.hp_regen, self:GetAbility():GetName(), "Ability")
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
g.modifier_neutral_talent_1 = r
g.neutral_ult_1 = c()
local t = g.neutral_ult_1
t.name = "neutral_ult_1"
d(t, o)
function t.prototype.OnSpellStart(self)
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_neutral_ult_1",
		{ duration = self:GetSpecialValueFor("duration") }
	)
end
t = e({ p(nil) }, t)
g.neutral_ult_1 = t
g.modifier_neutral_ult_1 = c()
local u = g.modifier_neutral_ult_1
u.name = "modifier_neutral_ult_1"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_bonus = self:GetAbilitySpecialValueFor("attackspeed_bonus")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
end
function u.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function u.prototype.EOM_GetModifierAttackSpeedBonus(self)
	if IsServer() then
		return self.attackspeed_bonus
			* Script_RemapValClamped(self:GetParent():GetHealthPercent(), 100, self.threshold, 0, 1)
	end
end
function u.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
function u.prototype.GetEffectName(self)
	return "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodrage_eztzhok.vpcf"
end
u = e(
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
	u
)
g.modifier_neutral_ult_1 = u
return g