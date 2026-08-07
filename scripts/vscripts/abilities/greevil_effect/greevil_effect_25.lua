--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_25"
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
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 6,
		["17"] = 6,
		["18"] = 8,
		["19"] = 9,
		["20"] = 10,
		["21"] = 11,
		["22"] = 12,
		["23"] = 13,
		["24"] = 14,
		["25"] = 15,
		["26"] = 15,
		["28"] = 16,
		["29"] = 16,
		["31"] = 16,
		["32"] = 17,
		["35"] = 20,
		["36"] = 21,
		["37"] = 22,
		["38"] = 23,
		["39"] = 23,
		["40"] = 23,
		["41"] = 23,
		["42"] = 23,
		["43"] = 23,
		["44"] = 23,
		["45"] = 23,
		["47"] = 29,
		["50"] = 6,
		["51"] = 6,
		["52"] = 4,
	}
)
local f = {}
local g = require("abilities.greevil_effect.greevil_effect_base")
local h = g.GreevilEffectBase
f.greevil_effect_25 = c()
local i = f.greevil_effect_25
i.name = "greevil_effect_25"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getSpecialValueFor("count")
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, function()
		local k = PlayerData:getHero(self.playerID)
		if k then
			local l = k.abilityShopData
			local m = k:getAbilityUpgradeData()
			local n = {}
			for o, p in pairs(l) do
				local q = KeyValues.AbilityUpgradesKvs[o]
				local r = m[o]
				local s = r and r.level or 0
				local t
				if q ~= nil then
					t = q.rarity
				end
				if t == "n" and s < q.MaxLevel then
					n[#n + 1] = tostring(o)
				end
			end
			local u = GetRandomElement(n)
			if u ~= nil then
				k:learnAbility(u, true)
				Notification:combatToPlayer(
					self.playerID,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[u].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.name,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
					}
				)
			else
				Notification:combatToPlayer(
					self.playerID,
					{
						message = "notify_enemy_ability_self_none",
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.name,
					}
				)
			end
		end
	end)
end
return f