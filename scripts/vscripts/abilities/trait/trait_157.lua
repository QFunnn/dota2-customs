--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_157"
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
		["36"] = 24,
		["37"] = 25,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["43"] = 26,
		["44"] = 24,
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
		["56"] = 30,
		["57"] = 37,
		["58"] = 30,
		["59"] = 37,
		["61"] = 37,
		["62"] = 40,
		["63"] = 30,
		["64"] = 42,
		["65"] = 43,
		["66"] = 44,
		["67"] = 45,
		["68"] = 42,
		["69"] = 48,
		["70"] = 49,
		["71"] = 48,
		["72"] = 55,
		["73"] = 56,
		["74"] = 57,
		["75"] = 58,
		["76"] = 59,
		["78"] = 61,
		["79"] = 55,
		["80"] = 64,
		["81"] = 65,
		["82"] = 66,
		["84"] = 64,
		["85"] = 70,
		["86"] = 71,
		["87"] = 72,
		["88"] = 73,
		["89"] = 73,
		["90"] = 73,
		["91"] = 73,
		["92"] = 73,
		["94"] = 70,
		["95"] = 77,
		["96"] = 78,
		["97"] = 77,
		["98"] = 37,
		["99"] = 30,
		["100"] = 30,
		["101"] = 30,
		["102"] = 30,
		["103"] = 30,
		["104"] = 30,
		["105"] = 30,
		["106"] = 37,
		["108"] = 37,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_157 = c()
local n = g.trait_157
n.name = "trait_157"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_157"
end
n = e({ j(nil) }, n)
g.trait_157 = n
g.modifier_trait_157 = c()
local o = g.modifier_trait_157
o.name = "modifier_trait_157"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_157_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_157_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_157 = o
g.modifier_trait_157_buff = c()
local q = g.modifier_trait_157_buff
q.name = "modifier_trait_157_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = false
end
function q.prototype.GetAbilitySpecialValue(self)
	self.timer = self:GetAbilitySpecialValueFor("timer")
	self.poison_dmg_steal = self:GetAbilitySpecialValueFor("poison_dmg_steal")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
	}
end
function q.prototype.OnBattleStartBefore(self, p)
	local r = PlayerData:getHero(self.parent:GetPlayerOwnerID())
	local s = self.timer
	if r then
		s = s - (r:getSectLevel("sect_poison") + r:getSectLevel("sect_attack")) * self.interval
	end
	self:StartIntervalThink(s)
end
function q.prototype.OnIntervalThink(self)
	if IsServer() then
		self.enable = true
	end
end
function q.prototype.OnCustomAttackLanded(self, t)
	if self.enable then
		self.enable = false
		TriggerPoison(t.target, self.poison_dmg_steal, self:GetAbility())
	end
end
function q.prototype.OnBattleEnd(self, p)
	self.parent:RemoveModifierByName("modifier_trait_157_buff")
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_157_buff = q
return g