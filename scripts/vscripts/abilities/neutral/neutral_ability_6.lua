--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_6"
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
		["41"] = 31,
		["43"] = 30,
		["44"] = 20,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 20,
		["55"] = 20,
		["56"] = 35,
		["57"] = 36,
		["58"] = 35,
		["59"] = 36,
		["60"] = 37,
		["61"] = 38,
		["62"] = 39,
		["63"] = 40,
		["64"] = 40,
		["65"] = 40,
		["66"] = 40,
		["67"] = 40,
		["68"] = 40,
		["69"] = 40,
		["70"] = 41,
		["71"] = 41,
		["72"] = 42,
		["73"] = 42,
		["74"] = 42,
		["75"] = 42,
		["76"] = 42,
		["77"] = 42,
		["78"] = 43,
		["79"] = 44,
		["80"] = 44,
		["81"] = 44,
		["82"] = 44,
		["83"] = 44,
		["84"] = 45,
		["85"] = 45,
		["86"] = 45,
		["87"] = 45,
		["88"] = 45,
		["89"] = 46,
		["90"] = 47,
		["91"] = 37,
		["92"] = 36,
		["93"] = 35,
		["94"] = 36,
		["96"] = 36,
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
g.neutral_talent_6 = c()
local q = g.neutral_talent_6
q.name = "neutral_talent_6"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_6"
end
q = e({ j(nil) }, q)
g.neutral_talent_6 = q
g.modifier_neutral_talent_6 = c()
local r = g.modifier_neutral_talent_6
r.name = "modifier_neutral_talent_6"
d(r, m)
function r.prototype.GetAbilitySpecialValue(self)
	self.extra_evasion = self:GetAbilitySpecialValueFor("extra_evasion")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function r.prototype.EOM_GetModifierEvasion_Bonus(self, s)
	if s and s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self.extra_evasion
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
g.modifier_neutral_talent_6 = r
g.neutral_ult_6 = c()
local t = g.neutral_ult_6
t.name = "neutral_ult_6"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = u:GetEnemy()
	AddIce(u, v, self:GetSpecialValueFor("ice"), self:GetName(), "Ability")
	local w = v:FindModifierByName("modifier_ice_custom")
	local x = w and w:GetStackCount() or 0
	u:DealDamage(
		v,
		self,
		self:GetSpecialValueFor("damage") + x * self:GetSpecialValueFor("factor"),
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
	)
	local y = ParticleManager:CreateParticle(
		"particles/econ/items/ancient_apparition/aa_2021_immortal/aa_2021_immortal_chilling_projectile_hit.vpcf",
		PATTACH_CENTER_FOLLOW,
		v
	)
	ParticleManager:SetParticleControl(y, 1, v:GetCenter())
	ParticleManager:SetParticleControl(y, 3, v:GetCenter())
	ParticleManager:ReleaseParticleIndex(y)
	EmitSoundOn("Hero_Ancient_Apparition.ChillingTouch.Target", v)
end
t = e({ p(nil) }, t)
g.neutral_ult_6 = t
return g