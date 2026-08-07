--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_51"
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
		["15"] = 16,
		["16"] = 17,
		["17"] = 18,
		["18"] = 19,
		["19"] = 16,
		["20"] = 21,
		["21"] = 22,
		["22"] = 23,
		["24"] = 21,
		["25"] = 26,
		["26"] = 27,
		["27"] = 28,
		["28"] = 26,
		["29"] = 30,
		["30"] = 31,
		["31"] = 32,
		["32"] = 32,
		["33"] = 31,
		["34"] = 30,
		["35"] = 35,
		["36"] = 36,
		["37"] = 35,
		["38"] = 38,
		["39"] = 39,
		["40"] = 38,
		["41"] = 12,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 3,
		["47"] = 3,
		["48"] = 3,
		["49"] = 3,
		["50"] = 3,
		["51"] = 12,
		["53"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_51 = c()
local k = g.modifier_card_effect_51
k.name = "modifier_card_effect_51"
d(k, i)
function k.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetEffectCardValueFor("interval")
	self.regen = self:GetEffectCardValueFor("regen")
	self.regen_pct = self:GetEffectCardValueFor("regen_pct")
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
function k.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY] = self.regen_pct }
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
g.modifier_card_effect_51 = k
return g