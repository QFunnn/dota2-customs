--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		if type(bo) ~= "function" then
			return self["then"](self, bo, bo)
		end
		return self["then"](self, function(Y, bp)
			local bq = aU(b2, function(Y, b4)
				return b4(nil, bo(nil))
			end)
			return bq["then"](bq, function()
				return bp
			end)
		end, function(Y, br)
			local bs = aU(b2, function(Y, b4)
				return b4(nil, bo(nil))
			end)
			return bs["then"](bs, function()
				error(br, 0)
			end)
		end)
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
	function b2.prototype.invokeCallbacks(self, bt, f)
		local bu = #bt
		if bu ~= 0 then
			for k = 1, bu - 1 do
				bt[k](bt, f)
			end
			return bt[bu](bt, f)
		end
	end
	function b2.prototype.createPromiseResolvingCallback(self, bv, b4, b5)
		return function(Y, f)
			local be, bw = bd(bv, nil, f)
			if not be then
				return b5(nil, bw)
			end
			return self:handleCallbackValue(bw, b4, b5)
		end
	end
	function b2.prototype.handleCallbackValue(self, f, b4, b5)
		if bb(f) then
			local bx = f
			if bx.state == 1 then
				return b4(nil, bx.value)
			elseif bx.state == 2 then
				return b5(nil, bx.rejectionReason)
			else
				return bx:addCallbacks(b4, b5)
			end
		else
			return b4(nil, f)
		end
	end
end
local by, bz
do
	local bA = _G.coroutine or {}
	local bB = bA.create
	local bC = bA.resume
	local bD = bA.status
	local bE = bA.yield
	function by(bF)
		return aU(b2, function(Y, b4, b5)
			local bG, bH, bI, bJ
			function bG(self, f)
				local be, bw = bC(bJ, f)
				if be then
					return bH(bw)
				end
				return b5(nil, bw)
			end
			function bH(i)
				if bI then
					return
				end
				if bD(bJ) == "dead" then
					return b4(nil, i)
				end
				return b2.resolve(i):addCallbacks(bG, b5)
			end
			bI = false
			bJ = bB(bF)
			local be, bw = bC(bJ, function(Y, Z)
				bI = true
				return b2.resolve(Z):addCallbacks(b4, b5)
			end)
			if be then
				return bH(bw)
			else
				return b5(nil, bw)
			end
		end)
	end
	function bz(bK)
		return bE(bK)
	end
end
local function bL(aV, bM)
	aV.____super = bM
	local bN = setmetatable({ __index = bM }, bM)
	setmetatable(aV, bN)
	local bO = getmetatable(bM)
	if bO then
		if type(bO.__index) == "function" then
			bN.__index = bO.__index
		end
		if type(bO.__newindex) == "function" then
			bN.__newindex = bO.__newindex
		end
	end
	setmetatable(aV.prototype, bM.prototype)
	if type(bM.prototype.__index) == "function" then
		aV.prototype.__index = bM.prototype.__index
	end
	if type(bM.prototype.__newindex) == "function" then
		aV.prototype.__newindex = bM.prototype.__newindex
	end
	if type(bM.prototype.__tostring) == "function" then
		aV.prototype.__tostring = bM.prototype.__tostring
	end
end
local function bP(bQ)
	local f
	local bR
	local bS
	local bT
	local bU
	local bV
	bV = bQ.enumerable
	bU = bQ.configurable
	bT = bQ.get
	bS = bQ.set
	bR = bQ.writable
	f = bQ.value
	local bW = { enumerable = bV == true, configurable = bU == true }
	local bX = bT ~= nil or bS ~= nil
	local bY = bR ~= nil or f ~= nil
	if bX and bY then
		error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
	end
	if bT or bS then
		bW.get = bT
		bW.set = bS
	else
		bW.value = f
		bW.writable = bR == true
	end
	return bW
end
local function bZ(self, b_, c0, c1)
	local i = b_
	do
		local k = #c0
		while k >= 0 do
			local c2 = c0[k + 1]
			if c2 ~= nil then
				local c3 = c2(self, i, c1)
				if c3 == nil then
					c3 = i
				end
				i = c3
			end
			k = k - 1
		end
	end
	return i
end
local function c4(aV, ...)
	local c5 = { ... }
	for k = 1, #c5 do
		local c6 = c5[k]
		if type(c6) == "table" then
			for t in pairs(c6) do
				aV[t] = c6[t]
			end
		end
	end
	return aV
end
local function c7(aF, t)
	local c8 = getmetatable(aF)
	if not c8 then
		return
	end
	if not rawget(c8, "_descriptors") then
		return
	end
	return rawget(c8, "_descriptors")[t]
end
local c9
do
	local getmetatable = _G.getmetatable
	local ca = _G.rawget
	function c9(self, c8, t)
		while c8 do
			local cb = ca(c8, t)
			if cb ~= nil then
				return cb
			end
			local cc = ca(c8, "_descriptors")
			if cc then
				local bW = cc[t]
				if bW ~= nil then
					if bW.get then
						return bW.get(self)
					end
					return bW.value
				end
			end
			c8 = getmetatable(c8)
		end
	end
end
local cd
do
	local getmetatable = _G.getmetatable
	local ca = _G.rawget
	local rawset = _G.rawset
	function cd(self, c8, t, f)
		while c8 do
			local cc = ca(c8, "_descriptors")
			if cc then
				local bW = cc[t]
				if bW ~= nil then
					if bW.set then
						bW.set(self, f)
					else
						if bW.writable == false then
							error(
								((("Cannot assign to read only property '" .. t) .. "' of object '") .. tostring(self))
									.. "'",
								0
							)
						end
						bW.value = f
					end
					return
				end
			end
			c8 = getmetatable(c8)
		end
		rawset(self, t, f)
	end
end
local ce
do
	local getmetatable = _G.getmetatable
	local function cf(self, t)
		return c9(self, getmetatable(self), t)
	end
	local function cg(self, t, f)
		return cd(self, getmetatable(self), t, f)
	end
	function ce(aV, t, ch, ci)
		if ci == nil then
			ci = false
		end
		local cj
		if ci then
			cj = aV
		else
			cj = getmetatable(aV)
		end
		local c8 = cj
		if not c8 then
			c8 = {}
			setmetatable(aV, c8)
		end
		if not ci and not rawget(c8, "_isOwnDescriptorMetatable") then
			local ck = {}
			ck._isOwnDescriptorMetatable = true
			setmetatable(ck, c8)
			setmetatable(aV, ck)
			c8 = ck
		end
		local f = rawget(aV, t)
		if f ~= nil then
			rawset(aV, t, nil)
		end
		if not rawget(c8, "_descriptors") then
			c8._descriptors = {}
		end
		c8._descriptors[t] = bP(ch)
		c8.__index = cf
		c8.__newindex = cg
	end
end
local function cl(c0, aV, t, ch)
	local i = aV
	do
		local k = #c0
		while k >= 0 do
			local c2 = c0[k + 1]
			if c2 ~= nil then
				local cm = i
				if t == nil then
					i = c2(nil, i)
				elseif ch == true then
					local f = rawget(aV, t)
					local bW = c7(aV, t) or { configurable = true, writable = true, value = f }
					local ch = c2(nil, aV, t, bW) or bW
					local cn = ch.configurable == true and ch.writable == true and not ch.get and not ch.set
					if cn then
						rawset(aV, t, ch.value)
					else
						ce(aV, t, c4({}, bW, ch))
					end
				elseif ch == false then
					i = c2(nil, aV, t, ch)
				else
					i = c2(nil, aV, t)
				end
				i = i or cm
			end
			k = k - 1
		end
	end
	return i
end
local function co(cp, c2)
	return function(Y, aV, t)
		return c2(nil, aV, t, cp)
	end
end
local function cq(self, cr, cs)
	if not cs then
		cs = 1
	else
		cs = cs + 1
	end
	local P = string.find(self, cr, cs, true)
	return P ~= nil
end
local ct, cu, cv, cw, cx, cy
do
	local function cz(self, cA)
		if debug == nil then
			return nil
		end
		local cB = 1
		while true do
			local cC = debug.getinfo(cB, "f")
			cB = cB + 1
			if not cC then
				cB = 1
				break
			elseif cC.func == cA then
				break
			end
		end
		if cq(_VERSION, "Lua 5.0") then
			return debug.traceback(("[Level " .. tostring(cB)) .. "]")
		elseif _VERSION == "Lua 5.1" then
			return string.sub(debug.traceback("", cB), 2)
		else
			return debug.traceback(nil, cB)
		end
	end
	local function cD(self, cE)
		return function(self)
			local q = cE(self)
			local cF = debug.getinfo(3, "f")
			local cG = cq(_VERSION, "Lua 5.0")
			if cG or cF and cF.func ~= error then
				return q
			else
				return (q .. "\n") .. tostring(self.stack)
			end
		end
	end
	local function cH(self, cI, cJ)
		cI.name = cJ
		return setmetatable(cI, {
			__call = function(Y, cK, cL)
				return aU(cI, cL)
			end,
		})
	end
	local cM = cH
	local cN = b0()
	cN.name = ""
	function cN.prototype.____constructor(self, cL)
		if cL == nil then
			cL = ""
		end
		self.message = cL
		self.name = "Error"
		self.stack = cz(nil, aU)
		local c8 = getmetatable(self)
		if c8 and not c8.__errorToStringPatched then
			c8.__errorToStringPatched = true
			c8.__tostring = cD(nil, c8.__tostring)
		end
	end
	function cN.prototype.__tostring(self)
		return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
	end
	ct = cM(nil, cN, "Error")
	local function cO(self, cJ)
		local cP = cH
		local cQ = b0()
		cQ.name = cQ.name
		bL(cQ, ct)
		function cQ.prototype.____constructor(self, ...)
			cQ.____super.prototype.____constructor(self, ...)
			self.name = cJ
		end
		return cP(nil, cQ, cJ)
	end
	cu = cO(nil, "RangeError")
	cv = cO(nil, "ReferenceError")
	cw = cO(nil, "SyntaxError")
	cx = cO(nil, "TypeError")
	cy = cO(nil, "URIError")
end
local function cR(aF)
	local c8 = getmetatable(aF)
	if not c8 then
		return {}
	end
	return rawget(c8, "_descriptors") or {}
end
local function cS(aV, t)
	local cc = cR(aV)
	local bW = cc[t]
	if bW then
		if not bW.configurable then
			error(aU(cx, ((("Cannot delete property " .. tostring(t)) .. " of ") .. tostring(aV)) .. "."), 0)
		end
		cc[t] = nil
		return true
	end
	aV[t] = nil
	return true
end
local function cT(self, P)
	if P >= 0 and P < #self then
		return string.sub(self, P + 1, P + 1)
	end
end
local function cU(Q)
	if type(Q) == "string" then
		for P = 0, #Q - 1 do
			coroutine.yield(cT(Q, P))
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
local function cV(cW, ...)
	local cX = { ... }
	return function(Y, ...)
		local ax = { ... }
		ak(ax, aO(cX))
		return cW(aO(ax))
	end
end
local cY
do
	local function cZ(self)
		return self
	end
	local function c_(self, ...)
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
	function cY(cW)
		return function(...)
			local ax = { ... }
			local d0 = ae(...)
			return { ____coroutine = coroutine.create(function()
				return cW(aO(ax, 1, d0))
			end), [o.iterator] = cZ, next = c_ }
		end
	end
end
local function d1(f)
	local d2 = type(f)
	return d2 == "table" or d2 == "function"
end
local function d3(self, d4, d5)
	local d6 = {}
	local t, f = self(d4, d5)
	while t do
		d6[#d6 + 1] = { t, f }
		t, f = self(d4, t)
	end
	return aO(d6)
end
local d7
do
	d7 = b0()
	d7.name = "Map"
	function d7.prototype.____constructor(self, d8)
		self[o.toStringTag] = "Map"
		self.items = {}
		self.size = 0
		self.nextKey = {}
		self.previousKey = {}
		if d8 == nil then
			return
		end
		local Q = d8
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
			local s = d8
			for Y, d9 in ipairs(s) do
				self:set(d9[1], d9[2])
			end
		end
	end
	function d7.prototype.clear(self)
		self.items = {}
		self.nextKey = {}
		self.previousKey = {}
		self.firstKey = nil
		self.lastKey = nil
		self.size = 0
	end
	function d7.prototype.delete(self, t)
		local da = self:has(t)
		if da then
			self.size = self.size - 1
			local next = self.nextKey[t]
			local db = self.previousKey[t]
			if next ~= nil and db ~= nil then
				self.nextKey[db] = next
				self.previousKey[next] = db
			elseif next ~= nil then
				self.firstKey = next
				self.previousKey[next] = nil
			elseif db ~= nil then
				self.lastKey = db
				self.nextKey[db] = nil
			else
				self.firstKey = nil
				self.lastKey = nil
			end
			self.nextKey[t] = nil
			self.previousKey[t] = nil
		end
		self.items[t] = nil
		return da
	end
	function d7.prototype.forEach(self, aL)
		for Y, t in J(self:keys()) do
			aL(nil, self.items[t], t, self)
		end
	end
	function d7.prototype.get(self, t)
		return self.items[t]
	end
	function d7.prototype.has(self, t)
		return self.nextKey[t] ~= nil or self.lastKey == t
	end
	function d7.prototype.set(self, t, f)
		local dc = not self:has(t)
		if dc then
			self.size = self.size + 1
		end
		self.items[t] = f
		if self.firstKey == nil then
			self.firstKey = t
			self.lastKey = t
		elseif dc then
			self.nextKey[self.lastKey] = t
			self.previousKey[t] = self.lastKey
			self.lastKey = t
		end
		return self
	end
	d7.prototype[o.iterator] = function(self)
		return self:entries()
	end
	function d7.prototype.entries(self)
		local function dd()
			return self.firstKey
		end
		local h = self.items
		local de = self.nextKey
		local t
		local df = false
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not df then
					df = true
					t = dd(nil)
				else
					t = de[t]
				end
				return { done = not t, value = { t, h[t] } }
			end,
		}
	end
	function d7.prototype.keys(self)
		local function dd()
			return self.firstKey
		end
		local de = self.nextKey
		local t
		local df = false
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not df then
					df = true
					t = dd(nil)
				else
					t = de[t]
				end
				return { done = not t, value = t }
			end,
		}
	end
	function d7.prototype.values(self)
		local function dd()
			return self.firstKey
		end
		local h = self.items
		local de = self.nextKey
		local t
		local df = false
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not df then
					df = true
					t = dd(nil)
				else
					t = de[t]
				end
				return { done = not t, value = h[t] }
			end,
		}
	end
	d7[o.species] = d7
end
local function dg(h, dh)
	local i = aU(d7)
	local k = 0
	for Y, l in J(h) do
		local t = dh(nil, l, k)
		if i:has(t) then
			local di = i:get(t)
			di[#di + 1] = l
		else
			i:set(t, { l })
		end
		k = k + 1
	end
	return i
end
local dj = string.match
local dk = math.atan2 or math.atan
local dl = math.modf
local function dm(f)
	return f ~= f
end
local function dn(aJ)
	if dm(aJ) or aJ == 0 then
		return aJ
	end
	if aJ < 0 then
		return -1
	end
	return 1
end
local function dp(f)
	return type(f) == "number" and f == f and f ~= math.huge and f ~= -math.huge
end
local function dq(aJ)
	if not dp(aJ) or aJ == 0 then
		return aJ
	end
	return aJ > 0 and math.floor(aJ) or math.ceil(aJ)
end
local function dr(f)
	local d2 = type(f)
	if d2 == "number" then
		return f
	elseif d2 == "string" then
		local ds = tonumber(f)
		if ds then
			return ds
		end
		if f == "Infinity" then
			return math.huge
		end
		if f == "-Infinity" then
			return -math.huge
		end
		local dt = string.gsub(f, "%s", "")
		if dt == "" then
			return 0
		end
		return 0 / 0
	elseif d2 == "boolean" then
		return f and 1 or 0
	else
		return 0 / 0
	end
end
local function du(f)
	return dp(f) and math.floor(f) == f
end
local function dv(self, y, z)
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
local dw
do
	local dx = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
	function dw(dy, bM)
		if bM == nil then
			bM = 10
			local dz = dj(dy, "^%s*-?0[xX]")
			if dz ~= nil then
				bM = 16
				dy = dj(dz, "-") and "-" .. dv(dy, #dz) or dv(dy, #dz)
			end
		end
		if bM < 2 or bM > 36 then
			return 0 / 0
		end
		local dA = bM <= 10 and dv(dx, 0, bM) or dv(dx, 0, 10 + 2 * (bM - 10))
		local dB = ("^%s*(-?[" .. dA) .. "]*)"
		local dC = tonumber(dj(dy, dB), bM)
		if dC == nil then
			return 0 / 0
		end
		if dC >= 0 then
			return math.floor(dC)
		else
			return math.ceil(dC)
		end
	end
end
local function dD(dy)
	local dE = dj(dy, "^%s*(-?Infinity)")
	if dE ~= nil then
		return cT(dE, 0) == "-" and -math.huge or math.huge
	end
	local dC = tonumber(dj(dy, "^%s*(-?%d+%.?%d*)"))
	return dC or 0 / 0
end
local dF
do
	local dG = "0123456789abcdefghijklmnopqrstuvwxyz"
	function dF(self, dH)
		if dH == nil or dH == 10 or self == math.huge or self == -math.huge or self ~= self then
			return tostring(self)
		end
		dH = math.floor(dH)
		if dH < 2 or dH > 36 then
			error("toString() radix argument must be between 2 and 36", 0)
		end
		local dI, dJ = dl(math.abs(self))
		local i = ""
		if dH == 8 then
			i = string.format("%o", dI)
		elseif dH == 16 then
			i = string.format("%x", dI)
		else
			repeat
				do
					i = cT(dG, dI % dH) .. i
					dI = math.floor(dI / dH)
				end
			until not (dI ~= 0)
		end
		if dJ ~= 0 then
			i = i .. "."
			local dK = 1e-16
			repeat
				do
					dJ = dJ * dH
					dK = dK * dH
					local dL = math.floor(dJ)
					i = i .. cT(dG, dL)
					dJ = dJ - dL
				end
			until not (dJ >= dK)
		end
		if self < 0 then
			i = "-" .. i
		end
		return i
	end
end
local function dM(self, dN)
	if math.abs(self) >= 1e+21 or self ~= self then
		return tostring(self)
	end
	local bv = math.floor(dN or 0)
	if bv < 0 or bv > 99 then
		error("toFixed() digits argument must be between 0 and 99", 0)
	end
	return string.format(("%." .. tostring(bv)) .. "f", self)
end
local function dO(aV, t, ch)
	local dP = type(t) == "number" and t + 1 or t
	local f = rawget(aV, dP)
	local bX = ch.get ~= nil or ch.set ~= nil
	local bW
	if bX then
		if f ~= nil then
			error("Cannot redefine property: " .. tostring(t), 0)
		end
		bW = ch
	else
		local dQ = f ~= nil
		local dR = ch.set
		local dS = ch.get
		local dT = ch.configurable
		if dT == nil then
			dT = dQ
		end
		local dU = ch.enumerable
		if dU == nil then
			dU = dQ
		end
		local dV = ch.writable
		if dV == nil then
			dV = dQ
		end
		local dW
		if ch.value ~= nil then
			dW = ch.value
		else
			dW = f
		end
		bW = { set = dR, get = dS, configurable = dT, enumerable = dU, writable = dV, value = dW }
	end
	ce(aV, dP, bW)
	return aV
end
local function dX(aY)
	local i = {}
	local j = 0
	for t in pairs(aY) do
		j = j + 1
		i[j] = { t, aY[t] }
	end
	return i
end
local function dY(d8)
	local aY = {}
	local Q = d8
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
		for Y, dZ in ipairs(d8) do
			aY[dZ[1]] = dZ[2]
		end
	end
	return aY
end
local function d_(h, dh)
	local i = {}
	local k = 0
	for Y, l in J(h) do
		local t = dh(nil, l, k)
		if i[t] ~= nil then
			local e0 = i[t]
			e0[#e0 + 1] = l
		else
			i[t] = { l }
		end
		k = k + 1
	end
	return i
end
local function e1(aY)
	local i = {}
	local j = 0
	for t in pairs(aY) do
		j = j + 1
		i[j] = t
	end
	return i
end
local function e2(aV, e3)
	local i = {}
	for e4 in pairs(aV) do
		if not e3[e4] then
			i[e4] = aV[e4]
		end
	end
	return i
end
local function e5(aY)
	local i = {}
	local j = 0
	for t in pairs(aY) do
		j = j + 1
		i[j] = aY[t]
	end
	return i
end
local function e6(Q)
	local d6 = {}
	local e7 = {}
	local e8 = 0
	local k = 0
	for Y, l in J(Q) do
		if aX(l, b2) then
			if l.state == 1 then
				d6[k + 1] = l.value
			elseif l.state == 2 then
				return b2.reject(l.rejectionReason)
			else
				e8 = e8 + 1
				e7[k] = l
			end
		else
			d6[k + 1] = l
		end
		k = k + 1
	end
	if e8 == 0 then
		return b2.resolve(d6)
	end
	return aU(b2, function(Y, b4, b5)
		for P, b9 in pairs(e7) do
			b9["then"](b9, function(Y, e9)
				d6[P + 1] = e9
				e8 = e8 - 1
				if e8 == 0 then
					b4(nil, d6)
				end
			end, function(Y, bh)
				b5(nil, bh)
			end)
		end
	end)
end
local function ea(Q)
	local d6 = {}
	local e7 = {}
	local e8 = 0
	local k = 0
	for Y, l in J(Q) do
		if aX(l, b2) then
			if l.state == 1 then
				d6[k + 1] = { status = "fulfilled", value = l.value }
			elseif l.state == 2 then
				d6[k + 1] = { status = "rejected", reason = l.rejectionReason }
			else
				e8 = e8 + 1
				e7[k] = l
			end
		else
			d6[k + 1] = { status = "fulfilled", value = l }
		end
		k = k + 1
	end
	if e8 == 0 then
		return b2.resolve(d6)
	end
	return aU(b2, function(Y, b4)
		for P, b9 in pairs(e7) do
			b9["then"](b9, function(Y, e9)
				d6[P + 1] = { status = "fulfilled", value = e9 }
				e8 = e8 - 1
				if e8 == 0 then
					b4(nil, d6)
				end
			end, function(Y, bh)
				d6[P + 1] = { status = "rejected", reason = bh }
				e8 = e8 - 1
				if e8 == 0 then
					b4(nil, d6)
				end
			end)
		end
	end)
end
local function eb(Q)
	local ec = {}
	local ed = {}
	for Y, l in J(Q) do
		if aX(l, b2) then
			if l.state == 1 then
				return b2.resolve(l.value)
			elseif l.state == 2 then
				ec[#ec + 1] = l.rejectionReason
			else
				ed[#ed + 1] = l
			end
		else
			return b2.resolve(l)
		end
	end
	if #ed == 0 then
		return b2.reject("No promises to resolve with .any()")
	end
	local ee = 0
	return aU(b2, function(Y, b4, b5)
		for Y, b9 in ipairs(ed) do
			b9["then"](b9, function(Y, e9)
				b4(nil, e9)
			end, function(Y, bh)
				ec[#ec + 1] = bh
				ee = ee + 1
				if ee == #ed then
					b5(nil, { name = "AggregateError", message = "All Promises rejected", errors = ec })
				end
			end)
		end
	end)
end
local function ef(Q)
	local ed = {}
	for Y, l in J(Q) do
		if aX(l, b2) then
			if l.state == 1 then
				return b2.resolve(l.value)
			elseif l.state == 2 then
				return b2.reject(l.rejectionReason)
			else
				ed[#ed + 1] = l
			end
		else
			return b2.resolve(l)
		end
	end
	return aU(b2, function(Y, b4, b5)
		for Y, b9 in ipairs(ed) do
			b9["then"](b9, function(Y, f)
				return b4(nil, f)
			end, function(Y, bh)
				return b5(nil, bh)
			end)
		end
	end)
end
local eg
do
	eg = b0()
	eg.name = "Set"
	function eg.prototype.____constructor(self, eh)
		self[o.toStringTag] = "Set"
		self.size = 0
		self.nextKey = {}
		self.previousKey = {}
		if eh == nil then
			return
		end
		local Q = eh
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
			local s = eh
			for Y, f in ipairs(s) do
				self:add(f)
			end
		end
	end
	function eg.prototype.add(self, f)
		local dc = not self:has(f)
		if dc then
			self.size = self.size + 1
		end
		if self.firstKey == nil then
			self.firstKey = f
			self.lastKey = f
		elseif dc then
			self.nextKey[self.lastKey] = f
			self.previousKey[f] = self.lastKey
			self.lastKey = f
		end
		return self
	end
	function eg.prototype.clear(self)
		self.nextKey = {}
		self.previousKey = {}
		self.firstKey = nil
		self.lastKey = nil
		self.size = 0
	end
	function eg.prototype.delete(self, f)
		local da = self:has(f)
		if da then
			self.size = self.size - 1
			local next = self.nextKey[f]
			local db = self.previousKey[f]
			if next ~= nil and db ~= nil then
				self.nextKey[db] = next
				self.previousKey[next] = db
			elseif next ~= nil then
				self.firstKey = next
				self.previousKey[next] = nil
			elseif db ~= nil then
				self.lastKey = db
				self.nextKey[db] = nil
			else
				self.firstKey = nil
				self.lastKey = nil
			end
			self.nextKey[f] = nil
			self.previousKey[f] = nil
		end
		return da
	end
	function eg.prototype.forEach(self, aL)
		for Y, t in J(self:keys()) do
			aL(nil, t, t, self)
		end
	end
	function eg.prototype.has(self, f)
		return self.nextKey[f] ~= nil or self.lastKey == f
	end
	eg.prototype[o.iterator] = function(self)
		return self:values()
	end
	function eg.prototype.entries(self)
		local function dd()
			return self.firstKey
		end
		local de = self.nextKey
		local t
		local df = false
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not df then
					df = true
					t = dd(nil)
				else
					t = de[t]
				end
				return { done = not t, value = { t, t } }
			end,
		}
	end
	function eg.prototype.keys(self)
		local function dd()
			return self.firstKey
		end
		local de = self.nextKey
		local t
		local df = false
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not df then
					df = true
					t = dd(nil)
				else
					t = de[t]
				end
				return { done = not t, value = t }
			end,
		}
	end
	function eg.prototype.values(self)
		local function dd()
			return self.firstKey
		end
		local de = self.nextKey
		local t
		local df = false
		return {
			[o.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not df then
					df = true
					t = dd(nil)
				else
					t = de[t]
				end
				return { done = not t, value = t }
			end,
		}
	end
	function eg.prototype.union(self, ei)
		local i = aU(eg, self)
		for Y, l in J(ei) do
			i:add(l)
		end
		return i
	end
	function eg.prototype.intersection(self, ei)
		local i = aU(eg)
		for Y, l in J(self) do
			if ei:has(l) then
				i:add(l)
			end
		end
		return i
	end
	function eg.prototype.difference(self, ei)
		local i = aU(eg, self)
		for Y, l in J(ei) do
			i:delete(l)
		end
		return i
	end
	function eg.prototype.symmetricDifference(self, ei)
		local i = aU(eg, self)
		for Y, l in J(ei) do
			if self:has(l) then
				i:delete(l)
			else
				i:add(l)
			end
		end
		return i
	end
	function eg.prototype.isSubsetOf(self, ei)
		for Y, l in J(self) do
			if not ei:has(l) then
				return false
			end
		end
		return true
	end
	function eg.prototype.isSupersetOf(self, ei)
		for Y, l in J(ei) do
			if not self:has(l) then
				return false
			end
		end
		return true
	end
	function eg.prototype.isDisjointFrom(self, ei)
		for Y, l in J(self) do
			if ei:has(l) then
				return false
			end
		end
		return true
	end
	eg[o.species] = eg
end
local function ej(...)
	local ek = { ... }
	ek.sparseLength = ae(...)
	return ek
end
local function el(ek, ...)
	local ax = { ... }
	local em = ae(...)
	local en = ek.sparseLength
	for k = 1, em do
		ek[en + k] = ax[k]
	end
	ek.sparseLength = en + em
end
local function eo(ek)
	local ep = unpack or table.unpack
	return ep(ek, 1, ek.sparseLength)
end
local eq
do
	eq = b0()
	eq.name = "WeakMap"
	function eq.prototype.____constructor(self, d8)
		self[o.toStringTag] = "WeakMap"
		self.items = {}
		setmetatable(self.items, { __mode = "k" })
		if d8 == nil then
			return
		end
		local Q = d8
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
			for Y, d9 in ipairs(d8) do
				self.items[d9[1]] = d9[2]
			end
		end
	end
	function eq.prototype.delete(self, t)
		local da = self:has(t)
		self.items[t] = nil
		return da
	end
	function eq.prototype.get(self, t)
		return self.items[t]
	end
	function eq.prototype.has(self, t)
		return self.items[t] ~= nil
	end
	function eq.prototype.set(self, t, f)
		self.items[t] = f
		return self
	end
	eq[o.species] = eq
end
local er
do
	er = b0()
	er.name = "WeakSet"
	function er.prototype.____constructor(self, eh)
		self[o.toStringTag] = "WeakSet"
		self.items = {}
		setmetatable(self.items, { __mode = "k" })
		if eh == nil then
			return
		end
		local Q = eh
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
			for Y, f in ipairs(eh) do
				self.items[f] = true
			end
		end
	end
	function er.prototype.add(self, f)
		self.items[f] = true
		return self
	end
	function er.prototype.delete(self, f)
		local da = self:has(f)
		self.items[f] = nil
		return da
	end
	function er.prototype.has(self, f)
		return self.items[f] == true
	end
	er[o.species] = er
end
local function es(et, eu)
	_G.__TS__sourcemap = _G.__TS__sourcemap or {}
	_G.__TS__sourcemap[et] = eu
	if _G.__TS__originalTraceback == nil then
		local ev = debug.traceback
		_G.__TS__originalTraceback = ev
		debug.traceback = function(ew, cL, cB)
			local ex
			if ew == nil and cL == nil and cB == nil then
				ex = ev()
			elseif cq(_VERSION, "Lua 5.0") then
				ex = ev((("[Level " .. tostring(cB)) .. "] ") .. tostring(cL))
			else
				ex = ev(ew, cL, cB)
			end
			if type(ex) ~= "string" then
				return ex
			end
			local function ey(Y, ez, eA, eB)
				local eC = _G.__TS__sourcemap[ez]
				if eC ~= nil and eC[eB] ~= nil then
					local e9 = eC[eB]
					if type(e9) == "number" then
						return (eA .. ":") .. tostring(e9)
					end
					return (e9.file .. ":") .. tostring(e9.line)
				end
				return (ez .. ":") .. eB
			end
			local i = string.gsub(ex, "([^%s<]+)%.lua:(%d+)", function(ez, eB)
				return ey(nil, ez .. ".lua", ez .. ".ts", eB)
			end)
			local function eD(Y, ez, eB)
				local eC = _G.__TS__sourcemap[ez]
				if eC ~= nil and eC[eB] ~= nil then
					local eE = dj(ez, '%[string "([^"]+)"%]')
					local eF = string.gsub(eE, ".lua$", ".ts")
					local e9 = eC[eB]
					if type(e9) == "number" then
						return (eF .. ":") .. tostring(e9)
					end
					return (e9.file .. ":") .. tostring(e9.line)
				end
				return (ez .. ":") .. eB
			end
			i = string.gsub(i, '(%[string "[^"]+"%]):(%d+)', function(ez, eB)
				return eD(nil, ez, eB)
			end)
			return i
		end
	end
end
local function eG(Q)
	local V = {}
	if type(Q) == "string" then
		for k = 0, #Q - 1 do
			V[k + 1] = cT(Q, k)
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
local function eH(self, eI)
	if eI ~= eI then
		eI = 0
	end
	if eI < 0 then
		return ""
	end
	return string.sub(self, eI + 1, eI + 1)
end
local function eJ(self, P)
	if P ~= P then
		P = 0
	end
	if P < 0 then
		return 0 / 0
	end
	return string.byte(self, P + 1) or 0 / 0
end
local function eK(self, cr, eL)
	if eL == nil or eL > #self then
		eL = #self
	end
	return string.sub(self, eL - #cr + 1, eL) == cr
end
local function eM(self, eN, eO)
	if eO == nil then
		eO = " "
	end
	if eN ~= eN then
		eN = 0
	end
	if eN == -math.huge or eN == math.huge then
		error("Invalid string length", 0)
	end
	if #self >= eN or #eO == 0 then
		return self
	end
	eN = eN - #self
	if eN > #eO then
		eO = eO .. string.rep(eO, math.floor(eN / #eO))
	end
	return self .. string.sub(eO, 1, math.floor(eN))
end
local function eP(self, eN, eO)
	if eO == nil then
		eO = " "
	end
	if eN ~= eN then
		eN = 0
	end
	if eN == -math.huge or eN == math.huge then
		error("Invalid string length", 0)
	end
	if #self >= eN or #eO == 0 then
		return self
	end
	eN = eN - #self
	if eN > #eO then
		eO = eO .. string.rep(eO, math.floor(eN / #eO))
	end
	return string.sub(eO, 1, math.floor(eN)) .. self
end
local eQ
do
	local eR = string.sub
	function eQ(c6, eS, eT)
		local eU, eV = string.find(c6, eS, nil, true)
		if not eU then
			return c6
		end
		local eW = eR(c6, 1, eU - 1)
		local eX = type(eT) == "string" and eT or eT(nil, eS, eU - 1, c6)
		local eY = eR(c6, eV + 1)
		return (eW .. eX) .. eY
	end
end
local eZ
do
	local eR = string.sub
	local e_ = string.find
	function eZ(c6, a9, f0)
		if f0 == nil then
			f0 = 4294967295
		end
		if f0 == 0 then
			return {}
		end
		local i = {}
		local f1 = 1
		if a9 == nil or a9 == "" then
			for k = 1, #c6 do
				i[f1] = eR(c6, k, k)
				f1 = f1 + 1
			end
		else
			local f2 = 1
			while f1 <= f0 do
				local eU, eV = e_(c6, a9, f2, true)
				if not eU then
					break
				end
				i[f1] = eR(c6, f2, eU - 1)
				f1 = f1 + 1
				f2 = eV + 1
			end
			if f1 <= f0 then
				i[f1] = eR(c6, f2)
			end
		end
		return i
	end
end
local f3
do
	local eR = string.sub
	local e_ = string.find
	function f3(c6, eS, eT)
		if type(eT) == "string" then
			local f4 = table.concat(eZ(c6, eS), eT)
			if #eS == 0 then
				return (eT .. f4) .. eT
			end
			return f4
		end
		local aa = {}
		local f5 = 1
		if #eS == 0 then
			aa[1] = eT(nil, "", 0, c6)
			f5 = 2
			for k = 1, #c6 do
				aa[f5] = eR(c6, k, k)
				aa[f5 + 1] = eT(nil, "", k, c6)
				f5 = f5 + 2
			end
		else
			local f2 = 1
			while true do
				local eU, eV = e_(c6, eS, f2, true)
				if not eU then
					break
				end
				aa[f5] = eR(c6, f2, eU - 1)
				aa[f5 + 1] = eT(nil, eS, eU - 1, c6)
				f5 = f5 + 2
				f2 = eV + 1
			end
			aa[f5] = eR(c6, f2)
		end
		return table.concat(aa)
	end
end
local function f6(self, y, z)
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
local function f7(self, cr, cs)
	if cs == nil or cs < 0 then
		cs = 0
	end
	return string.sub(self, cs + 1, #cr + cs) == cr
end
local function f8(self, aC, aN)
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
local function f9(self)
	local i = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
	return i
end
local function fa(self)
	local i = string.gsub(self, "[%s ﻿]*$", "")
	return i
end
local function fb(self)
	local i = string.gsub(self, "^[%s ﻿]*", "")
	return i
end
local fc, fd
do
	local fe = {}
	function fc(t)
		if not fe[t] then
			fe[t] = n(t)
		end
		return fe[t]
	end
	function fd(ff)
		for t in pairs(fe) do
			if fe[t] == ff then
				return t
			end
		end
		return nil
	end
end
local function fg(f)
	local fh = type(f)
	if fh == "table" then
		return "object"
	elseif fh == "nil" then
		return "undefined"
	else
		return fh
	end
end
local function fi(self, fj, ...)
	local ax = { ... }
	local fk
	local fl, i = xpcall(function()
		return fj(aO(ax))
	end, function(bg)
		fk = bg
		return fk
	end)
	local fm = { aO(ax) }
	do
		local k = #fm - 1
		while k >= 0 do
			local fn = fm[k + 1]
			fn[o.dispose](fn)
			k = k - 1
		end
	end
	if not fl then
		error(fk, 0)
	end
	return i
end
local function fo(self, fj, ...)
	local ax = { ... }
	return by(function(fp)
		local fk
		local fl, i = xpcall(function()
			return fj(nil, aO(ax))
		end, function(bg)
			fk = bg
			return fk
		end)
		local fm = { aO(ax) }
		do
			local k = #fm - 1
			while k >= 0 do
				if fm[k + 1][o.dispose] ~= nil then
					local fn = fm[k + 1]
					fn[o.dispose](fn)
				end
				if fm[k + 1][o.asyncDispose] ~= nil then
					local fq = fm[k + 1]
					bz(fq[o.asyncDispose](fq))
				end
				k = k - 1
			end
		end
		if not fl then
			error(fk, 0)
		end
		return fp(nil, i)
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
	__TS__AsyncAwaiter = by,
	__TS__Await = bz,
	__TS__Class = b0,
	__TS__ClassExtends = bL,
	__TS__CloneDescriptor = bP,
	__TS__CountVarargs = ae,
	__TS__Decorate = bZ,
	__TS__DecorateLegacy = cl,
	__TS__DecorateParam = co,
	__TS__Delete = cS,
	__TS__DelegatedYield = cU,
	__TS__DescriptorGet = c9,
	__TS__DescriptorSet = cd,
	Error = ct,
	RangeError = cu,
	ReferenceError = cv,
	SyntaxError = cw,
	TypeError = cx,
	URIError = cy,
	__TS__FunctionBind = cV,
	__TS__Generator = cY,
	__TS__InstanceOf = aX,
	__TS__InstanceOfObject = d1,
	__TS__Iterator = J,
	__TS__LuaIteratorSpread = d3,
	Map = d7,
	__TS__MapGroupBy = dg,
	__TS__Match = dj,
	__TS__MathAtan2 = dk,
	__TS__MathModf = dl,
	__TS__MathSign = dn,
	__TS__MathTrunc = dq,
	__TS__New = aU,
	__TS__Number = dr,
	__TS__NumberIsFinite = dp,
	__TS__NumberIsInteger = du,
	__TS__NumberIsNaN = dm,
	__TS__ParseInt = dw,
	__TS__ParseFloat = dD,
	__TS__NumberToString = dF,
	__TS__NumberToFixed = dM,
	__TS__ObjectAssign = c4,
	__TS__ObjectDefineProperty = dO,
	__TS__ObjectEntries = dX,
	__TS__ObjectFromEntries = dY,
	__TS__ObjectGetOwnPropertyDescriptor = c7,
	__TS__ObjectGetOwnPropertyDescriptors = cR,
	__TS__ObjectGroupBy = d_,
	__TS__ObjectKeys = e1,
	__TS__ObjectRest = e2,
	__TS__ObjectValues = e5,
	__TS__ParseFloat = dD,
	__TS__ParseInt = dw,
	__TS__Promise = b2,
	__TS__PromiseAll = e6,
	__TS__PromiseAllSettled = ea,
	__TS__PromiseAny = eb,
	__TS__PromiseRace = ef,
	Set = eg,
	__TS__SetDescriptor = ce,
	__TS__SparseArrayNew = ej,
	__TS__SparseArrayPush = el,
	__TS__SparseArraySpread = eo,
	WeakMap = eq,
	WeakSet = er,
	__TS__SourceMapTraceBack = es,
	__TS__Spread = eG,
	__TS__StringAccess = cT,
	__TS__StringCharAt = eH,
	__TS__StringCharCodeAt = eJ,
	__TS__StringEndsWith = eK,
	__TS__StringIncludes = cq,
	__TS__StringPadEnd = eM,
	__TS__StringPadStart = eP,
	__TS__StringReplace = eQ,
	__TS__StringReplaceAll = f3,
	__TS__StringSlice = f6,
	__TS__StringSplit = eZ,
	__TS__StringStartsWith = f7,
	__TS__StringSubstr = f8,
	__TS__StringSubstring = dv,
	__TS__StringTrim = f9,
	__TS__StringTrimEnd = fa,
	__TS__StringTrimStart = fb,
	__TS__Symbol = n,
	Symbol = o,
	__TS__SymbolRegistryFor = fc,
	__TS__SymbolRegistryKeyFor = fd,
	__TS__TypeOf = fg,
	__TS__Unpack = aO,
	__TS__Using = fi,
	__TS__UsingAsync = fo,
}