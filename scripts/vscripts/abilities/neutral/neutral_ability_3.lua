--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_3"
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
		["44"] = 31,
		["45"] = 31,
		["46"] = 31,
		["47"] = 31,
		["48"] = 31,
		["49"] = 30,
		["50"] = 20,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 20,
		["61"] = 20,
		["62"] = 36,
		["63"] = 44,
		["64"] = 36,
		["65"] = 44,
		["66"] = 46,
		["67"] = 47,
		["68"] = 46,
		["69"] = 49,
		["70"] = 50,
		["71"] = 49,
		["72"] = 52,
		["73"] = 53,
		["74"] = 52,
		["75"] = 44,
		["76"] = 36,
		["77"] = 36,
		["78"] = 36,
		["79"] = 36,
		["80"] = 36,
		["81"] = 36,
		["82"] = 36,
		["83"] = 36,
		["84"] = 44,
		["86"] = 44,
		["87"] = 59,
		["88"] = 60,
		["89"] = 59,
		["90"] = 60,
		["91"] = 61,
		["92"] = 62,
		["93"] = 63,
		["94"] = 64,
		["95"] = 65,
		["96"] = 66,
		["97"] = 70,
		["98"] = 61,
		["99"] = 60,
		["100"] = 59,
		["101"] = 60,
		["103"] = 60,
		["104"] = 77,
		["105"] = 85,
		["106"] = 77,
		["107"] = 85,
		["108"] = 87,
		["109"] = 88,
		["110"] = 87,
		["111"] = 90,
		["112"] = 91,
		["113"] = 92,
		["114"] = 92,
		["115"] = 91,
		["116"] = 90,
		["117"] = 95,
		["118"] = 96,
		["119"] = 95,
		["120"] = 100,
		["121"] = 101,
		["122"] = 101,
		["124"] = 100,
		["125"] = 103,
		["126"] = 104,
		["127"] = 105,
		["128"] = 106,
		["130"] = 108,
		["133"] = 103,
		["134"] = 112,
		["135"] = 113,
		["136"] = 112,
		["137"] = 115,
		["138"] = 116,
		["139"] = 115,
		["140"] = 85,
		["141"] = 77,
		["142"] = 77,
		["143"] = 77,
		["144"] = 77,
		["145"] = 77,
		["146"] = 77,
		["147"] = 77,
		["148"] = 77,
		["149"] = 85,
		["151"] = 85,
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
g.neutral_talent_3 = c()
local q = g.neutral_talent_3
q.name = "neutral_talent_3"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_3"
end
q = e({ j(nil) }, q)
g.neutral_talent_3 = q
g.modifier_neutral_talent_3 = c()
local r = g.modifier_neutral_talent_3
r.name = "modifier_neutral_talent_3"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function r.prototype.OnCritical(self, s)
	s.target:AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_neutral_talent_3_debuff",
		{ duration = self.duration }
	)
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
g.modifier_neutral_talent_3 = r
g.modifier_neutral_talent_3_debuff = c()
local t = g.modifier_neutral_talent_3_debuff
t.name = "modifier_neutral_talent_3_debuff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.damage_decrease = self:GetAbilitySpecialValueFor("damage_decrease")
end
function t.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = -self.damage_decrease }
end
t = e(
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
	t
)
g.modifier_neutral_talent_3_debuff = t
g.neutral_ult_3 = c()
local u = g.neutral_ult_3
u.name = "neutral_ult_3"
d(u, o)
function u.prototype.OnSpellStart(self)
	local v = self:GetCaster()
	local w = v:GetEnemy()
	local x = ParticleManager:CreateParticle(
		"particles/neutral_fx/wolf_intimidate_howl_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		v
	)
	ParticleManager:ReleaseParticleIndex(x)
	EmitSoundOn("Hero_Lycan.Howl", v)
	DamageSystem:performAttack(v, w, { is_crit = true, ability = self })
end
u = e({ p(nil) }, u)
g.neutral_ult_3 = u
g.modifier_neutral_ult_3 = c()
local y = g.modifier_neutral_ult_3
y.name = "modifier_neutral_ult_3"
d(y, l)
function y.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
end
function y.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function y.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function y.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	if self:GetStackCount() >= self.stack - 1 then
		return 100
	end
end
function y.prototype.OnCustomAttackLanded(self, z)
	if z and IsValid(z.target) and z.target:IsBaseNPC() then
		if self:GetStackCount() >= self.stack then
			self:SetStackCount(0)
		else
			self:IncrementStackCount()
		end
	end
end
function y.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
function y.prototype.GetEffectName(self)
	return "particles/neutral_fx/wolf_intimidate_howl_cast_dmg_debuff.vpcf"
end
y = e(
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
	y
)
g.modifier_neutral_ult_3 = y
return g