--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_10"
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
		["71"] = 43,
		["72"] = 43,
		["73"] = 43,
		["74"] = 43,
		["75"] = 43,
		["76"] = 43,
		["77"] = 41,
		["78"] = 40,
		["79"] = 39,
		["80"] = 40,
		["82"] = 40,
		["83"] = 49,
		["84"] = 57,
		["85"] = 49,
		["86"] = 57,
		["87"] = 62,
		["88"] = 63,
		["89"] = 64,
		["90"] = 65,
		["91"] = 62,
		["92"] = 67,
		["93"] = 68,
		["94"] = 69,
		["95"] = 70,
		["97"] = 67,
		["98"] = 73,
		["99"] = 74,
		["100"] = 73,
		["101"] = 76,
		["102"] = 77,
		["103"] = 76,
		["104"] = 79,
		["105"] = 80,
		["106"] = 81,
		["107"] = 82,
		["108"] = 82,
		["109"] = 82,
		["110"] = 82,
		["111"] = 82,
		["112"] = 82,
		["113"] = 83,
		["114"] = 84,
		["115"] = 85,
		["116"] = 86,
		["117"] = 86,
		["118"] = 86,
		["119"] = 86,
		["120"] = 86,
		["121"] = 86,
		["122"] = 87,
		["123"] = 87,
		["124"] = 87,
		["125"] = 87,
		["126"] = 87,
		["127"] = 88,
		["128"] = 88,
		["129"] = 88,
		["130"] = 88,
		["131"] = 88,
		["132"] = 88,
		["133"] = 88,
		["134"] = 88,
		["135"] = 88,
		["136"] = 89,
		["137"] = 90,
		["139"] = 79,
		["140"] = 57,
		["141"] = 49,
		["142"] = 49,
		["143"] = 49,
		["144"] = 49,
		["145"] = 49,
		["146"] = 49,
		["147"] = 49,
		["148"] = 49,
		["149"] = 57,
		["151"] = 57,
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
g.neutral_talent_10 = c()
local q = g.neutral_talent_10
q.name = "neutral_talent_10"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_10"
end
q = e({ j(nil) }, q)
g.neutral_talent_10 = q
g.modifier_neutral_talent_10 = c()
local r = g.modifier_neutral_talent_10
r.name = "modifier_neutral_talent_10"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.shield = self:GetAbilitySpecialValueFor("shield")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent(), self:GetParent() } }
end
function r.prototype.OShieldGained(self, s)
	if s and self:PRD(self.chance) then
		AddShield(self:GetParent(), self.shield, self:GetAbility():GetName(), "Ability")
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
g.modifier_neutral_talent_10 = r
g.neutral_ult_10 = c()
local t = g.neutral_ult_10
t.name = "neutral_ult_10"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	u:AddNewModifier(u, self, "modifier_neutral_ult_10", { duration = self:GetSpecialValueFor("duration") })
end
t = e({ p(nil) }, t)
g.neutral_ult_10 = t
g.modifier_neutral_ult_10 = c()
local v = g.modifier_neutral_ult_10
v.name = "modifier_neutral_ult_10"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.shield = self:GetAbilitySpecialValueFor("shield")
	self.damage_shield = self:GetAbilitySpecialValueFor("damage_shield")
end
function v.prototype.OnCreated(self, s)
	if IsServer() then
		self.t = 0
		self:StartIntervalThink(self.interval)
	end
end
function v.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_pangolier/pangolier_defense_stance_shield.vpcf"
end
function v.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
function v.prototype.OnIntervalThink(self)
	local w = self:GetParent()
	local x = w:GetEnemy()
	AddShield(w, self.shield, self:GetAbility():GetName(), "Ability")
	self.t = self.t + self.interval
	if self.t >= 1 then
		self.t = self.t - 1
		w:DealDamage(x, self:GetAbility(), GetShield(w) * self.damage_shield, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
		local y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf",
			PATTACH_CENTER_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(y, 1, x, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_invalid, false)
		ParticleManager:ReleaseParticleIndex(y)
		EmitSoundOn("Hero_TemplarAssassin.PsiBlade", x)
	end
end
v = e(
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
	v
)
g.modifier_neutral_ult_10 = v
return g