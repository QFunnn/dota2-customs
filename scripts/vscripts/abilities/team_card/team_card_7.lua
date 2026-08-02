--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_7"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 5,
		["14"] = 6,
		["15"] = 7,
		["16"] = 7,
		["17"] = 7,
		["18"] = 7,
		["19"] = 7,
		["21"] = 9,
		["22"] = 10,
		["24"] = 5,
		["25"] = 14,
		["26"] = 15,
		["29"] = 18,
		["30"] = 18,
		["31"] = 18,
		["33"] = 18,
		["34"] = 19,
		["35"] = 20,
		["36"] = 21,
		["37"] = 21,
		["38"] = 21,
		["39"] = 21,
		["40"] = 21,
		["41"] = 21,
		["42"] = 21,
		["43"] = 21,
		["44"] = 26,
		["45"] = 27,
		["47"] = 14,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_7 = c()
local i = f.team_card_7
i.name = "team_card_7"
d(i, h)
function i.prototype.spawn(self)
	if PlayerData:loadData(self.playerID, "team_card_7") then
		PlayerData:saveData(self.playerID, "team_card_7", PlayerData:loadData(self.playerID, "team_card_7") + 1)
	else
		PlayerData:saveData(self.playerID, "team_card_7", 1)
		self.id = self:ModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN_FOR_TEAMMEAT,
			self.OnAbilityLearnForTeammeat
		)
	end
end
function i.prototype.OnAbilityLearnForTeammeat(self, j, k)
	if k ~= self.playerID then
		return
	end
	local l = PlayerData:loadData(self.playerID, "team_card_7")
	if l == nil then
		l = 0
	end
	local m = l
	if m > 0 then
		PlayerData:getHero(self.playerID):learnAbility(j.abilityname, true)
		Notification:combatToPlayer(
			self.playerID,
			{
				message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[j.abilityname].rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_team_card_7",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. j.abilityname,
			}
		)
		m = m - 1
		PlayerData:saveData(self.playerID, "team_card_7", m)
	end
end
return f