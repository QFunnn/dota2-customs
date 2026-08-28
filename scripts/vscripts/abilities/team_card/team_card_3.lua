--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_3"
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
		["17"] = 10,
		["18"] = 11,
		["19"] = 12,
		["20"] = 12,
		["21"] = 12,
		["22"] = 12,
		["23"] = 13,
		["24"] = 13,
		["25"] = 13,
		["26"] = 13,
		["27"] = 13,
		["29"] = 6,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_3 = c()
local i = f.team_card_3
i.name = "team_card_3"
d(i, h)
function i.prototype.spawn(self)
	if IsServer() then
		self.self_count = self:getSpecialValueFor("self_count")
		self.teammate_count = self:getSpecialValueFor("teammate_count")
		PlayerData:ModifyFreeRefresh(self.playerID, self.self_count)
		PlayerData:ModifyFreeRefreshByKey(self.playerID, "team_card_3", self.self_count)
		PlayerData:ModifyFreeRefresh(GroupTeam:GetTeammatePlayerID(self.playerID), self.teammate_count)
		PlayerData:ModifyFreeRefreshByKey(
			GroupTeam:GetTeammatePlayerID(self.playerID),
			"team_card_3",
			self.teammate_count
		)
	end
end
return f