--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_6"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 4,
		["13"] = 3,
		["14"] = 4,
		["15"] = 5,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 9,
		["21"] = 9,
		["22"] = 9,
		["23"] = 10,
		["24"] = 11,
		["26"] = 12,
		["27"] = 12,
		["28"] = 12,
		["29"] = 12,
		["30"] = 12,
		["32"] = 15,
		["33"] = 15,
		["34"] = 16,
		["35"] = 17,
		["36"] = 17,
		["37"] = 17,
		["38"] = 17,
		["39"] = 17,
		["40"] = 17,
		["41"] = 17,
		["42"] = 17,
		["43"] = 15,
		["47"] = 5,
		["48"] = 4,
		["49"] = 3,
		["50"] = 4,
		["52"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.treasure_6 = c()
local k = g.treasure_6
k.name = "treasure_6"
d(k, i)
function k.prototype.Spawn(self)
	if IsServer() then
		local l = self:GetCaster():GetPlayerOwnerID()
		local m = PlayerData:getHero(l)
		local n = math.min(self:GetSpecialValueFor("cost"), PlayerData.playerData[l].health - 1)
		if n > 0 then
			PlayerData:modifyHealth(l, -n, true)
		end
		local o = AbilityShop:getRandomAbility(l, self:GetSpecialValueFor("count"), { isAbilityShop = false })
		do
			local p = 0
			while p < #o do
				m:learnAbility(o[p + 1].aid, true)
				Notification:combatToPlayer(
					l,
					{
						message = "notify_artifact_ability_" .. o[p + 1].rarity,
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. o[p + 1].aid,
					}
				)
				p = p + 1
			end
		end
	end
end
k = e({ j(nil) }, k)
g.treasure_6 = k
return g