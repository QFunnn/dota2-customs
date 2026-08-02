--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_20"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 4,
		["10"] = 4,
		["11"] = 4,
		["12"] = 4,
		["13"] = 5,
		["14"] = 6,
		["15"] = 7,
		["16"] = 8,
		["17"] = 8,
		["18"] = 8,
		["19"] = 9,
		["20"] = 10,
		["21"] = 11,
		["22"] = 12,
		["23"] = 13,
		["24"] = 14,
		["25"] = 15,
		["27"] = 17,
		["28"] = 18,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["37"] = 32,
		["38"] = 33,
		["41"] = 8,
		["42"] = 8,
		["43"] = 5,
	}
)
local f = {}
local g = require("abilities.greevil_effect.greevil_effect_base")
local h = g.GreevilEffectBase
f.greevil_effect_20 = c()
local i = f.greevil_effect_20
i.name = "greevil_effect_20"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getSpecialValueFor("sect_exp")
	local k = self:getSpecialValueFor("refresh_free")
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, function(l, m)
		local n = m.round_number - 1
		local o = PlayerData:getplayerData(self:getPlayerID())
		local p
		if GameState:isNeutralRound(n) then
			p = PlayerData:getNeutralResult(self.playerID) == true
		elseif GameState:isRoshanRound(n) then
			p = Roshan.roshanBattleState[self.playerID] == true
		else
			local q = o and o.loseStack or 0
			p = q <= 0
		end
		local r = PlayerData:getHero(self.playerID)
		if r then
			if p then
				local s = GetRandomElement(AbilityShop.pickList)
				r:addSectExp(s, j)
				Notification:combatToPlayer(
					self.playerID,
					{
						message = "notify_artifact_48",
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.name,
						string_sect = "DOTA_Tooltip_ability_" .. s,
						int_exp = j,
					}
				)
			else
				PlayerData:ModifyFreeRefresh(self.playerID, k)
				PlayerData:ModifyFreeRefreshByKey(self.playerID, self.name, k)
			end
		end
	end)
end
return f