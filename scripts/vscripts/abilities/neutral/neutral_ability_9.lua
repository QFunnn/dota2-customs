--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_9"
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
		["45"] = 32,
		["46"] = 32,
		["47"] = 32,
		["48"] = 32,
		["49"] = 32,
		["50"] = 33,
		["51"] = 33,
		["52"] = 33,
		["53"] = 33,
		["54"] = 33,
		["55"] = 34,
		["56"] = 34,
		["57"] = 34,
		["58"] = 34,
		["59"] = 34,
		["60"] = 34,
		["61"] = 34,
		["62"] = 34,
		["63"] = 34,
		["64"] = 35,
		["65"] = 36,
		["67"] = 30,
		["68"] = 20,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 20,
		["79"] = 20,
		["80"] = 41,
		["81"] = 42,
		["82"] = 41,
		["83"] = 42,
		["84"] = 43,
		["85"] = 44,
		["86"] = 45,
		["87"] = 45,
		["88"] = 45,
		["89"] = 45,
		["90"] = 45,
		["91"] = 45,
		["92"] = 43,
		["93"] = 42,
		["94"] = 41,
		["95"] = 42,
		["97"] = 42,
		["98"] = 51,
		["99"] = 59,
		["100"] = 51,
		["101"] = 59,
		["102"] = 63,
		["103"] = 64,
		["104"] = 65,
		["105"] = 66,
		["106"] = 63,
		["107"] = 68,
		["108"] = 69,
		["109"] = 68,
		["110"] = 73,
		["111"] = 74,
		["112"] = 75,
		["114"] = 73,
		["115"] = 78,
		["116"] = 79,
		["117"] = 78,
		["118"] = 81,
		["119"] = 82,
		["120"] = 81,
		["121"] = 84,
		["122"] = 85,
		["123"] = 86,
		["124"] = 87,
		["125"] = 87,
		["126"] = 87,
		["127"] = 87,
		["128"] = 87,
		["129"] = 87,
		["130"] = 84,
		["131"] = 59,
		["132"] = 51,
		["133"] = 51,
		["134"] = 51,
		["135"] = 51,
		["136"] = 51,
		["137"] = 51,
		["138"] = 51,
		["139"] = 51,
		["140"] = 59,
		["142"] = 59,
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
g.neutral_talent_9 = c()
local q = g.neutral_talent_9
q.name = "neutral_talent_9"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_9"
end
q = e({ j(nil) }, q)
g.neutral_talent_9 = q
g.modifier_neutral_talent_9 = c()
local r = g.modifier_neutral_talent_9
r.name = "modifier_neutral_talent_9"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 } }
end
function r.prototype.OnEvasion(self, s)
	if s then
		s.target:DealDamage(s.attacker, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf",
			PATTACH_CENTER_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			t,
			1,
			s.attacker,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			vec3_invalid,
			false
		)
		ParticleManager:ReleaseParticleIndex(t)
		EmitSoundOn("Hero_TemplarAssassin.PsiBlade", s.attacker)
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
g.modifier_neutral_talent_9 = r
g.neutral_ult_9 = c()
local u = g.neutral_ult_9
u.name = "neutral_ult_9"
d(u, o)
function u.prototype.OnSpellStart(self)
	local v = self:GetCaster()
	v:AddNewModifier(v, self, "modifier_neutral_ult_9", { duration = self:GetSpecialValueFor("duration") })
end
u = e({ p(nil) }, u)
g.neutral_ult_9 = u
g.modifier_neutral_ult_9 = c()
local w = g.modifier_neutral_ult_9
w.name = "modifier_neutral_ult_9"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.evasion_increase = self:GetAbilitySpecialValueFor("evasion_increase")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.evasion_damage = self:GetAbilitySpecialValueFor("evasion_damage")
end
function w.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.evasion_increase }
end
function w.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(1)
	end
end
function w.prototype.GetEffectName(self)
	return "particles/econ/courier/courier_babyroshan_ti10/courier_babyroshan_ti10_ambient_smoke_c.vpcf"
end
function w.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function w.prototype.OnIntervalThink(self)
	local x = self:GetParent()
	local y = x:GetEnemy()
	x:DealDamage(
		y,
		self:GetAbility(),
		self.damage + GetEvasion(x, nil) * self.evasion_damage,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
	)
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
g.modifier_neutral_ult_9 = w
return g