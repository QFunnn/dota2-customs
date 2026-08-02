--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_19"
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
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 41,
		["61"] = 42,
		["62"] = 43,
		["63"] = 41,
		["64"] = 50,
		["65"] = 51,
		["66"] = 51,
		["67"] = 51,
		["68"] = 51,
		["69"] = 51,
		["70"] = 50,
		["71"] = 57,
		["72"] = 58,
		["73"] = 59,
		["74"] = 57,
		["75"] = 61,
		["76"] = 62,
		["77"] = 61,
		["78"] = 68,
		["79"] = 69,
		["80"] = 68,
		["81"] = 73,
		["82"] = 74,
		["83"] = 73,
		["84"] = 76,
		["85"] = 77,
		["86"] = 77,
		["87"] = 77,
		["88"] = 77,
		["89"] = 77,
		["90"] = 77,
		["91"] = 76,
		["92"] = 79,
		["93"] = 80,
		["94"] = 81,
		["95"] = 82,
		["96"] = 83,
		["97"] = 83,
		["98"] = 83,
		["99"] = 83,
		["100"] = 83,
		["101"] = 83,
		["102"] = 83,
		["104"] = 79,
		["105"] = 38,
		["106"] = 31,
		["107"] = 31,
		["108"] = 31,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 31,
		["113"] = 38,
		["115"] = 38,
		["116"] = 87,
		["117"] = 94,
		["118"] = 87,
		["119"] = 94,
		["120"] = 95,
		["121"] = 96,
		["122"] = 95,
		["123"] = 94,
		["124"] = 87,
		["125"] = 87,
		["126"] = 87,
		["127"] = 87,
		["128"] = 87,
		["129"] = 87,
		["130"] = 87,
		["131"] = 94,
		["133"] = 94,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_19 = c()
local n = g.trait_19
n.name = "trait_19"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_19"
end
n = e({ j(nil) }, n)
g.trait_19 = n
g.modifier_trait_19 = c()
local o = g.modifier_trait_19
o.name = "modifier_trait_19"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_19_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_19_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_19 = o
g.modifier_trait_19_buff = c()
local q = g.modifier_trait_19_buff
q.name = "modifier_trait_19_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
	self.health = self:GetAbilitySpecialValueFor("health")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL] = { self:GetParent() },
	}
end
function q.prototype.OnBattleStartBefore(self, p)
	self:SetStackCount(GetWispHealth(self:GetParent()))
	self:GetParent():CalculateGenericBonuses()
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_SHARE_PERCENTAGE] = -1000,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL] = self.reduce,
	}
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function q.prototype.EOM_GetModifierHealthBonus(self)
	return self:GetStackCount()
end
function q.prototype.OnWispSpawn(self, p)
	p.wisp:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_19_wisp", nil)
end
function q.prototype.OnWispHeal(self, p)
	local r = self:GetParent()
	local s = r:GetEnemy()
	if IsInjurable(r, s) and p.healAmount > 0 then
		DealDamageToWisp(r, s, self:GetAbility(), p.healAmount, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_19_buff = q
g.modifier_trait_19_wisp = c()
local t = g.modifier_trait_19_wisp
t.name = "modifier_trait_19_wisp"
d(t, l)
function t.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_19_wisp = t
return g