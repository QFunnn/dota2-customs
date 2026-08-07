--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_15"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{ ["7"] = 1, ["8"] = 1, ["9"] = 3, ["10"] = 3, ["11"] = 3, ["12"] = 3, ["13"] = 4, ["14"] = 5, ["15"] = 6, ["16"] = 7, ["17"] = 8, ["18"] = 9, ["20"] = 4 }
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_15 = c()
local i = f.team_card_15
i.name = "team_card_15"
d(i, h)
function i.prototype.spawn(self)
	local j = PlayerData:getHero(self:getPlayerID()).hero
	local k = PlayerResource:GetSelectedHeroEntity(self:getPlayerID())
	TeamCard:DrawAttributeForPlayer(self:getPlayerID())
	if IsValid(k) then
		k:AddNewModifier(j, nil, "modifier_team_card_15", {})
	end
end
return f