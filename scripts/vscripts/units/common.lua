--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "units/common"
local b = require("lualib_bundle")
local c = b.__TS__StringSplit
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["6"] = 1,
		["7"] = 1,
		["8"] = 6,
		["9"] = 6,
		["10"] = 6,
		["11"] = 6,
		["12"] = 7,
		["13"] = 8,
		["14"] = 9,
		["15"] = 9,
		["16"] = 9,
		["17"] = 9,
		["18"] = 10,
		["19"] = 11,
		["21"] = 13,
		["22"] = 14,
		["23"] = 15,
		["24"] = 16,
		["26"] = 18,
		["27"] = 18,
		["28"] = 18,
		["29"] = 18,
		["30"] = 18,
		["31"] = 20,
		["32"] = 21,
		["33"] = 22,
		["34"] = 23,
		["35"] = 24,
		["36"] = 25,
		["37"] = 26,
		["39"] = 28,
		["42"] = 32,
		["43"] = 33,
		["44"] = 34,
		["45"] = 34,
		["46"] = 34,
		["47"] = 34,
		["48"] = 34,
		["49"] = 35,
		["50"] = 36,
		["51"] = 37,
		["57"] = 6,
		["58"] = 6,
		["59"] = 45,
		["60"] = 45,
		["61"] = 45,
		["62"] = 45,
		["63"] = 46,
		["64"] = 47,
		["65"] = 47,
		["66"] = 47,
		["67"] = 47,
		["68"] = 47,
		["70"] = 45,
		["71"] = 45,
	}
)
local e = {}
local f = require("lib.dota_ts_adapter")
local g = f.registerEntityFunction
g(nil, "Spawn", function(h, i)
	if IsServer() then
		if not thisEntity.bIsNotFirstSpawn then
			local j = EntIndexToHScript(toFiniteNumber(i:GetValue("iOwnerIndex"), -1))
			if IsValid(j) then
				thisEntity:SetOwner(j)
			end
			local k = { n = #SYNC_UNIT_KEY }
			for l = 0, #SYNC_UNIT_KEY - 1, 1 do
				local m = SYNC_UNIT_KEY[l + 1]
				k[l + 1] = i:GetValue(m)
			end
			CustomNetTables:SetTableValue("unit_kv", tostring(thisEntity:entindex()), { _ = json.encode(k) })
			local n = i:GetValue("OverrideKeys")
			if type(n) == "string" then
				local o = c(n, ",")
				for l = 0, #o - 1, 1 do
					local p = o[l + 1]
					if thisEntity._tOverrideData == nil then
						thisEntity._tOverrideData = {}
					end
					thisEntity._tOverrideData[p] = i:GetValue(p)
				end
			end
			local q = i:GetValue("AIScripts")
			if type(q) == "string" then
				local r = pcall(DoIncludeScript, q, getfenv(1))
				if r then
					if type(AIStart) == "function" then
						AIStart(nil, i)
					end
				end
			end
		end
	end
end)
g(nil, "UpdateOnRemove", function()
	if IsServer() then
		CustomNetTables:SetTableValue("unit_kv", tostring(thisEntity:entindex()), nil)
	end
end)
return e