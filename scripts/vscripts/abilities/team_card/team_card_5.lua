--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_5"
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
		["14"] = 3,
		["15"] = 4,
		["16"] = 3,
		["17"] = 8,
		["18"] = 9,
		["19"] = 8,
		["20"] = 11,
		["21"] = 12,
		["22"] = 12,
		["23"] = 12,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["29"] = 16,
		["30"] = 17,
		["31"] = 22,
		["32"] = 22,
		["33"] = 22,
		["34"] = 22,
		["35"] = 23,
		["36"] = 23,
		["37"] = 23,
		["38"] = 23,
		["39"] = 28,
		["41"] = 30,
		["43"] = 11,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_5 = c()
local i = f.team_card_5
i.name = "team_card_5"
d(i, h)
function i.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.record = 0
end
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, self.OnRoundChange)
end
function i.prototype.OnRoundChange(self)
	local j = PlayerData:loadData(self.playerID, "team_card_5")
	if j == nil then
		j = 0
	end
	self.record = j + 1
	self.round_count = self:getSpecialValueFor("round_count")
	if self.record >= self.round_count then
		self.gold = self:getSpecialValueFor("gold")
		PlayerData:modifyGold(self.playerID, self.gold)
		Notification:combatToPlayer(
			self.playerID,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_team_card_5",
				int_gold = self.gold,
			}
		)
		PlayerData:modifyGold(GroupTeam:GetTeammatePlayerID(self.playerID), self.gold)
		Notification:combatToPlayer(
			GroupTeam:GetTeammatePlayerID(self.playerID),
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_team_card_5",
				int_gold = self.gold,
			}
		)
		self:RemoveModifierEvent(self.id)
	else
		PlayerData:saveData(self.playerID, "team_card_5", self.record)
	end
end
return f