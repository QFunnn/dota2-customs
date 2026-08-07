--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "class/object_pool"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.Error
local e = b.RangeError
local f = b.ReferenceError
local g = b.SyntaxError
local h = b.TypeError
local i = b.URIError
local j = b.__TS__New
local k = b.__TS__SetDescriptor
local l = {}
l.ObjectPool = c()
local m = l.ObjectPool
m.name = "ObjectPool"
function m.prototype.____constructor(self, n, o, p, q, r, s)
	if r == nil then
		r = true
	end
	if s == nil then
		s = 10000
	end
	self._list = {}
	self.CountAll = 0
	if n == nil then
		error(j(d, "createFunc is undefined"), 0)
	end
	if s <= 0 then
		error(j(d, "Max Size must be greater than 0"), 0)
	end
	self._list = {}
	self._createFunc = n
	self._maxSize = s
	if o ~= nil then
		self._actionOnGet = o
	end
	if p ~= nil then
		self._actionOnRelease = p
	end
	if q ~= nil then
		self._actionOnDestroy = q
	end
	self._collectionCheck = r
end
function m.prototype.Get(self)
	local t
	if #self._list == 0 then
		t = self:_createFunc()
		self.CountAll = self.CountAll + 1
	else
		t = table.remove(self._list)
	end
	local o = self._actionOnGet
	if o ~= nil then
		o(nil, t)
	end
	return t
end
function m.prototype.Release(self, u)
	if self._collectionCheck and #self._list > 0 then
		do
			local v = 0
			while v < #self._list do
				if u == self._list[v + 1] then
					print("Trying to release an object that has already been released to the pool.")
					return
				end
				v = v + 1
			end
		end
	end
	local p = self._actionOnRelease
	if p ~= nil then
		p(nil, u)
	end
	if self.CountInactive < self._maxSize then
		local w = self._list
		w[#w + 1] = u
	else
		local q = self._actionOnDestroy
		if q ~= nil then
			q(nil, u)
		end
	end
end
function m.prototype.Clear(self)
	local q = self._actionOnDestroy
	if q ~= nil then
		do
			local v = 0
			while v < #self._list do
				q(nil, self._list[v + 1])
				v = v + 1
			end
		end
	end
	self._list = {}
	self.CountAll = 0
end
k(m.prototype, "CountActive", {
	get = function(self)
		return self.CountAll - #self._list
	end,
}, true)
k(m.prototype, "CountInactive", {
	get = function(self)
		return #self._list
	end,
}, true)
return l