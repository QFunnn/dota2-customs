--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_24"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["24"] = 15,
		["25"] = 18,
		["26"] = 18,
		["27"] = 18,
		["28"] = 18,
		["29"] = 18,
		["30"] = 18,
		["31"] = 18,
		["32"] = 19,
		["33"] = 20,
		["34"] = 18,
		["35"] = 18,
		["36"] = 4,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.card_effect_24 = c()
local j = g.card_effect_24
j.name = "card_effect_24"
d(j, i)
function j.prototype.spawn(self)
	local k = self:getPlayerID()
	local l = PlayerData:getHero(k)
	local m = self:getSpecialValueFor("cost")
	local n = self:getSpecialValueFor("count")
	local o = PlayerData.playerData[k].health
	local p = math.min(m, o - 1)
	if p > 0 then
		PlayerData:modifyHealth(k, -p, true)
	end
	local q = AbilityShop:getRandomAbility(k, n, { isAbilityShop = false })
	e(q, function(r, s, t)
		local u
		local v
		v = s.aid
		u = s.rarity
		l:learnAbility(v, true)
		Notification:combatToPlayer(
			k,
			{
				message = "notify_artifact_ability_" .. u,
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. v,
			}
		)
	end)
end
return g