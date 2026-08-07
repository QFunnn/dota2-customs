--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_150"
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
		["11"] = 4,
		["12"] = 5,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["24"] = 11,
		["25"] = 16,
		["26"] = 16,
		["27"] = 16,
		["28"] = 19,
		["29"] = 20,
		["30"] = 21,
		["31"] = 21,
		["32"] = 22,
		["33"] = 23,
		["34"] = 24,
		["36"] = 30,
		["37"] = 31,
		["40"] = 16,
		["41"] = 16,
		["43"] = 6,
		["44"] = 5,
		["45"] = 4,
		["46"] = 5,
		["48"] = 5,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.trait_150 = c()
local k = g.trait_150
k.name = "trait_150"
d(k, i)
function k.prototype.Spawn(self)
	if IsServer() then
		local l = self:GetCaster()
		local m = l:GetPlayerOwnerID()
		local n = {}
		PlayerData:eachPlayer(function(o, p, q)
			if q ~= m then
				n[#n + 1] = q
			end
		end)
		PlayerData:requestPlayerSelection(m, { players = n, ability_name = "trait_150" }, function(o, m, r)
			if IsValid(self) and IsValid(self:GetCaster()) then
				local s = PlayerData:getTraitAbility(r, 2)
				local t = s and s:GetAbilityName()
				if t then
					PlayerData:setTraitAbility(m, t, 2)
					Notification:combatToPlayer(
						m,
						{
							message = "notify_artifact_ability_sr",
							string_itemname_artifact = "DOTA_Tooltip_ability_trait_150",
							string_ability_name = "DOTA_Tooltip_ability_" .. t,
						}
					)
				else
					ErrorMessage(m, "InvalidChoice")
					return false
				end
			end
		end)
	end
end
k = e({ j(nil) }, k)
g.trait_150 = k
return g