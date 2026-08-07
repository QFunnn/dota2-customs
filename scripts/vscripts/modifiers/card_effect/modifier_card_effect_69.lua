--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_69"
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
		["27"] = 26,
		["28"] = 25,
		["29"] = 24,
		["30"] = 29,
		["31"] = 30,
		["32"] = 29,
		["33"] = 34,
		["34"] = 35,
		["35"] = 36,
		["37"] = 34,
		["38"] = 39,
		["39"] = 40,
		["40"] = 39,
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
g.modifier_card_effect_69 = c()
local k = g.modifier_card_effect_69
k.name = "modifier_card_effect_69"
d(k, i)
function k.prototype.GetAbilitySpecialValue(self)
	self.crit = self:GetEffectCardValueFor("crit")
	self.count = self:GetEffectCardValueFor("count")
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(self.count)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function k.prototype.OnCritical(self, l)
	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
	end
end
function k.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, l)
	return self:GetStackCount() > 0 and self.crit or 0
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
g.modifier_card_effect_69 = k
return g