--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
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
function Activate()
	print("=== Activate ===")
	local d = SpawnEntityFromTableSynchronous("logic_timer", { origin = "0 0 0", RefireTime = 0 })
	local e = d:GetOrCreatePrivateScriptScope()
	e.OnTimer = function()
		if Convars:GetBool("sv_cheats") then
			Convars:SetBool("sv_cheats", false)
		end
	end
	d:RedirectOutput("OnTimer", "OnTimer", d)
end
function Precache(f)
	local g = require("precache_auto")
	for h in pairs(g) do
		local i = g[h]
		if h == "particle_tool" and (IsInToolsMode() or not IsDedicatedServer()) then
			for j, k in ipairs(i) do
				PrecacheResource("particle", k, f)
			end
		else
			c(i, function(l, k)
				PrecacheResource(h, k, f)
			end)
		end
	end
	local m = require("precache")
	for h, n in pairs(m) do
		for j, k in ipairs(n) do
			PrecacheResource(h, k, f)
		end
	end
end
function SpawnGroupPrecache(o, f) end
require("reload")