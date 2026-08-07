--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_20"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectKeys
local f = b.__TS__ArrayFilter
local g = b.__TS__Delete
local h = b.__TS__ArrayForEach
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 3,
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 9,
		["24"] = 9,
		["25"] = 10,
		["26"] = 11,
		["27"] = 9,
		["28"] = 9,
		["29"] = 14,
		["30"] = 14,
		["31"] = 14,
		["32"] = 14,
		["33"] = 16,
		["34"] = 17,
		["35"] = 18,
		["36"] = 19,
		["37"] = 21,
		["38"] = 22,
		["41"] = 25,
		["42"] = 26,
		["43"] = 27,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 39,
		["48"] = 40,
		["50"] = 42,
		["51"] = 42,
		["53"] = 44,
		["54"] = 38,
		["55"] = 38,
		["56"] = 50,
		["57"] = 51,
		["58"] = 52,
		["61"] = 4,
	}
)
local j = {}
local k = require("abilities.card_effect.card_effect_base")
local l = k.CardEffectBase
j.card_effect_20 = c()
local m = j.card_effect_20
m.name = "card_effect_20"
d(m, l)
function m.prototype.spawn(self)
	local n = self:getPlayerID()
	local o = PlayerData:getHero(n)
	local p = PlayerData:getplayerData(n)
	local q = o:getAbilityUpgradeData(true, true)
	local r = f(e(q), function(s, t)
		local u = KeyValues.AbilityUpgradesKvs[t]
		return u.rarity == "r"
	end)
	local v = PickList(r, self:getSpecialValueFor("cost"))
	if #v > 0 then
		local w = AbilityShop:getAbilityPoolNew("sr", nil, { p.bannedSect })
		for x, y in pairs(w.tList) do
			o:getAbilityUpgradeLevel(tostring(x))
			if o:getAbilityUpgradeLevel(tostring(x)) >= SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[x].rarity] then
				g(w.tList, x)
			end
		end
		w:update()
		local z = w:random()
		if z then
			h(v, function(s, A)
				if q[A].level == 1 then
					o:removeAbility(A)
				else
					local B, C = q[A], "level"
					B[C] = B[C] - 1
				end
				Notification:combatToPlayer(
					n,
					{
						message = "notify_card_loss_r",
						string_card = "DOTA_Tooltip_ability_" .. self.cardName,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. A,
					}
				)
			end)
			o:learnAbility(z, true)
			o:syncAbilityData()
			Notification:combatToPlayer(
				n,
				{
					message = "notify_artifact_ability_sr",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
				}
			)
		end
	end
end
return j