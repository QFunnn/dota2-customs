--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__ObjectKeys
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 3,
		["14"] = 4,
		["15"] = 3,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["21"] = 8,
		["22"] = 9,
		["23"] = 9,
		["24"] = 9,
		["25"] = 9,
		["26"] = 10,
		["27"] = 11,
		["28"] = 11,
		["29"] = 11,
		["30"] = 14,
		["31"] = 15,
		["32"] = 16,
		["33"] = 17,
		["34"] = 18,
		["35"] = 19,
		["36"] = 20,
		["38"] = 21,
		["39"] = 21,
		["40"] = 22,
		["41"] = 23,
		["42"] = 24,
		["44"] = 21,
		["47"] = 27,
		["48"] = 27,
		["49"] = 27,
		["50"] = 27,
		["52"] = 28,
		["53"] = 28,
		["54"] = 29,
		["55"] = 30,
		["56"] = 31,
		["57"] = 32,
		["58"] = 32,
		["59"] = 32,
		["60"] = 32,
		["61"] = 32,
		["62"] = 32,
		["63"] = 32,
		["64"] = 32,
		["65"] = 39,
		["66"] = 40,
		["67"] = 41,
		["68"] = 41,
		["69"] = 41,
		["70"] = 41,
		["73"] = 28,
		["77"] = 46,
		["78"] = 47,
		["80"] = 11,
		["81"] = 11,
		["82"] = 5,
		["83"] = 4,
		["84"] = 3,
		["85"] = 4,
		["87"] = 4,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
i.treasure_3 = c()
local m = i.treasure_3
m.name = "treasure_3"
d(m, k)
function m.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local n = self:GetCaster():GetPlayerOwnerID()
	local o = e(PlayerData:getAlivePlayerIDList(), function(p, q)
		return q ~= n
	end)
	local r = self:GetSpecialValueFor("count")
	PlayerData:requestPlayerSelection(n, { players = o, ability_name = "treasure_3" }, function(p, n, s)
		local t = PlayerData:getHero(s)
		local u = t and t:getAbilityUpgradeData()
		if t and u and #f(u) > 0 then
			local v = PlayerData:getHero(n)
			local w = {}
			local x = f(v:getAbilityUpgradeData())
			do
				local y = 0
				while y < #x do
					local q = x[y + 1]
					if v:getAbilityUpgradeLevel(q) >= SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[q].rarity] then
						w[q] = true
					end
					y = y + 1
				end
			end
			local z = e(f(u), function(p, q)
				return not w[q]
			end)
			do
				local A = 0
				while A < r do
					local B = GetRandomElement(z)
					if B then
						v:learnAbility(B, true)
						Notification:combatToPlayer(
							n,
							{
								message = "notify_artifact_ability_"
									.. tostring(KeyValues.AbilityUpgradesKvs[B].rarity),
								string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. B,
							}
						)
						local C = SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[B].rarity]
						if v:getAbilityUpgradeLevel(B) >= C then
							z = e(z, function(p, q)
								return q ~= B
							end)
						end
					end
					A = A + 1
				end
			end
		else
			ErrorMessage(n, "InvalidChoice")
			return false
		end
	end)
end
m = g({ l(nil) }, m)
i.treasure_3 = m
return i