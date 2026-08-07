--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_11"
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
		["13"] = 5,
		["14"] = 6,
		["15"] = 5,
		["16"] = 8,
		["17"] = 9,
		["18"] = 10,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["22"] = 14,
		["23"] = 14,
		["25"] = 15,
		["26"] = 21,
		["28"] = 8,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_11 = c()
local i = f.card_effect_11
i.name = "card_effect_11"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY, self.OnAbilityBuy)
end
function i.prototype.OnAbilityBuy(self, j)
	if IsValid(j.playerhero) and j.playerhero:GetPlayerOwnerID() == self:getPlayerID() then
		local k = self:getPlayerID()
		local l = PlayerData:getHero(k)
		local m = GetRandomElement(AbilityShop.pickList)
		local n = self:getSpecialValueFor("exp")
		if l ~= nil then
			l:addSectExp(m, n)
		end
		Notification:combatToPlayer(
			k,
			{
				message = "notify_artifact_48",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
				string_sect = "DOTA_Tooltip_ability_" .. m,
				int_exp = n,
			}
		)
		self:RemoveModifierEvent(self.id)
	end
end
return f