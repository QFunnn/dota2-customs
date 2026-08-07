--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_14"
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
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 24,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 31,
		["42"] = 30,
		["43"] = 29,
		["44"] = 34,
		["45"] = 35,
		["46"] = 36,
		["47"] = 36,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 37,
		["53"] = 38,
		["54"] = 39,
		["56"] = 34,
		["57"] = 20,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 20,
		["68"] = 20,
		["69"] = 44,
		["70"] = 45,
		["71"] = 44,
		["72"] = 45,
		["73"] = 46,
		["74"] = 47,
		["75"] = 48,
		["76"] = 48,
		["77"] = 48,
		["78"] = 48,
		["79"] = 48,
		["80"] = 48,
		["81"] = 49,
		["82"] = 49,
		["83"] = 49,
		["84"] = 49,
		["85"] = 49,
		["86"] = 49,
		["87"] = 52,
		["88"] = 53,
		["89"] = 53,
		["90"] = 53,
		["91"] = 53,
		["92"] = 53,
		["93"] = 54,
		["94"] = 55,
		["95"] = 46,
		["96"] = 45,
		["97"] = 44,
		["98"] = 45,
		["100"] = 45,
		["101"] = 60,
		["102"] = 68,
		["103"] = 60,
		["104"] = 68,
		["105"] = 70,
		["106"] = 71,
		["107"] = 70,
		["108"] = 73,
		["109"] = 74,
		["110"] = 73,
		["111"] = 78,
		["112"] = 79,
		["113"] = 78,
		["114"] = 81,
		["115"] = 82,
		["116"] = 81,
		["117"] = 68,
		["118"] = 60,
		["119"] = 60,
		["120"] = 60,
		["121"] = 60,
		["122"] = 60,
		["123"] = 60,
		["124"] = 60,
		["125"] = 60,
		["126"] = 68,
		["128"] = 68,
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
g.neutral_talent_14 = c()
local q = g.neutral_talent_14
q.name = "neutral_talent_14"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_14"
end
q = e({ j(nil) }, q)
g.neutral_talent_14 = q
g.modifier_neutral_talent_14 = c()
local r = g.modifier_neutral_talent_14
r.name = "modifier_neutral_talent_14"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.factor = self:GetAbilitySpecialValueFor("factor")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomAttackLanded(self, s)
	if s and self:PRD(self.chance) then
		self:GetParent():DealDamage(
			s.target,
			self:GetAbility(),
			self.damage + GetFury(self:GetParent()) * self.factor,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
		local t = ParticleManager:CreateParticle(
			"particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
			PATTACH_CENTER_FOLLOW,
			s.target
		)
		ParticleManager:ReleaseParticleIndex(t)
		EmitSoundOn("Hero_Warlock.FatalBondsDamage", s.target)
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
g.modifier_neutral_talent_14 = r
g.neutral_ult_14 = c()
local u = g.neutral_ult_14
u.name = "neutral_ult_14"
d(u, o)
function u.prototype.OnSpellStart(self)
	local v = self:GetCaster()
	AddFury(v, self:GetSpecialValueFor("fury"), self:GetName(), "Ability")
	v:AddNewModifier(v, self, "modifier_neutral_ult_14", { duration = self:GetSpecialValueFor("duration") })
	local t = ParticleManager:CreateParticle(
		"particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
		PATTACH_ABSORIGIN,
		v
	)
	ParticleManager:SetParticleControl(t, 1, Vector(150, 0, 0))
	ParticleManager:ReleaseParticleIndex(t)
	EmitSoundOn("Hero_Ursa.Enrage", v)
end
u = e({ p(nil) }, u)
g.neutral_ult_14 = u
g.modifier_neutral_ult_14 = c()
local w = g.modifier_neutral_ult_14
w.name = "modifier_neutral_ult_14"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_bonus = self:GetAbilitySpecialValueFor("attackspeed_bonus")
end
function w.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed_bonus }
end
function w.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
function w.prototype.GetEffectName(self)
	return "particles/econ/items/warlock/warlock_ti10_head/warlock_ti_10_fatal_bonds_icon.vpcf"
end
w = e(
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
	w
)
g.modifier_neutral_ult_14 = w
return g