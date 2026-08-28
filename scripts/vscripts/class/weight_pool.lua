--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "class/weight_pool"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__Delete
local e = b.__TS__ArrayIndexOf
local f = b.__TS__New
local g = b.__TS__SetDescriptor
local h = {}
local i = require("class.priority_queue")
local j = i.PriorityQueue
local k = math.pow
local l = math.log
local m = math.floor
local n = math.random
h.CWeightPool = c()
local o = h.CWeightPool
o.name = "CWeightPool"
function o.prototype.____constructor(self, p)
	self._weightData = {}
	self._totalWeight = 0
	self._count = 0
	self._validCount = 0
	if p ~= nil then
		for q, r in pairs(p) do
			self._weightData[q] = r
			self._totalWeight = self._totalWeight + r
			self._count = self._count + 1
			if r > 0 then
				self._validCount = self._validCount + 1
			end
		end
	end
end
function o.prototype.Each(self, s, t)
	if t == nil then
		t = false
	end
	for q, r in pairs(self._weightData) do
		do
			if t == true and r <= 0 then
				goto u
			end
			if s(nil, q, r) == true then
				return
			end
		end
		::u::
	end
end
function o.prototype.Has(self, q)
	return self._weightData[q] ~= nil
end
function o.prototype.Get(self, q)
	return self._weightData[q] or 0
end
function o.prototype.Set(self, q, r)
	if not self:Has(q) then
		self._count = self._count + 1
	end
	local v = self:Get(q)
	self._weightData[q] = r
	self._totalWeight = self._totalWeight + r - v
	if v > 0 and r <= 0 then
		self._validCount = self._validCount - 1
	elseif v <= 0 and r > 0 then
		self._validCount = self._validCount + 1
	end
end
function o.prototype.Add(self, q, w)
	self:Set(q, self:Get(q) + w)
end
function o.prototype.Remove(self, q)
	local v = self:Get(q)
	d(self._weightData, q)
	self._totalWeight = self._totalWeight - v
	self._count = self._count - 1
	if v > 0 then
		self._validCount = self._validCount - 1
	end
end
function o.prototype.Random(self, x, y)
	if self._validCount <= 0 then
		return nil
	end
	local z = self._totalWeight
	if y ~= nil then
		z = 0
		for q, r in pairs(self._weightData) do
			do
				if r <= 0 then
					goto A
				end
				if y[q] ~= nil then
					z = z + r * (1 + y[q] * 0.01)
				else
					z = z + r
				end
			end
			::A::
		end
	end
	local B = n(1, z)
	local C = 0
	for q, r in pairs(self._weightData) do
		do
			if r <= 0 then
				goto D
			end
			local E = r
			if y ~= nil and y[q] ~= nil then
				E = r * (1 + y[q] * 0.01)
			end
			C = C + E
			if x ~= nil and e(x, q) ~= -1 then
				goto D
			end
			if B <= C then
				return q
			end
		end
		::D::
	end
end
function o.prototype.MultipleRandom(self, F, x)
	local G = {}
	if self._validCount <= 0 then
		return G
	end
	local H = {}
	do
		local I = 0
		while I < F do
			H[I + 1] = n(1, self._totalWeight)
			I = I + 1
		end
	end
	F = #H
	local C = 0
	for q, r in pairs(self._weightData) do
		do
			if r <= 0 or x ~= nil and e(x, q) ~= -1 then
				goto J
			end
			C = C + r
			do
				local I = #H
				while I >= 1 do
					do
						if H[I] > C then
							goto K
						end
						G[F - #H + 1] = q
						table.remove(H, I)
						if #H <= 0 then
							return G
						end
					end
					::K::
					I = I - 1
				end
			end
		end
		::J::
	end
	return G
end
function o.prototype.MultipleRandomWithoutReplacement(self, F, x)
	if self._validCount <= 0 then
		return {}
	elseif F > self._validCount then
		F = self._validCount
	end
	F = m(F)
	local L = f(j)
	local M = 0 / 0
	local N = 0
	local O = 0
	local I = 0
	for q, r in pairs(self._weightData) do
		do
			if r <= 0 or x ~= nil and e(x, q) ~= -1 then
				goto P
			end
			if I < F then
				local Q = n()
				local R = k(Q, 1 / r)
				L:Enqueue(q, R)
				I = I + 1
				goto P
			end
			if O == 0 then
				N = L:PeekPriority() or 0
				local S = n()
				M = l(S) / l(N)
			end
			local T = r
			if O + T < M then
				O = O + T
				I = I + 1
				goto P
			end
			O = 0
			local U = k(N, T)
			local V = U + (1 - U) * n()
			local W = k(V, 1 / T)
			L:DequeueEnqueue(q, W)
			I = I + 1
		end
		::P::
	end
	return L:ToElementArray()
end
function o.prototype.Copy(self)
	return f(h.CWeightPool, self._weightData)
end
g(o.prototype, "Count", {
	get = function(self)
		return self._validCount
	end,
}, true)
g(o.prototype, "ValidCount", {
	get = function(self)
		return self._validCount
	end,
}, true)
g(o.prototype, "TotalWeight", {
	get = function(self)
		return self._totalWeight
	end,
}, true)
return h