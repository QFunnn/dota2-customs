--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/global"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["7"] = 5,
		["8"] = 5,
		["9"] = 5,
		["11"] = 5,
		["12"] = 5,
		["14"] = 6,
		["15"] = 7,
		["17"] = 10,
		["18"] = 11,
		["21"] = 15,
		["22"] = 16,
		["25"] = 20,
		["26"] = 21,
		["27"] = 22,
		["28"] = 24,
		["29"] = 26,
		["30"] = 27,
		["31"] = 28,
		["33"] = 30,
		["34"] = 31,
		["35"] = 32,
		["38"] = 35,
		["39"] = 36,
		["42"] = 40,
		["43"] = 41,
		["45"] = 5,
		["46"] = 45,
		["47"] = 46,
		["48"] = 47,
		["49"] = 45,
		["50"] = 56,
		["51"] = 57,
		["52"] = 58,
		["54"] = 61,
		["55"] = 62,
		["56"] = 63,
		["57"] = 64,
		["58"] = 65,
		["59"] = 66,
		["60"] = 67,
		["63"] = 70,
		["66"] = 73,
		["67"] = 56,
		["68"] = 83,
		["69"] = 84,
		["70"] = 83,
	}
)
function PrintTable(d, e, f)
	if e == nil then
		e = 0
	end
	if f == nil then
		f = 5
	end
	if e == 0 then
		print("----------------------------------------PrintTable----------------------------------------")
	end
	if e > f then
		print(string.rep("  ", e) .. "[Max depth reached]")
		return
	end
	if type(d) ~= "table" then
		print(string.rep("  ", e) .. tostring(d))
		return
	end
	for g, h in pairs(d) do
		local i = string.rep("  ", e)
		local j = type(g) == "string" and g or ("[" .. tostring(g)) .. "]"
		if type(h) == "table" then
			local k = getmetatable(h)
			if k ~= nil then
				print((i .. j) .. " = <table with metatable>")
			else
				print((i .. j) .. " = {")
				PrintTable(h, e + 1, f)
				print(i .. "}")
			end
		else
			local l = type(h) == "string" and ('"' .. tostring(h)) .. '"' or tostring(h)
			print(((i .. j) .. " = ") .. l)
		end
	end
	if e == 0 then
		print("-------------------------------------------End--------------------------------------------")
	end
end
function traceback(self, m)
	print("[Error]: " .. tostring(m))
	return m
end
string.split = function(n, o, p)
	if n == nil or n == "" or o == nil then
		return { n or "" }
	end
	local q = {}
	local r = "(.-)" .. o
	for s in string.gmatch(n .. o, r) do
		if p == true then
			local h = tonumber(s)
			if h ~= nil then
				q[#q + 1] = h
			end
		else
			q[#q + 1] = s
		end
	end
	return q
end
string.replace = function(t, r, u)
	return string.gsub(t, r, u)
end