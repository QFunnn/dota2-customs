--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_8"
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
		["25"] = 15,
		["26"] = 16,
		["29"] = 19,
		["30"] = 19,
		["31"] = 19,
		["33"] = 19,
		["36"] = 22,
		["37"] = 22,
		["38"] = 22,
		["40"] = 22,
		["41"] = 23,
		["42"] = 24,
		["43"] = 25,
		["44"] = 25,
		["45"] = 25,
		["46"] = 25,
		["47"] = 25,
		["48"] = 25,
		["49"] = 25,
		["50"] = 25,
		["51"] = 30,
		["52"] = 31,
		["54"] = 15,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_8 = c()
local i = f.team_card_8
i.name = "team_card_8"
d(i, h)
function i.prototype.spawn(self)
	if PlayerData:loadData(self.playerID, "team_card_8") then
		PlayerData:saveData(self.playerID, "team_card_8", PlayerData:loadData(self.playerID, "team_card_8") + 1)
	else
		PlayerData:saveData(self.playerID, "team_card_8", 1)
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
	if l > 0 then
		return
	end
	local m = PlayerData:loadData(self.playerID, "team_card_8")
	if m == nil then
		m = 0
	end
	local n = m
	if n > 0 then
		PlayerData:getHero(self.playerID):learnAbility(j.abilityname, true)
		Notification:combatToPlayer(
			self.playerID,
			{
				message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[j.abilityname].rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_team_card_8",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. j.abilityname,
			}
		)
		n = n - 1
		PlayerData:saveData(self.playerID, "team_card_8", n)
	end
end
return f