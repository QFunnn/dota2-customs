--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_12"
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
		["10"] = 2,
		["11"] = 2,
		["13"] = 5,
		["14"] = 13,
		["15"] = 5,
		["16"] = 13,
		["17"] = 15,
		["18"] = 16,
		["19"] = 15,
		["20"] = 18,
		["21"] = 19,
		["22"] = 18,
		["23"] = 23,
		["24"] = 24,
		["27"] = 25,
		["28"] = 26,
		["29"] = 27,
		["30"] = 32,
		["31"] = 23,
		["32"] = 13,
		["33"] = 5,
		["34"] = 5,
		["35"] = 5,
		["36"] = 5,
		["37"] = 5,
		["38"] = 5,
		["39"] = 5,
		["40"] = 5,
		["41"] = 13,
		["43"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_12 = c()
local l = g.modifier_city_12
l.name = "modifier_city_12"
d(l, k)
function l.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function l.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_ARTIFACT] = { -1, -1 } }
end
function l.prototype.OnSelectArtifact(self, m)
	if m.gift then
		return
	end
	local n = self.gold * Rounds:getCurrentRound()
	PlayerData:modifyGold(m.playerID, n)
	Notification:combatToPlayer(
		m.playerID,
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name, int_gold = n }
	)
	CityEffect:modifyCityEffectExtraData(m.playerID, "bonus_gold", n)
end
l = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	l
)
g.modifier_city_12 = l
return g