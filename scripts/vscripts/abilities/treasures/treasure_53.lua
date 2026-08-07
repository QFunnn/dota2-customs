--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_53"
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
		["60"] = 42,
		["61"] = 43,
		["62"] = 44,
		["63"] = 42,
		["64"] = 47,
		["65"] = 48,
		["66"] = 48,
		["67"] = 50,
		["68"] = 50,
		["69"] = 50,
		["70"] = 48,
		["71"] = 48,
		["72"] = 47,
		["73"] = 53,
		["74"] = 54,
		["75"] = 53,
		["76"] = 56,
		["77"] = 57,
		["78"] = 56,
		["79"] = 60,
		["80"] = 61,
		["83"] = 65,
		["84"] = 66,
		["85"] = 67,
		["86"] = 68,
		["87"] = 68,
		["88"] = 68,
		["89"] = 68,
		["90"] = 68,
		["91"] = 68,
		["92"] = 68,
		["93"] = 68,
		["94"] = 60,
		["95"] = 38,
		["96"] = 31,
		["97"] = 31,
		["98"] = 31,
		["99"] = 31,
		["100"] = 31,
		["101"] = 31,
		["102"] = 31,
		["103"] = 38,
		["105"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_53 = c()
local n = g.treasure_53
n.name = "treasure_53"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_53"
end
n = e({ j(nil) }, n)
g.treasure_53 = n
g.modifier_treasure_53 = c()
local o = g.modifier_treasure_53
o.name = "modifier_treasure_53"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_53_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_53_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_53 = o
g.modifier_treasure_53_buff = c()
local q = g.modifier_treasure_53_buff
q.name = "modifier_treasure_53_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.second = self:GetAbilitySpecialValueFor("second")
	self.healthReplyPct = self:GetAbilitySpecialValueFor("health_reply_pct")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function q.prototype.OnBattleStart(self, p)
	self:StartThink(self.second, "treasure_53_heal")
end
function q.prototype.OnBattleEnd(self, p)
	self:StartThink(-1, "treasure_53_heal")
end
function q.prototype.OnThink(self, r)
	if r ~= "treasure_53_heal" then
		return
	end
	self:StartThink(-1, "treasure_53_heal")
	local s = self:GetParent()
	local t = (s:GetMaxHealth() - s:GetHealth()) * self.healthReplyPct * 0.01
	Heal(s, t, self:GetAbility():GetAbilityName(), "Ability", true, HealFlags.HEAL_FLAG_IGNORE_DISTURB)
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_53_buff = q
return g