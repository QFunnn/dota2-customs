--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local function a(self, b)
	local c = b < 0 and #self + b or b
	if c >= 0 and c < #self then
		return self[c + 1]
	end
	return nil
end
local function d(e)
	return type(e) == "table" and (e[1] ~= nil or next(e) == nil)
end
local function f(self, ...)
	local g = { ... }
	local h = {}
	local i = 0
	for j = 1, #self do
		i = i + 1
		h[i] = self[j]
	end
	for j = 1, #g do
		local k = g[j]
		if d(k) then
			for l = 1, #k do
				i = i + 1
				h[i] = k[l]
			end
		else
			i = i + 1
			h[i] = k
		end
	end
	return h
end
local m, n
do
	local o = {
		__tostring = function(self)
			return ("Symbol(" .. (self.description or "")) .. ")"
		end,
	}
	function m(p)
		return setmetatable({ description = p }, o)
	end
	n = {
		asyncDispose = m("Symbol.asyncDispose"),
		dispose = m("Symbol.dispose"),
		iterator = m("Symbol.iterator"),
		hasInstance = m("Symbol.hasInstance"),
		species = m("Symbol.species"),
		toStringTag = m("Symbol.toStringTag"),
	}
end
local function q(r)
	local s = 0
	return {
		[n.iterator] = function(self)
			return self
		end,
		next = function(self)
			local h = { done = r[s + 1] == nil, value = { s, r[s + 1] } }
			s = s + 1
			return h
		end,
	}
end
local function t(self, u, v)
	for j = 1, #self do
		if not u(v, self[j], j - 1, self) then
			return false
		end
	end
	return true
end
local function w(self, e, x, y)
	local z = x or 0
	local A = y or #self
	if z < 0 then
		z = z + #self
	end
	if A < 0 then
		A = A + #self
	end
	do
		local j = z
		while j < A do
			self[j + 1] = e
			j = j + 1
		end
	end
	return self
end
local function B(self, u, v)
	local h = {}
	local i = 0
	for j = 1, #self do
		if u(v, self[j], j - 1, self) then
			i = i + 1
			h[i] = self[j]
		end
	end
	return h
end
local function C(self, D, v)
	for j = 1, #self do
		D(v, self[j], j - 1, self)
	end
end
local function E(self, F, v)
	for j = 1, #self do
		local G = self[j]
		if F(v, G, j - 1, self) then
			return G
		end
	end
	return nil
end
local function H(self, D, v)
	for j = 1, #self do
		if D(v, self[j], j - 1, self) then
			return j - 1
		end
	end
	return -1
end
local I
do
	local function J(self)
		local K = self.____coroutine
		local L, e = coroutine.resume(K)
		if not L then
			error(e, 0)
		end
		if coroutine.status(K) == "dead" then
			return
		end
		return true, e
	end
	local function M(self)
		local h = self:next()
		if h.done then
			return
		end
		return true, h.value
	end
	local function N(self, O)
		O = O + 1
		if O > #self then
			return
		end
		return O, string.sub(self, O, O)
	end
	function I(P)
		if type(P) == "string" then
			return N, P, 0
		elseif P.____coroutine ~= nil then
			return J, P
		elseif P[n.iterator] then
			local Q = P[n.iterator](P)
			return M, Q
		else
			return ipairs(P)
		end
	end
end
local R
do
	local function S(self, O)
		O = O + 1
		if O > self.length then
			return
		end
		return O, self[O]
	end
	local function T(U)
		if type(U.length) == "number" then
			return S, U, 0
		end
		return I(U)
	end
	function R(V, W, v)
		local h = {}
		if W == nil then
			for X, Y in T(V) do
				h[#h + 1] = Y
			end
		else
			local j = 0
			for X, Y in T(V) do
				local Z = W
				local _ = v
				local a0 = Y
				local a1 = j
				j = a1 + 1
				h[#h + 1] = Z(_, a0, a1)
			end
		end
		return h
	end
end
local function a2(self, a3, a4)
	if a4 == nil then
		a4 = 0
	end
	local i = #self
	local a5 = a4
	if a4 < 0 then
		a5 = i + a4
	end
	if a5 < 0 then
		a5 = 0
	end
	for j = a5 + 1, i do
		if self[j] == a3 then
			return true
		end
	end
	return false
end
local function a6(self, a3, a4)
	if a4 == nil then
		a4 = 0
	end
	local i = #self
	if i == 0 then
		return -1
	end
	if a4 >= i then
		return -1
	end
	if a4 < 0 then
		a4 = i + a4
		if a4 < 0 then
			a4 = 0
		end
	end
	for j = a4 + 1, i do
		if self[j] == a3 then
			return j - 1
		end
	end
	return -1
end
local function a7(self, a8)
	if a8 == nil then
		a8 = ","
	end
	local a9 = {}
	for j = 1, #self do
		a9[j] = tostring(self[j])
	end
	return table.concat(a9, a8)
end
local function aa(self, u, v)
	local h = {}
	for j = 1, #self do
		h[j] = u(v, self[j], j - 1, self)
	end
	return h
end
local function ab(self, ...)
	local g = { ... }
	local i = #self
	for j = 1, #g do
		i = i + 1
		self[i] = g[j]
	end
	return i
end
local function ac(self, g)
	local i = #self
	for j = 1, #g do
		i = i + 1
		self[i] = g[j]
	end
	return i
end
local function ad(...)
	return select("#", ...)
end
local function ae(self, D, ...)
	local i = #self
	local a5 = 0
	local af = nil
	if ad(...) ~= 0 then
		af = ...
	elseif i > 0 then
		af = self[1]
		a5 = 1
	else
		error("Reduce of empty array with no initial value", 0)
	end
	for j = a5 + 1, i do
		af = D(nil, af, self[j], j - 1, self)
	end
	return af
end
local function ag(self, D, ...)
	local i = #self
	local a5 = i - 1
	local af = nil
	if ad(...) ~= 0 then
		af = ...
	elseif i > 0 then
		af = self[a5 + 1]
		a5 = a5 - 1
	else
		error("Reduce of empty array with no initial value", 0)
	end
	for j = a5 + 1, 1, -1 do
		af = D(nil, af, self[j], j - 1, self)
	end
	return af
end
local function ah(self)
	local j = 1
	local l = #self
	while j < l do
		local ai = self[l]
		self[l] = self[j]
		self[j] = ai
		j = j + 1
		l = l - 1
	end
	return self
end
local function aj(self, ...)
	local g = { ... }
	local ak = #g
	if ak == 0 then
		return #self
	end
	for j = #self, 1, -1 do
		self[j + ak] = self[j]
	end
	for j = 1, ak do
		self[j] = g[j]
	end
	return #self
end
local function al(self, am)
	if am ~= nil then
		table.sort(self, function(an, ao)
			return am(nil, an, ao) < 0
		end)
	else
		table.sort(self)
	end
	return self
end
local function ap(self, aq, ar)
	local i = #self
	aq = aq or 0
	if aq < 0 then
		aq = i + aq
		if aq < 0 then
			aq = 0
		end
	else
		if aq > i then
			aq = i
		end
	end
	ar = ar or i
	if ar < 0 then
		ar = i + ar
		if ar < 0 then
			ar = 0
		end
	else
		if ar > i then
			ar = i
		end
	end
	local as = {}
	aq = aq + 1
	ar = ar + 1
	local at = 1
	while aq < ar do
		as[at] = self[aq]
		aq = aq + 1
		at = at + 1
	end
	return as
end
local function au(self, u, v)
	for j = 1, #self do
		if u(v, self[j], j - 1, self) then
			return true
		end
	end
	return false
end
local function av(self, ...)
	local aw = { ... }
	local i = #self
	local ax = ad(...)
	local x = aw[1]
	local ay = aw[2]
	if x < 0 then
		x = i + x
		if x < 0 then
			x = 0
		end
	elseif x > i then
		x = i
	end
	local az = ax - 2
	if az < 0 then
		az = 0
	end
	local aA
	if ax == 0 then
		aA = 0
	elseif ax == 1 then
		aA = i - x
	else
		aA = ay or 0
		if aA < 0 then
			aA = 0
		end
		if aA > i - x then
			aA = i - x
		end
	end
	local as = {}
	for a5 = 1, aA do
		local aB = x + a5
		if self[aB] ~= nil then
			as[a5] = self[aB]
		end
	end
	if az < aA then
		for a5 = x + 1, i - aA do
			local aB = a5 + aA
			local aC = a5 + az
			if self[aB] then
				self[aC] = self[aB]
			else
				self[aC] = nil
			end
		end
		for a5 = i - aA + az + 1, i do
			self[a5] = nil
		end
	elseif az > aA then
		for a5 = i - aA, x + 1, -1 do
			local aB = a5 + aA
			local aC = a5 + az
			if self[aB] then
				self[aC] = self[aB]
			else
				self[aC] = nil
			end
		end
	end
	local l = x + 1
	for j = 3, ax do
		self[l] = aw[j]
		l = l + 1
	end
	for a5 = #self, i - aA + az + 1, -1 do
		self[a5] = nil
	end
	return as
end
local function aD(self)
	local aE = {}
	for j = 1, #self do
		aE[j - 1] = self[j]
	end
	return aE
end
local function aF(self, aG)
	if aG == nil then
		aG = 1
	end
	local h = {}
	local i = 0
	for j = 1, #self do
		local e = self[j]
		if aG > 0 and d(e) then
			local aH
			if aG == 1 then
				aH = e
			else
				aH = aF(e, aG - 1)
			end
			for l = 1, #aH do
				local aI = aH[l]
				i = i + 1
				h[i] = aI
			end
		else
			i = i + 1
			h[i] = e
		end
	end
	return h
end
local function aJ(self, aK, v)
	local h = {}
	local i = 0
	for j = 1, #self do
		local e = aK(v, self[j], j - 1, self)
		if d(e) then
			for l = 1, #e do
				i = i + 1
				h[i] = e[l]
			end
		else
			i = i + 1
			h[i] = e
		end
	end
	return h
end
local function aL(self, aM)
	if aM < 0 or aM ~= aM or aM == math.huge or math.floor(aM) ~= aM then
		error("invalid array length: " .. tostring(aM), 0)
	end
	for j = aM + 1, #self do
		self[j] = nil
	end
	return aM
end
local aN = table.unpack or unpack
local function aO(self)
	local aP = { aN(self) }
	ah(aP)
	return aP
end
local function aQ(self, am)
	local aP = { aN(self) }
	al(aP, am)
	return aP
end
local function aR(self, x, ay, ...)
	local aP = { aN(self) }
	av(aP, x, ay, ...)
	return aP
end
local function aS(self, O, e)
	local aP = { aN(self) }
	aP[O + 1] = e
	return aP
end
local function aT(aU, ...)
	local aV = setmetatable({}, aU.prototype)
	aV:____constructor(...)
	return aV
end
local function aW(aX, aY)
	if type(aY) ~= "table" then
		error("Right-hand side of 'instanceof' is not an object", 0)
	end
	if aY[n.hasInstance] ~= nil then
		return not not aY[n.hasInstance](aY, aX)
	end
	if type(aX) == "table" then
		local aZ = aX.constructor
		while aZ ~= nil do
			if aZ == aY then
				return true
			end
			aZ = aZ.____super
		end
	end
	return false
end
local function a_(self)
	local b0 = { prototype = {} }
	b0.prototype.__index = b0.prototype
	b0.prototype.constructor = b0
	return b0
end
local b1
do
	local function b2()
		local b3
		local b4
		local function b5(X, b6, b7)
			b3 = b6
			b4 = b7
		end
		return function()
			local b8 = aT(b1, b5)
			return b8, b3, b4
		end
	end
	local b9 = b2()
	local function ba(e)
		return aW(e, b1)
	end
	local function bb(self) end
	local bc = _G.pcall
	b1 = a_()
	b1.name = "__TS__Promise"
	function b1.prototype.____constructor(self, b5)
		self.state = 0
		self.fulfilledCallbacks = {}
		self.rejectedCallbacks = {}
		local bd, be = bc(b5, nil, function(X, Y)
			return self:resolve(Y)
		end, function(X, bf)
			return self:reject(bf)
		end)
		if not bd then
			self:reject(be)
		end
	end
	function b1.resolve(e)
		if aW(e, b1) then
			return e
		end
		local b8 = aT(b1, bb)
		b8.state = 1
		b8.value = e
		return b8
	end
	function b1.reject(bg)
		local b8 = aT(b1, bb)
		b8.state = 2
		b8.rejectionReason = bg
		return b8
	end
	b1.prototype["then"] = function(self, bh, bi)
		local b8, b3, b4 = b9()
		self:addCallbacks(
			bh and self:createPromiseResolvingCallback(bh, b3, b4) or b3,
			bi and self:createPromiseResolvingCallback(bi, b3, b4) or b4
		)
		return b8
	end
	function b1.prototype.addCallbacks(self, bj, bk)
		if self.state == 1 then
			return bj(nil, self.value)
		end
		if self.state == 2 then
			return bk(nil, self.rejectionReason)
		end
		local bl = self.fulfilledCallbacks
		bl[#bl + 1] = bj
		local bm = self.rejectedCallbacks
		bm[#bm + 1] = bk
	end
	function b1.prototype.catch(self, bi)
		return self["then"](self, nil, bi)
	end
	function b1.prototype.finally(self, bn)
		if type(bn) ~= "function" then
			return self["then"](self, bn, bn)
		end
		return self["then"](self, function(X, bo)
			local bp = aT(b1, function(X, b3)
				return b3(nil, bn(nil))
			end)
			return bp["then"](bp, function()
				return bo
			end)
		end, function(X, bq)
			local br = aT(b1, function(X, b3)
				return b3(nil, bn(nil))
			end)
			return br["then"](br, function()
				error(bq, 0)
			end)
		end)
	end
	function b1.prototype.resolve(self, e)
		if ba(e) then
			return e:addCallbacks(function(X, Y)
				return self:resolve(Y)
			end, function(X, bf)
				return self:reject(bf)
			end)
		end
		if self.state == 0 then
			self.state = 1
			self.value = e
			return self:invokeCallbacks(self.fulfilledCallbacks, e)
		end
	end
	function b1.prototype.reject(self, bg)
		if self.state == 0 then
			self.state = 2
			self.rejectionReason = bg
			return self:invokeCallbacks(self.rejectedCallbacks, bg)
		end
	end
	function b1.prototype.invokeCallbacks(self, bs, e)
		local bt = #bs
		if bt ~= 0 then
			for j = 1, bt - 1 do
				bs[j](bs, e)
			end
			return bs[bt](bs, e)
		end
	end
	function b1.prototype.createPromiseResolvingCallback(self, bu, b3, b4)
		return function(X, e)
			local bd, bv = bc(bu, nil, e)
			if not bd then
				return b4(nil, bv)
			end
			return self:handleCallbackValue(bv, b3, b4)
		end
	end
	function b1.prototype.handleCallbackValue(self, e, b3, b4)
		if ba(e) then
			local bw = e
			if bw.state == 1 then
				return b3(nil, bw.value)
			elseif bw.state == 2 then
				return b4(nil, bw.rejectionReason)
			else
				return bw:addCallbacks(b3, b4)
			end
		else
			return b3(nil, e)
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
		return aT(b1, function(X, b3, b4)
			local bF, bG, bH, bI
			function bF(self, e)
				local bd, bv = bB(bI, e)
				if bd then
					return bG(bv)
				end
				return b4(nil, bv)
			end
			function bG(h)
				if bH then
					return
				end
				if bC(bI) == "dead" then
					return b3(nil, h)
				end
				return b1.resolve(h):addCallbacks(bF, b4)
			end
			bH = false
			bI = bA(bE)
			local bd, bv = bB(bI, function(X, Y)
				bH = true
				return b1.resolve(Y):addCallbacks(b3, b4)
			end)
			if bd then
				return bG(bv)
			else
				return b4(nil, bv)
			end
		end)
	end
	function by(bJ)
		return bD(bJ)
	end
end
local function bK(aU, bL)
	aU.____super = bL
	local bM = setmetatable({ __index = bL }, bL)
	setmetatable(aU, bM)
	local bN = getmetatable(bL)
	if bN then
		if type(bN.__index) == "function" then
			bM.__index = bN.__index
		end
		if type(bN.__newindex) == "function" then
			bM.__newindex = bN.__newindex
		end
	end
	setmetatable(aU.prototype, bL.prototype)
	if type(bL.prototype.__index) == "function" then
		aU.prototype.__index = bL.prototype.__index
	end
	if type(bL.prototype.__newindex) == "function" then
		aU.prototype.__newindex = bL.prototype.__newindex
	end
	if type(bL.prototype.__tostring) == "function" then
		aU.prototype.__tostring = bL.prototype.__tostring
	end
end
local function bO(bP)
	local e
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
	e = bP.value
	local bV = { enumerable = bU == true, configurable = bT == true }
	local bW = bS ~= nil or bR ~= nil
	local bX = bQ ~= nil or e ~= nil
	if bW and bX then
		error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
	end
	if bS or bR then
		bV.get = bS
		bV.set = bR
	else
		bV.value = e
		bV.writable = bQ == true
	end
	return bV
end
local function bY(self, bZ, b_, c0)
	local h = bZ
	do
		local j = #b_
		while j >= 0 do
			local c1 = b_[j + 1]
			if c1 ~= nil then
				local c2 = c1(self, h, c0)
				if c2 == nil then
					c2 = h
				end
				h = c2
			end
			j = j - 1
		end
	end
	return h
end
local function c3(aU, ...)
	local c4 = { ... }
	for j = 1, #c4 do
		local c5 = c4[j]
		if type(c5) == "table" then
			for s in pairs(c5) do
				aU[s] = c5[s]
			end
		end
	end
	return aU
end
local function c6(aE, s)
	local c7 = getmetatable(aE)
	if not c7 then
		return
	end
	if not rawget(c7, "_descriptors") then
		return
	end
	return rawget(c7, "_descriptors")[s]
end
local c8
do
	local getmetatable = _G.getmetatable
	local c9 = _G.rawget
	function c8(self, c7, s)
		while c7 do
			local ca = c9(c7, s)
			if ca ~= nil then
				return ca
			end
			local cb = c9(c7, "_descriptors")
			if cb then
				local bV = cb[s]
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
	function cc(self, c7, s, e)
		while c7 do
			local cb = c9(c7, "_descriptors")
			if cb then
				local bV = cb[s]
				if bV ~= nil then
					if bV.set then
						bV.set(self, e)
					else
						if bV.writable == false then
							error(
								((("Cannot assign to read only property '" .. s) .. "' of object '") .. tostring(self))
									.. "'",
								0
							)
						end
						bV.value = e
					end
					return
				end
			end
			c7 = getmetatable(c7)
		end
		rawset(self, s, e)
	end
end
local cd
do
	local getmetatable = _G.getmetatable
	local function ce(self, s)
		return c8(self, getmetatable(self), s)
	end
	local function cf(self, s, e)
		return cc(self, getmetatable(self), s, e)
	end
	function cd(aU, s, cg, ch)
		if ch == nil then
			ch = false
		end
		local ci
		if ch then
			ci = aU
		else
			ci = getmetatable(aU)
		end
		local c7 = ci
		if not c7 then
			c7 = {}
			setmetatable(aU, c7)
		end
		if not ch and not rawget(c7, "_isOwnDescriptorMetatable") then
			local cj = {}
			cj._isOwnDescriptorMetatable = true
			setmetatable(cj, c7)
			setmetatable(aU, cj)
			c7 = cj
		end
		local e = rawget(aU, s)
		if e ~= nil then
			rawset(aU, s, nil)
		end
		if not rawget(c7, "_descriptors") then
			c7._descriptors = {}
		end
		c7._descriptors[s] = bO(cg)
		c7.__index = ce
		c7.__newindex = cf
	end
end
local function ck(b_, aU, s, cg)
	local h = aU
	do
		local j = #b_
		while j >= 0 do
			local c1 = b_[j + 1]
			if c1 ~= nil then
				local cl = h
				if s == nil then
					h = c1(nil, h)
				elseif cg == true then
					local e = rawget(aU, s)
					local bV = c6(aU, s) or { configurable = true, writable = true, value = e }
					local cg = c1(nil, aU, s, bV) or bV
					local cm = cg.configurable == true and cg.writable == true and not cg.get and not cg.set
					if cm then
						rawset(aU, s, cg.value)
					else
						cd(aU, s, c3({}, bV, cg))
					end
				elseif cg == false then
					h = c1(nil, aU, s, cg)
				else
					h = c1(nil, aU, s)
				end
				h = h or cl
			end
			j = j - 1
		end
	end
	return h
end
local function cn(co, c1)
	return function(X, aU, s)
		return c1(nil, aU, s, co)
	end
end
local function cp(self, cq, cr)
	if not cr then
		cr = 1
	else
		cr = cr + 1
	end
	local O = string.find(self, cq, cr, true)
	return O ~= nil
end
local cs, ct, cu, cv, cw, cx
do
	local function cy(self, cz)
		if debug == nil then
			return nil
		end
		local cA = 1
		while true do
			local cB = debug.getinfo(cA, "f")
			cA = cA + 1
			if not cB then
				cA = 1
				break
			elseif cB.func == cz then
				break
			end
		end
		if cp(_VERSION, "Lua 5.0") then
			return debug.traceback(("[Level " .. tostring(cA)) .. "]")
		elseif _VERSION == "Lua 5.1" then
			return string.sub(debug.traceback("", cA), 2)
		else
			return debug.traceback(nil, cA)
		end
	end
	local function cC(self, cD)
		return function(self)
			local p = cD(self)
			local cE = debug.getinfo(3, "f")
			local cF = cp(_VERSION, "Lua 5.0")
			if cF or cE and cE.func ~= error then
				return p
			else
				return (p .. "\n") .. tostring(self.stack)
			end
		end
	end
	local function cG(self, cH, cI)
		cH.name = cI
		return setmetatable(cH, {
			__call = function(X, cJ, cK)
				return aT(cH, cK)
			end,
		})
	end
	local cL = cG
	local cM = a_()
	cM.name = ""
	function cM.prototype.____constructor(self, cK)
		if cK == nil then
			cK = ""
		end
		self.message = cK
		self.name = "Error"
		self.stack = cy(nil, aT)
		local c7 = getmetatable(self)
		if c7 and not c7.__errorToStringPatched then
			c7.__errorToStringPatched = true
			c7.__tostring = cC(nil, c7.__tostring)
		end
	end
	function cM.prototype.__tostring(self)
		return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
	end
	cs = cL(nil, cM, "Error")
	local function cN(self, cI)
		local cO = cG
		local cP = a_()
		cP.name = cP.name
		bK(cP, cs)
		function cP.prototype.____constructor(self, ...)
			cP.____super.prototype.____constructor(self, ...)
			self.name = cI
		end
		return cO(nil, cP, cI)
	end
	ct = cN(nil, "RangeError")
	cu = cN(nil, "ReferenceError")
	cv = cN(nil, "SyntaxError")
	cw = cN(nil, "TypeError")
	cx = cN(nil, "URIError")
end
local function cQ(aE)
	local c7 = getmetatable(aE)
	if not c7 then
		return {}
	end
	return rawget(c7, "_descriptors") or {}
end
local function cR(aU, s)
	local cb = cQ(aU)
	local bV = cb[s]
	if bV then
		if not bV.configurable then
			error(aT(cw, ((("Cannot delete property " .. tostring(s)) .. " of ") .. tostring(aU)) .. "."), 0)
		end
		cb[s] = nil
		return true
	end
	aU[s] = nil
	return true
end
local function cS(self, O)
	if O >= 0 and O < #self then
		return string.sub(self, O + 1, O + 1)
	end
end
local function cT(P)
	if type(P) == "string" then
		for O = 0, #P - 1 do
			coroutine.yield(cS(P, O))
		end
	elseif P.____coroutine ~= nil then
		local K = P.____coroutine
		while true do
			local L, e = coroutine.resume(K)
			if not L then
				error(e, 0)
			end
			if coroutine.status(K) == "dead" then
				return e
			else
				coroutine.yield(e)
			end
		end
	elseif P[n.iterator] then
		local Q = P[n.iterator](P)
		while true do
			local h = Q:next()
			if h.done then
				return h.value
			else
				coroutine.yield(h.value)
			end
		end
	else
		for X, e in ipairs(P) do
			coroutine.yield(e)
		end
	end
end
local function cU(cV, ...)
	local cW = { ... }
	return function(X, ...)
		local aw = { ... }
		aj(aw, aN(cW))
		return cV(aN(aw))
	end
end
local cX
do
	local function cY(self)
		return self
	end
	local function cZ(self, ...)
		local K = self.____coroutine
		if coroutine.status(K) == "dead" then
			return { done = true }
		end
		local L, e = coroutine.resume(K, ...)
		if not L then
			error(e, 0)
		end
		return { value = e, done = coroutine.status(K) == "dead" }
	end
	function cX(cV)
		return function(...)
			local aw = { ... }
			local c_ = ad(...)
			return { ____coroutine = coroutine.create(function()
				return cV(aN(aw, 1, c_))
			end), [n.iterator] = cY, next = cZ }
		end
	end
end
local function d0(e)
	local d1 = type(e)
	return d1 == "table" or d1 == "function"
end
local function d2(self, d3, d4)
	local d5 = {}
	local s, e = self(d3, d4)
	while s do
		d5[#d5 + 1] = { s, e }
		s, e = self(d3, s)
	end
	return aN(d5)
end
local d6
do
	d6 = a_()
	d6.name = "Map"
	function d6.prototype.____constructor(self, d7)
		self[n.toStringTag] = "Map"
		self.items = {}
		self.size = 0
		self.nextKey = {}
		self.previousKey = {}
		if d7 == nil then
			return
		end
		local P = d7
		if P[n.iterator] then
			local Q = P[n.iterator](P)
			while true do
				local h = Q:next()
				if h.done then
					break
				end
				local e = h.value
				self:set(e[1], e[2])
			end
		else
			local r = d7
			for X, d8 in ipairs(r) do
				self:set(d8[1], d8[2])
			end
		end
	end
	function d6.prototype.clear(self)
		self.items = {}
		self.nextKey = {}
		self.previousKey = {}
		self.firstKey = nil
		self.lastKey = nil
		self.size = 0
	end
	function d6.prototype.delete(self, s)
		local d9 = self:has(s)
		if d9 then
			self.size = self.size - 1
			local next = self.nextKey[s]
			local da = self.previousKey[s]
			if next ~= nil and da ~= nil then
				self.nextKey[da] = next
				self.previousKey[next] = da
			elseif next ~= nil then
				self.firstKey = next
				self.previousKey[next] = nil
			elseif da ~= nil then
				self.lastKey = da
				self.nextKey[da] = nil
			else
				self.firstKey = nil
				self.lastKey = nil
			end
			self.nextKey[s] = nil
			self.previousKey[s] = nil
		end
		self.items[s] = nil
		return d9
	end
	function d6.prototype.forEach(self, aK)
		for X, s in I(self:keys()) do
			aK(nil, self.items[s], s, self)
		end
	end
	function d6.prototype.get(self, s)
		return self.items[s]
	end
	function d6.prototype.has(self, s)
		return self.nextKey[s] ~= nil or self.lastKey == s
	end
	function d6.prototype.set(self, s, e)
		local db = not self:has(s)
		if db then
			self.size = self.size + 1
		end
		self.items[s] = e
		if self.firstKey == nil then
			self.firstKey = s
			self.lastKey = s
		elseif db then
			self.nextKey[self.lastKey] = s
			self.previousKey[s] = self.lastKey
			self.lastKey = s
		end
		return self
	end
	d6.prototype[n.iterator] = function(self)
		return self:entries()
	end
	function d6.prototype.entries(self)
		local function dc()
			return self.firstKey
		end
		local g = self.items
		local dd = self.nextKey
		local s
		local de = false
		return {
			[n.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not de then
					de = true
					s = dc(nil)
				else
					s = dd[s]
				end
				return { done = not s, value = { s, g[s] } }
			end,
		}
	end
	function d6.prototype.keys(self)
		local function dc()
			return self.firstKey
		end
		local dd = self.nextKey
		local s
		local de = false
		return {
			[n.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not de then
					de = true
					s = dc(nil)
				else
					s = dd[s]
				end
				return { done = not s, value = s }
			end,
		}
	end
	function d6.prototype.values(self)
		local function dc()
			return self.firstKey
		end
		local g = self.items
		local dd = self.nextKey
		local s
		local de = false
		return {
			[n.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not de then
					de = true
					s = dc(nil)
				else
					s = dd[s]
				end
				return { done = not s, value = g[s] }
			end,
		}
	end
	d6[n.species] = d6
end
local function df(g, dg)
	local h = aT(d6)
	local j = 0
	for X, k in I(g) do
		local s = dg(nil, k, j)
		if h:has(s) then
			local dh = h:get(s)
			dh[#dh + 1] = k
		else
			h:set(s, { k })
		end
		j = j + 1
	end
	return h
end
local di = string.match
local dj = math.atan2 or math.atan
local dk = math.modf
local function dl(e)
	return e ~= e
end
local function dm(aI)
	if dl(aI) or aI == 0 then
		return aI
	end
	if aI < 0 then
		return -1
	end
	return 1
end
local function dn(e)
	return type(e) == "number" and e == e and e ~= math.huge and e ~= -math.huge
end
local function dp(aI)
	if not dn(aI) or aI == 0 then
		return aI
	end
	return aI > 0 and math.floor(aI) or math.ceil(aI)
end
local function dq(e)
	local d1 = type(e)
	if d1 == "number" then
		return e
	elseif d1 == "string" then
		local dr = tonumber(e)
		if dr then
			return dr
		end
		if e == "Infinity" then
			return math.huge
		end
		if e == "-Infinity" then
			return -math.huge
		end
		local ds = string.gsub(e, "%s", "")
		if ds == "" then
			return 0
		end
		return 0 / 0
	elseif d1 == "boolean" then
		return e and 1 or 0
	else
		return 0 / 0
	end
end
local function dt(e)
	return dn(e) and math.floor(e) == e
end
local function du(self, x, y)
	if y ~= y then
		y = 0
	end
	if y ~= nil and x > y then
		x, y = y, x
	end
	if x >= 0 then
		x = x + 1
	else
		x = 1
	end
	if y ~= nil and y < 0 then
		y = 0
	end
	return string.sub(self, x, y)
end
local dv
do
	local dw = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
	function dv(dx, bL)
		if bL == nil then
			bL = 10
			local dy = di(dx, "^%s*-?0[xX]")
			if dy ~= nil then
				bL = 16
				dx = di(dy, "-") and "-" .. du(dx, #dy) or du(dx, #dy)
			end
		end
		if bL < 2 or bL > 36 then
			return 0 / 0
		end
		local dz = bL <= 10 and du(dw, 0, bL) or du(dw, 0, 10 + 2 * (bL - 10))
		local dA = ("^%s*(-?[" .. dz) .. "]*)"
		local dB = tonumber(di(dx, dA), bL)
		if dB == nil then
			return 0 / 0
		end
		if dB >= 0 then
			return math.floor(dB)
		else
			return math.ceil(dB)
		end
	end
end
local function dC(dx)
	local dD = di(dx, "^%s*(-?Infinity)")
	if dD ~= nil then
		return cS(dD, 0) == "-" and -math.huge or math.huge
	end
	local dB = tonumber(di(dx, "^%s*(-?%d+%.?%d*)"))
	return dB or 0 / 0
end
local dE
do
	local dF = "0123456789abcdefghijklmnopqrstuvwxyz"
	function dE(self, dG)
		if dG == nil or dG == 10 or self == math.huge or self == -math.huge or self ~= self then
			return tostring(self)
		end
		dG = math.floor(dG)
		if dG < 2 or dG > 36 then
			error("toString() radix argument must be between 2 and 36", 0)
		end
		local dH, dI = dk(math.abs(self))
		local h = ""
		if dG == 8 then
			h = string.format("%o", dH)
		elseif dG == 16 then
			h = string.format("%x", dH)
		else
			repeat
				do
					h = cS(dF, dH % dG) .. h
					dH = math.floor(dH / dG)
				end
			until not (dH ~= 0)
		end
		if dI ~= 0 then
			h = h .. "."
			local dJ = 1e-16
			repeat
				do
					dI = dI * dG
					dJ = dJ * dG
					local dK = math.floor(dI)
					h = h .. cS(dF, dK)
					dI = dI - dK
				end
			until not (dI >= dJ)
		end
		if self < 0 then
			h = "-" .. h
		end
		return h
	end
end
local function dL(self, dM)
	if math.abs(self) >= 1e+21 or self ~= self then
		return tostring(self)
	end
	local bu = math.floor(dM or 0)
	if bu < 0 or bu > 99 then
		error("toFixed() digits argument must be between 0 and 99", 0)
	end
	return string.format(("%." .. tostring(bu)) .. "f", self)
end
local function dN(aU, s, cg)
	local dO = type(s) == "number" and s + 1 or s
	local e = rawget(aU, dO)
	local bW = cg.get ~= nil or cg.set ~= nil
	local bV
	if bW then
		if e ~= nil then
			error("Cannot redefine property: " .. tostring(s), 0)
		end
		bV = cg
	else
		local dP = e ~= nil
		local dQ = cg.set
		local dR = cg.get
		local dS = cg.configurable
		if dS == nil then
			dS = dP
		end
		local dT = cg.enumerable
		if dT == nil then
			dT = dP
		end
		local dU = cg.writable
		if dU == nil then
			dU = dP
		end
		local dV
		if cg.value ~= nil then
			dV = cg.value
		else
			dV = e
		end
		bV = { set = dQ, get = dR, configurable = dS, enumerable = dT, writable = dU, value = dV }
	end
	cd(aU, dO, bV)
	return aU
end
local function dW(aX)
	local h = {}
	local i = 0
	for s in pairs(aX) do
		i = i + 1
		h[i] = { s, aX[s] }
	end
	return h
end
local function dX(d7)
	local aX = {}
	local P = d7
	if P[n.iterator] then
		local Q = P[n.iterator](P)
		while true do
			local h = Q:next()
			if h.done then
				break
			end
			local e = h.value
			aX[e[1]] = e[2]
		end
	else
		for X, dY in ipairs(d7) do
			aX[dY[1]] = dY[2]
		end
	end
	return aX
end
local function dZ(g, dg)
	local h = {}
	local j = 0
	for X, k in I(g) do
		local s = dg(nil, k, j)
		if h[s] ~= nil then
			local d_ = h[s]
			d_[#d_ + 1] = k
		else
			h[s] = { k }
		end
		j = j + 1
	end
	return h
end
local function e0(aX)
	local h = {}
	local i = 0
	for s in pairs(aX) do
		i = i + 1
		h[i] = s
	end
	return h
end
local function e1(aU, e2)
	local h = {}
	for e3 in pairs(aU) do
		if not e2[e3] then
			h[e3] = aU[e3]
		end
	end
	return h
end
local function e4(aX)
	local h = {}
	local i = 0
	for s in pairs(aX) do
		i = i + 1
		h[i] = aX[s]
	end
	return h
end
local function e5(P)
	local d5 = {}
	local e6 = {}
	local e7 = 0
	local j = 0
	for X, k in I(P) do
		if aW(k, b1) then
			if k.state == 1 then
				d5[j + 1] = k.value
			elseif k.state == 2 then
				return b1.reject(k.rejectionReason)
			else
				e7 = e7 + 1
				e6[j] = k
			end
		else
			d5[j + 1] = k
		end
		j = j + 1
	end
	if e7 == 0 then
		return b1.resolve(d5)
	end
	return aT(b1, function(X, b3, b4)
		for O, b8 in pairs(e6) do
			b8["then"](b8, function(X, e8)
				d5[O + 1] = e8
				e7 = e7 - 1
				if e7 == 0 then
					b3(nil, d5)
				end
			end, function(X, bg)
				b4(nil, bg)
			end)
		end
	end)
end
local function e9(P)
	local d5 = {}
	local e6 = {}
	local e7 = 0
	local j = 0
	for X, k in I(P) do
		if aW(k, b1) then
			if k.state == 1 then
				d5[j + 1] = { status = "fulfilled", value = k.value }
			elseif k.state == 2 then
				d5[j + 1] = { status = "rejected", reason = k.rejectionReason }
			else
				e7 = e7 + 1
				e6[j] = k
			end
		else
			d5[j + 1] = { status = "fulfilled", value = k }
		end
		j = j + 1
	end
	if e7 == 0 then
		return b1.resolve(d5)
	end
	return aT(b1, function(X, b3)
		for O, b8 in pairs(e6) do
			b8["then"](b8, function(X, e8)
				d5[O + 1] = { status = "fulfilled", value = e8 }
				e7 = e7 - 1
				if e7 == 0 then
					b3(nil, d5)
				end
			end, function(X, bg)
				d5[O + 1] = { status = "rejected", reason = bg }
				e7 = e7 - 1
				if e7 == 0 then
					b3(nil, d5)
				end
			end)
		end
	end)
end
local function ea(P)
	local eb = {}
	local ec = {}
	for X, k in I(P) do
		if aW(k, b1) then
			if k.state == 1 then
				return b1.resolve(k.value)
			elseif k.state == 2 then
				eb[#eb + 1] = k.rejectionReason
			else
				ec[#ec + 1] = k
			end
		else
			return b1.resolve(k)
		end
	end
	if #ec == 0 then
		return b1.reject("No promises to resolve with .any()")
	end
	local ed = 0
	return aT(b1, function(X, b3, b4)
		for X, b8 in ipairs(ec) do
			b8["then"](b8, function(X, e8)
				b3(nil, e8)
			end, function(X, bg)
				eb[#eb + 1] = bg
				ed = ed + 1
				if ed == #ec then
					b4(nil, { name = "AggregateError", message = "All Promises rejected", errors = eb })
				end
			end)
		end
	end)
end
local function ee(P)
	local ec = {}
	for X, k in I(P) do
		if aW(k, b1) then
			if k.state == 1 then
				return b1.resolve(k.value)
			elseif k.state == 2 then
				return b1.reject(k.rejectionReason)
			else
				ec[#ec + 1] = k
			end
		else
			return b1.resolve(k)
		end
	end
	return aT(b1, function(X, b3, b4)
		for X, b8 in ipairs(ec) do
			b8["then"](b8, function(X, e)
				return b3(nil, e)
			end, function(X, bg)
				return b4(nil, bg)
			end)
		end
	end)
end
local ef
do
	ef = a_()
	ef.name = "Set"
	function ef.prototype.____constructor(self, eg)
		self[n.toStringTag] = "Set"
		self.size = 0
		self.nextKey = {}
		self.previousKey = {}
		if eg == nil then
			return
		end
		local P = eg
		if P[n.iterator] then
			local Q = P[n.iterator](P)
			while true do
				local h = Q:next()
				if h.done then
					break
				end
				self:add(h.value)
			end
		else
			local r = eg
			for X, e in ipairs(r) do
				self:add(e)
			end
		end
	end
	function ef.prototype.add(self, e)
		local db = not self:has(e)
		if db then
			self.size = self.size + 1
		end
		if self.firstKey == nil then
			self.firstKey = e
			self.lastKey = e
		elseif db then
			self.nextKey[self.lastKey] = e
			self.previousKey[e] = self.lastKey
			self.lastKey = e
		end
		return self
	end
	function ef.prototype.clear(self)
		self.nextKey = {}
		self.previousKey = {}
		self.firstKey = nil
		self.lastKey = nil
		self.size = 0
	end
	function ef.prototype.delete(self, e)
		local d9 = self:has(e)
		if d9 then
			self.size = self.size - 1
			local next = self.nextKey[e]
			local da = self.previousKey[e]
			if next ~= nil and da ~= nil then
				self.nextKey[da] = next
				self.previousKey[next] = da
			elseif next ~= nil then
				self.firstKey = next
				self.previousKey[next] = nil
			elseif da ~= nil then
				self.lastKey = da
				self.nextKey[da] = nil
			else
				self.firstKey = nil
				self.lastKey = nil
			end
			self.nextKey[e] = nil
			self.previousKey[e] = nil
		end
		return d9
	end
	function ef.prototype.forEach(self, aK)
		for X, s in I(self:keys()) do
			aK(nil, s, s, self)
		end
	end
	function ef.prototype.has(self, e)
		return self.nextKey[e] ~= nil or self.lastKey == e
	end
	ef.prototype[n.iterator] = function(self)
		return self:values()
	end
	function ef.prototype.entries(self)
		local function dc()
			return self.firstKey
		end
		local dd = self.nextKey
		local s
		local de = false
		return {
			[n.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not de then
					de = true
					s = dc(nil)
				else
					s = dd[s]
				end
				return { done = not s, value = { s, s } }
			end,
		}
	end
	function ef.prototype.keys(self)
		local function dc()
			return self.firstKey
		end
		local dd = self.nextKey
		local s
		local de = false
		return {
			[n.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not de then
					de = true
					s = dc(nil)
				else
					s = dd[s]
				end
				return { done = not s, value = s }
			end,
		}
	end
	function ef.prototype.values(self)
		local function dc()
			return self.firstKey
		end
		local dd = self.nextKey
		local s
		local de = false
		return {
			[n.iterator] = function(self)
				return self
			end,
			next = function(self)
				if not de then
					de = true
					s = dc(nil)
				else
					s = dd[s]
				end
				return { done = not s, value = s }
			end,
		}
	end
	function ef.prototype.union(self, eh)
		local h = aT(ef, self)
		for X, k in I(eh) do
			h:add(k)
		end
		return h
	end
	function ef.prototype.intersection(self, eh)
		local h = aT(ef)
		for X, k in I(self) do
			if eh:has(k) then
				h:add(k)
			end
		end
		return h
	end
	function ef.prototype.difference(self, eh)
		local h = aT(ef, self)
		for X, k in I(eh) do
			h:delete(k)
		end
		return h
	end
	function ef.prototype.symmetricDifference(self, eh)
		local h = aT(ef, self)
		for X, k in I(eh) do
			if self:has(k) then
				h:delete(k)
			else
				h:add(k)
			end
		end
		return h
	end
	function ef.prototype.isSubsetOf(self, eh)
		for X, k in I(self) do
			if not eh:has(k) then
				return false
			end
		end
		return true
	end
	function ef.prototype.isSupersetOf(self, eh)
		for X, k in I(eh) do
			if not self:has(k) then
				return false
			end
		end
		return true
	end
	function ef.prototype.isDisjointFrom(self, eh)
		for X, k in I(self) do
			if eh:has(k) then
				return false
			end
		end
		return true
	end
	ef[n.species] = ef
end
local function ei(...)
	local ej = { ... }
	ej.sparseLength = ad(...)
	return ej
end
local function ek(ej, ...)
	local aw = { ... }
	local el = ad(...)
	local em = ej.sparseLength
	for j = 1, el do
		ej[em + j] = aw[j]
	end
	ej.sparseLength = em + el
end
local function en(ej)
	local eo = unpack or table.unpack
	return eo(ej, 1, ej.sparseLength)
end
local ep
do
	ep = a_()
	ep.name = "WeakMap"
	function ep.prototype.____constructor(self, d7)
		self[n.toStringTag] = "WeakMap"
		self.items = {}
		setmetatable(self.items, { __mode = "k" })
		if d7 == nil then
			return
		end
		local P = d7
		if P[n.iterator] then
			local Q = P[n.iterator](P)
			while true do
				local h = Q:next()
				if h.done then
					break
				end
				local e = h.value
				self.items[e[1]] = e[2]
			end
		else
			for X, d8 in ipairs(d7) do
				self.items[d8[1]] = d8[2]
			end
		end
	end
	function ep.prototype.delete(self, s)
		local d9 = self:has(s)
		self.items[s] = nil
		return d9
	end
	function ep.prototype.get(self, s)
		return self.items[s]
	end
	function ep.prototype.has(self, s)
		return self.items[s] ~= nil
	end
	function ep.prototype.set(self, s, e)
		self.items[s] = e
		return self
	end
	ep[n.species] = ep
end
local eq
do
	eq = a_()
	eq.name = "WeakSet"
	function eq.prototype.____constructor(self, eg)
		self[n.toStringTag] = "WeakSet"
		self.items = {}
		setmetatable(self.items, { __mode = "k" })
		if eg == nil then
			return
		end
		local P = eg
		if P[n.iterator] then
			local Q = P[n.iterator](P)
			while true do
				local h = Q:next()
				if h.done then
					break
				end
				self.items[h.value] = true
			end
		else
			for X, e in ipairs(eg) do
				self.items[e] = true
			end
		end
	end
	function eq.prototype.add(self, e)
		self.items[e] = true
		return self
	end
	function eq.prototype.delete(self, e)
		local d9 = self:has(e)
		self.items[e] = nil
		return d9
	end
	function eq.prototype.has(self, e)
		return self.items[e] == true
	end
	eq[n.species] = eq
end
local function er(es, et)
	_G.__TS__sourcemap = _G.__TS__sourcemap or {}
	_G.__TS__sourcemap[es] = et
	if _G.__TS__originalTraceback == nil then
		local eu = debug.traceback
		_G.__TS__originalTraceback = eu
		debug.traceback = function(ev, cK, cA)
			local ew
			if ev == nil and cK == nil and cA == nil then
				ew = eu()
			elseif cp(_VERSION, "Lua 5.0") then
				ew = eu((("[Level " .. tostring(cA)) .. "] ") .. tostring(cK))
			else
				ew = eu(ev, cK, cA)
			end
			if type(ew) ~= "string" then
				return ew
			end
			local function ex(X, ey, ez, eA)
				local eB = _G.__TS__sourcemap[ey]
				if eB ~= nil and eB[eA] ~= nil then
					local e8 = eB[eA]
					if type(e8) == "number" then
						return (ez .. ":") .. tostring(e8)
					end
					return (e8.file .. ":") .. tostring(e8.line)
				end
				return (ey .. ":") .. eA
			end
			local h = string.gsub(ew, "([^%s<]+)%.lua:(%d+)", function(ey, eA)
				return ex(nil, ey .. ".lua", ey .. ".ts", eA)
			end)
			local function eC(X, ey, eA)
				local eB = _G.__TS__sourcemap[ey]
				if eB ~= nil and eB[eA] ~= nil then
					local eD = di(ey, '%[string "([^"]+)"%]')
					local eE = string.gsub(eD, ".lua$", ".ts")
					local e8 = eB[eA]
					if type(e8) == "number" then
						return (eE .. ":") .. tostring(e8)
					end
					return (e8.file .. ":") .. tostring(e8.line)
				end
				return (ey .. ":") .. eA
			end
			h = string.gsub(h, '(%[string "[^"]+"%]):(%d+)', function(ey, eA)
				return eC(nil, ey, eA)
			end)
			return h
		end
	end
end
local function eF(P)
	local U = {}
	if type(P) == "string" then
		for j = 0, #P - 1 do
			U[j + 1] = cS(P, j)
		end
	else
		local i = 0
		for X, k in I(P) do
			i = i + 1
			U[i] = k
		end
	end
	return aN(U)
end
local function eG(self, eH)
	if eH ~= eH then
		eH = 0
	end
	if eH < 0 then
		return ""
	end
	return string.sub(self, eH + 1, eH + 1)
end
local function eI(self, O)
	if O ~= O then
		O = 0
	end
	if O < 0 then
		return 0 / 0
	end
	return string.byte(self, O + 1) or 0 / 0
end
local function eJ(self, cq, eK)
	if eK == nil or eK > #self then
		eK = #self
	end
	return string.sub(self, eK - #cq + 1, eK) == cq
end
local function eL(self, eM, eN)
	if eN == nil then
		eN = " "
	end
	if eM ~= eM then
		eM = 0
	end
	if eM == -math.huge or eM == math.huge then
		error("Invalid string length", 0)
	end
	if #self >= eM or #eN == 0 then
		return self
	end
	eM = eM - #self
	if eM > #eN then
		eN = eN .. string.rep(eN, math.floor(eM / #eN))
	end
	return self .. string.sub(eN, 1, math.floor(eM))
end
local function eO(self, eM, eN)
	if eN == nil then
		eN = " "
	end
	if eM ~= eM then
		eM = 0
	end
	if eM == -math.huge or eM == math.huge then
		error("Invalid string length", 0)
	end
	if #self >= eM or #eN == 0 then
		return self
	end
	eM = eM - #self
	if eM > #eN then
		eN = eN .. string.rep(eN, math.floor(eM / #eN))
	end
	return string.sub(eN, 1, math.floor(eM)) .. self
end
local eP
do
	local eQ = string.sub
	function eP(c5, eR, eS)
		local eT, eU = string.find(c5, eR, nil, true)
		if not eT then
			return c5
		end
		local eV = eQ(c5, 1, eT - 1)
		local eW = type(eS) == "string" and eS or eS(nil, eR, eT - 1, c5)
		local eX = eQ(c5, eU + 1)
		return (eV .. eW) .. eX
	end
end
local eY
do
	local eQ = string.sub
	local eZ = string.find
	function eY(c5, a8, e_)
		if e_ == nil then
			e_ = 4294967295
		end
		if e_ == 0 then
			return {}
		end
		local h = {}
		local f0 = 1
		if a8 == nil or a8 == "" then
			for j = 1, #c5 do
				h[f0] = eQ(c5, j, j)
				f0 = f0 + 1
			end
		else
			local f1 = 1
			while f0 <= e_ do
				local eT, eU = eZ(c5, a8, f1, true)
				if not eT then
					break
				end
				h[f0] = eQ(c5, f1, eT - 1)
				f0 = f0 + 1
				f1 = eU + 1
			end
			if f0 <= e_ then
				h[f0] = eQ(c5, f1)
			end
		end
		return h
	end
end
local f2
do
	local eQ = string.sub
	local eZ = string.find
	function f2(c5, eR, eS)
		if type(eS) == "string" then
			local f3 = table.concat(eY(c5, eR), eS)
			if #eR == 0 then
				return (eS .. f3) .. eS
			end
			return f3
		end
		local a9 = {}
		local f4 = 1
		if #eR == 0 then
			a9[1] = eS(nil, "", 0, c5)
			f4 = 2
			for j = 1, #c5 do
				a9[f4] = eQ(c5, j, j)
				a9[f4 + 1] = eS(nil, "", j, c5)
				f4 = f4 + 2
			end
		else
			local f1 = 1
			while true do
				local eT, eU = eZ(c5, eR, f1, true)
				if not eT then
					break
				end
				a9[f4] = eQ(c5, f1, eT - 1)
				a9[f4 + 1] = eS(nil, eR, eT - 1, c5)
				f4 = f4 + 2
				f1 = eU + 1
			end
			a9[f4] = eQ(c5, f1)
		end
		return table.concat(a9)
	end
end
local function f5(self, x, y)
	if x == nil or x ~= x then
		x = 0
	end
	if y ~= y then
		y = 0
	end
	if x >= 0 then
		x = x + 1
	end
	if y ~= nil and y < 0 then
		y = y - 1
	end
	return string.sub(self, x, y)
end
local function f6(self, cq, cr)
	if cr == nil or cr < 0 then
		cr = 0
	end
	return string.sub(self, cr + 1, #cq + cr) == cq
end
local function f7(self, aB, aM)
	if aB ~= aB then
		aB = 0
	end
	if aM ~= nil then
		if aM ~= aM or aM <= 0 then
			return ""
		end
		aM = aM + aB
	end
	if aB >= 0 then
		aB = aB + 1
	end
	return string.sub(self, aB, aM)
end
local function f8(self)
	local h = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
	return h
end
local function f9(self)
	local h = string.gsub(self, "[%s ﻿]*$", "")
	return h
end
local function fa(self)
	local h = string.gsub(self, "^[%s ﻿]*", "")
	return h
end
local fb, fc
do
	local fd = {}
	function fb(s)
		if not fd[s] then
			fd[s] = m(s)
		end
		return fd[s]
	end
	function fc(fe)
		for s in pairs(fd) do
			if fd[s] == fe then
				return s
			end
		end
		return nil
	end
end
local function ff(e)
	local fg = type(e)
	if fg == "table" then
		return "object"
	elseif fg == "nil" then
		return "undefined"
	else
		return fg
	end
end
local function fh(self, fi, ...)
	local aw = { ... }
	local fj
	local fk, h = xpcall(function()
		return fi(aN(aw))
	end, function(bf)
		fj = bf
		return fj
	end)
	local fl = { aN(aw) }
	do
		local j = #fl - 1
		while j >= 0 do
			local fm = fl[j + 1]
			fm[n.dispose](fm)
			j = j - 1
		end
	end
	if not fk then
		error(fj, 0)
	end
	return h
end
local function fn(self, fi, ...)
	local aw = { ... }
	return bx(function(fo)
		local fj
		local fk, h = xpcall(function()
			return fi(nil, aN(aw))
		end, function(bf)
			fj = bf
			return fj
		end)
		local fl = { aN(aw) }
		do
			local j = #fl - 1
			while j >= 0 do
				if fl[j + 1][n.dispose] ~= nil then
					local fm = fl[j + 1]
					fm[n.dispose](fm)
				end
				if fl[j + 1][n.asyncDispose] ~= nil then
					local fp = fl[j + 1]
					by(fp[n.asyncDispose](fp))
				end
				j = j - 1
			end
		end
		if not fk then
			error(fj, 0)
		end
		return fo(nil, h)
	end)
end
return {
	__TS__ArrayAt = a,
	__TS__ArrayConcat = f,
	__TS__ArrayEntries = q,
	__TS__ArrayEvery = t,
	__TS__ArrayFill = w,
	__TS__ArrayFilter = B,
	__TS__ArrayForEach = C,
	__TS__ArrayFind = E,
	__TS__ArrayFindIndex = H,
	__TS__ArrayFrom = R,
	__TS__ArrayIncludes = a2,
	__TS__ArrayIndexOf = a6,
	__TS__ArrayIsArray = d,
	__TS__ArrayJoin = a7,
	__TS__ArrayMap = aa,
	__TS__ArrayPush = ab,
	__TS__ArrayPushArray = ac,
	__TS__ArrayReduce = ae,
	__TS__ArrayReduceRight = ag,
	__TS__ArrayReverse = ah,
	__TS__ArrayUnshift = aj,
	__TS__ArraySort = al,
	__TS__ArraySlice = ap,
	__TS__ArraySome = au,
	__TS__ArraySplice = av,
	__TS__ArrayToObject = aD,
	__TS__ArrayFlat = aF,
	__TS__ArrayFlatMap = aJ,
	__TS__ArraySetLength = aL,
	__TS__ArrayToReversed = aO,
	__TS__ArrayToSorted = aQ,
	__TS__ArrayToSpliced = aR,
	__TS__ArrayWith = aS,
	__TS__AsyncAwaiter = bx,
	__TS__Await = by,
	__TS__Class = a_,
	__TS__ClassExtends = bK,
	__TS__CloneDescriptor = bO,
	__TS__CountVarargs = ad,
	__TS__Decorate = bY,
	__TS__DecorateLegacy = ck,
	__TS__DecorateParam = cn,
	__TS__Delete = cR,
	__TS__DelegatedYield = cT,
	__TS__DescriptorGet = c8,
	__TS__DescriptorSet = cc,
	Error = cs,
	RangeError = ct,
	ReferenceError = cu,
	SyntaxError = cv,
	TypeError = cw,
	URIError = cx,
	__TS__FunctionBind = cU,
	__TS__Generator = cX,
	__TS__InstanceOf = aW,
	__TS__InstanceOfObject = d0,
	__TS__Iterator = I,
	__TS__LuaIteratorSpread = d2,
	Map = d6,
	__TS__MapGroupBy = df,
	__TS__Match = di,
	__TS__MathAtan2 = dj,
	__TS__MathModf = dk,
	__TS__MathSign = dm,
	__TS__MathTrunc = dp,
	__TS__New = aT,
	__TS__Number = dq,
	__TS__NumberIsFinite = dn,
	__TS__NumberIsInteger = dt,
	__TS__NumberIsNaN = dl,
	__TS__ParseInt = dv,
	__TS__ParseFloat = dC,
	__TS__NumberToString = dE,
	__TS__NumberToFixed = dL,
	__TS__ObjectAssign = c3,
	__TS__ObjectDefineProperty = dN,
	__TS__ObjectEntries = dW,
	__TS__ObjectFromEntries = dX,
	__TS__ObjectGetOwnPropertyDescriptor = c6,
	__TS__ObjectGetOwnPropertyDescriptors = cQ,
	__TS__ObjectGroupBy = dZ,
	__TS__ObjectKeys = e0,
	__TS__ObjectRest = e1,
	__TS__ObjectValues = e4,
	__TS__ParseFloat = dC,
	__TS__ParseInt = dv,
	__TS__Promise = b1,
	__TS__PromiseAll = e5,
	__TS__PromiseAllSettled = e9,
	__TS__PromiseAny = ea,
	__TS__PromiseRace = ee,
	Set = ef,
	__TS__SetDescriptor = cd,
	__TS__SparseArrayNew = ei,
	__TS__SparseArrayPush = ek,
	__TS__SparseArraySpread = en,
	WeakMap = ep,
	WeakSet = eq,
	__TS__SourceMapTraceBack = er,
	__TS__Spread = eF,
	__TS__StringAccess = cS,
	__TS__StringCharAt = eG,
	__TS__StringCharCodeAt = eI,
	__TS__StringEndsWith = eJ,
	__TS__StringIncludes = cp,
	__TS__StringPadEnd = eL,
	__TS__StringPadStart = eO,
	__TS__StringReplace = eP,
	__TS__StringReplaceAll = f2,
	__TS__StringSlice = f5,
	__TS__StringSplit = eY,
	__TS__StringStartsWith = f6,
	__TS__StringSubstr = f7,
	__TS__StringSubstring = du,
	__TS__StringTrim = f8,
	__TS__StringTrimEnd = f9,
	__TS__StringTrimStart = fa,
	__TS__Symbol = m,
	Symbol = n,
	__TS__SymbolRegistryFor = fb,
	__TS__SymbolRegistryKeyFor = fc,
	__TS__TypeOf = ff,
	__TS__Unpack = aN,
	__TS__Using = fh,
	__TS__UsingAsync = fn,
}