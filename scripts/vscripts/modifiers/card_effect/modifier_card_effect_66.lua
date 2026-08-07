--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_66"
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
		["26"] = 24,
		["27"] = 29,
		["28"] = 30,
		["29"] = 29,
		["30"] = 34,
		["31"] = 35,
		["32"] = 34,
		["33"] = 37,
		["34"] = 38,
		["35"] = 37,
		["36"] = 40,
		["37"] = 41,
		["38"] = 42,
		["39"] = 40,
		["40"] = 12,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 3,
		["47"] = 3,
		["48"] = 3,
		["49"] = 3,
		["50"] = 12,
		["52"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_66 = c()
local k = g.modifier_card_effect_66
k.name = "modifier_card_effect_66"
d(k, i)
function k.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetEffectCardValueFor("damage")
	self.duration = self:GetEffectCardValueFor("duration")
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(1)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function k.prototype.EOM_GetModifierOutgoingDamagePercentage(self, l)
	return self.damage * self:GetStackCount()
end
function k.prototype.OnBattleStartBefore(self, l)
	self:StartIntervalThink(self.duration)
end
function k.prototype.OnIntervalThink(self)
	self:StartIntervalThink(-1)
	self:SetStackCount(0)
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
g.modifier_card_effect_66 = k
return g