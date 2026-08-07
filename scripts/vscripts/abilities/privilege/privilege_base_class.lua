--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_base_class"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["7"] = 4,
		["8"] = 4,
		["9"] = 4,
		["10"] = 9,
		["11"] = 10,
		["12"] = 11,
		["13"] = 12,
		["14"] = 9,
		["15"] = 14,
		["16"] = 15,
		["17"] = 14,
		["18"] = 17,
		["19"] = 18,
		["20"] = 17,
		["21"] = 20,
		["22"] = 21,
		["23"] = 20,
		["24"] = 23,
		["25"] = 24,
		["26"] = 23,
		["27"] = 27,
		["28"] = 28,
		["29"] = 27,
		["30"] = 30,
		["31"] = 30,
		["32"] = 32,
		["33"] = 32,
		["34"] = 36,
		["35"] = 37,
		["36"] = 37,
		["37"] = 38,
		["38"] = 39,
		["39"] = 40,
		["40"] = 41,
		["43"] = 45,
		["45"] = 36,
		["46"] = 48,
		["47"] = 49,
		["48"] = 51,
		["50"] = 53,
		["52"] = 56,
		["53"] = 58,
		["54"] = 60,
		["55"] = 61,
		["56"] = 62,
		["57"] = 63,
		["58"] = 64,
		["59"] = 65,
		["60"] = 66,
		["61"] = 67,
		["63"] = 69,
		["64"] = 70,
		["66"] = 65,
		["67"] = 73,
		["68"] = 74,
		["69"] = 75,
		["71"] = 77,
		["72"] = 78,
		["74"] = 73,
		["75"] = 81,
		["76"] = 82,
		["77"] = 83,
		["79"] = 85,
		["80"] = 86,
		["82"] = 81,
		["83"] = 89,
		["84"] = 90,
		["85"] = 91,
		["87"] = 93,
		["88"] = 94,
		["90"] = 89,
		["91"] = 97,
		["92"] = 98,
		["93"] = 99,
		["95"] = 101,
		["96"] = 102,
		["98"] = 97,
		["99"] = 48,
	}
)
local e = {}
e.PrivilegeBase = c()
local f = e.PrivilegeBase
f.name = "PrivilegeBase"
function f.prototype.____constructor(self, g, h)
	self.privilege_name = h
	self.playerID = g
	self.privilege_count = 0
end
function f.prototype.GetAbilityName(self)
	return self.privilege_name
end
function f.prototype.GetPlayerID(self)
	return self.playerID
end
function f.prototype.OnModifierCount(self, i)
	self.privilege_count = self.privilege_count + i
end
function f.prototype.Spawn(self)
	self:OnCreate()
end
function f.prototype.dispose(self)
	self:OnDestory()
end
function f.prototype.OnCreate(self) end
function f.prototype.OnDestory(self) end
local function j(self, k, l)
	local m = l
	local n = m.prototype
	while n do
		for o in pairs(n) do
			if not (rawget(k, o) ~= nil) then
				k[o] = n[o]
			end
		end
		n = getmetatable(n)
	end
end
e.registerPrivilege = function(p, q)
	return function(p, r)
		if q ~= nil then
			r.name = q
		else
			q = r.name
		end
		local s = _G
		s[q] = {}
		j(nil, s[q], r)
		local t = s[q].Spawn
		local u = s[q].OnCreate
		local v = s[q].OnDestory
		local w = s[q].OnModifierCount
		s[q].Spawn = function(self)
			if t then
				t(self)
			end
			if t ~= e.PrivilegeBase.prototype.Spawn then
				e.PrivilegeBase.prototype.Spawn(self)
			end
		end
		s[q].Spawn = function(self)
			if t then
				t(self)
			end
			if t ~= e.PrivilegeBase.prototype.Spawn then
				e.PrivilegeBase.prototype.Spawn(self)
			end
		end
		s[q].OnCreate = function(self)
			if u then
				u(self)
			end
			if u ~= e.PrivilegeBase.prototype.OnCreate then
				e.PrivilegeBase.prototype.OnCreate(self)
			end
		end
		s[q].OnDestory = function(self)
			if v then
				v(self)
			end
			if v ~= e.PrivilegeBase.prototype.OnDestory then
				e.PrivilegeBase.prototype.OnDestory(self)
			end
		end
		s[q].OnModifierCount = function(self, i)
			if w then
				w(self, i)
			end
			if w ~= e.PrivilegeBase.prototype.OnModifierCount then
				e.PrivilegeBase.prototype.OnModifierCount(self, i)
			end
		end
	end
end
return e