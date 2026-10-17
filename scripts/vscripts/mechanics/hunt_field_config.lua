--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/hunt_field_config"
local b = require("lualib_bundle")
local c = b.__TS__StringTrim
local d = b.__TS__StringSplit
local e = b.__TS__ArrayFilter
local f = b.__TS__StringSubstring
local g = {}
g.HUNT_FIXED_MODIFIERS = { heavy = "modifier_hunt_heavy", freeze = "modifier_hunt_freeze", calm = "modifier_hunt_calm" }
function g.ParseHuntFixedAffixes(self, h)
	local i = {}
	local j = {}
	for k, l in ipairs(d(h, "|")) do
		do
			if c(l) == "" then
				goto m
			end
			local n = d(l, ":")
			local o = c(n[1])
			local p = #n == 1 and 1 or toFiniteNumber(c(n[2]), 0)
			if #n > 2 or o == "" or p < 1 or p ~= math.floor(p) or j[o] ~= nil then
				return
			end
			j[o] = true
			i[#i + 1] = { id = o, level = p }
		end
		::m::
	end
	return i
end
function g.GetHuntLevelValue(self, h, p, q)
	if p == nil then
		p = 1
	end
	if q == nil then
		q = 0
	end
	local r = e(d(c(h), " "), function(k, s)
		return s ~= ""
	end)
	if #r == 0 then
		return q
	end
	local t = math.min(math.max(1, math.floor(toFiniteNumber(p, 1))), #r) - 1
	return toFiniteNumber(r[t + 1], q)
end
function g.ParseHuntEffectParams(self, u, p)
	if p == nil then
		p = 1
	end
	local i = {}
	for k, l in ipairs(d(u, "|")) do
		do
			local v = (string.find(l, ":", nil, true) or 0) - 1
			if v <= 0 then
				goto w
			end
			local x = c(f(l, 0, v))
			if x ~= "" then
				i[x] = g.GetHuntLevelValue(nil, f(l, v + 1), p)
			end
		end
		::w::
	end
	return i
end
function g.GetHuntFieldEffectError(self, o, y)
	local z = {
		immortal_totem = { "Interval", "WarningTime", "Duration", "Radius", "BombInterval", "DamagePct" },
		healing_totem = { "Interval", "WarningTime", "LaneCount", "LaneWidth", "WaveRadius", "Distance", "Speed", "DamagePct" },
		hunter = { "Interval", "Lifetime", "MoveSpeed", "TriggerDistance", "WarningTime", "BlastRadius", "DamagePct" },
		siphon = { "Interval", "Duration", "TickInterval", "DamagePct", "HealPct", "BreakDistance" },
		energy_orb = { "Interval", "PickupRadius", "Countdown", "DamagePct" },
		lightning = {
			"Interval",
			"TrackTime",
			"Radius",
			"WarningTime",
			"DamagePct",
			"Duration",
			"TickInterval",
			"TickDamagePct",
		},
	}
	local A = z[o]
	if A == nil then
		return "unsupported effect"
	end
	for k, x in ipairs(A) do
		local s = y[x]
		if type(s) ~= "number" or toFiniteNumber(s, 0) <= 0 then
			return (("expected positive number " .. x) .. "=") .. tostring(s)
		end
	end
	if o == "immortal_totem" and y.BombInterval < 0.1 then
		return "BombInterval must be >= 0.1, got " .. tostring(y.BombInterval)
	end
	if o == "healing_totem" then
		if y.LaneCount < 6 or y.LaneCount ~= math.floor(y.LaneCount) then
			return "LaneCount must be an integer >= 6, got " .. tostring(y.LaneCount)
		end
		if y.WaveRadius >= y.LaneWidth or 2 * (y.LaneWidth - y.WaveRadius) < 256 then
			return (("unsafe tide gap LaneWidth=" .. tostring(y.LaneWidth)) .. " WaveRadius=") .. tostring(y.WaveRadius)
		end
	end
end
function g.GetHuntFieldBuffConfig(self, o, p)
	if p == nil then
		p = 1
	end
	if p < 1 or p ~= math.floor(p) then
		return
	end
	local B = KeyValues.hunt_field_buff
	local h = B and B[o]
	if h == nil then
		return
	end
	local C = math.floor(toFiniteNumber(h.Type, 0))
	if C ~= 1 and C ~= 2 then
		return
	end
	local D = o
	local E = p
	local F = C
	local G = toFiniteNumber(h.Weight, 0)
	local H = math.max
	local I = g.GetHuntLevelValue
	local J = tostring
	local K = h.Time
	if K == nil then
		K = "0"
	end
	local L = H(0, I(nil, J(K), p))
	local M = tostring
	local N = h.AbilityTextureName
	if N == nil then
		N = ""
	end
	local O = c(M(N))
	local P = g.ParseHuntEffectParams
	local Q = tostring
	local R = h.EffectParams
	if R == nil then
		R = ""
	end
	return { id = D, level = E, type = F, weight = G, time = L, abilityTextureName = O, params = P(nil, Q(R), p) }
end
return g