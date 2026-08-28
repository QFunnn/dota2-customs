--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_21"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectKeys
local f = b.__TS__ArrayFilter
local g = b.__TS__ArrayMap
local h = b.__TS__Delete
local i = b.__TS__ArrayForEach
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 3,
		["18"] = 4,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 10,
		["25"] = 10,
		["26"] = 10,
		["27"] = 10,
		["28"] = 11,
		["29"] = 12,
		["30"] = 10,
		["31"] = 10,
		["32"] = 13,
		["34"] = 14,
		["35"] = 14,
		["36"] = 15,
		["37"] = 14,
		["40"] = 10,
		["41"] = 10,
		["42"] = 18,
		["43"] = 18,
		["44"] = 18,
		["45"] = 18,
		["46"] = 19,
		["47"] = 20,
		["48"] = 21,
		["49"] = 22,
		["50"] = 24,
		["51"] = 25,
		["54"] = 28,
		["55"] = 29,
		["56"] = 30,
		["57"] = 31,
		["58"] = 31,
		["59"] = 31,
		["60"] = 32,
		["61"] = 33,
		["63"] = 35,
		["64"] = 35,
		["66"] = 37,
		["67"] = 31,
		["68"] = 31,
		["69"] = 43,
		["70"] = 44,
		["71"] = 45,
		["74"] = 4,
	}
)
local k = {}
local l = require("abilities.card_effect.card_effect_base")
local m = l.CardEffectBase
k.card_effect_21 = c()
local n = k.card_effect_21
n.name = "card_effect_21"
d(n, m)
function n.prototype.spawn(self)
	local o = self:getPlayerID()
	local p = PlayerData:getHero(o)
	local q = PlayerData:getplayerData(o)
	local r = p:getAbilityUpgradeData(true, true)
	local s = {}
	g(
		f(e(r), function(t, u)
			local v = KeyValues.AbilityUpgradesKvs[u]
			return v.rarity == "n"
		end),
		function(t, u)
			do
				local w = 0
				while w < r[u].level do
					s[#s + 1] = u
					w = w + 1
				end
			end
		end
	)
	local x = PickList(s, self:getSpecialValueFor("cost"))
	if #x > 0 then
		local y = AbilityShop:getAbilityPoolNew("r", nil, { q.bannedSect })
		for z, A in pairs(y.tList) do
			p:getAbilityUpgradeLevel(tostring(z))
			if p:getAbilityUpgradeLevel(tostring(z)) >= SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[z].rarity] then
				h(y.tList, z)
			end
		end
		y:update()
		local B = y:random()
		if B then
			i(x, function(t, C)
				if r[C].level == 1 then
					p:removeAbility(C)
				else
					local D, E = r[C], "level"
					D[E] = D[E] - 1
				end
				Notification:combatToPlayer(
					o,
					{
						message = "notify_card_loss",
						string_card = "DOTA_Tooltip_ability_" .. self.cardName,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. C,
					}
				)
			end)
			p:learnAbility(B, true)
			p:syncAbilityData()
			Notification:combatToPlayer(
				o,
				{
					message = "notify_artifact_ability_r",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. B,
				}
			)
		end
	end
end
return k