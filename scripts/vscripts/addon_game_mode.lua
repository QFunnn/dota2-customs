--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


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
		return { source = "", what = "" }
	end
end
local a = "addon_game_mode"
local b = require("lualib_bundle")
local c = b.__TS__ArrayForEach
SendToServerConsole("dota_combine_models 0")
Convars:SetBool("dota_combine_models", false)
SendToServerConsole("dota_max_physical_items_purchase_limit 99999")
require("requires")
function Activate()
	print("=== Activate ===")
	CModule:initialize()
end
function Precache(d)
	local e = require("precache_auto")
	for f in pairs(e) do
		local g = e[f]
		if f == "particle_tool" and (IsInToolsMode() or not IsDedicatedServer()) then
			for h, i in ipairs(g) do
				PrecacheResource("particle", i, d)
			end
		else
			c(g, function(j, i)
				PrecacheResource(f, i, d)
			end)
		end
	end
	local k = require("precache")
	for f, l in pairs(k) do
		for h, i in ipairs(l) do
			PrecacheResource(f, i, d)
		end
	end
	for m in pairs(KeyValues.heroes) do
		if m ~= "Version" then
			PrecacheUnitByNameSync(m, d)
		end
	end
	for m in pairs(KeyValues.units) do
		if m ~= "Version" then
			PrecacheUnitByNameSync(m, d)
		end
	end
end
function SpawnGroupPrecache(n, d) end
require("reload")