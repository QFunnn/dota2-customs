--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "class/priority_queue"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayIsArray
local e = b.__TS__Iterator
local f = b.__TS__Symbol
local g = b.Symbol
local h = b.__TS__ArraySlice
local i = {}
i.PriorityQueue = c()
local j = i.PriorityQueue
j.name = "PriorityQueue"
function j.prototype.____constructor(self, k, l)
	self._version = 0
	self._size = 0
	self._elements = {}
	self._priorities = {}
	if d(k) then
		do
			local m = 0
			while m < #k do
				local n = k[m + 1]
				self._elements[m + 1] = n[0]
				self._priorities[m + 1] = n[1]
				m = m + 1
			end
		end
		self._size = #k
		self._comparer = l
	else
		self._size = 0
		self._comparer = k
	end
	if self._size > 1 then
		self:Heapify()
	end
end
function j.prototype.Enqueue(self, o, p)
	local q = self._size
	self._version = self._version + 1
	self._size = q + 1
	if self._comparer == nil then
		self:MoveUpDefaultComparer(o, p, q)
	else
		self:MoveUpCustomComparer(o, p, q)
	end
end
function j.prototype.Peek(self)
	if self._size == 0 then
		return nil
	end
	return self._elements[1]
end
function j.prototype.PeekPriority(self)
	if self._size == 0 then
		return nil
	end
	return self._priorities[1]
end
function j.prototype.PeekNode(self)
	if self._size == 0 then
		return nil, nil
	end
	return self._elements[1], self._priorities[1]
end
function j.prototype.Dequeue(self)
	if self._size <= 0 then
		return nil
	end
	local o = self._elements[1]
	self:RemoveRootNode()
	return o
end
function j.prototype.DequeueEnqueue(self, o, p)
	if self._size == 0 then
		return
	end
	local r = self._elements[1]
	local s = self._priorities[1]
	if self._comparer == nil then
		if i.PriorityQueue:Compare(p, s) > 0 then
			self:MoveDownDefaultComparer(o, p, 0)
		else
			self._elements[1] = o
			self._priorities[1] = p
		end
	else
		if self:_comparer(p, s) > 0 then
			self:MoveDownCustomComparer(o, p, 0)
		else
			self._elements[1] = o
			self._priorities[1] = p
		end
	end
	self._version = self._version + 1
	return r
end
function j.prototype.EnqueueDequeue(self, o, p)
	if self._size ~= 0 then
		local r = self._elements[1]
		local s = self._priorities[1]
		if self._comparer == nil then
			if i.PriorityQueue:Compare(p, s) > 0 then
				self:MoveDownDefaultComparer(o, p, 0)
				self._version = self._version + 1
				return r
			end
		else
			if self:_comparer(p, s) > 0 then
				self:MoveDownCustomComparer(o, p, 0)
				self._version = self._version + 1
				return r
			end
		end
	end
	return o
end
function j.prototype.Remove(self, o, t)
	local m = self:FindIndex(o, t)
	if m < 0 then
		return false
	end
	local u = self._elements
	local v = self._priorities
	local w, x = self, "_size"
	local y = w[x] - 1
	w[x] = y
	local z = y
	if m < z then
		if self._comparer == nil then
			self:MoveUpDefaultComparer(u[z + 1], v[z + 1], m)
		else
			self:MoveUpCustomComparer(u[z + 1], v[z + 1], m)
		end
	end
	u[z + 1] = i.PriorityQueue.DefaultElement
	v[z + 1] = i.PriorityQueue.DefaultPriority
	self._version = self._version + 1
	return true
end
function j.prototype.Clear(self)
	self._elements = {}
	self._priorities = {}
	self._size = 0
	self._version = self._version + 1
end
function j.prototype.RemoveRootNode(self)
	local A, B = self, "_size"
	local C = A[B] - 1
	A[B] = C
	local D = C
	self._version = self._version + 1
	if D > 0 then
		local E = self._elements[D + 1]
		local F = self._priorities[D + 1]
		if self._comparer == nil then
			self:MoveDownDefaultComparer(E, F, 0)
		else
			self:MoveDownCustomComparer(E, F, 0)
		end
	end
	self._elements[D + 1] = i.PriorityQueue.DefaultElement
	self._priorities[D + 1] = i.PriorityQueue.DefaultPriority
end
function j.prototype.Each(self, G)
	for H, I in e(self) do
		local o = I[1]
		local p = I[2]
		if G(nil, o, p) == true then
			return
		end
	end
end
j.prototype[g.iterator] = function(self)
	local J
	local u = self._elements
	local v = self._priorities
	local K = self._version
	local m = 0
	local L = i.PriorityQueue.DefaultElement
	local M = i.PriorityQueue.DefaultPriority
	local function N()
		if K == self._version and m < self._size then
			L = u[m + 1]
			M = v[m + 1]
			m = m + 1
			return true
		end
		return J(nil)
	end
	J = function()
		if K ~= self._version then
			error("PriorityQueue was modified when enumerating.", 0)
		end
		m = self._size + 1
		L = i.PriorityQueue.DefaultElement
		M = i.PriorityQueue.DefaultPriority
		return false
	end
	return {
		next = function()
			if N(nil) and L ~= i.PriorityQueue.DefaultElement then
				return { value = { L, M }, done = false }
			else
				return { value = nil, done = true }
			end
		end,
	}
end
function j.prototype.ToElementArray(self)
	return self._elements
end
function j.GetParentIndex(self, m)
	return bit.arshift(m - 1, i.PriorityQueue.Log2Arity)
end
function j.GetFirstChildIndex(self, m)
	return bit.lshift(m, i.PriorityQueue.Log2Arity) + 1
end
function j.Compare(self, k, O)
	if k < O then
		return -1
	elseif k > O then
		return 1
	else
		return 0
	end
end
function j.Equals(self, k, O)
	return k == O
end
function j.prototype.Heapify(self)
	local u = self._elements
	local v = self._priorities
	local P = i.PriorityQueue:GetParentIndex(self._size - 1)
	if self._comparer == nil then
		do
			local m = P
			while m >= 0 do
				self:MoveDownDefaultComparer(u[m + 1], v[m + 1], m)
				m = m - 1
			end
		end
	else
		do
			local m = P
			while m >= 0 do
				self:MoveDownCustomComparer(u[m + 1], v[m + 1], m)
				m = m - 1
			end
		end
	end
end
function j.prototype.FindIndex(self, o, t)
	local u = h(self._elements)
	if t == nil then
		do
			local Q = 0
			while Q < #u do
				if i.PriorityQueue:Equals(o, u[Q + 1]) then
					return Q
				end
				Q = Q + 1
			end
		end
	else
		do
			local Q = 0
			while Q < #u do
				if t(nil, o, u[Q + 1]) then
					return Q
				end
				Q = Q + 1
			end
		end
	end
	return -1
end
function j.prototype.MoveUpDefaultComparer(self, o, p, R)
	if self._comparer ~= nil then
		return
	end
	if not (0 <= R and R < self._size) then
		return
	end
	local u = self._elements
	local v = self._priorities
	while R > 0 do
		local S = i.PriorityQueue:GetParentIndex(R)
		local T = u[S + 1]
		local U = v[S + 1]
		if i.PriorityQueue:Compare(p, U) < 0 then
			u[R + 1] = T
			v[R + 1] = U
			R = S
		else
			break
		end
	end
	u[R + 1] = o
	v[R + 1] = p
end
function j.prototype.MoveUpCustomComparer(self, o, p, R)
	if self._comparer == nil then
		return
	end
	if not (0 <= R and R < self._size) then
		return
	end
	local u = self._elements
	local v = self._priorities
	while R > 0 do
		local S = i.PriorityQueue:GetParentIndex(R)
		local T = u[S + 1]
		local U = v[S + 1]
		if self:_comparer(p, U) < 0 then
			u[R + 1] = T
			v[R + 1] = U
			R = S
		else
			break
		end
	end
	u[R + 1] = o
	v[R + 1] = p
end
function j.prototype.MoveDownDefaultComparer(self, o, p, R)
	if self._comparer ~= nil then
		return
	end
	if not (0 <= R and R < self._size) then
		return
	end
	local u = self._elements
	local v = self._priorities
	local V = self._size
	local Q
	while true do
		Q = i.PriorityQueue:GetFirstChildIndex(R)
		if not (Q < V) then
			break
		end
		local W = u[Q + 1]
		local X = v[Q + 1]
		local Y = Q
		local Z = math.min(Q + i.PriorityQueue.Arity, V)
		while true do
			Q = Q + 1
			if not (Q < Z) then
				break
			end
			local _ = u[Q + 1]
			local a0 = v[Q + 1]
			if i.PriorityQueue:Compare(a0, X) < 0 then
				W = _
				X = a0
				Y = Q
			end
		end
		if i.PriorityQueue:Compare(p, X) <= 0 then
			break
		end
		u[R + 1] = W
		v[R + 1] = X
		R = Y
	end
	u[R + 1] = o
	v[R + 1] = p
end
function j.prototype.MoveDownCustomComparer(self, o, p, R)
	if self._comparer == nil then
		return
	end
	if not (0 <= R and R < self._size) then
		return
	end
	local l = self._comparer
	local u = self._elements
	local v = self._priorities
	local V = self._size
	local Q
	while true do
		Q = i.PriorityQueue:GetFirstChildIndex(R)
		if not (Q < V) then
			break
		end
		local W = u[Q + 1]
		local X = v[Q + 1]
		local Y = Q
		local Z = math.min(Q + i.PriorityQueue.Arity, V)
		while true do
			Q = Q + 1
			if not (Q < Z) then
				break
			end
			local _ = u[Q + 1]
			local a0 = v[Q + 1]
			if l(nil, a0, X) < 0 then
				W = _
				X = a0
				Y = Q
			end
		end
		if l(nil, p, X) <= 0 then
			break
		end
		u[R + 1] = W
		v[R + 1] = X
		R = Y
	end
	u[R + 1] = o
	v[R + 1] = p
end
j.Log2Arity = 2
j.Arity = 4
j.DefaultElement = f("PriorityQueue.DefaultElement")
j.DefaultPriority = f("PriorityQueue.DefaultPriority")
return i