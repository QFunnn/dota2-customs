--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_17"
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
		["13"] = 4,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 4,
		["20"] = 5,
		["21"] = 12,
		["22"] = 21,
		["23"] = 12,
		["24"] = 21,
		["25"] = 24,
		["26"] = 25,
		["27"] = 26,
		["28"] = 24,
		["29"] = 28,
		["30"] = 29,
		["31"] = 30,
		["32"] = 30,
		["33"] = 29,
		["34"] = 28,
		["35"] = 33,
		["36"] = 34,
		["37"] = 33,
		["38"] = 39,
		["39"] = 40,
		["40"] = 39,
		["41"] = 42,
		["42"] = 43,
		["43"] = 44,
		["44"] = 45,
		["45"] = 46,
		["46"] = 47,
		["47"] = 47,
		["48"] = 47,
		["49"] = 47,
		["50"] = 47,
		["51"] = 47,
		["52"] = 47,
		["53"] = 47,
		["55"] = 42,
		["56"] = 21,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 21,
		["68"] = 21,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_17 = c()
local m = g.greevil_effect_17
m.name = "greevil_effect_17"
d(m, l)
function m.prototype.spawn(self)
	self:AddBattleBuff("modifier_greevil_effect_17")
	l.prototype.spawn(self)
end
g.modifier_greevil_effect_17 = c()
local n = g.modifier_greevil_effect_17
n.name = "modifier_greevil_effect_17"
d(n, i)
function n.prototype.GetAbilitySpecialValue(self)
	self.second = self:GetGreevilEffectValueFor("greevil_effect_17", "second")
	self.health_reply_pct = self:GetGreevilEffectValueFor("greevil_effect_17", "health_reply_pct")
end
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function n.prototype.OnCreated(self, o)
	self:StartThink(self.second, "modifier_greevil_effect_17")
end
function n.prototype.OnBattleEnd(self, o)
	self:StartThink(-1, "modifier_greevil_effect_17")
end
function n.prototype.OnThink(self, p)
	if p == "modifier_greevil_effect_17" then
		self:StartThink(-1, "modifier_greevil_effect_17")
		local q = self:GetParent()
		local r = (q:GetMaxHealth() - q:GetHealth()) * self.health_reply_pct * 0.01
		Heal(q, r, "greevil_effect_17", "Ability", true, HealFlags.HEAL_FLAG_IGNORE_DISTURB)
	end
end
n = e(
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
	n
)
g.modifier_greevil_effect_17 = n
return g