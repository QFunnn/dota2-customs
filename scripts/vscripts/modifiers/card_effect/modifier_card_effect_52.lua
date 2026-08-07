--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_52"
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
		["15"] = 15,
		["16"] = 16,
		["17"] = 17,
		["18"] = 15,
		["19"] = 19,
		["20"] = 20,
		["21"] = 21,
		["23"] = 19,
		["24"] = 24,
		["25"] = 25,
		["26"] = 26,
		["27"] = 24,
		["28"] = 28,
		["29"] = 29,
		["30"] = 30,
		["31"] = 30,
		["32"] = 29,
		["33"] = 28,
		["34"] = 33,
		["35"] = 34,
		["36"] = 33,
		["37"] = 12,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 3,
		["47"] = 12,
		["49"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_52 = c()
local k = g.modifier_card_effect_52
k.name = "modifier_card_effect_52"
d(k, i)
function k.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetEffectCardValueFor("interval")
	self.regen = self:GetEffectCardValueFor("regen")
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function k.prototype.OnIntervalThink(self)
	local m = self:GetParent()
	Heal(m, self.regen, "sect_regen", "Sect")
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function k.prototype.OnBattleEnd(self, l)
	self:StartIntervalThink(-1)
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
g.modifier_card_effect_52 = k
return g