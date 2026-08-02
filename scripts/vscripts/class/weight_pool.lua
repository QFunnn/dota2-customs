--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "class/weight_pool"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ObjectKeys
local e = b.__TS__Delete
local f = b.__TS__ArraySlice
local g = b.__TS__New
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["21"] = 14,
		["22"] = 14,
		["23"] = 14,
		["24"] = 18,
		["25"] = 19,
		["26"] = 20,
		["27"] = 18,
		["28"] = 22,
		["29"] = 23,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 29,
		["36"] = 29,
		["37"] = 30,
		["38"] = 30,
		["40"] = 22,
		["41"] = 33,
		["42"] = 34,
		["45"] = 37,
		["46"] = 38,
		["50"] = 33,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["57"] = 49,
		["58"] = 43,
		["59"] = 51,
		["60"] = 52,
		["61"] = 51,
		["62"] = 54,
		["63"] = 55,
		["64"] = 56,
		["67"] = 59,
		["68"] = 60,
		["70"] = 62,
		["72"] = 64,
		["73"] = 54,
		["74"] = 67,
		["75"] = 68,
		["76"] = 69,
		["77"] = 67,
		["78"] = 72,
		["79"] = 73,
		["80"] = 72,
		["81"] = 76,
		["82"] = 77,
		["84"] = 78,
		["85"] = 78,
		["86"] = 79,
		["87"] = 80,
		["88"] = 81,
		["90"] = 78,
		["93"] = 76,
		["94"] = 85,
		["95"] = 86,
		["96"] = 87,
		["97"] = 88,
		["99"] = 89,
		["100"] = 89,
		["102"] = 90,
		["103"] = 91,
		["104"] = 92,
		["106"] = 94,
		["107"] = 95,
		["108"] = 96,
		["110"] = 98,
		["111"] = 99,
		["112"] = 100,
		["115"] = 89,
		["118"] = 102,
		["119"] = 103,
		["121"] = 105,
		["123"] = 106,
		["124"] = 106,
		["125"] = 107,
		["126"] = 108,
		["128"] = 106,
		["131"] = 111,
		["132"] = 85,
		["133"] = 113,
		["134"] = 114,
		["135"] = 115,
		["136"] = 116,
		["137"] = 117,
		["138"] = 118,
		["139"] = 119,
		["140"] = 120,
		["141"] = 121,
		["142"] = 121,
		["143"] = 121,
		["144"] = 121,
		["145"] = 122,
		["148"] = 126,
		["150"] = 127,
		["151"] = 127,
		["152"] = 128,
		["153"] = 129,
		["154"] = 130,
		["156"] = 127,
		["159"] = 133,
		["160"] = 113,
		["161"] = 135,
		["162"] = 136,
		["163"] = 136,
		["164"] = 136,
		["165"] = 136,
		["166"] = 135,
		["167"] = 139,
		["168"] = 139,
		["169"] = 139,
		["171"] = 140,
		["172"] = 141,
		["173"] = 142,
		["174"] = 143,
		["175"] = 144,
		["178"] = 147,
		["179"] = 139,
	}
)
local i = {}
i.CWeightPool = c()
local j = i.CWeightPool
j.name = "CWeightPool"
function j.prototype.____constructor(self, k)
	self.tList = k
	self:update()
end
function j.prototype.update(self)
	self.tName = {}
	self.tSection = {}
	local l = 0
	local m = d(self.tList)
	for n, o in ipairs(m) do
		l = l + self.tList[o]
		local p = self.tSection
		p[#p + 1] = l
		local q = self.tName
		q[#q + 1] = o
	end
end
function j.prototype.each(self, r)
	if not self.tList then
		return
	end
	for o in pairs(self.tList) do
		if r(nil, o) == true then
			return
		end
	end
end
function j.prototype.has(self, s)
	for o in pairs(self.tList) do
		if o == s then
			return true
		end
	end
	return false
end
function j.prototype.get(self, s)
	return self.tList[s] or 0
end
function j.prototype.set(self, s, t)
	if s == nil then
		debug.traceback("in function 'CWeightPool.set': parameter:sName a nil value")
		return
	end
	if t > 0 then
		self.tList[s] = t
	else
		e(self.tList, s)
	end
	self:update()
end
function j.prototype.add(self, s, t)
	local u = self.tList[s] or 0
	self:set(s, u + t)
end
function j.prototype.remove(self, s)
	self:set(s, 0)
end
function j.prototype.random(self)
	local v = RandomInt(1, self.tSection[#self.tSection] or 1)
	do
		local w = 0
		while w < #self.tSection do
			local x = self.tSection[w + 1]
			if v <= x then
				return self.tName[w + 1]
			end
			w = w + 1
		end
	end
end
function j.prototype.randomExclude(self, y)
	local l = 0
	local z = {}
	local A = {}
	do
		local w = 0
		while w < #self.tName do
			do
				local o = self.tName[w + 1]
				if y[o] then
					goto B
				end
				local C = self.tList[o] or 0
				if C <= 0 then
					goto B
				end
				l = l + C
				z[#z + 1] = o
				A[#A + 1] = l
			end
			::B::
			w = w + 1
		end
	end
	if l <= 0 then
		return nil
	end
	local v = RandomInt(1, l)
	do
		local w = 0
		while w < #A do
			if v <= A[w + 1] then
				return z[w + 1]
			end
			w = w + 1
		end
	end
	return nil
end
function j.prototype.randomByNum(self, D)
	local E = {}
	local F = {}
	self:update()
	local w = 0
	for G in pairs(self.tList) do
		local H = self.tList[G]
		while H > 0 do
			local I = E
			local J = w
			w = J + 1
			I[J + 1] = G
			H = H - 1
		end
	end
	F = f(E, 0, D)
	do
		local K = D
		while K < w do
			local L = math.floor(math.random() * (K + 1))
			if L < D then
				F[L + 1] = E[K + 1]
			end
			K = K + 1
		end
	end
	return F
end
function j.prototype.copy(self)
	return g(i.CWeightPool, shallowcopy(self.tList))
end
function j.prototype.count(self, M)
	if M == nil then
		M = false
	end
	local N = 0
	for K in pairs(self.tList) do
		local O = self.tList[K]
		if O > 0 or M then
			N = N + 1
		end
	end
	return N
end
return i