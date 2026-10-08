--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_216"
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
		["60"] = 42,
		["61"] = 43,
		["62"] = 44,
		["63"] = 42,
		["64"] = 46,
		["65"] = 47,
		["66"] = 48,
		["67"] = 48,
		["68"] = 48,
		["69"] = 47,
		["70"] = 49,
		["71"] = 49,
		["72"] = 49,
		["73"] = 47,
		["74"] = 47,
		["75"] = 46,
		["76"] = 52,
		["77"] = 53,
		["80"] = 54,
		["81"] = 55,
		["82"] = 56,
		["83"] = 57,
		["84"] = 57,
		["85"] = 57,
		["86"] = 57,
		["87"] = 57,
		["88"] = 57,
		["90"] = 52,
		["91"] = 60,
		["92"] = 61,
		["95"] = 62,
		["96"] = 63,
		["97"] = 64,
		["98"] = 65,
		["99"] = 65,
		["100"] = 65,
		["101"] = 65,
		["102"] = 65,
		["103"] = 65,
		["104"] = 66,
		["105"] = 66,
		["106"] = 66,
		["107"] = 66,
		["108"] = 66,
		["109"] = 66,
		["110"] = 66,
		["111"] = 66,
		["113"] = 60,
		["114"] = 39,
		["115"] = 31,
		["116"] = 31,
		["117"] = 31,
		["118"] = 31,
		["119"] = 31,
		["120"] = 31,
		["121"] = 31,
		["122"] = 31,
		["123"] = 39,
		["125"] = 39,
		["126"] = 71,
		["127"] = 78,
		["128"] = 71,
		["129"] = 78,
		["130"] = 78,
		["131"] = 71,
		["132"] = 71,
		["133"] = 71,
		["134"] = 71,
		["135"] = 71,
		["136"] = 71,
		["137"] = 71,
		["138"] = 78,
		["140"] = 78,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_216 = c()
local n = g.trait_216
n.name = "trait_216"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_216"
end
n = e({ j(nil) }, n)
g.trait_216 = n
g.modifier_trait_216 = c()
local o = g.modifier_trait_216
o.name = "modifier_trait_216"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_216_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_216_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_216 = o
g.modifier_trait_216_buff = c()
local q = g.modifier_trait_216_buff
q.name = "modifier_trait_216_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function q.prototype.OnCustomAbilityFullyCast(self, r)
	if not IsServer() then
		return
	end
	local s = self:GetParent()
	local t = s:GetEnemy()
	if IsInjurable(t) then
		t:AddNewModifier(s, self:GetAbility(), "modifier_trait_216_mark", { duration = self.duration })
	end
end
function q.prototype.OnCustomAttackLanded(self, r)
	if not IsServer() then
		return
	end
	local u = r.target
	if u:HasModifier("modifier_trait_216_mark") then
		local s = self:GetParent()
		s:DealDamage(u, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		AddInjury(s, u, 1, "trait_216", "Ability", InjuryFlags.INJURY_FLAG_NO_EXTRA)
	end
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
g.modifier_trait_216_buff = q
g.modifier_trait_216_mark = c()
local v = g.modifier_trait_216_mark
v.name = "modifier_trait_216_mark"
d(v, l)
v = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	v
)
g.modifier_trait_216_mark = v
return g