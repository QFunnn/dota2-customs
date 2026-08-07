--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_21"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 3,
		["13"] = 4,
		["14"] = 3,
		["15"] = 4,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["22"] = 11,
		["23"] = 13,
		["24"] = 14,
		["27"] = 17,
		["29"] = 18,
		["30"] = 18,
		["31"] = 19,
		["32"] = 20,
		["33"] = 21,
		["34"] = 22,
		["35"] = 22,
		["36"] = 22,
		["37"] = 22,
		["38"] = 22,
		["39"] = 22,
		["40"] = 22,
		["41"] = 22,
		["43"] = 18,
		["47"] = 5,
		["48"] = 4,
		["49"] = 3,
		["50"] = 4,
		["52"] = 4,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
h.treasure_21 = c()
local l = h.treasure_21
l.name = "treasure_21"
d(l, j)
function l.prototype.Spawn(self)
	if IsServer() then
		local m = self:GetCaster():GetPlayerOwnerID()
		local n = PlayerData:getHero(m)
		local o = PlayerData:getplayerData(m)
		local p = AbilityShop:getAbilityPoolNew("sr", nil, { o.bannedSect })
		for q, r in pairs(p.tList) do
			if n:getAbilityUpgradeLevel(tostring(q)) >= SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[q].rarity] then
				e(p.tList, q)
			end
		end
		p:update()
		do
			local s = 0
			while s < self:GetSpecialValueFor("count") do
				local t = p:random()
				if t then
					n:learnAbility(t, true)
					Notification:combatToPlayer(
						m,
						{
							message = "notify_artifact_ability_sr",
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. t,
						}
					)
				end
				s = s + 1
			end
		end
	end
end
l = f({ k(nil) }, l)
h.treasure_21 = l
return h