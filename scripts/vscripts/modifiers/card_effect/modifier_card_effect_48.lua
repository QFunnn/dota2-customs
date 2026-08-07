--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_48"
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
		["11"] = 3,
		["12"] = 12,
		["13"] = 3,
		["14"] = 12,
		["15"] = 14,
		["16"] = 15,
		["17"] = 14,
		["18"] = 19,
		["19"] = 20,
		["20"] = 21,
		["21"] = 22,
		["23"] = 19,
		["24"] = 36,
		["25"] = 38,
		["26"] = 39,
		["28"] = 41,
		["29"] = 42,
		["30"] = 43,
		["31"] = 44,
		["32"] = 44,
		["33"] = 44,
		["34"] = 44,
		["35"] = 44,
		["36"] = 44,
		["37"] = 44,
		["38"] = 44,
		["39"] = 44,
		["40"] = 45,
		["41"] = 46,
		["42"] = 46,
		["43"] = 46,
		["44"] = 46,
		["45"] = 46,
		["46"] = 47,
		["47"] = 51,
		["48"] = 52,
		["49"] = 53,
		["50"] = 54,
		["52"] = 56,
		["53"] = 36,
		["54"] = 12,
		["55"] = 3,
		["56"] = 3,
		["57"] = 3,
		["58"] = 3,
		["59"] = 3,
		["60"] = 3,
		["61"] = 3,
		["62"] = 3,
		["63"] = 3,
		["64"] = 12,
		["66"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_48 = c()
local k = g.modifier_card_effect_48
k.name = "modifier_card_effect_48"
d(k, i)
function k.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(1)
		self.hp_pct = self:GetEffectCardValueFor("hp_pct")
	end
end
function k.prototype.EOM_GetModifierAvoidDamage(self, l)
	if bit.band(l.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return 0
	end
	if self:GetStackCount() > 0 and l.damage >= l.target:GetHealth() then
		local m = self:GetParent()
		local n = ParticleManager:CreateParticle("particles/sect/health_legend.vpcf", PATTACH_CUSTOMORIGIN, m)
		ParticleManager:SetParticleControlEnt(n, 0, m, PATTACH_ABSORIGIN_FOLLOW, nil, m:GetAbsOrigin(), false)
		ParticleManager:ReleaseParticleIndex(n)
		EmitSoundOnLocationWithCaster(m:GetAbsOrigin(), "Hero_Omniknight.GuardianAngel.Cast", m)
		m:SetHealth(m:GetMaxHealth() * self.hp_pct * 0.01)
		PurgeDebuff(m)
		ParticleManager:CreateParticle("particles/items_fx/aegis_respawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, m)
		self:DecrementStackCount()
		return 1
	end
	return 0
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	k
)
g.modifier_card_effect_48 = k
return g