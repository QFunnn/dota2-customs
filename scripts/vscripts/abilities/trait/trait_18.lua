--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_18"
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
		["64"] = 45,
		["65"] = 46,
		["66"] = 47,
		["68"] = 45,
		["69"] = 50,
		["70"] = 51,
		["71"] = 52,
		["72"] = 52,
		["73"] = 52,
		["74"] = 51,
		["75"] = 53,
		["76"] = 53,
		["77"] = 53,
		["78"] = 51,
		["79"] = 54,
		["80"] = 54,
		["81"] = 54,
		["82"] = 51,
		["83"] = 51,
		["84"] = 50,
		["85"] = 57,
		["86"] = 58,
		["87"] = 59,
		["88"] = 60,
		["89"] = 61,
		["90"] = 61,
		["91"] = 61,
		["92"] = 61,
		["93"] = 61,
		["94"] = 61,
		["95"] = 61,
		["97"] = 57,
		["98"] = 64,
		["99"] = 65,
		["100"] = 66,
		["101"] = 67,
		["102"] = 68,
		["103"] = 68,
		["104"] = 68,
		["105"] = 68,
		["106"] = 68,
		["107"] = 68,
		["108"] = 68,
		["110"] = 64,
		["111"] = 71,
		["112"] = 72,
		["113"] = 73,
		["114"] = 74,
		["115"] = 75,
		["116"] = 75,
		["117"] = 75,
		["118"] = 75,
		["119"] = 75,
		["120"] = 75,
		["121"] = 75,
		["123"] = 71,
		["124"] = 78,
		["125"] = 79,
		["126"] = 78,
		["127"] = 38,
		["128"] = 31,
		["129"] = 31,
		["130"] = 31,
		["131"] = 31,
		["132"] = 31,
		["133"] = 31,
		["134"] = 31,
		["135"] = 38,
		["137"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_18 = c()
local n = g.trait_18
n.name = "trait_18"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_18"
end
n = e({ j(nil) }, n)
g.trait_18 = n
g.modifier_trait_18 = c()
local o = g.modifier_trait_18
o.name = "modifier_trait_18"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_18_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_18_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_18 = o
g.modifier_trait_18_buff = c()
local q = g.modifier_trait_18_buff
q.name = "modifier_trait_18_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self["return"] = self:GetAbilitySpecialValueFor("return")
	self.get = self:GetAbilitySpecialValueFor("get")
end
function q.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self:GetParent():GetHeroBase():getLevel())
	end
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { -1, self:GetParent() },
	}
end
function q.prototype.OnInjuryGained(self, p)
	if p.origin ~= "trait_18" then
		local r = self:GetParent()
		local s = r:GetEnemy()
		AddInjury(r, s, p.iStackCount * self["return"] * 0.01, "trait_18", "Ability")
	end
end
function q.prototype.OnIceGained(self, p)
	if p.origin ~= "trait_18" then
		local r = self:GetParent()
		local s = r:GetEnemy()
		AddIce(r, s, p.iStackCount * self["return"] * 0.01, "trait_18", "Ability")
	end
end
function q.prototype.OnPoisonGained(self, p)
	if p.origin ~= "trait_18" then
		local r = self:GetParent()
		local s = r:GetEnemy()
		AddPoison(r, s, p.iStackCount * self["return"] * 0.01, "trait_18", "Ability")
	end
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE] = -self.get,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE] = -self.get,
	}
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_18_buff = q
return g