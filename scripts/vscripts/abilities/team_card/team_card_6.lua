--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_6"
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
		["13"] = 6,
		["14"] = 7,
		["15"] = 6,
		["16"] = 9,
		["17"] = 10,
		["20"] = 13,
		["21"] = 14,
		["22"] = 15,
		["23"] = 20,
		["24"] = 20,
		["25"] = 20,
		["26"] = 20,
		["27"] = 21,
		["28"] = 21,
		["29"] = 21,
		["30"] = 21,
		["31"] = 26,
		["32"] = 9,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_6 = c()
local i = f.team_card_6
i.name = "team_card_6"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN_FOR_TEAMMEAT,
		self.OnAbilityLearnForTeammeat
	)
end
function i.prototype.OnAbilityLearnForTeammeat(self, j, k)
	if k ~= self.playerID then
		return
	end
	self.gold = self:getSpecialValueFor("gold")
	PlayerData:modifyGold(self.playerID, self.gold)
	Notification:combatToPlayer(
		self.playerID,
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_team_card_6", int_gold = self.gold }
	)
	PlayerData:modifyGold(GroupTeam:GetTeammatePlayerID(self.playerID), self.gold)
	Notification:combatToPlayer(
		GroupTeam:GetTeammatePlayerID(self.playerID),
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_team_card_6", int_gold = self.gold }
	)
	self:RemoveModifierEvent(self.id)
end
return f