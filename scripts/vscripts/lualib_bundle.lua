--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = _G.debug or {}
_G.debug = a
if a.traceback == nil then
	a.traceback = function(...)
		return ""
	end
end
if a.getinfo == nil then
	a.getinfo = function(...)
		return { source = "", what = "", short_src = "" }
	end
end
local function b(self, c)
	local d = c < 0 and #self + c or c
	if d >= 0 and d < #self then
		return self[d + 1]
	end
	return nil
end
local function e(f)
	return type(f) == "table" and (f[1] ~= nil or next(f) == nil)
end
local function g(self, ...)
	local h = { ... }
	local i = {}
	local j = 0
	for k = 1, #self do
		j = j + 1
		i[j] = self[k]
	end
	for k = 1, #h do
		local l = h[k]
		if e(l) then
			for m = 1, #l do
				j = j + 1
				i[j] = l[m]
			end
		else
			j = j + 1
			i[j] = l
		end
	end
	return i
end
local n, o
do
	local p = {
		__tostring = function(self)
			return ("Symbol(" .. (self.description or "")) .. ")"
		end,
	}
	function n(q)
		return setmetatable({ description = q }, p)
	end
	o = {
		asyncDispose = n("Symbol.asyncDispose"),
		dispose = n("Symbol.dispose"),
		iterator = n("Symbol.iterator"),
		hasInstance = n("Symbol.hasInstance"),
		species = n("Symbol.species"),
		toStringTag = n("Symbol.toStringTag"),
	}
end
local function r(s)
	local t = 0
	return {
		[o.iterator] = function(self)
			return self
		end,
		next = function(self)
			local i = { done = s[t + 1] == nil, value = { t, s[t + 1] } }
			t = t + 1
			return i
		end,
	}
end
local function u(self, v, w)
	for k = 1, #self do
		if not v(w, self[k], k - 1, self) then
			return false
		end
	end
	return true
end
local function x(self, f, y, z)
	local A = y or 0
	local B = z or #self
	if A < 0 then
		A = A + #self
	end
	if B < 0 then
		B = B + #self
	end
	do
		local k = A
		while k < B do
			self[k + 1] = f
			k = k + 1
		end
	end
	return self
end
local function C(self, v, w)
	local i = {}
	local j = 0
	for k = 1, #self do
		if v(w, self[k], k - 1, self) then
			j = j + 1
			i[j] = self[k]
		end
	end
	return i
end
local function D(self, E, w)
	for k = 1, #self do
		E(w, self[k], k - 1, self)
	end
end
local function F(self, G, w)
	for k = 1, #self do
		local H = self[k]
		if G(w, H, k - 1, self) then
			return H
		end
	end
	return nil
end
local function I(self, E, w)
	for k = 1, #self do
		if E(w, self[k], k - 1, self) then
			return k - 1
		end
	end
	return -1
end
local J
do
	local function K(self)
		local L = self.____coroutine
		local M, f = coroutine.resume(L)
		if not M then
			error(f, 0)
		end
		if coroutine.status(L) == "dead" then
			return
		end
		return true, f
	end
	local function N(self)
		local i = self:next()
		if i.done then
			return
		end
		return true, i.value
	end
	local function O(self, P)
		P = P + 1
		if P > #self then
			return
		end
		return P, string.sub(self, P, P)
	end
	function J(Q)
		if type(Q) == "string" then
			return O, Q, 0
		elseif Q.____coroutine ~= nil then
			return K, Q
		elseif Q[o.iterator] then
			local R = Q[o.iterator](Q)
			return N, R
		else
			return ipairs(Q)
		end
	end
end
local S
do
	local function T(self, P)
		P = P + 1
		if P > self.length then
			return
		end
		return P, self[P]
	end
	local function U(V)
		if type(V.length) == "number" then
			return T, V, 0
		end
		return J(V)
	end
	function S(W, X, w)
		local i = {}
		if X == nil then
			for Y, Z in U(W) do
				i[#i + 1] = Z
			end
		else
			local k = 0
			for Y, Z in U(W) do
				local _ = X
				local a0 = w
				local a1 = Z
				local a2 = k
				k = a2 + 1
				i[#i + 1] = _(a0, a1, a2)
			end
		end
		return i
	end
end
local function a3(self, a4, a5)
	if a5 == nil then
		a5 = 0
	end
	local j = #self
	local a6 = a5
	if a5 < 0 then
		a6 = j + a5
	end
	if a6 < 0 then
		a6 = 0
	end
	for k = a6 + 1, j do
		if self[k] == a4 then
			return true
		end
	end
	return false
end
local function a7(self, a4, a5)
	if a5 == nil then
		a5 = 0
	end
	local j = #self
	if j == 0 then
		return -1
	end
	if a5 >= j then
		return -1
	end
	if a5 < 0 then
		a5 = j + a5
		if a5 < 0 then
			a5 = 0
		end
	end
	for k = a5 + 1, j do
		if self[k] == a4 then
			return k - 1
		end
	end
	return -1
end
local function a8(self, a9)
	if a9 == nil then
		a9 = ","
	end
	local aa = {}
	for k = 1, #self do
		aa[k] = tostring(self[k])
	end
	return table.concat(aa, a9)
end
local function ab(self, v, w)
	local i = {}
	for k = 1, #self do
		i[k] = v(w, self[k], k - 1, self)
	end
	return i
end
local function ac(self, ...)
	local h = { ... }
	local j = #self
	for k = 1, #h do
		j = j + 1
		self[j] = h[k]
	end
	return j
end
local function ad(self, h)
	local j = #self
	for k = 1, #h do
		j = j + 1
		self[j] = h[k]
	end
	return j
end
local function ae(...)
	return select("#", ...)
end
local function af(self, E, ...)
	local j = #self
	local a6 = 0
	local ag = nil
	if ae(...) ~= 0 then
		ag = ...
	elseif j > 0 then
		ag = self[1]
		a6 = 1
	else
		error("Reduce of empty array with no initial value", 0)
	end
	for k = a6 + 1, j do
		ag = E(nil, ag, self[k], k - 1, self)
	end
	return ag
end
local function ah(self, E, ...)
	local j = #self
	local a6 = j - 1
	local ag = nil
	if ae(...) ~= 0 then
		ag = ...
	elseif j > 0 then
		ag = self[a6 + 1]
		a6 = a6 - 1
	else
		error("Reduce of empty array with no initial value", 0)
	end
	for k = a6 + 1, 1, -1 do
		ag = E(nil, ag, self[k], k - 1, self)
	end
	return ag
end
local function ai(self)
	local k = 1
	local m = #self
	while k < m do
		local aj = self[m]
		self[m] = self[k]
		self[k] = aj
		k = k + 1
		m = m - 1
	end
	return self
end
local function ak(self, ...)
	local h = { ... }
	local al = #h
	if al == 0 then
		return #self
	end
	for k = #self, 1, -1 do
		self[k + al] = self[k]
	end
	for k = 1, al do
		self[k] = h[k]
	end
	return #self
end
local function am(self, an)
	if an ~= nil then
		table.sort(self, function(ao, ap)
			return an(nil, ao, ap) < 0
		end)
	else
		table.sort(self)
	end
	return self
end
local function aq(self, ar, as)
	local j = #self
	ar = ar or 0
	if ar < 0 then
		ar = j + ar
		if ar < 0 then
			ar = 0
		end
	else
		if ar > j then
			ar = j
		end
	end
	as = as or j
	if as < 0 then
		as = j + as
		if as < 0 then
			as = 0
		end
	else
		if as > j then
			as = j
		end
	end
	local at = {}
	ar = ar + 1
	as = as + 1
	local au = 1
	while ar < as do
		at[au] = self[ar]
		ar = ar + 1
		au = au + 1
	end
	return at
end
local function av(self, v, w)
	for k = 1, #self do
		if v(w, self[k], k - 1, self) then
			return true
		end
	end
	return false
end
local function aw(self, ...)
	local ax = { ... }
	local j = #self
	local ay = ae(...)
	local y = ax[1]
	local az = ax[2]
	if y < 0 then
		y = j + y
		if y < 0 then
			y = 0
		end
	elseif y > j then
		y = j
	end
	local aA = ay - 2
	if aA < 0 then
		aA = 0
	end
	local aB
	if ay == 0 then
		aB = 0
	elseif ay == 1 then
		aB = j - y
	else
		aB = az or 0
		if aB < 0 then
			aB = 0
		end
		if aB > j - y then
			aB = j - y
		end
	end
	local at = {}
	for a6 = 1, aB do
		local aC = y + a6
		if self[aC] ~= nil then
			at[a6] = self[aC]
		end
	end
	if aA < aB then
		for a6 = y + 1, j - aB do
			local aC = a6 + aB
			local aD = a6 + aA
			if self[aC] then
				self[aD] = self[aC]
			else
				self[aD] = nil
			end
		end
		for a6 = j - aB + aA + 1, j do
			self[a6] = nil
		end
	elseif aA > aB then
		for a6 = j - aB, y + 1, -1 do
			local aC = a6 + aB
			local aD = a6 + aA
			if self[aC] then
				self[aD] = self[aC]
			else
				self[aD] = nil
			end
		end
	end
	local m = y + 1
	for k = 3, ay do
		self[m] = ax[k]
		m = m + 1
	end
	for a6 = #self, j - aB + aA + 1, -1 do
		self[a6] = nil
	end
	return at
end
local function aE(self)
	local aF = {}
	for k = 1, #self do
		aF[k - 1] = self[k]
	end
	return aF
end
local function aG(self, aH)
	if aH == nil then
		aH = 1
	end
	local i = {}
	local j = 0
	for k = 1, #self do
		local f = self[k]
		if aH > 0 and e(f) then
			local aI
			if aH == 1 then
				aI = f
			else
				aI = aG(f, aH - 1)
			end
			for m = 1, #aI do
				local aJ = aI[m]
				j = j + 1
				i[j] = aJ
			end
		else
			j = j + 1
			i[j] = f
		end
	end
	return i
end
local function aK(self, aL, w)
	local i = {}
	local j = 0
	for k = 1, #self do
		local f = aL(w, self[k], k - 1, self)
		if e(f) then
			for m = 1, #f do
				j = j + 1
				i[j] = f[m]
			end
		else
			j = j + 1
			i[j] = f
		end
	end
	return i
end
local function aM(self, aN)
	if aN < 0 or aN ~= aN or aN == math.huge or math.floor(aN) ~= aN then
		error("invalid array length: " .. tostring(aN), 0)
	end
	for k = aN + 1, #self do
		self[k] = nil
	end
	return aN
end
local aO = table.unpack or unpack
local function aP(self)
	local aQ = { aO(self) }
	ai(aQ)
	return aQ
end
local function aR(self, an)
	local aQ = { aO(self) }
	am(aQ, an)
	return aQ
end
local function aS(self, y, az, ...)
	local aQ = { aO(self) }
	aw(aQ, y, az, ...)
	return aQ
end
local function aT(self, P, f)
	local aQ = { aO(self) }
	aQ[P + 1] = f
	return aQ
end
local function aU(aV, ...)
	local aW = setmetatable({}, aV.prototype)
	aW:____constructor(...)
	return aW
end
local function aX(aY, aZ)
	if type(aZ) ~= "table" then
		error("Right-hand side of 'instanceof' is not an object", 0)
	end
	if aZ[o.hasInstance] ~= nil then
		return not not aZ[o.hasInstance](aZ, aY)
	end
	if type(aY) == "table" then
		local a_ = aY.constructor
		while a_ ~= nil do
			if a_ == aZ then
				return true
			end
			a_ = a_.____super
		end
	end
	return false
end
local function b0(self)
	local b1 = { prototype = {} }
	b1.prototype.__index = b1.prototype
	b1.prototype.constructor = b1
	return b1
end
local b2
do
	local function b3()
		local b4
		local b5
		local function b6(Y, b7, b8)
			b4 = b7
			b5 = b8
		end
		return function()
			local b9 = aU(b2, b6)
			return b9, b4, b5
		end
	end
	local ba = b3()
	local function bb(f)
		return aX(f, b2)
	end
	local function bc(self) end
	local bd = _G.pcall
	b2 = b0()
	b2.name = "__TS__Promise"
	function b2.prototype.____constructor(self, b6)
		self.state = 0
		self.fulfilledCallbacks = {}
		self.rejectedCallbacks = {}
		self.finallyCallbacks = {}
		local be, bf = bd(b6, nil, function(Y, Z)
			return self:resolve(Z)
		end, function(Y, bg)
			return self:reject(bg)
		end)
		if not be then
			self:reject(bf)
		end
	end
	function b2.resolve(f)
		if aX(f, b2) then
			return f
		end
		local b9 = aU(b2, bc)
		b9.state = 1
		b9.value = f
		return b9
	end
	function b2.reject(bh)
		local b9 = aU(b2, bc)
		b9.state = 2
		b9.rejectionReason = bh
		return b9
	end
	b2.prototype["then"] = function(self, bi, bj)
		local b9, b4, b5 = ba()
		self:addCallbacks(
			bi and self:createPromiseResolvingCallback(bi, b4, b5) or b4,
			bj and self:createPromiseResolvingCallback(bj, b4, b5) or b5
		)
		return b9
	end
	function b2.prototype.addCallbacks(self, bk, bl)
		if self.state == 1 then
			return bk(nil, self.value)
		end
		if self.state == 2 then
			return bl(nil, self.rejectionReason)
		end
		local bm = self.fulfilledCallbacks
		bm[#bm + 1] = bk
		local bn = self.rejectedCallbacks
		bn[#bn + 1] = bl
	end
	function b2.prototype.catch(self, bj)
		return self["then"](self, nil, bj)
	end
	function b2.prototype.finally(self, bo)
		if bo then
			local bp = self.finallyCallbacks
			bp[#bp + 1] = bo
			if self.state ~= 0 then
				bo(nil)
			end
		end
		return self
	end
	function b2.prototype.resolve(self, f)
		if bb(f) then
			return f:addCallbacks(function(Y, Z)
				return self:resolve(Z)
			end, function(Y, bg)
				return self:reject(bg)
			end)
		end
		if self.state == 0 then
			self.state = 1
			self.value = f
			return self:invokeCallbacks(self.fulfilledCallbacks, f)
		end
	end
	function b2.prototype.reject(self, bh)
		if self.state == 0 then
			self.state = 2
			self.rejectionReason = bh
			return self:invokeCallbacks(self.rejectedCallbacks, bh)
		end
	end
	function b2.prototype.invokeCallbacks(self, bq, f)
		local br = #bq
		local bs = self.finallyCallbacks
		local bt = #bs
		if br ~= 0 then
			for k = 1, br - 1 do
				bq[k](bq, f)
			end
			if bt == 0 then
				return bq[br](bq, f)
			end
			bq[br](bq, f)
		end
		if bt ~= 0 then
			for k = 1, bt - 1 do
				bs[k](bs)
			end
			return bs[bt](bs)
		end
	end
	function b2.prototype.createPromiseResolvingCallback(self, bu, b4, b5)
		return function(Y, f)
			local be, bv = bd(bu, nil, f)
			if not be then
				return b5(nil, bv)
			end
			return self:handleCallbackValue(bv, b4, b5)
		end
	end
	function b2.prototype.handleCallbackValue(self, f, b4, b5)
		if bb(f) then
			local bw = f
			if bw.state == 1 then
				return b4(nil, bw.value)
			elseif bw.state == 2 then
				return b5(nil, bw.rejectionReason)
			else
				return bw:addCallbacks(b4, b5)
			end
		else
			return b4(nil, f)
		end
	end
end
local bx, by
do
	local bz = _G.coroutine or {}
	local bA = bz.create
	local bB = bz.resume
	local bC = bz.status
	local bD = bz.yield
	function bx(bE)
		return aU(b2, function(Y, b4, b5)
			local bF, bG, bH, bI
			function bF(self, f)
				local be, bv = bB(bI, f)
				if be then
					return bG(bv)
				end
				return b5(nil, bv)
			end
			function bG(i)
				if bH then
					return
				end
				if bC(bI) == "dead" then
					return b4(nil, i)
				end
				return b2.resolve(i):addCallbacks(bF, b5)
			end
			bH = false
			bI = bA(bE)
			local be, bv = bB(bI, function(Y, Z)
				bH = true
				return b2.resolve(Z):addCallbacks(b4, b5)
			end)
			if be then
				return bG(bv)
			else
				return b5(nil, bv)
			end
		end)
	end
	function by(bJ)
		return bD(bJ)
	end
end
local function bK(aV, bL)
	aV.____super = bL
	local bM = setmetatable({ __index = bL }, bL)
	setmetatable(aV, bM)
	local bN = getmetatable(bL)
	if bN then
		if type(bN.__index) == "function" then
			bM.__index = bN.__index
		end
		if type(bN.__newindex) == "function" then
			bM.__newindex = bN.__newindex
		end
	end
	setmetatable(aV.prototype, bL.prototype)
	if type(bL.prototype.__index) == "function" then
		aV.prototype.__index = bL.prototype.__index
	end
	if type(bL.prototype.__newindex) == "function" then
		aV.prototype.__newindex = bL.prototype.__newindex
	end
	if type(bL.prototype.__tostring) == "function" then
		aV.prototype.__tostring = bL.prototype.__tostring
	end
end
local function bO(bP)
	local f
	local bQ
	local bR
	local bS
	local bT
	local bU
	bU = bP.enumerable
	bT = bP.configurable
	bS = bP.get
	bR = bP.set
	bQ = bP.writable
	f = bP.value
	local bV = { enumerable = bU == true, configurable = bT == true }
	local bW = bS ~= nil or bR ~= nil
	local bX = bQ ~= nil or f ~= nil
	if bW and bX then
		error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
	end
	if bS or bR then
		bV.get = bS
		bV.set = bR
	else
		bV.value = f
		bV.writable = bQ == true
	end
	return bV
end
local function bY(self, bZ, b_, c0)
	local i = bZ
	do
		local k = #b_
		while k >= 0 do
			local c1 = b_[k + 1]
			if c1 ~= nil then
				local c2 = c1(self, i, c0)
				if c2 == nil then
					c2 = i
				end
				i = c2
			end
			k = k - 1
		end
	end
	return i
end
local function c3(aV, ...)
	local c4 = { ... }
	for k = 1, #c4 do
		local c5 = c4[k]
		for t in pairs(c5) do
			aV[t] = c5[t]
		end
	end
	return aV
end
local function c6(aF, t)
	local c7 = getmetatable(aF)
	if not c7 then
		return
	end
	if not rawget(c7, "_descriptors") then
		return
	end
	return rawget(c7, "_descriptors")[t]
end
local c8
do
	local getmetatable = _G.getmetatable
	local c9 = _G.rawget
	function c8(self, c7, t)
		while c7 do
			local ca = c9(c7, t)
			if ca ~= nil then
				return ca
			end
			local cb = c9(c7, "_descriptors")
			if cb then
				local bV = cb[t]
				if bV ~= nil then
					if bV.get then
						return bV.get(self)
					end
					return bV.value
				end
			end
			c7 = getmetatable(c7)
		end
	end
end
local cc
do
	local getmetatable = _G.getmetatable
	local c9 = _G.rawget
	local rawset = _G.rawset
	function cc(self, c7, t, f)
		while c7 do
			local cb = c9(c7, "_descriptors")
			if cb then
				local bV = cb[t]
				if bV ~= nil then
					if bV.set then
						bV.set(self, f)
					else
						if bV.writable == false then
							error(
								((("Cannot assign to read only property '" .. t) .. "' of object '") .. tostring(self))
									.. "'",
								0
							)
						end
						bV.value = f
					end
					return
				end
			end
			c7 = getmetatable(c7)
		end
		rawset(self, t, f)
	end
end
local cd
do
	local getmetatable = _G.getmetatable
	local function ce(self, t)
		return c8(self, getmetatable(self), t)
	end
	local function cf(self, t, f)
		return cc(self, getmetatable(self), t, f)
	end
	function cd(aV, t, cg, ch)
		if ch == nil then
			ch = false
		end
		local ci
		if ch then
			ci = aV
		else
			ci = getmetatable(aV)
		end
		local c7 = ci
		if not c7 then
			c7 = {}
			setmetatable(aV, c7)
		end
		local f = rawget(aV, t)
		if f ~= nil then
			rawset(aV, t, nil)
		end
		if not rawget(c7, "_descriptors") then
			c7._descriptors = {}
		end
		c7._descriptors[t] = bO(cg)
		c7.__index = ce
		c7.__newindex = cf
	end
end
local function cj(b_, aV, t, cg)
	local i = aV
	do
		local k = #b_
		while k >= 0 do
			local c1 = b_[k + 1]
			if c1 ~= nil then
				local ck = i
				if t == nil then
					i = c1(nil, i)
				elseif cg == true then
					local f = rawget(aV, t)
					local bV = c6(aV, t) or { configurable = true, writable = true, value = f }
					local cg = c1(nil, aV, t, bV) or bV
					local cl = cg.configurable == true and cg.writable == true and not cg.get and not cg.set
					if cl then
						rawset(aV, t, cg.value)
					else
						cd(aV, t, c3({}, bV, cg))
					end
				elseif cg == false then
					i = c1(nil, aV, t, cg)
				else
					i = c1(nil, aV, t)
				end
				i = i or ck
			end
			k = k - 1
		end
	end
	return i
end
local function cm(cn, c1)
	return function(Y, aV, t)
		return c1(nil, aV, t, cn)
	end
end
local function co(self, cp, cq)
	if not cq then
		cq = 1
	else
		cq = cq + 1
	end
	local P = string.find(self, cp, cq, true)
	return P ~= nil
end
local cr, cs, ct, cu, cv, cw
do
	local function cx(self, cy)
		if debug == nil then
			return nil
		end
		local cz = 1
		while true do
			local cA = debug.getinfo(cz, "f")
			cz = cz + 1
			if not cA then
				cz = 1
				break
			elseif cA.func == cy then
				break
			end
		end
		if co(_VERSION, "Lua 5.0") then
			return debug.traceback(("[Level " .. tostring(cz)) .. "]")
		elseif _VERSION == "Lua 5.1" then
			return string.sub(debug.traceback("", cz), 2)
		else
			return debug.traceback(nil, cz)
		end
	end
	local function cB(self, cC)
		return function(self)
			local q = cC(self)
			local cD = debug.getinfo(3, "f")
			local cE = co(_VERSION, "Lua 5.0")
			if cE or cD and cD.func ~= error then
				return q
			else
				return (q .. "\n") .. tostring(self.stack)
			end
		end
	end
	local function cF(self, cG, cH)
		cG.name = cH
		return setmetatable(cG, {
			__call = function(Y, cI, cJ)
				return aU(cG, cJ)
			end,
		})
	end
	local cK = cF
	local cL = b0()
	cL.name = ""
	function cL.prototype.____constructor(self, cJ)
		if cJ == nil then
			cJ = ""
		end
		self.message = cJ
		self.name = "Error"
		self.stack = cx(nil, aU)
		local c7 = getmetatable(self)
		if c7 and not c7.__errorToStringPatched then
			c7.__errorToStringPatched = true
			c7.__tostring = cB(nil, c7.__tostring)
		end
	end
	function cL.prototype.__tostring(self)
		return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
	end
	cr = cK(nil, cL, "Error")
	local function cM(self, cH)
		local cN = cF
		local cO = b0()
		cO.name = cO.name
		bK(cO, cr)
		function cO.prototype.____constructor(self, ...)
			cO.____super.prototype.____constructor(self, ...)
			self.name = cH
		end
		return cN(nil, cO, cH)
	end
	cs = cM(nil, "RangeError")
	ct = cM(nil, "ReferenceError")
	cu = cM(nil, "SyntaxError")
	cv = cM(nil, "TypeError")
	cw = cM(nil, "URIError")
end
local function cP(aF)
	local c7 = getmetatable(aF)
	if not c7 then
		return {}
	end
	return rawget(c7, "_descriptors") or {}
end
local function cQ(aV, t)
	local cb = cP(aV)
	local bV = cb[t]
	if bV then
		if not bV.configurable then
			error(aU(cv, ((("Cannot delete property " .. tostring(t)) .. " of ") .. tostring(aV)) .. "."), 0)
		end
		cb[t] = nil
		return true
	end
	aV[t] = nil
	return true
end
local function cR(self, P)
	if P >= 0 and P < #self then
		return string.sub(self, P + 1, P + 1)
	end
end
local function cS(Q)
	if type(Q) == "string" then
		for P = 0, #Q - 1 do
			coroutine.yield(cR(Q, P))
		end
	elseif Q.____coroutine ~= nil then
		local L = Q.____coroutine
		while true do
			local M, f = coroutine.resume(L)
			if not M then
				error(f, 0)
			end
			if coroutine.status(L) == "dead" then
				return f
			else
				coroutine.yield(f)
			end
		end
	elseif Q[o.iterator] then
		local R = Q[o.iterator](Q)
		while true do
			local i = R:next()
			if i.done then
				return i.value
			else
				coroutine.yield(i.value)
			end
		end
	else
		for Y, f in ipairs(Q) do
			coroutine.yield(f)
		end
	end
end
local function cT(cU, ...)
	local cV = { ... }
	return function(Y, ...)
		local ax = { ... }
		ak(ax, aO(cV))
		return cU(aO(ax))
	end
end
local cW
do
	local function cX(self)
		return self
	end
	local function cY(self, ...)
		local L = self.____coroutine
		if coroutine.status(L) == "dead" then
			return { done = true }
		end
		local M, f = coroutine.resume(L, ...)
		if not M then
			error(f, 0)
		end
		return { value = f, done = coroutine.status(L) == "dead" }
	end
	function cW(cU)
		return function(...)
			local ax = { ... }
			local cZ = ae(...)
			return { ____coroutine = coroutine.create(function()
				return cU(aO(ax, 1, cZ))
			end), [o.iterator] = cX, next = cY }
		end
	end
end
local function c_(f)
	local d0 = type(f)
	return d0 == "table" or d0 == "function"
end
local function d1(self, d2, d3)
	local d4 = {}
	local t, f = self(d2, d3)
	while t do
		d4[#d4 + 1] = { t, f }
		t, f = self(d2, t)
	end
	return aO(d4)
end
local d5
do
	d5 = b0()
	d5.name = "Map"
	function d5.prototype.____constructor(self, d6)
		self[o.toStringTag] = "Map"
		self.items = {}
		self.size = 0
		self.nextKey = {}
		self.previousKey = {}
		if d6 == nil then
			return
		end
		local Q = d6
		if Q[o.iterator] then
			local R = Q[o.iterator](Q)
			while true do
				local i = R:next()
				if i.done then
					break
				end
				local f = i.value
				self:set(f[1], f[2])
			end
		else
			local s = d6
			for Y, d7 in ipairs(s) do
				self:set(d7[1], d7[2])
			end
		end
	end
	function d5.prototype.clear(self)
		self.items = {}
		self.nextKey = {}
		self.previousKey = {}
		self.firstKey = nil
		self.lastKey = nil
		self.size = 0
	end
	function d5.prototype.delete(self, t)
		local d8 = self:has(t)
		if d8 then
			self.size = self.size - 1
			local next = self.nextKey[t]
			local d9 = self.previousKey[t]
			if next ~= nil and d9 ~= nil then
				self.nextKey[d9] = next
				self.previousKey[next] = d9
			elseif next ~= nil then
				self.firstKey = next
				self.previousKey[next] = nil
			elseif d9 ~= nil then
				self.lastKey = d9
				self.nextKey[d9] = nil
			else
				self.firstKey = nil
				self.lastKey = nil
			end
			self.nextKey[t] = nil
			self.previousKey[t] = nil
		end
		self.items[t] = nil
		return d8
	end
	function d5.prototype.forEach(self, aL)
		for Y, t in J(self:keys()) do
			aL(nil, self.items[t], t, self)
		end
	end
	function d5.prototype.get(self, t)
		return self.items[t]
	end
	function d5.prototype.has(self, t)
		return self.nextKey[t] ~= nil or self.lastKey == t
	end
	function d5.prototype.set(self, t, f)
		local da = not self:has(t)
		if da then
			self.size = self.size + 1
		end
		self.items[t] = f
		if self.firstKey == nil then
			self.firstKey = t
			self.lastKey = t
		elseif da then
			self.nextKey[self.lastKey] = t
			self.previousKey[t] = self.lastKey
			self.lastKey = t
		end
		return self
	end
	d5.prototype[o.iterator] = function(self)
		return self:entries()
	end
	function d5.prototype.entries(self)
		local h = self.items
		local db = self.nextKey
		local t = self.firstKey
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				local i = { done = not t, value = { t, h[t] } }
				t = db[t]
				return i
			end,
		}
	end
	function d5.prototype.keys(self)
		local db = self.nextKey
		local t = self.firstKey
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				local i = { done = not t, value = t }
				t = db[t]
				return i
			end,
		}
	end
	function d5.prototype.values(self)
		local h = self.items
		local db = self.nextKey
		local t = self.firstKey
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				local i = { done = not t, value = h[t] }
				t = db[t]
				return i
			end,
		}
	end
	d5[o.species] = d5
end
local function dc(h, dd)
	local i = aU(d5)
	local k = 0
	for Y, l in J(h) do
		local t = dd(nil, l, k)
		if i:has(t) then
			local de = i:get(t)
			de[#de + 1] = l
		else
			i:set(t, { l })
		end
		k = k + 1
	end
	return i
end
local df = string.match
local dg = math.atan2 or math.atan
local dh = math.modf
local function di(f)
	return f ~= f
end
local function dj(aJ)
	if di(aJ) or aJ == 0 then
		return aJ
	end
	if aJ < 0 then
		return -1
	end
	return 1
end
local function dk(f)
	return type(f) == "number" and f == f and f ~= math.huge and f ~= -math.huge
end
local function dl(aJ)
	if not dk(aJ) or aJ == 0 then
		return aJ
	end
	return aJ > 0 and math.floor(aJ) or math.ceil(aJ)
end
local function dm(f)
	local d0 = type(f)
	if d0 == "number" then
		return f
	elseif d0 == "string" then
		local dn = tonumber(f)
		if dn then
			return dn
		end
		if f == "Infinity" then
			return math.huge
		end
		if f == "-Infinity" then
			return -math.huge
		end
		local dp = string.gsub(f, "%s", "")
		if dp == "" then
			return 0
		end
		return 0 / 0
	elseif d0 == "boolean" then
		return f and 1 or 0
	else
		return 0 / 0
	end
end
local function dq(f)
	return dk(f) and math.floor(f) == f
end
local function dr(self, y, z)
	if z ~= z then
		z = 0
	end
	if z ~= nil and y > z then
		y, z = z, y
	end
	if y >= 0 then
		y = y + 1
	else
		y = 1
	end
	if z ~= nil and z < 0 then
		z = 0
	end
	return string.sub(self, y, z)
end
local ds
do
	local dt = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
	function ds(du, bL)
		if bL == nil then
			bL = 10
			local dv = df(du, "^%s*-?0[xX]")
			if dv ~= nil then
				bL = 16
				du = df(dv, "-") and "-" .. dr(du, #dv) or dr(du, #dv)
			end
		end
		if bL < 2 or bL > 36 then
			return 0 / 0
		end
		local dw = bL <= 10 and dr(dt, 0, bL) or dr(dt, 0, 10 + 2 * (bL - 10))
		local dx = ("^%s*(-?[" .. dw) .. "]*)"
		local dy = tonumber(df(du, dx), bL)
		if dy == nil then
			return 0 / 0
		end
		if dy >= 0 then
			return math.floor(dy)
		else
			return math.ceil(dy)
		end
	end
end
local function dz(du)
	local dA = df(du, "^%s*(-?Infinity)")
	if dA ~= nil then
		return cR(dA, 0) == "-" and -math.huge or math.huge
	end
	local dy = tonumber(df(du, "^%s*(-?%d+%.?%d*)"))
	return dy or 0 / 0
end
local dB
do
	local dC = "0123456789abcdefghijklmnopqrstuvwxyz"
	function dB(self, dD)
		if dD == nil or dD == 10 or self == math.huge or self == -math.huge or self ~= self then
			return tostring(self)
		end
		dD = math.floor(dD)
		if dD < 2 or dD > 36 then
			error("toString() radix argument must be between 2 and 36", 0)
		end
		local dE, dF = dh(math.abs(self))
		local i = ""
		if dD == 8 then
			i = string.format("%o", dE)
		elseif dD == 16 then
			i = string.format("%x", dE)
		else
			repeat
				do
					i = cR(dC, dE % dD) .. i
					dE = math.floor(dE / dD)
				end
			until not (dE ~= 0)
		end
		if dF ~= 0 then
			i = i .. "."
			local dG = 1e-16
			repeat
				do
					dF = dF * dD
					dG = dG * dD
					local dH = math.floor(dF)
					i = i .. cR(dC, dH)
					dF = dF - dH
				end
			until not (dF >= dG)
		end
		if self < 0 then
			i = "-" .. i
		end
		return i
	end
end
local function dI(self, dJ)
	if math.abs(self) >= 1e+21 or self ~= self then
		return tostring(self)
	end
	local bu = math.floor(dJ or 0)
	if bu < 0 or bu > 99 then
		error("toFixed() digits argument must be between 0 and 99", 0)
	end
	return string.format(("%." .. tostring(bu)) .. "f", self)
end
local function dK(aV, t, cg)
	local dL = type(t) == "number" and t + 1 or t
	local f = rawget(aV, dL)
	local bW = cg.get ~= nil or cg.set ~= nil
	local bV
	if bW then
		if f ~= nil then
			error("Cannot redefine property: " .. tostring(t), 0)
		end
		bV = cg
	else
		local dM = f ~= nil
		local dN = cg.set
		local dO = cg.get
		local dP = cg.configurable
		if dP == nil then
			dP = dM
		end
		local dQ = cg.enumerable
		if dQ == nil then
			dQ = dM
		end
		local dR = cg.writable
		if dR == nil then
			dR = dM
		end
		local dS
		if cg.value ~= nil then
			dS = cg.value
		else
			dS = f
		end
		bV = { set = dN, get = dO, configurable = dP, enumerable = dQ, writable = dR, value = dS }
	end
	cd(aV, dL, bV)
	return aV
end
local function dT(aY)
	local i = {}
	local j = 0
	for t in pairs(aY) do
		j = j + 1
		i[j] = { t, aY[t] }
	end
	return i
end
local function dU(d6)
	local aY = {}
	local Q = d6
	if Q[o.iterator] then
		local R = Q[o.iterator](Q)
		while true do
			local i = R:next()
			if i.done then
				break
			end
			local f = i.value
			aY[f[1]] = f[2]
		end
	else
		for Y, dV in ipairs(d6) do
			aY[dV[1]] = dV[2]
		end
	end
	return aY
end
local function dW(h, dd)
	local i = {}
	local k = 0
	for Y, l in J(h) do
		local t = dd(nil, l, k)
		if i[t] ~= nil then
			local dX = i[t]
			dX[#dX + 1] = l
		else
			i[t] = { l }
		end
		k = k + 1
	end
	return i
end
local function dY(aY)
	local i = {}
	local j = 0
	for t in pairs(aY) do
		j = j + 1
		i[j] = t
	end
	return i
end
local function dZ(aV, d_)
	local i = {}
	for e0 in pairs(aV) do
		if not d_[e0] then
			i[e0] = aV[e0]
		end
	end
	return i
end
local function e1(aY)
	local i = {}
	local j = 0
	for t in pairs(aY) do
		j = j + 1
		i[j] = aY[t]
	end
	return i
end
local function e2(Q)
	local d4 = {}
	local e3 = {}
	local e4 = 0
	local k = 0
	for Y, l in J(Q) do
		if aX(l, b2) then
			if l.state == 1 then
				d4[k + 1] = l.value
			elseif l.state == 2 then
				return b2.reject(l.rejectionReason)
			else
				e4 = e4 + 1
				e3[k] = l
			end
		else
			d4[k + 1] = l
		end
		k = k + 1
	end
	if e4 == 0 then
		return b2.resolve(d4)
	end
	return aU(b2, function(Y, b4, b5)
		for P, b9 in pairs(e3) do
			b9["then"](b9, function(Y, e5)
				d4[P + 1] = e5
				e4 = e4 - 1
				if e4 == 0 then
					b4(nil, d4)
				end
			end, function(Y, bh)
				b5(nil, bh)
			end)
		end
	end)
end
local function e6(Q)
	local d4 = {}
	local e3 = {}
	local e4 = 0
	local k = 0
	for Y, l in J(Q) do
		if aX(l, b2) then
			if l.state == 1 then
				d4[k + 1] = { status = "fulfilled", value = l.value }
			elseif l.state == 2 then
				d4[k + 1] = { status = "rejected", reason = l.rejectionReason }
			else
				e4 = e4 + 1
				e3[k] = l
			end
		else
			d4[k + 1] = { status = "fulfilled", value = l }
		end
		k = k + 1
	end
	if e4 == 0 then
		return b2.resolve(d4)
	end
	return aU(b2, function(Y, b4)
		for P, b9 in pairs(e3) do
			b9["then"](b9, function(Y, e5)
				d4[P + 1] = { status = "fulfilled", value = e5 }
				e4 = e4 - 1
				if e4 == 0 then
					b4(nil, d4)
				end
			end, function(Y, bh)
				d4[P + 1] = { status = "rejected", reason = bh }
				e4 = e4 - 1
				if e4 == 0 then
					b4(nil, d4)
				end
			end)
		end
	end)
end
local function e7(Q)
	local e8 = {}
	local e9 = {}
	for Y, l in J(Q) do
		if aX(l, b2) then
			if l.state == 1 then
				return b2.resolve(l.value)
			elseif l.state == 2 then
				e8[#e8 + 1] = l.rejectionReason
			else
				e9[#e9 + 1] = l
			end
		else
			return b2.resolve(l)
		end
	end
	if #e9 == 0 then
		return b2.reject("No promises to resolve with .any()")
	end
	local ea = 0
	return aU(b2, function(Y, b4, b5)
		for Y, b9 in ipairs(e9) do
			b9["then"](b9, function(Y, e5)
				b4(nil, e5)
			end, function(Y, bh)
				e8[#e8 + 1] = bh
				ea = ea + 1
				if ea == #e9 then
					b5(nil, { name = "AggregateError", message = "All Promises rejected", errors = e8 })
				end
			end)
		end
	end)
end
local function eb(Q)
	local e9 = {}
	for Y, l in J(Q) do
		if aX(l, b2) then
			if l.state == 1 then
				return b2.resolve(l.value)
			elseif l.state == 2 then
				return b2.reject(l.rejectionReason)
			else
				e9[#e9 + 1] = l
			end
		else
			return b2.resolve(l)
		end
	end
	return aU(b2, function(Y, b4, b5)
		for Y, b9 in ipairs(e9) do
			b9["then"](b9, function(Y, f)
				return b4(nil, f)
			end, function(Y, bh)
				return b5(nil, bh)
			end)
		end
	end)
end
local ec
do
	ec = b0()
	ec.name = "Set"
	function ec.prototype.____constructor(self, ed)
		self[o.toStringTag] = "Set"
		self.size = 0
		self.nextKey = {}
		self.previousKey = {}
		if ed == nil then
			return
		end
		local Q = ed
		if Q[o.iterator] then
			local R = Q[o.iterator](Q)
			while true do
				local i = R:next()
				if i.done then
					break
				end
				self:add(i.value)
			end
		else
			local s = ed
			for Y, f in ipairs(s) do
				self:add(f)
			end
		end
	end
	function ec.prototype.add(self, f)
		local da = not self:has(f)
		if da then
			self.size = self.size + 1
		end
		if self.firstKey == nil then
			self.firstKey = f
			self.lastKey = f
		elseif da then
			self.nextKey[self.lastKey] = f
			self.previousKey[f] = self.lastKey
			self.lastKey = f
		end
		return self
	end
	function ec.prototype.clear(self)
		self.nextKey = {}
		self.previousKey = {}
		self.firstKey = nil
		self.lastKey = nil
		self.size = 0
	end
	function ec.prototype.delete(self, f)
		local d8 = self:has(f)
		if d8 then
			self.size = self.size - 1
			local next = self.nextKey[f]
			local d9 = self.previousKey[f]
			if next ~= nil and d9 ~= nil then
				self.nextKey[d9] = next
				self.previousKey[next] = d9
			elseif next ~= nil then
				self.firstKey = next
				self.previousKey[next] = nil
			elseif d9 ~= nil then
				self.lastKey = d9
				self.nextKey[d9] = nil
			else
				self.firstKey = nil
				self.lastKey = nil
			end
			self.nextKey[f] = nil
			self.previousKey[f] = nil
		end
		return d8
	end
	function ec.prototype.forEach(self, aL)
		for Y, t in J(self:keys()) do
			aL(nil, t, t, self)
		end
	end
	function ec.prototype.has(self, f)
		return self.nextKey[f] ~= nil or self.lastKey == f
	end
	ec.prototype[o.iterator] = function(self)
		return self:values()
	end
	function ec.prototype.entries(self)
		local db = self.nextKey
		local t = self.firstKey
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				local i = { done = not t, value = { t, t } }
				t = db[t]
				return i
			end,
		}
	end
	function ec.prototype.keys(self)
		local db = self.nextKey
		local t = self.firstKey
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				local i = { done = not t, value = t }
				t = db[t]
				return i
			end,
		}
	end
	function ec.prototype.values(self)
		local db = self.nextKey
		local t = self.firstKey
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				local i = { done = not t, value = t }
				t = db[t]
				return i
			end,
		}
	end
	function ec.prototype.union(self, ee)
		local i = aU(ec, self)
		for Y, l in J(ee) do
			i:add(l)
		end
		return i
	end
	function ec.prototype.intersection(self, ee)
		local i = aU(ec)
		for Y, l in J(self) do
			if ee:has(l) then
				i:add(l)
			end
		end
		return i
	end
	function ec.prototype.difference(self, ee)
		local i = aU(ec, self)
		for Y, l in J(ee) do
			i:delete(l)
		end
		return i
	end
	function ec.prototype.symmetricDifference(self, ee)
		local i = aU(ec, self)
		for Y, l in J(ee) do
			if self:has(l) then
				i:delete(l)
			else
				i:add(l)
			end
		end
		return i
	end
	function ec.prototype.isSubsetOf(self, ee)
		for Y, l in J(self) do
			if not ee:has(l) then
				return false
			end
		end
		return true
	end
	function ec.prototype.isSupersetOf(self, ee)
		for Y, l in J(ee) do
			if not self:has(l) then
				return false
			end
		end
		return true
	end
	function ec.prototype.isDisjointFrom(self, ee)
		for Y, l in J(self) do
			if ee:has(l) then
				return false
			end
		end
		return true
	end
	ec[o.species] = ec
end
local function ef(...)
	local eg = { ... }
	eg.sparseLength = ae(...)
	return eg
end
local function eh(eg, ...)
	local ax = { ... }
	local ei = ae(...)
	local ej = eg.sparseLength
	for k = 1, ei do
		eg[ej + k] = ax[k]
	end
	eg.sparseLength = ej + ei
end
local function ek(eg)
	local el = unpack or table.unpack
	return el(eg, 1, eg.sparseLength)
end
local em
do
	em = b0()
	em.name = "WeakMap"
	function em.prototype.____constructor(self, d6)
		self[o.toStringTag] = "WeakMap"
		self.items = {}
		setmetatable(self.items, { __mode = "k" })
		if d6 == nil then
			return
		end
		local Q = d6
		if Q[o.iterator] then
			local R = Q[o.iterator](Q)
			while true do
				local i = R:next()
				if i.done then
					break
				end
				local f = i.value
				self.items[f[1]] = f[2]
			end
		else
			for Y, d7 in ipairs(d6) do
				self.items[d7[1]] = d7[2]
			end
		end
	end
	function em.prototype.delete(self, t)
		local d8 = self:has(t)
		self.items[t] = nil
		return d8
	end
	function em.prototype.get(self, t)
		return self.items[t]
	end
	function em.prototype.has(self, t)
		return self.items[t] ~= nil
	end
	function em.prototype.set(self, t, f)
		self.items[t] = f
		return self
	end
	em[o.species] = em
end
local en
do
	en = b0()
	en.name = "WeakSet"
	function en.prototype.____constructor(self, ed)
		self[o.toStringTag] = "WeakSet"
		self.items = {}
		setmetatable(self.items, { __mode = "k" })
		if ed == nil then
			return
		end
		local Q = ed
		if Q[o.iterator] then
			local R = Q[o.iterator](Q)
			while true do
				local i = R:next()
				if i.done then
					break
				end
				self.items[i.value] = true
			end
		else
			for Y, f in ipairs(ed) do
				self.items[f] = true
			end
		end
	end
	function en.prototype.add(self, f)
		self.items[f] = true
		return self
	end
	function en.prototype.delete(self, f)
		local d8 = self:has(f)
		self.items[f] = nil
		return d8
	end
	function en.prototype.has(self, f)
		return self.items[f] == true
	end
	en[o.species] = en
end
local function eo(ep, eq)
	_G.__TS__sourcemap = _G.__TS__sourcemap or {}
	_G.__TS__sourcemap[ep] = eq
	if _G.__TS__originalTraceback == nil then
		local er = debug.traceback
		_G.__TS__originalTraceback = er
		debug.traceback = function(es, cJ, cz)
			local et
			if es == nil and cJ == nil and cz == nil then
				et = er()
			elseif co(_VERSION, "Lua 5.0") then
				et = er((("[Level " .. tostring(cz)) .. "] ") .. tostring(cJ))
			else
				et = er(es, cJ, cz)
			end
			if type(et) ~= "string" then
				return et
			end
			local function eu(Y, ev, ew, ex)
				local ey = _G.__TS__sourcemap[ev]
				if ey ~= nil and ey[ex] ~= nil then
					local e5 = ey[ex]
					if type(e5) == "number" then
						return (ew .. ":") .. tostring(e5)
					end
					return (e5.file .. ":") .. tostring(e5.line)
				end
				return (ev .. ":") .. ex
			end
			local i = string.gsub(et, "(%S+)%.lua:(%d+)", function(ev, ex)
				return eu(nil, ev .. ".lua", ev .. ".ts", ex)
			end)
			local function ez(Y, ev, ex)
				local ey = _G.__TS__sourcemap[ev]
				if ey ~= nil and ey[ex] ~= nil then
					local eA = df(ev, '%[string "([^"]+)"%]')
					local eB = string.gsub(eA, ".lua$", ".ts")
					local e5 = ey[ex]
					if type(e5) == "number" then
						return (eB .. ":") .. tostring(e5)
					end
					return (e5.file .. ":") .. tostring(e5.line)
				end
				return (ev .. ":") .. ex
			end
			i = string.gsub(i, '(%[string "[^"]+"%]):(%d+)', function(ev, ex)
				return ez(nil, ev, ex)
			end)
			return i
		end
	end
end
local function eC(Q)
	local V = {}
	if type(Q) == "string" then
		for k = 0, #Q - 1 do
			V[k + 1] = cR(Q, k)
		end
	else
		local j = 0
		for Y, l in J(Q) do
			j = j + 1
			V[j] = l
		end
	end
	return aO(V)
end
local function eD(self, eE)
	if eE ~= eE then
		eE = 0
	end
	if eE < 0 then
		return ""
	end
	return string.sub(self, eE + 1, eE + 1)
end
local function eF(self, P)
	if P ~= P then
		P = 0
	end
	if P < 0 then
		return 0 / 0
	end
	return string.byte(self, P + 1) or 0 / 0
end
local function eG(self, cp, eH)
	if eH == nil or eH > #self then
		eH = #self
	end
	return string.sub(self, eH - #cp + 1, eH) == cp
end
local function eI(self, eJ, eK)
	if eK == nil then
		eK = " "
	end
	if eJ ~= eJ then
		eJ = 0
	end
	if eJ == -math.huge or eJ == math.huge then
		error("Invalid string length", 0)
	end
	if #self >= eJ or #eK == 0 then
		return self
	end
	eJ = eJ - #self
	if eJ > #eK then
		eK = eK .. string.rep(eK, math.floor(eJ / #eK))
	end
	return self .. string.sub(eK, 1, math.floor(eJ))
end
local function eL(self, eJ, eK)
	if eK == nil then
		eK = " "
	end
	if eJ ~= eJ then
		eJ = 0
	end
	if eJ == -math.huge or eJ == math.huge then
		error("Invalid string length", 0)
	end
	if #self >= eJ or #eK == 0 then
		return self
	end
	eJ = eJ - #self
	if eJ > #eK then
		eK = eK .. string.rep(eK, math.floor(eJ / #eK))
	end
	return string.sub(eK, 1, math.floor(eJ)) .. self
end
local eM
do
	local eN = string.sub
	function eM(c5, eO, eP)
		local eQ, eR = string.find(c5, eO, nil, true)
		if not eQ then
			return c5
		end
		local eS = eN(c5, 1, eQ - 1)
		local eT = type(eP) == "string" and eP or eP(nil, eO, eQ - 1, c5)
		local eU = eN(c5, eR + 1)
		return (eS .. eT) .. eU
	end
end
local eV
do
	local eN = string.sub
	local eW = string.find
	function eV(c5, a9, eX)
		if eX == nil then
			eX = 4294967295
		end
		if eX == 0 then
			return {}
		end
		local i = {}
		local eY = 1
		if a9 == nil or a9 == "" then
			for k = 1, #c5 do
				i[eY] = eN(c5, k, k)
				eY = eY + 1
			end
		else
			local eZ = 1
			while eY <= eX do
				local eQ, eR = eW(c5, a9, eZ, true)
				if not eQ then
					break
				end
				i[eY] = eN(c5, eZ, eQ - 1)
				eY = eY + 1
				eZ = eR + 1
			end
			if eY <= eX then
				i[eY] = eN(c5, eZ)
			end
		end
		return i
	end
end
local e_
do
	local eN = string.sub
	local eW = string.find
	function e_(c5, eO, eP)
		if type(eP) == "string" then
			local f0 = table.concat(eV(c5, eO), eP)
			if #eO == 0 then
				return (eP .. f0) .. eP
			end
			return f0
		end
		local aa = {}
		local f1 = 1
		if #eO == 0 then
			aa[1] = eP(nil, "", 0, c5)
			f1 = 2
			for k = 1, #c5 do
				aa[f1] = eN(c5, k, k)
				aa[f1 + 1] = eP(nil, "", k, c5)
				f1 = f1 + 2
			end
		else
			local eZ = 1
			while true do
				local eQ, eR = eW(c5, eO, eZ, true)
				if not eQ then
					break
				end
				aa[f1] = eN(c5, eZ, eQ - 1)
				aa[f1 + 1] = eP(nil, eO, eQ - 1, c5)
				f1 = f1 + 2
				eZ = eR + 1
			end
			aa[f1] = eN(c5, eZ)
		end
		return table.concat(aa)
	end
end
local function f2(self, y, z)
	if y == nil or y ~= y then
		y = 0
	end
	if z ~= z then
		z = 0
	end
	if y >= 0 then
		y = y + 1
	end
	if z ~= nil and z < 0 then
		z = z - 1
	end
	return string.sub(self, y, z)
end
local function f3(self, cp, cq)
	if cq == nil or cq < 0 then
		cq = 0
	end
	return string.sub(self, cq + 1, #cp + cq) == cp
end
local function f4(self, aC, aN)
	if aC ~= aC then
		aC = 0
	end
	if aN ~= nil then
		if aN ~= aN or aN <= 0 then
			return ""
		end
		aN = aN + aC
	end
	if aC >= 0 then
		aC = aC + 1
	end
	return string.sub(self, aC, aN)
end
local function f5(self)
	local i = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
	return i
end
local function f6(self)
	local i = string.gsub(self, "[%s ﻿]*$", "")
	return i
end
local function f7(self)
	local i = string.gsub(self, "^[%s ﻿]*", "")
	return i
end
local f8, f9
do
	local fa = {}
	function f8(t)
		if not fa[t] then
			fa[t] = n(t)
		end
		return fa[t]
	end
	function f9(fb)
		for t in pairs(fa) do
			if fa[t] == fb then
				return t
			end
		end
		return nil
	end
end
local function fc(f)
	local fd = type(f)
	if fd == "table" then
		return "object"
	elseif fd == "nil" then
		return "undefined"
	else
		return fd
	end
end
local function fe(self, ff, ...)
	local ax = { ... }
	local fg
	local fh, i = xpcall(function()
		return ff(aO(ax))
	end, function(bg)
		fg = bg
		return fg
	end)
	local fi = { aO(ax) }
	do
		local k = #fi - 1
		while k >= 0 do
			local fj = fi[k + 1]
			fj[o.dispose](fj)
			k = k - 1
		end
	end
	if not fh then
		error(fg, 0)
	end
	return i
end
local function fk(self, ff, ...)
	local ax = { ... }
	return bx(function(fl)
		local fg
		local fh, i = xpcall(function()
			return ff(nil, aO(ax))
		end, function(bg)
			fg = bg
			return fg
		end)
		local fi = { aO(ax) }
		do
			local k = #fi - 1
			while k >= 0 do
				if fi[k + 1][o.dispose] ~= nil then
					local fj = fi[k + 1]
					fj[o.dispose](fj)
				end
				if fi[k + 1][o.asyncDispose] ~= nil then
					local fm = fi[k + 1]
					by(fm[o.asyncDispose](fm))
				end
				k = k - 1
			end
		end
		if not fh then
			error(fg, 0)
		end
		return fl(nil, i)
	end)
end
return {
	__TS__ArrayAt = b,
	__TS__ArrayConcat = g,
	__TS__ArrayEntries = r,
	__TS__ArrayEvery = u,
	__TS__ArrayFill = x,
	__TS__ArrayFilter = C,
	__TS__ArrayForEach = D,
	__TS__ArrayFind = F,
	__TS__ArrayFindIndex = I,
	__TS__ArrayFrom = S,
	__TS__ArrayIncludes = a3,
	__TS__ArrayIndexOf = a7,
	__TS__ArrayIsArray = e,
	__TS__ArrayJoin = a8,
	__TS__ArrayMap = ab,
	__TS__ArrayPush = ac,
	__TS__ArrayPushArray = ad,
	__TS__ArrayReduce = af,
	__TS__ArrayReduceRight = ah,
	__TS__ArrayReverse = ai,
	__TS__ArrayUnshift = ak,
	__TS__ArraySort = am,
	__TS__ArraySlice = aq,
	__TS__ArraySome = av,
	__TS__ArraySplice = aw,
	__TS__ArrayToObject = aE,
	__TS__ArrayFlat = aG,
	__TS__ArrayFlatMap = aK,
	__TS__ArraySetLength = aM,
	__TS__ArrayToReversed = aP,
	__TS__ArrayToSorted = aR,
	__TS__ArrayToSpliced = aS,
	__TS__ArrayWith = aT,
	__TS__AsyncAwaiter = bx,
	__TS__Await = by,
	__TS__Class = b0,
	__TS__ClassExtends = bK,
	__TS__CloneDescriptor = bO,
	__TS__CountVarargs = ae,
	__TS__Decorate = bY,
	__TS__DecorateLegacy = cj,
	__TS__DecorateParam = cm,
	__TS__Delete = cQ,
	__TS__DelegatedYield = cS,
	__TS__DescriptorGet = c8,
	__TS__DescriptorSet = cc,
	Error = cr,
	RangeError = cs,
	ReferenceError = ct,
	SyntaxError = cu,
	TypeError = cv,
	URIError = cw,
	__TS__FunctionBind = cT,
	__TS__Generator = cW,
	__TS__InstanceOf = aX,
	__TS__InstanceOfObject = c_,
	__TS__Iterator = J,
	__TS__LuaIteratorSpread = d1,
	Map = d5,
	__TS__MapGroupBy = dc,
	__TS__Match = df,
	__TS__MathAtan2 = dg,
	__TS__MathModf = dh,
	__TS__MathSign = dj,
	__TS__MathTrunc = dl,
	__TS__New = aU,
	__TS__Number = dm,
	__TS__NumberIsFinite = dk,
	__TS__NumberIsInteger = dq,
	__TS__NumberIsNaN = di,
	__TS__ParseInt = ds,
	__TS__ParseFloat = dz,
	__TS__NumberToString = dB,
	__TS__NumberToFixed = dI,
	__TS__ObjectAssign = c3,
	__TS__ObjectDefineProperty = dK,
	__TS__ObjectEntries = dT,
	__TS__ObjectFromEntries = dU,
	__TS__ObjectGetOwnPropertyDescriptor = c6,
	__TS__ObjectGetOwnPropertyDescriptors = cP,
	__TS__ObjectGroupBy = dW,
	__TS__ObjectKeys = dY,
	__TS__ObjectRest = dZ,
	__TS__ObjectValues = e1,
	__TS__ParseFloat = dz,
	__TS__ParseInt = ds,
	__TS__Promise = b2,
	__TS__PromiseAll = e2,
	__TS__PromiseAllSettled = e6,
	__TS__PromiseAny = e7,
	__TS__PromiseRace = eb,
	Set = ec,
	__TS__SetDescriptor = cd,
	__TS__SparseArrayNew = ef,
	__TS__SparseArrayPush = eh,
	__TS__SparseArraySpread = ek,
	WeakMap = em,
	WeakSet = en,
	__TS__SourceMapTraceBack = eo,
	__TS__Spread = eC,
	__TS__StringAccess = cR,
	__TS__StringCharAt = eD,
	__TS__StringCharCodeAt = eF,
	__TS__StringEndsWith = eG,
	__TS__StringIncludes = co,
	__TS__StringPadEnd = eI,
	__TS__StringPadStart = eL,
	__TS__StringReplace = eM,
	__TS__StringReplaceAll = e_,
	__TS__StringSlice = f2,
	__TS__StringSplit = eV,
	__TS__StringStartsWith = f3,
	__TS__StringSubstr = f4,
	__TS__StringSubstring = dr,
	__TS__StringTrim = f5,
	__TS__StringTrimEnd = f6,
	__TS__StringTrimStart = f7,
	__TS__Symbol = n,
	Symbol = o,
	__TS__SymbolRegistryFor = f8,
	__TS__SymbolRegistryKeyFor = f9,
	__TS__TypeOf = fc,
	__TS__Unpack = aO,
	__TS__Using = fe,
	__TS__UsingAsync = fk,
}