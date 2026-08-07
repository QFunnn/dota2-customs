--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_64"
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
		["21"] = 19,
		["22"] = 24,
		["23"] = 25,
		["24"] = 24,
		["25"] = 27,
		["26"] = 28,
		["27"] = 29,
		["28"] = 30,
		["29"] = 31,
		["30"] = 32,
		["31"] = 32,
		["32"] = 32,
		["33"] = 32,
		["34"] = 32,
		["35"] = 32,
		["37"] = 27,
		["38"] = 12,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 3,
		["47"] = 3,
		["48"] = 12,
		["50"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_64 = c()
local k = g.modifier_card_effect_64
k.name = "modifier_card_effect_64"
d(k, i)
function k.prototype.GetAbilitySpecialValue(self)
	self.delay = self:GetEffectCardValueFor("delay")
	self.stun = self:GetEffectCardValueFor("stun")
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function k.prototype.OnBattleStartBefore(self, l)
	self:StartIntervalThink(self.delay)
end
function k.prototype.OnIntervalThink(self)
	self:StartIntervalThink(-1)
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
g.modifier_card_effect_64 = k
return g