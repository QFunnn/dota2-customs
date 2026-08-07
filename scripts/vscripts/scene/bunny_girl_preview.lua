--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/bunny_girl_preview"
local b = require("lualib_bundle")
local c = b.__TS__ObjectEntries
local d = b.__TS__ArrayForEach
local e = b.__TS__ArraySort
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 5,
		["11"] = 5,
		["12"] = 5,
		["13"] = 5,
		["14"] = 7,
		["15"] = 7,
		["16"] = 7,
		["17"] = 7,
		["18"] = 8,
		["19"] = 8,
		["20"] = 8,
		["21"] = 8,
		["22"] = 10,
		["23"] = 11,
		["24"] = 11,
		["25"] = 11,
		["26"] = 11,
		["27"] = 11,
		["28"] = 11,
		["29"] = 11,
		["30"] = 12,
		["31"] = 13,
		["32"] = 14,
		["33"] = 15,
		["34"] = 15,
		["35"] = 16,
		["36"] = 17,
		["39"] = 11,
		["40"] = 11,
		["41"] = 21,
		["42"] = 22,
		["43"] = 22,
		["44"] = 22,
		["45"] = 23,
		["46"] = 22,
		["47"] = 22,
		["48"] = 25,
		["49"] = 25,
		["50"] = 25,
		["51"] = 26,
		["52"] = 26,
		["53"] = 27,
		["54"] = 28,
		["56"] = 29,
		["57"] = 30,
		["59"] = 30,
		["62"] = 31,
		["64"] = 31,
		["67"] = 32,
		["69"] = 32,
		["72"] = 33,
		["74"] = 33,
		["77"] = 34,
		["79"] = 34,
		["80"] = 34,
		["81"] = 34,
		["82"] = 34,
		["83"] = 34,
		["84"] = 34,
		["85"] = 34,
		["92"] = 37,
		["93"] = 38,
		["94"] = 38,
		["95"] = 38,
		["96"] = 40,
		["97"] = 40,
		["98"] = 40,
		["100"] = 40,
		["101"] = 42,
		["102"] = 43,
		["103"] = 45,
		["104"] = 47,
		["105"] = 47,
		["106"] = 47,
		["108"] = 47,
		["110"] = 42,
		["111"] = 42,
		["112"] = 42,
		["113"] = 42,
		["114"] = 42,
		["115"] = 42,
		["116"] = 42,
		["117"] = 42,
		["118"] = 42,
		["120"] = 25,
		["121"] = 25,
		["123"] = 5,
		["124"] = 5,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.registerEntityFunction
i(nil, "Spawn", function(j, k)
	if CustomNetTables:GetTableValue("service", "player_bunny" .. tostring(GetLocalPlayerID())) then
		local l =
			json.decode(CustomNetTables:GetTableValue("service", "player_bunny" .. tostring(GetLocalPlayerID())).data)
		local m = {}
		d(c(l), function(j, n)
			local o
			local p
			p = n[1]
			o = n[2]
			local q = p
			local r = o
			if q and r ~= -1 then
				local s = KeyValues.CosmeticsKV
				local t = s and s[q]
				if t then
					m[#m + 1] = q
				end
			end
		end)
		local u = #m
		e(m, function(j, v, w)
			return l[v] - l[w]
		end)
		d(m, function(j, q, x)
			local y = KeyValues.CosmeticsKV
			local t = y and y[q]
			if t then
				local z = { 0 }
				repeat
					local A = u
					local B = A == 1
					if B then
						z = { 0 }
						break
					end
					B = B or A == 2
					if B then
						z = { -100, 100 }
						break
					end
					B = B or A == 3
					if B then
						z = { -110, 0, 110 }
						break
					end
					B = B or A == 4
					if B then
						z = { -150, -50, 50, 150 }
						break
					end
					B = B or A == 5
					if B then
						z = { -220, -110, 0, 110, 220 }
						break
					end
					do
						break
					end
				until true
				local C = t.resource
				local D = GetSupportGroupAnimationDataByModelName(nil, C)
				local E = D.startAnimName
				local F = D.idleAnimName
				local G = t.model_scale
				if G == nil then
					G = 1
				end
				local H = G
				local I = SpawnEntityFromTableSynchronous
				local J = string.format("0 %d 4", z[x + 1])
				local K = (((tostring(H) .. " ") .. tostring(H)) .. " ") .. tostring(H)
				local L
				if E == F then
					L = nil
				else
					L = E
				end
				I(
					"prop_dynamic_clientside",
					{
						origin = J,
						parentname = "bunny_girl_1",
						scales = K,
						use_animgraph = "1",
						StartingAnim = L,
						IdleAnim = F,
						model = t.resource,
					}
				)
			end
		end)
	end
end)
return g