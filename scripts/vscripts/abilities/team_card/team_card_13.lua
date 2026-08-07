--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_13"
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
		["15"] = 8,
		["16"] = 9,
		["17"] = 9,
		["18"] = 9,
		["19"] = 9,
		["20"] = 9,
		["21"] = 9,
		["23"] = 9,
		["24"] = 10,
		["25"] = 11,
		["26"] = 12,
		["27"] = 13,
		["28"] = 14,
		["30"] = 20,
		["31"] = 21,
		["32"] = 21,
		["33"] = 21,
		["34"] = 21,
		["35"] = 21,
		["37"] = 21,
		["40"] = 6,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_13 = c()
local i = f.team_card_13
i.name = "team_card_13"
d(i, h)
function i.prototype.spawn(self)
	if IsServer() then
		self.get_chance = self:getSpecialValueFor("get_chance")
		local j = PlayerData
		local k = PlayerData.saveData
		local l = self.playerID
		local m = PlayerData:loadData(self.playerID, "team_card_13")
		if m == nil then
			m = 0
		end
		k(j, l, "team_card_13", m + 1)
		if self:PRD(self.get_chance) then
			self.base_gold = self:getSpecialValueFor("base_gold")
			local n = PlayerData:loadData(self.playerID, "team_card_13")
			PlayerData:modifyGold(self.playerID, self.base_gold * n)
			Notification:combatToPlayer(
				self.playerID,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_team_card_13",
					int_gold = self.base_gold * n,
				}
			)
		else
			local o = GroupTeam:GetTeammatePlayerID(self.playerID)
			local p = PlayerData
			local q = PlayerData.saveData
			local r = PlayerData:loadData(o, "team_card_13")
			if r == nil then
				r = 0
			end
			q(p, o, "team_card_13", r + 1)
		end
	end
end
return f