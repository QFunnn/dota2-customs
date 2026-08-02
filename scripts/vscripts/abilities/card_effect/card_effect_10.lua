--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_10"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 14,
		["24"] = 15,
		["25"] = 17,
		["26"] = 18,
		["29"] = 21,
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 25,
		["35"] = 31,
		["37"] = 8,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.card_effect_10 = c()
local j = g.card_effect_10
j.name = "card_effect_10"
d(j, i)
function j.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY, self.OnAbilityBuy)
end
function j.prototype.OnAbilityBuy(self, k)
	if IsValid(k.playerhero) and k.playerhero:GetPlayerOwnerID() == self:getPlayerID() then
		local l = self:getPlayerID()
		local m = PlayerData:getHero(l)
		local n = PlayerData:getplayerData(l)
		local o = AbilityShop:getAbilityPoolNew("n", nil, { n.bannedSect })
		for p, q in pairs(o.tList) do
			m:getAbilityUpgradeLevel(tostring(p))
			if m:getAbilityUpgradeLevel(tostring(p)) >= SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[p].rarity] then
				e(o.tList, p)
			end
		end
		o:update()
		local r = o:random()
		if r then
			m:learnAbility(r, true)
			Notification:combatToPlayer(
				l,
				{
					message = "notify_artifact_ability_n",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r,
				}
			)
		end
		self:RemoveModifierEvent(self.id)
	end
end
return g