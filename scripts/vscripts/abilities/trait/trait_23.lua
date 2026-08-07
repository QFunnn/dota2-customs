--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_23"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["34"] = 21,
		["35"] = 20,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 19,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 19,
		["55"] = 19,
		["56"] = 31,
		["57"] = 39,
		["58"] = 31,
		["59"] = 39,
		["60"] = 41,
		["61"] = 42,
		["62"] = 41,
		["63"] = 44,
		["64"] = 45,
		["65"] = 44,
		["66"] = 49,
		["67"] = 50,
		["68"] = 49,
		["69"] = 54,
		["70"] = 55,
		["71"] = 56,
		["72"] = 57,
		["74"] = 54,
		["75"] = 60,
		["76"] = 61,
		["77"] = 60,
		["78"] = 65,
		["79"] = 67,
		["80"] = 68,
		["82"] = 70,
		["83"] = 71,
		["84"] = 72,
		["85"] = 73,
		["86"] = 73,
		["87"] = 73,
		["88"] = 73,
		["89"] = 73,
		["90"] = 73,
		["91"] = 73,
		["92"] = 73,
		["93"] = 73,
		["94"] = 74,
		["95"] = 75,
		["96"] = 75,
		["97"] = 75,
		["98"] = 75,
		["99"] = 75,
		["100"] = 76,
		["101"] = 77,
		["102"] = 81,
		["103"] = 82,
		["104"] = 83,
		["105"] = 84,
		["107"] = 86,
		["108"] = 65,
		["109"] = 39,
		["110"] = 31,
		["111"] = 31,
		["112"] = 31,
		["113"] = 31,
		["114"] = 31,
		["115"] = 31,
		["116"] = 31,
		["117"] = 31,
		["118"] = 39,
		["120"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_23 = c()
local n = g.trait_23
n.name = "trait_23"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_23"
end
n = e({ j(nil) }, n)
g.trait_23 = n
g.modifier_trait_23 = c()
local o = g.modifier_trait_23
o.name = "modifier_trait_23"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_23_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_23_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_23 = o
g.modifier_trait_23_buff = c()
local q = g.modifier_trait_23_buff
q.name = "modifier_trait_23_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.level = self:GetAbilitySpecialValueFor("level")
end
function q.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function q.prototype.OnBattleStart(self, p)
	local r = self:GetParent():GetHeroBase()
	if r then
		self:SetStackCount(math.floor(r:getLevel() / self.level))
	end
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_OVERRIDE] = KeyValues.CommonUnitsKv[self:GetParent()
			:GetUnitName()].StatusHealth,
	}
end
function q.prototype.EOM_GetModifierAvoidDamage(self, p)
	if bit.band(p.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return 0
	end
	if self:GetStackCount() > 0 and p.damage >= p.target:GetHealth() then
		local s = self:GetParent()
		local t = ParticleManager:CreateParticle("particles/sect/health_legend.vpcf", PATTACH_CUSTOMORIGIN, s)
		ParticleManager:SetParticleControlEnt(t, 0, s, PATTACH_ABSORIGIN_FOLLOW, nil, s:GetAbsOrigin(), false)
		ParticleManager:ReleaseParticleIndex(t)
		EmitSoundOnLocationWithCaster(s:GetAbsOrigin(), "Hero_Omniknight.GuardianAngel.Cast", s)
		s:SetHealth(s:GetMaxHealth())
		CombatLog:recordSectAbilityCast(s, "58")
		PurgeDebuff(s)
		ParticleManager:CreateParticle("particles/items_fx/aegis_respawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, s)
		self:DecrementStackCount()
		return 1
	end
	return 0
end
q = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	q
)
g.modifier_trait_23_buff = q
return g