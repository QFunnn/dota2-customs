--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_5"
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
		["95"] = 64,
		["96"] = 64,
		["97"] = 64,
		["98"] = 64,
		["99"] = 65,
		["100"] = 66,
		["101"] = 67,
		["102"] = 67,
		["103"] = 67,
		["104"] = 67,
		["105"] = 67,
		["106"] = 67,
		["107"] = 70,
		["108"] = 70,
		["109"] = 70,
		["110"] = 70,
		["111"] = 70,
		["112"] = 70,
		["113"] = 61,
		["114"] = 60,
		["115"] = 59,
		["116"] = 60,
		["118"] = 60,
		["119"] = 74,
		["120"] = 82,
		["121"] = 74,
		["122"] = 82,
		["123"] = 84,
		["124"] = 85,
		["125"] = 84,
		["126"] = 87,
		["127"] = 88,
		["128"] = 87,
		["129"] = 92,
		["130"] = 93,
		["131"] = 92,
		["132"] = 95,
		["133"] = 96,
		["134"] = 95,
		["135"] = 82,
		["136"] = 74,
		["137"] = 74,
		["138"] = 74,
		["139"] = 74,
		["140"] = 74,
		["141"] = 74,
		["142"] = 74,
		["143"] = 74,
		["144"] = 82,
		["146"] = 82,
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
g.neutral_talent_5 = c()
local q = g.neutral_talent_5
q.name = "neutral_talent_5"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_5"
end
q = e({ j(nil) }, q)
g.neutral_talent_5 = q
g.modifier_neutral_talent_5 = c()
local r = g.modifier_neutral_talent_5
r.name = "modifier_neutral_talent_5"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function r.prototype.OnCritical(self, s)
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_neutral_talent_5_debuff",
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
g.modifier_neutral_talent_5 = r
g.modifier_neutral_talent_5_debuff = c()
local t = g.modifier_neutral_talent_5_debuff
t.name = "modifier_neutral_talent_5_debuff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.damage_increase = self:GetAbilitySpecialValueFor("damage_increase")
end
function t.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE] = self.damage_increase }
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
g.modifier_neutral_talent_5_debuff = t
g.neutral_ult_5 = c()
local u = g.neutral_ult_5
u.name = "neutral_ult_5"
d(u, o)
function u.prototype.OnSpellStart(self)
	local v = self:GetCaster()
	local w =
		ParticleManager:CreateParticle("particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", PATTACH_ABSORIGIN, v)
	ParticleManager:SetParticleControl(w, 1, Vector(350, 350, 350))
	ParticleManager:ReleaseParticleIndex(w)
	EmitSoundOn("n_creep_Centaur.Stomp", v)
	v:AddNewModifier(v, self, "modifier_neutral_ult_5", { duration = self:GetSpecialValueFor("duration") })
	v:DealDamage(
		v:GetEnemy(),
		self,
		self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("crit_damage") * GetPhysicalCriticalChance(v, nil),
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
	)
end
u = e({ p(nil) }, u)
g.neutral_ult_5 = u
g.modifier_neutral_ult_5 = c()
local x = g.modifier_neutral_ult_5
x.name = "modifier_neutral_ult_5"
d(x, l)
function x.prototype.GetAbilitySpecialValue(self)
	self.crit_increase = self:GetAbilitySpecialValueFor("crit_increase")
end
function x.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit_increase }
end
function x.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function x.prototype.GetEffectName(self)
	return "particles/neutral_fx/hellbear_power.vpcf"
end
x = e(
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
	x
)
g.modifier_neutral_ult_5 = x
return g