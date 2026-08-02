--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "utils"
local b = require("lualib_bundle")
local c = b.__TS__ParseFloat
local d = b.__TS__StringSubstr
local e = b.__TS__Generator
local f = b.__TS__Iterator
local g = b.__TS__StringAccess
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 2,
		["11"] = 3,
		["12"] = 2,
		["14"] = 7,
		["15"] = 8,
		["16"] = 7,
		["18"] = 12,
		["19"] = 13,
		["20"] = 13,
		["21"] = 13,
		["22"] = 13,
		["23"] = 14,
		["24"] = 16,
		["25"] = 12,
		["26"] = 20,
		["27"] = 21,
		["28"] = 22,
		["29"] = 23,
		["30"] = 24,
		["31"] = 25,
		["32"] = 20,
		["37"] = 34,
		["38"] = 35,
		["39"] = 38,
		["40"] = 34,
		["41"] = 41,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["45"] = 44,
		["46"] = 45,
		["49"] = 48,
		["50"] = 41,
		["51"] = 57,
		["52"] = 58,
		["53"] = 59,
		["54"] = 60,
		["55"] = 61,
		["57"] = 57,
		["58"] = 66,
		["59"] = 67,
		["60"] = 68,
		["61"] = 69,
		["62"] = 70,
		["63"] = 71,
		["66"] = 74,
		["67"] = 67,
		["68"] = 76,
		["69"] = 77,
		["70"] = 78,
		["71"] = 79,
		["72"] = 80,
		["73"] = 81,
		["77"] = 85,
		["78"] = 76,
		["79"] = 87,
		["80"] = 88,
		["81"] = 89,
		["82"] = 90,
		["83"] = 91,
		["86"] = 94,
		["87"] = 87,
		["89"] = 98,
		["90"] = 99,
		["91"] = 99,
		["93"] = 100,
		["95"] = 101,
		["96"] = 101,
		["97"] = 102,
		["98"] = 103,
		["99"] = 104,
		["100"] = 108,
		["101"] = 109,
		["103"] = 111,
		["105"] = 101,
		["108"] = 115,
		["109"] = 98,
	}
)
function steam_3_64(self, i)
	return "7656" .. tostring(c(i) + 1197960265728)
end
function steam_64_3(self, j)
	return "" .. tostring(c(d(j .. "", 4)) - 1197960265728)
end
function DirectionToQAngle(self, k)
	local l = math.deg(math.atan2(k.z, math.sqrt(k.x * k.x + k.y * k.y)))
	local m = math.deg(math.atan2(k.y, k.x))
	return QAngle(l, m, 0)
end
function Rotation2D(self, n, o)
	local p = n:Length2D()
	local q = n * 1 / p
	local r = math.cos(o)
	local s = math.sin(o)
	return Vector(q.x * r - q.y * s, q.x * s + q.y * r, q.z) * p
end
function easeInOut(self, t)
	local u = t < 0.5 and 0.5 * (2 * t) ^ 2 or -0.5 * ((2 * t - 2) ^ 2 - 2)
	return u
end
function multiCompare(self, ...)
	local v = { ... }
	for w = 1, select("#", ...) do
		local x = select(w, ...)
		if x ~= 0 then
			return x
		end
	end
	return v[#v]
end
loopEntity = e(function(self, y)
	local z = Entities:First()
	while z ~= nil do
		coroutine.yield(z)
		z = Entities:Next(z)
	end
end)
if IsClient() then
	Entities.FindAllInSphere = function(self, A, B)
		local C = {}
		for D, E in f(loopEntity(nil)) do
			if E and (E:GetAbsOrigin() - A):Length2D() <= B then
				C[#C + 1] = E
			end
		end
		return C
	end
	Entities.FindAllByClassnameWithin = function(self, F, A, B)
		local C = {}
		for D, E in f(loopEntity(nil)) do
			if E and E:GetClassname() == F then
				if (E:GetAbsOrigin() - A):Length2D() <= B then
					C[#C + 1] = E
				end
			end
		end
		return C
	end
	Entities.FindAllByClassname = function(self, F)
		local C = {}
		for D, E in f(loopEntity(nil)) do
			if E and E:GetClassname() == F then
				C[#C + 1] = E
			end
		end
		return C
	end
end
function url_encode_unicode(self, G)
	if not G then
		return ""
	end
	local H = ""
	do
		local w = 0
		while w < #G do
			local I = g(G, w)
			local J = string.byte(I)
			local K = J >= 48 and J <= 57 or J >= 65 and J <= 90 or J >= 97 and J <= 122
			if K then
				H = H .. I
			else
				H = H .. string.format("%%%02X", J)
			end
			w = w + 1
		end
	end
	return H
end