--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_18"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectEntries
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 14,
		["24"] = 15,
		["25"] = 15,
		["26"] = 15,
		["27"] = 16,
		["28"] = 17,
		["29"] = 18,
		["32"] = 21,
		["33"] = 22,
		["34"] = 22,
		["35"] = 22,
		["36"] = 22,
		["37"] = 22,
		["38"] = 22,
		["39"] = 22,
		["40"] = 22,
		["41"] = 27,
		["42"] = 8,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.team_card_18 = c()
local j = g.team_card_18
j.name = "team_card_18"
d(j, i)
function j.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, self.OnRoundChange)
end
function j.prototype.OnRoundChange(self)
	local k = GroupTeam:GetTeammatePlayerID(self.playerID)
	local l = PlayerData:getHero(k)
	local m = PlayerData:getHero(self.playerID)
	local n = l.abilityShopData
	local o = 0
	local p = ""
	for q, r in ipairs(e(n)) do
		local s = r[1]
		local t = r[2]
		if o < t.gold then
			o = t.gold
			p = s
		end
	end
	m:learnAbility(p, true)
	Notification:combatToPlayer(
		self.playerID,
		{
			message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[p].rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_team_card_18",
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. p,
		}
	)
	self:RemoveModifierEvent(self.id)
end
return g