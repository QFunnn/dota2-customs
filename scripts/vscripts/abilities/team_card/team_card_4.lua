--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_4"
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
		["16"] = 6,
		["17"] = 11,
		["18"] = 12,
		["19"] = 13,
		["20"] = 14,
		["21"] = 15,
		["22"] = 16,
		["23"] = 17,
		["24"] = 18,
		["25"] = 18,
		["27"] = 19,
		["28"] = 25,
		["31"] = 11,
		["32"] = 29,
		["33"] = 30,
		["34"] = 31,
		["35"] = 32,
		["36"] = 33,
		["37"] = 34,
		["38"] = 35,
		["39"] = 36,
		["40"] = 36,
		["42"] = 37,
		["43"] = 43,
		["46"] = 29,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_4 = c()
local i = f.team_card_4
i.name = "team_card_4"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY, self.OnAbilityBuy)
	self.id2 = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY, self.OnAbilityBuy2)
end
function i.prototype.OnAbilityBuy(self, j)
	if IsServer() then
		if IsValid(j.playerhero) and j.playerhero:GetPlayerOwnerID() == self.playerID then
			local k = self.playerID
			local l = PlayerData:getHero(k)
			local m = GetRandomElement(AbilityShop.pickList)
			local n = self:getSpecialValueFor("sect_exp")
			if l ~= nil then
				l:addSectExp(m, n)
			end
			Notification:combatToPlayer(
				k,
				{
					message = "notify_artifact_48",
					string_itemname_artifact = "DOTA_Tooltip_ability_team_card_4",
					string_sect = "DOTA_Tooltip_ability_" .. m,
					int_exp = n,
				}
			)
			self:RemoveModifierEvent(self.id)
		end
	end
end
function i.prototype.OnAbilityBuy2(self, j)
	if IsServer() then
		if
			IsValid(j.playerhero)
			and j.playerhero:GetPlayerOwnerID() == GroupTeam:GetTeammatePlayerID(self.playerID)
		then
			local k = GroupTeam:GetTeammatePlayerID(self.playerID)
			local l = PlayerData:getHero(k)
			local m = GetRandomElement(AbilityShop.pickList)
			local n = self:getSpecialValueFor("sect_exp")
			if l ~= nil then
				l:addSectExp(m, n)
			end
			Notification:combatToPlayer(
				k,
				{
					message = "notify_artifact_48",
					string_itemname_artifact = "DOTA_Tooltip_ability_team_card_4",
					string_sect = "DOTA_Tooltip_ability_" .. m,
					int_exp = n,
				}
			)
			self:RemoveModifierEvent(self.id2)
		end
	end
end
return f