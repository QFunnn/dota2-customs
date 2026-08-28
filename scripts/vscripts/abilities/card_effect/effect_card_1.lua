--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/card_effect/effect_card_1.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__ObjectKeys
local g = c.__TS__ArrayFilter
local h = c.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["15"] = 4,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 8,
		["21"] = 8,
		["22"] = 9,
		["23"] = 10,
		["24"] = 11,
		["25"] = 8,
		["26"] = 8,
		["27"] = 13,
		["28"] = 14,
		["29"] = 15,
		["30"] = 16,
		["31"] = 17,
		["33"] = 18,
		["34"] = 18,
		["35"] = 19,
		["36"] = 20,
		["37"] = 20,
		["38"] = 20,
		["39"] = 20,
		["40"] = 20,
		["41"] = 20,
		["42"] = 20,
		["43"] = 20,
		["44"] = 18,
		["48"] = 4,
	}
)
local i = {}
local j = require("abilities.card_effect.effect_card_base")
local k = j.EffectCardBase
i.effect_card_1 = d()
local l = i.effect_card_1
l.name = "effect_card_1"
e(l, k)
function l.prototype.spawn(self)
	local m = self:getPlayerID()
	local n = PlayerData:getHero(m)
	local o = n:getAbilityUpgradeData()
	local p = g(f(o), function(q, r)
		local s = KeyValues.AbilityUpgradesKvs[r]
		local t = SECT_ABILITY_LEVEL[s.rarity]
		return o[r].level < t and s.rarity == "n"
	end)
	local u = GetRandomElement(p)
	if u then
		local s = KeyValues.AbilityUpgradesKvs[u]
		local t = SECT_ABILITY_LEVEL[s.rarity]
		local v = t - o[u].level
		do
			local w = 0
			while w < v do
				n:learnAbility(u, true)
				Notification:combatToPlayer(
					m,
					{
						message = "notify_artifact_ability_" .. tostring(s.rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
					}
				)
				w = w + 1
			end
		end
	end
end
return i