--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_39"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 18,
		["28"] = 11,
		["29"] = 18,
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 21,
		["34"] = 20,
		["35"] = 19,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 18,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 18,
		["55"] = 18,
		["56"] = 31,
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 41,
		["61"] = 42,
		["62"] = 41,
		["63"] = 45,
		["64"] = 46,
		["65"] = 45,
		["66"] = 51,
		["67"] = 52,
		["70"] = 56,
		["71"] = 57,
		["72"] = 58,
		["75"] = 62,
		["76"] = 63,
		["77"] = 63,
		["78"] = 63,
		["79"] = 63,
		["80"] = 63,
		["81"] = 63,
		["82"] = 63,
		["83"] = 70,
		["84"] = 71,
		["85"] = 71,
		["86"] = 71,
		["87"] = 71,
		["88"] = 71,
		["89"] = 71,
		["90"] = 71,
		["91"] = 71,
		["92"] = 72,
		["93"] = 72,
		["94"] = 72,
		["95"] = 72,
		["96"] = 72,
		["97"] = 72,
		["98"] = 72,
		["99"] = 72,
		["100"] = 74,
		["101"] = 75,
		["102"] = 76,
		["103"] = 77,
		["104"] = 63,
		["105"] = 63,
		["106"] = 51,
		["107"] = 38,
		["108"] = 31,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 31,
		["113"] = 31,
		["114"] = 31,
		["115"] = 38,
		["117"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_39 = c()
local n = g.treasure_39
n.name = "treasure_39"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_39"
end
n = e({ j(nil) }, n)
g.treasure_39 = n
g.modifier_treasure_39 = c()
local o = g.modifier_treasure_39
o.name = "modifier_treasure_39"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_39_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_39_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_39 = o
g.modifier_treasure_39_buff = c()
local q = g.modifier_treasure_39_buff
q.name = "modifier_treasure_39_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.damagePct = self:GetAbilitySpecialValueFor("damage_pct")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function q.prototype.OnBattleStartBefore(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = r:GetEnemy()
	if not IsInjurable(r, s) then
		return
	end
	local t = r:GetMaxHealth() * self.damagePct * 0.01
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/sect/sect_health_142.vpcf",
		hCaster = r,
		hTarget = s,
		Ability = self:GetAbility(),
		vSpawnOrigin = r:GetAbsOrigin(),
		iMoveSpeed = 1200,
		OnProjectileHit = function()
			s:DealDamage(
				r,
				self:GetAbility(),
				t * 0.5,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
				DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK
					+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
					+ DamageFlags.DAMAGE_FLAG_NO_LETHAL,
				"treasure_39"
			)
			r:DealDamage(
				s,
				self:GetAbility(),
				t,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
				DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK,
				"treasure_39"
			)
			ParticleManager:CreateParticle(
				"particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break.vpcf",
				PATTACH_ABSORIGIN,
				r
			)
			r:EmitSound("Hero_Huskar.Life_Break")
			ParticleManager:CreateParticle(
				"particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break.vpcf",
				PATTACH_ABSORIGIN,
				s
			)
			s:EmitSound("Hero_Huskar.Life_Break.Impact")
		end,
	})
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_39_buff = q
return g