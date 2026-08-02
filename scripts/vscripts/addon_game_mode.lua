--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "addon_game_mode"
local b = require("lualib_bundle")
local c = b.__TS__ArrayForEach
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["5"] = 2,
		["6"] = 4,
		["8"] = 6,
		["9"] = 7,
		["11"] = 9,
		["12"] = 10,
		["14"] = 13,
		["15"] = 14,
		["16"] = 14,
		["17"] = 14,
		["18"] = 15,
		["19"] = 16,
		["20"] = 17,
		["21"] = 18,
		["22"] = 19,
		["23"] = 20,
		["26"] = 23,
		["27"] = 25,
		["28"] = 26,
		["29"] = 25,
		["30"] = 29,
		["31"] = 30,
		["32"] = 31,
		["33"] = 32,
		["34"] = 33,
		["36"] = 34,
		["37"] = 35,
		["39"] = 37,
		["40"] = 37,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 40,
		["46"] = 37,
		["47"] = 37,
		["51"] = 44,
		["52"] = 45,
		["55"] = 46,
		["56"] = 47,
		["57"] = 48,
		["58"] = 49,
		["60"] = 51,
		["61"] = 52,
		["62"] = 53,
		["63"] = 54,
		["65"] = 44,
		["66"] = 57,
		["67"] = 58,
		["68"] = 59,
		["69"] = 60,
		["70"] = 61,
		["71"] = 62,
		["76"] = 67,
		["77"] = 68,
		["78"] = 69,
		["79"] = 70,
		["80"] = 70,
		["81"] = 70,
		["82"] = 70,
		["84"] = 72,
		["85"] = 73,
		["86"] = 73,
		["87"] = 73,
		["88"] = 73,
		["91"] = 77,
		["92"] = 78,
		["93"] = 79,
		["96"] = 83,
		["97"] = 84,
		["98"] = 85,
		["99"] = 86,
		["100"] = 87,
		["101"] = 88,
		["102"] = 89,
		["107"] = 30,
		["108"] = 96,
		["109"] = 96,
		["110"] = 97,
	}
)
if _G.debug == nil then
	_G.debug = {}
end
if _G.debug.traceback == nil then
	_G.debug.traceback = function(...)
		return ""
	end
end
if _G.debug.getinfo == nil then
	_G.debug.getinfo = function(...)
		return { source = "", what = "", short_src = "" }
	end
end
if IsInToolsMode() then
	local e = string.sub
	local f = debug.getinfo(1)
	local g = e(f and f.source or "", 2)
	if { string.find(g, "(.*dota 2 beta[\\/]game[\\/]dota_addons[\\/])([^\\/]+)[\\/]") } then
		local h, i = string.match(g, "(.*dota 2 beta[\\/]game[\\/]dota_addons[\\/])([^\\/]+)[\\/]")
		local j = string.gsub(h, "\\game\\dota_addons\\", "\\content\\dota_addons\\")
		_G.GameDir = h
		_G.AddonName = i
		_G.ContentDir = j
	end
end
require("requires")
function Activate()
	CModule:initialize()
end
require("precache")
function Precache(k)
	local l = {}
	local m = false
	for n in pairs(tPrecacheList) do
		do
			if not m and n == "particle" then
				goto o
			end
			c(tPrecacheList[n], function(p, q)
				if not l[q] then
					l[q] = true
					PrecacheResource(n, q, k)
				end
			end)
		end
		::o::
	end
	local function r(q, k)
		if l[q] then
			return
		end
		l[q] = true
		if (string.find(q, ".vpcf", nil, true) or 0) - 1 ~= -1 then
			if m then
				PrecacheResource("particle", q, k)
			end
		elseif (string.find(q, ".vsndevts", nil, true) or 0) - 1 ~= -1 then
			PrecacheResource("soundfile", q, k)
		elseif (string.find(q, ".vmdl", nil, true) or 0) - 1 ~= -1 then
			PrecacheResource("model", q, k)
		end
	end
	for s in pairs(KeyValues.AbilitiesKv) do
		if s ~= "Version" then
			local t = KeyValues.AbilitiesKv[s]
			if type(t.PrecacheResource) == "table" then
				for u, q in pairs(t.PrecacheResource) do
					r(q, k)
				end
			end
		end
	end
	for s in pairs(KeyValues.CosmeticsKV) do
		local t = KeyValues.CosmeticsKV[s]
		if t.resource then
			r(tostring(t.resource), k)
		end
		if t.extra_resource then
			r(tostring(t.extra_resource), k)
		end
	end
	for s in pairs(KeyValues.UnitsKv) do
		if s ~= "Version" then
			PrecacheUnitByNameSync(s, k)
		end
	end
	for s in pairs(KeyValues.ItemsKv) do
		if s ~= "Version" then
			PrecacheItemByNameSync(s, k)
			local t = KeyValues.ItemsKv[s]
			if type(t.PrecacheResource) == "table" then
				for u, q in pairs(t.PrecacheResource) do
					r(q, k)
				end
			end
		end
	end
end
function SpawnGroupPrecache(v, k) end
require("reload")