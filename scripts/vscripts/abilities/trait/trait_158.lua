--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_158"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__ArrayFilter
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 4,
		["14"] = 5,
		["15"] = 4,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["22"] = 11,
		["23"] = 12,
		["24"] = 13,
		["25"] = 13,
		["26"] = 13,
		["27"] = 14,
		["29"] = 14,
		["33"] = 14,
		["37"] = 14,
		["39"] = 14,
		["40"] = 15,
		["41"] = 13,
		["42"] = 13,
		["43"] = 18,
		["44"] = 18,
		["45"] = 18,
		["46"] = 18,
		["47"] = 18,
		["48"] = 18,
		["49"] = 18,
		["50"] = 18,
		["51"] = 19,
		["53"] = 6,
		["54"] = 5,
		["55"] = 4,
		["56"] = 5,
		["58"] = 5,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
i.trait_158 = c()
local m = i.trait_158
m.name = "trait_158"
d(m, k)
function m.prototype.Spawn(self)
	if IsServer() then
		local n = self:GetCaster()
		local o = n:GetPlayerOwnerID()
		local p = PlayerData:getHero(o)
		local q = p and p:getItemList("all") or {}
		local r = RuneTask.runeRewardTraitList["158"] or {}
		local s = f(r, function(t, u)
			local v = KeyValues.TraitAbilitiesKv[u]
			if v ~= nil then
				v = v.AbilityValues
			end
			local w
			if v ~= nil then
				w = v.item
			end
			local x
			if w ~= nil then
				x = w.value
			end
			local y = x
			return y ~= nil and e(q, y)
		end)
		local z = RuneTask:generateRandomRuneList(o, 4, RUNE_TASK_ROUNDS[2], s, true, "158")
		RuneTask:setRuneRewardList(o, z)
	end
end
m = g({ l(nil) }, m)
i.trait_158 = m
return i