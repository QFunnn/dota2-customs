--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_63"
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
		["15"] = 14,
		["16"] = 15,
		["17"] = 14,
		["18"] = 17,
		["19"] = 18,
		["20"] = 17,
		["21"] = 22,
		["22"] = 23,
		["23"] = 24,
		["24"] = 25,
		["25"] = 26,
		["26"] = 26,
		["27"] = 26,
		["28"] = 26,
		["29"] = 26,
		["30"] = 26,
		["32"] = 22,
		["33"] = 12,
		["34"] = 3,
		["35"] = 3,
		["36"] = 3,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 12,
		["45"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_63 = c()
local k = g.modifier_card_effect_63
k.name = "modifier_card_effect_63"
d(k, i)
function k.prototype.GetAbilitySpecialValue(self)
	self.stun = self:GetEffectCardValueFor("stun")
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function k.prototype.OnBattleStartBefore(self, l)
	local m = self:GetParent()
	local n = m:GetEnemy()
	if IsValid(n) then
		AddStun(m, n, m:GetDummyAbility(), self.stun)
	end
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
g.modifier_card_effect_63 = k
return g