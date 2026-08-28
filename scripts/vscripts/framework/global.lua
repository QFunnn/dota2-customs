--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/global"
local b = require("lualib_bundle")
local c = b.__TS__NumberIsFinite
local d = b.__TS__ObjectKeys
local e = b.__TS__ArraySort
local f = b.__TS__ArraySlice
local g = b.__TS__ArrayIsArray
local h = b.__TS__ArrayForEach
local i = b.__TS__StringSplit
local j = b.__TS__StringSubstring
function Clamp(k, l, m)
	if k > m then
		k = m
	elseif k < l then
		k = l
	end
	return k
end
function toFiniteNumber(n, o)
	if o == nil then
		o = 0
	end
	local p = tonumber(n)
	if p ~= nil and c(p) then
		return p
	end
	return o
end
do
	if not _G.print_Engine then
		_G.print_Engine = print
		_G.print = function(...)
			if IsInToolsMode() then
				print_Engine(...)
			end
		end
	end
end
string.split = function(q, r, s)
	if q == nil or q == "" or r == nil then
		return { q or "" }
	end
	local t = {}
	local u = "(.-)" .. r
	for v in string.gmatch(q .. r, u) do
		if s == true then
			local w = tonumber(v)
			if w ~= nil then
				t[#t + 1] = w
			end
		else
			t[#t + 1] = v
		end
	end
	return t
end
string.replace = function(x, u, y)
	return string.gsub(x, u, y)
end
function traceback(z)
	print("[Error]: " .. tostring(z))
	return z
end
function getFileScope(A)
	if A ~= nil and A ~= "" then
		return _G, A
	end
	local B = _G.__TSTL_CURRENT_FILE_SCOPE
	if B ~= nil and B ~= "" then
		return _G, B
	end
	return _G, "@unknown"
end
function EntityConstructor(C)
	if C == nil then
		return
	end
	if type(C.IsNull) ~= "function" then
		return
	end
	if C:IsNull() then
		return
	end
	local D = C:entindex()
	local E = C:GetOrCreatePrivateScriptScope()
	if E ~= nil then
		local F = E.UpdateOnRemove
		E.UpdateOnRemove = function(...)
			if type(F) == "function" then
				F(...)
			end
			FireGameEventLocal("custom_entity_removed", { entindex = D })
		end
	end
end
function PrintTable(G, H, I)
	if H == nil then
		H = 0
	end
	if I == nil then
		I = 5
	end
	if H == 0 then
		print("----------------------------------------PrintTable----------------------------------------")
	end
	if H > I then
		print(string.rep("  ", H) .. "[Max depth reached]")
		return
	end
	if type(G) ~= "table" then
		print(string.rep("  ", H) .. tostring(G))
		return
	end
	for J, w in pairs(G) do
		local K = string.rep("  ", H)
		local L = type(J) == "string" and J or ("[" .. tostring(J)) .. "]"
		if type(w) == "table" then
			local M = getmetatable(w)
			if M ~= nil then
				print((K .. L) .. " = <table with metatable>")
			else
				print((K .. L) .. " = {")
				PrintTable(w, H + 1, I)
				print(K .. "}")
			end
		else
			local N = type(w) == "string" and ('"' .. tostring(w)) .. '"' or tostring(w)
			print(((K .. L) .. " = ") .. N)
		end
	end
	if H == 0 then
		print("-------------------------------------------End--------------------------------------------")
	end
end
function PrintLongStr(q, O)
	if IsDedicatedServer() then
		return
	end
	if string.len(q) > 1000 then
		PrintLinkedConsoleMessage(
			type(O) == "string" and tostring(O) .. "\n"
				or "文字过长，鼠标悬浮以查看详情，若想复制请点击最左侧的方块箭头图标\n",
			q
		)
	else
		print(q, O)
	end
end
function FiniteNumber(n, o)
	if o == nil then
		o = 0
	end
	local p = tonumber(n)
	if p ~= nil and c(p) then
		return p
	end
	return o
end
function ArrayRemove(P, w)
	for n = #P - 1, 0, -1 do
		if P[n + 1] == w then
			table.remove(P, n + 1)
			return w, n
		end
	end
	return nil, nil
end
function shallowcopy(Q)
	local R
	if type(Q) == "table" then
		R = {}
		for O, S in pairs(Q) do
			R[O] = S
		end
	else
		R = Q
	end
	return R
end
function deepcopy(Q)
	local R
	if type(Q) == "table" then
		R = {}
		for O, S in pairs(Q) do
			R[deepcopy(O)] = deepcopy(S)
		end
		setmetatable(R, deepcopy(getmetatable(Q)))
	else
		R = Q
	end
	return R
end
function ShuffledList(T)
	do
		local n = #T - 1
		while n > 0 do
			local U = math.random(0, n)
			local V = { T[n + 1], T[U + 1] }
			T[U + 1] = V[1]
			T[n + 1] = V[2]
			n = n - 1
		end
	end
	return T
end
function CopyAndShuffledList(T)
	return ShuffledList(shallowcopy(T))
end
function PickList(W, X, Y)
	if Y == nil then
		Y = false
	end
	if X > #W then
		return W
	end
	local R = Y and ShuffledList(W) or CopyAndShuffledList(W)
	local Z = {}
	do
		local n = 0
		while n < X do
			Z[#Z + 1] = R[n + 1]
			n = n + 1
		end
	end
	if Y then
		for _, a0 in ipairs(Z) do
			ArrayRemove(W, a0)
		end
	end
	return Z
end
function TableOverride(a1, G)
	for J in pairs(G) do
		local w = G[J]
		if type(w) == "table" then
			if type(a1[J]) == "table" then
				a1[J] = TableOverride(a1[J], w)
			else
				a1[J] = TableOverride({}, w)
			end
		else
			a1[J] = w
		end
	end
	return a1
end
function TableReplace(a1, G)
	for J in pairs(G) do
		if a1[J] ~= nil then
			local w = G[J]
			if type(w) == "table" then
				if type(a1[J]) == "table" then
					a1[J] = TableOverride(a1[J], w)
				else
					a1[J] = TableOverride({}, w)
				end
			else
				a1[J] = w
			end
		end
	end
	return a1
end
function RandomValue(P)
	local a2 = d(P)
	if #a2 > 0 then
		local n = math.random(0, #a2 - 1)
		local J = a2[n + 1]
		return P[J]
	end
	return nil
end
function RandomElements(a3, a4)
	if a4 == nil then
		a4 = 1
	end
	if a4 < 1 then
		return
	end
	e(a3, function()
		return math.random() - 0.5
	end)
	return f(a3, 0, a4)
end
function GetRandomElement(a3)
	if #a3 > 0 then
		return a3[math.random(0, #a3 - 1) + 1]
	end
	return nil
end
function TableFindKey(P, w)
	for O in pairs(P) do
		local a5 = P[O]
		if w == a5 then
			return O
		end
	end
end
function TableCount(P)
	local p = 0
	for a6 in pairs(P) do
		p = p + 1
	end
	return p
end
function Round(a7, a8)
	if a8 == nil then
		a8 = 0
	end
	local a9 = a7 > 0 and 1 or -1
	a7 = math.abs(a7)
	local n = 10 ^ a8
	return a9 * math.floor(a7 * n + 0.5) / n
end
function StringToVector(q)
	local a3 = string.split(q, " ")
	return Vector(FiniteNumber(a3[1]), FiniteNumber(a3[2]), FiniteNumber(a3[3]))
end
function RGBStringToVector(aa, ab)
	if ab == nil then
		ab = Vector(0, 0, 0)
	end
	if aa == nil or aa == "" then
		return ab
	end
	local x = string.replace(aa, "%s+", "")
	x = string.replace(x, "^rgba%(", "")
	x = string.replace(x, "^rgb%(", "")
	x = string.replace(x, "%)$", "")
	local ac = string.split(x, ",", true)
	if #ac < 3 then
		return ab
	end
	local ad = Clamp(toFiniteNumber(ac[1], 0), 0, 255)
	local ae = Clamp(toFiniteNumber(ac[2], 0), 0, 255)
	local af = Clamp(toFiniteNumber(ac[3], 0), 0, 255)
	return Vector(ad, ae, af)
end
function VectorToString(w)
	return (((tostring(w.x) .. " ") .. tostring(w.y)) .. " ") .. tostring(w.z)
end
function Rotation2D(ag, ah, ai)
	if ai == nil then
		ai = false
	end
	if ai then
		ah = math.rad(ah)
	end
	local aj = ag:Length2D()
	local ak = ag / aj
	local al = math.cos(ah)
	local am = math.sin(ah)
	return Vector(ak.x * al - ak.y * am, ak.x * am + ak.y * al, ak.z) * aj
end
function Deg2Rad(an)
	return an * math.pi / 180
end
function Rad2Deg(ao)
	return ao * 180 / math.pi
end
function BitAndEquals(S, ap)
	return bit.band(S or 0, ap) == ap
end
function Lerp(P, a3, af)
	return a3 + P * (af - a3)
end
function VectorDistanceSq(aq, ar)
	return (aq.x - ar.x) * (aq.x - ar.x) + (aq.y - ar.y) * (aq.y - ar.y) + (aq.z - ar.z) * (aq.z - ar.z)
end
function VectorDistance(aq, ar)
	return math.sqrt(VectorDistanceSq(aq, ar))
end
function VectorLerp(P, a3, af)
	return Vector(Lerp(P, a3.x, af.x), Lerp(P, a3.y, af.y), Lerp(P, a3.z, af.z))
end
function VectorIsZero(w)
	return w.x == 0 and w.y == 0 and w.z == 0
end
function RemapVal(w, a3, af, as, at)
	if a3 == af then
		return w >= af and at or as
	end
	return as + (at - as) * (w - a3) / (af - a3)
end
function RemapValClamped(w, a3, af, as, at)
	if a3 == af then
		return w >= af and at or as
	end
	local P = (w - a3) / (af - a3)
	P = Clamp(P, 0, 1)
	return as + (at - as) * P
end
function IsPointInPolygon(au, av)
	local U = #av - 1
	local aw = 0
	for n = 0, #av - 1, 1 do
		local ax = av[U + 1]
		local ay = av[n + 1]
		if (ay.y < au.y and ax.y >= au.y or ax.y < au.y and ay.y >= au.y) and (ay.x <= au.x or ax.x <= au.x) then
			aw = bit.bxor(aw, ay.x + (au.y - ay.y) / (ax.y - ay.y) * (ax.x - ay.x) < au.x and 1 or 0)
		end
		U = n
	end
	return aw == 1
end
function CalcDistance(aq, ar)
	if aq.GetAbsOrigin ~= nil then
		aq = aq:GetAbsOrigin()
	end
	if ar.GetAbsOrigin ~= nil then
		ar = ar:GetAbsOrigin()
	end
	return (aq - ar):Length2D()
end
function CalcMidPoint(aq, ar)
	if aq.GetAbsOrigin ~= nil then
		aq = aq:GetAbsOrigin()
	end
	if ar.GetAbsOrigin ~= nil then
		ar = ar:GetAbsOrigin()
	end
	return (aq + ar) / 2
end
function CalcDirection(aq, ar)
	if aq.GetAbsOrigin ~= nil then
		aq = aq:GetAbsOrigin()
	end
	if ar.GetAbsOrigin ~= nil then
		ar = ar:GetAbsOrigin()
	end
	return (aq - ar):Normalized()
end
function CalcDirection2D(aq, ar)
	if aq.GetAbsOrigin ~= nil then
		aq = aq:GetAbsOrigin()
	end
	if ar.GetAbsOrigin ~= nil then
		ar = ar:GetAbsOrigin()
	end
	local az = aq - ar
	az.z = 0
	return az:Normalized()
end
function IsValid(aA)
	return aA ~= nil and not aA:IsNull()
end
function CompoundIncreaseSimple(a3, af)
	return ((1 + a3 * 0.01) * (1 + af * 0.01) - 1) * 100
end
function CompoundIncreaseSimple_Reverse(a3, af)
	return ((1 + a3 * 0.01) / (1 + af * 0.01) - 1) * 100
end
function CompoundIncrease(...)
	local aB = { ... }
	local aC = aB[1]
	for n = 1, #aB - 1, 1 do
		aC = ((1 + (aC or 0) * 0.01) * (1 + aB[n + 1] * 0.01) - 1) * 100
	end
	return aC or 0
end
function CompoundDecreaseSimple(a3, af)
	return (1 - (1 - a3 * 0.01) * (1 - af * 0.01)) * 100
end
function CompoundDecreaseSimple_Reverse(a3, af)
	return (1 - (1 - a3 * 0.01) / (1 - af * 0.01)) * 100
end
function CompoundDecrease(...)
	local aB = { ... }
	local aC = aB[1]
	for n = 1, #aB - 1, 1 do
		aC = (1 - (1 - (aC or 0) * 0.01) * (1 - aB[n + 1] * 0.01)) * 100
	end
	return aC or 0
end
function GetReverseSettleFunction(aD)
	if aD == CompoundIncreaseSimple then
		return CompoundIncreaseSimple_Reverse
	elseif aD == CompoundDecreaseSimple then
		return CompoundDecreaseSimple_Reverse
	end
end
function MaximumSimple(a3, af)
	return math.max(a3, af)
end
function Maximum(...)
	local aB = { ... }
	local aC = aB[1]
	for n = 1, #aB - 1, 1 do
		aC = math.max(aC or -math.huge, aB[n + 1])
	end
	return aC or 0
end
function MinimumSimple(a3, af)
	return math.min(a3, af)
end
function Minimum(...)
	local aB = { ... }
	local aC = aB[1]
	for n = 1, #aB - 1, 1 do
		aC = math.min(aC or math.huge, aB[n + 1])
	end
	return aC or 0
end
function FirstSimple(a3, af)
	if a3 ~= nil then
		return a3
	else
		return af
	end
end
function First(...)
	local aB = { ... }
	local aC = aB[1]
	for n = 1, #aB - 1, 1 do
		local w = aB[n + 1]
		if w ~= nil then
			aC = w
		end
	end
	return aC
end
function toString(n)
	local P = type(n)
	return (P == "number" or P == "string" or P == "boolean") and tostring(n) or nil
end
function toFiniteString(n, o)
	if o == nil then
		o = ""
	end
	return toString(n) or o
end
function SimplifyValues(P)
	if #P <= 1 then
		return P
	end
	local aE = P[1]
	for _, w in ipairs(P) do
		if w ~= aE then
			return P
		end
	end
	return { aE }
end
function GetArrayDefaultLastValidValue(P, aF)
	local aG = P[#P]
	if aF >= #P then
		return aG
	end
	return P[aF + 1]
end
function DebugDrawLineColor(aH, aI, aJ, aK, aL)
	if aJ == nil then
		aJ = Vector(255, 0, 0)
	end
	if aK == nil then
		aK = false
	end
	if aL == nil then
		aL = 0.5
	end
	DebugDrawLine(aH, aI, aJ.x, aJ.y, aJ.z, aK, aL)
end
function DebugDrawPolygonArea(aM, aJ, aK, aL)
	if aJ == nil then
		aJ = Vector(255, 0, 0)
	end
	if aK == nil then
		aK = false
	end
	if aL == nil then
		aL = 0.5
	end
	if #aM < 2 then
		return
	end
	do
		local n = 0
		while n < #aM do
			local aH = aM[n + 1]
			local aN = n + 1 >= #aM and 0 or n + 1
			local aI = aM[aN + 1]
			DebugDrawLineColor(aH, aI, aJ, aK, aL)
			n = n + 1
		end
	end
end
function DebugDrawArcArea(aO, aP, aQ, aR, aS, aJ, aK, aL)
	if aS == nil then
		aS = 12
	end
	if aJ == nil then
		aJ = Vector(255, 0, 0)
	end
	if aK == nil then
		aK = false
	end
	if aL == nil then
		aL = 0.5
	end
	if VectorIsZero(aP) or aQ <= 0 or aR <= 0 or aS < 1 then
		return
	end
	local az = aP:Normalized()
	local aT = aR / 2
	local aU
	do
		local n = 0
		while n <= aS do
			local aV = aT - aR * n / aS
			local aW = aO + Rotation2D(az, aV, true) * aQ
			if aU ~= nil then
				DebugDrawLineColor(aU, aW, aJ, aK, aL)
			end
			aU = aW
			n = n + 1
		end
	end
end
function DebugDrawSectorArea(aO, aQ, aP, aR, aJ, aK, aL, aS)
	if aJ == nil then
		aJ = Vector(255, 0, 0)
	end
	if aK == nil then
		aK = false
	end
	if aL == nil then
		aL = 0.5
	end
	if aS == nil then
		aS = 12
	end
	if VectorIsZero(aP) or aQ <= 0 or aR <= 0 then
		return
	end
	local az = aP:Normalized()
	local aT = aR / 2
	local aX = aO + Rotation2D(az, aT, true) * aQ
	local aY = aO + Rotation2D(az, -aT, true) * aQ
	DebugDrawLineColor(aO, aX, aJ, aK, aL)
	DebugDrawLineColor(aO, aY, aJ, aK, aL)
	DebugDrawArcArea(aO, az, aQ, aR, aS, aJ, aK, aL)
end
function DebugDrawTrapezoidArea(aO, aZ, aP, a_, b0, aJ, aK, aL)
	if aJ == nil then
		aJ = Vector(255, 0, 0)
	end
	if aK == nil then
		aK = false
	end
	if aL == nil then
		aL = 0.5
	end
	if VectorIsZero(aP) or aZ <= 0 then
		return
	end
	local az = aP:Normalized()
	local b1 = RotatePosition(vec3_zero, QAngle(0, 90, 0), az)
	local b2 = aO + az * aZ
	local b3 = { aO + b1 * a_, b2 + b1 * b0, b2 - b1 * b0, aO - b1 * a_ }
	DebugDrawPolygonArea(b3, aJ, aK, aL)
end
function DebugDrawTruncatedSectorArea(aO, b4, b5, aP, aR, aJ, aK, aL, aS)
	if aJ == nil then
		aJ = Vector(255, 0, 0)
	end
	if aK == nil then
		aK = false
	end
	if aL == nil then
		aL = 0.5
	end
	if aS == nil then
		aS = 12
	end
	if VectorIsZero(aP) or b5 <= 0 or aR <= 0 or b4 >= b5 then
		return
	end
	local az = aP:Normalized()
	local aT = aR / 2
	local b6 = Rotation2D(az, aT, true)
	local b7 = Rotation2D(az, -aT, true)
	local b8 = aO + b6 * b5
	local b9 = aO + b7 * b5
	local ba = aO + b6 * b4
	local bb = aO + b7 * b4
	DebugDrawLineColor(ba, b8, aJ, aK, aL)
	DebugDrawLineColor(bb, b9, aJ, aK, aL)
	DebugDrawLineColor(ba, bb, aJ, aK, aL)
	DebugDrawArcArea(aO, az, b5, aR, aS, aJ, aK, aL)
	DebugDrawLineColor(aO, aO + az * b5, Vector(0, 255, 0), aK, aL)
	DebugDrawLineColor(aO, aO + az * b4 * math.cos(math.rad(aT)), Vector(0, 255, 0), aK, aL)
	DebugDrawCircle(aO, Vector(255, 255, 0), 32, 8, aK, aL)
end
function FindUnitsInSector(bc, bd, be, bf, bg, bh, bi, bj, bk)
	bf = Vector(bf.x, bf.y, 0)
	local bl = FindUnitsInRadius(bc, bd, nil, be, bh, bi, bj, bk, false)
	for n = #bl - 1, 0, -1 do
		local bm = bl[n + 1]
		local bn = bm:GetAbsOrigin()
		local bo = bn - bd
		bo.z = 0
		local bp = math.deg(math.acos(bf:Normalized():Dot(bo:Normalized())))
		if bp > bg / 2 then
			table.remove(bl, n + 1)
		end
	end
	return bl
end
function FindUnitsInTruncatedSector(bc, bd, bq, br, bf, bg, bh, bi, bj, bk)
	bf = Vector(bf.x, bf.y, 0)
	if VectorIsZero(bf) or br <= 0 or bg <= 0 or bq >= br then
		return {}
	end
	local az = bf:Normalized()
	local aT = bg / 2
	local bs = math.cos(math.rad(aT))
	local bt = bq <= 0 and 0 or bq * bs
	local bl = FindUnitsInRadius(bc, bd, nil, br, bh, bi, bj, bk, false)
	for n = #bl - 1, 0, -1 do
		do
			local bm = bl[n + 1]
			local bn = bm:GetAbsOrigin()
			local bo = bn - bd
			bo.z = 0
			if VectorIsZero(bo) then
				table.remove(bl, n + 1)
				goto bu
			end
			local bv = bo:Length2D()
			local bp = math.deg(math.acos(az:Dot(bo:Normalized())))
			local bw = az:Dot(bo)
			if bv > br or bp > aT or bw < bt then
				table.remove(bl, n + 1)
			end
		end
		::bu::
	end
	return bl
end
function GetAOEMostTargetsSpellTarget(bx, by, bc, be, bh, bi, bj, bk, bz)
	if bk == nil then
		bk = FIND_ANY_ORDER
	end
	local bA = FindUnitsInRadius(bc, bx, nil, by + be, bh, bi, bj, bk, false)
	if bz ~= nil then
		if g(bz) then
			for n = 0, #bz - 1, 1 do
				ArrayRemove(bA, bz[n + 1])
			end
		else
			ArrayRemove(bA, bz)
		end
	end
	local bB
	local bC = 0
	for n = 0, #bA - 1, 1 do
		local bD = bA[n + 1]
		local p = 0
		if bD:IsPositionInRange(bx, by) then
			if bB == nil then
				bB = bD
			end
			for U = 0, #bA - 1, 1 do
				local bE = bA[U + 1]
				if bE:IsPositionInRange(bD:GetAbsOrigin(), be + bE:GetHullRadius()) then
					p = p + 1
				end
			end
		end
		if p > bC then
			bB = bD
			bC = p
		end
	end
	return bB
end
function GetAOEMostTargetsPosition(bx, by, bc, be, bh, bi, bj, bk, bz)
	if bk == nil then
		bk = FIND_ANY_ORDER
	end
	local bA = FindUnitsInRadius(bc, bx, nil, by + be, bh, bi, bj, bk, false)
	if bz ~= nil then
		if g(bz) then
			for n = 0, #bz - 1, 1 do
				ArrayRemove(bA, bz[n + 1])
			end
		else
			ArrayRemove(bA, bz)
		end
	end
	local bn = vec3_invalid
	if #bA == 1 then
		local bF = bA[1]:GetAbsOrigin() - bx
		bF.z = 0
		bn = bx + bF:Normalized() * math.min(by - 1, bF:Length2D())
	elseif #bA > 1 then
		local bG = {}
		local function bH(bd)
			bG[#bG + 1] = bd
		end
		for n = 0, #bA - 1, 1 do
			local bD = bA[n + 1]
			for U = n + 1, #bA - 1, 1 do
				local bE = bA[U + 1]
				local bF = bE:GetAbsOrigin() - bD:GetAbsOrigin()
				bF.z = 0
				local bI = bF:Length2D()
				if bI <= be * 2 and bI > 0 then
					local bJ = (bE:GetAbsOrigin() + bD:GetAbsOrigin()) / 2
					if (bJ - bx):Length2D() <= by then
						bH(bJ)
					else
						local bK = math.sqrt(bit.bxor(bit.bxor(be, 2 - bI / 2), 2))
						local w = RotatePosition(vec3_zero, QAngle(0, 90, 0), bF:Normalized()) * bK
						local bL = { bJ - w, bJ + w }
						h(bL, function(_, bd)
							if (bd - bx):Length2D() <= by then
								bH(bd)
							end
						end)
					end
				end
			end
		end
		local bC = 0
		for n = 0, #bG - 1, 1 do
			local bd = bG[n + 1]
			local p = 0
			for U = 0, #bA - 1, 1 do
				local bB = bA[U + 1]
				if bB:IsPositionInRange(bd, be + bB:GetHullRadius()) then
					p = p + 1
				end
			end
			if p > bC then
				bn = bd
				bC = p
			end
		end
		if bn == vec3_invalid then
			local bF = bA[2]:GetAbsOrigin() - bx
			bF.z = 0
			bn = bx + bF:Normalized() * math.min(by - 1, bF:Length2D())
		end
	end
	if bn ~= vec3_invalid then
		bn = GetGroundPosition(bn, nil)
	end
	return bn
end
function GetLinearMostTargetsPosition(bx, by, bc, bM, bN, bh, bi, bj, bk, bz)
	if bk == nil then
		bk = FIND_ANY_ORDER
	end
	local bA = FindUnitsInRadius(bc, bx, nil, by + bN, bh, bi, bj, bk, false)
	if bz ~= nil then
		if g(bz) then
			for n = 0, #bz - 1, 1 do
				ArrayRemove(bA, bz[n + 1])
			end
		else
			ArrayRemove(bA, bz)
		end
	end
	local bn = vec3_invalid
	if #bA == 1 then
		local bF = bA[1]:GetAbsOrigin() - bx
		bF.z = 0
		bn = bx + bF:Normalized() * (by - 1)
	elseif #bA > 1 then
		local bO = {}
		local function bP(bQ)
			bO[#bO + 1] = bQ
		end
		for n = 0, #bA - 1, 1 do
			local bD = bA[n + 1]
			for U = n + 1, #bA - 1, 1 do
				local bE = bA[U + 1]
				local bR = bD:GetAbsOrigin() - bx
				bR.z = 0
				local bS = bE:GetAbsOrigin() - bx
				bS.z = 0
				local bF = (bR + bS) / 2
				bF.z = 0
				local w = RotatePosition(vec3_zero, QAngle(0, 90, 0), bF:Normalized())
				local bT = bx + bF:Normalized() * (by - 1)
				local bQ = { bx + w * bM, bT + w * bN, bT, bT - w * bN, bx - w * bM }
				if
					(IsPointInPolygon(bD:GetAbsOrigin(), bQ) or bD:IsPositionInRange(bT, bN + bD:GetHullRadius()))
					and (IsPointInPolygon(bE:GetAbsOrigin(), bQ) or bE:IsPositionInRange(bT, bN + bE:GetHullRadius()))
				then
					bP(bQ)
				end
			end
			local bF = bD:GetAbsOrigin() - bx
			bF.z = 0
			local w = RotatePosition(vec3_zero, QAngle(0, 90, 0), bF:Normalized())
			local bT = bx + bF:Normalized() * (by - 1)
			local bQ = { bx + w * bM, bT + w * bN, bT, bT - w * bN, bx - w * bM }
			bP(bQ)
		end
		local bC = 0
		for n = 0, #bO - 1, 1 do
			local bQ = bO[n + 1]
			local p = 0
			for U = 0, #bA - 1, 1 do
				local bB = bA[U + 1]
				if IsPointInPolygon(bB:GetAbsOrigin(), bQ) or bB:IsPositionInRange(bQ[4], bN + bB:GetHullRadius()) then
					p = p + 1
				end
			end
			if p > bC then
				bn = bQ[4]
				bC = p
			end
		end
	end
	if bn ~= vec3_invalid then
		bn = GetGroundPosition(bn, nil)
	end
	return bn
end
function FindUnitsInLineWithAbility(bU, aH, aI, bV, bW)
	return FindUnitsInLine(
		bU:GetTeamNumber(),
		aH,
		aI,
		nil,
		bV,
		bW:GetAbilityTargetTeam(),
		bW:GetAbilityTargetType(),
		bW:GetAbilityTargetFlags()
	)
end
function FindUnitsInRadiusWithAbility(bU, aO, aQ, bW, bX)
	if not IsValid(bU) or not IsValid(bW) then
		return {}
	end
	if bX == nil then
		bX = FIND_ANY_ORDER
	end
	return FindUnitsInRadius(
		bU:GetTeamNumber(),
		aO,
		nil,
		aQ,
		bW:GetAbilityTargetTeam(),
		bW:GetAbilityTargetType(),
		bW:GetAbilityTargetFlags(),
		bX,
		false
	)
end
function FindUnitsInSectorWithAbility(bU, aO, aQ, aP, aR, bW, bX)
	if not IsValid(bU) or not IsValid(bW) then
		return {}
	end
	if bX == nil then
		bX = FIND_ANY_ORDER
	end
	return FindUnitsInSector(
		bU:GetTeamNumber(),
		aO,
		aQ,
		aP,
		aR,
		bW:GetAbilityTargetTeam(),
		bW:GetAbilityTargetType(),
		bW:GetAbilityTargetFlags(),
		bX
	)
end
function FindUnitsInTruncatedSectorWithAbility(bU, aO, b4, b5, aP, aR, bW, bX)
	if not IsValid(bU) or not IsValid(bW) then
		return {}
	end
	if bX == nil then
		bX = FIND_ANY_ORDER
	end
	return FindUnitsInTruncatedSector(
		bU:GetTeamNumber(),
		aO,
		b4,
		b5,
		aP,
		aR,
		bW:GetAbilityTargetTeam(),
		bW:GetAbilityTargetType(),
		bW:GetAbilityTargetFlags(),
		bX
	)
end
function FindEnemiesInRadius(bU, aO, aQ, bX, bY)
	if bX == nil then
		bX = FIND_ANY_ORDER
	end
	if bY == nil then
		bY = false
	end
	if not IsValid(bU) then
		return {}
	end
	if bY then
		DebugDrawCircle(aO, Vector(255, 0, 0), 32, aQ, false, 0.5)
	end
	return FindUnitsInRadius(
		bU:GetTeamNumber(),
		aO,
		nil,
		aQ,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		bX,
		false
	)
end
function FindEnemiesInLine(bU, aH, aI, bV, bY)
	if bY == nil then
		bY = false
	end
	if not IsValid(bU) then
		return {}
	end
	if bY then
		local az = CalcDirection2D(aI, aH)
		local b1 = RotatePosition(vec3_zero, QAngle(0, 90, 0), az) * bV
		local bZ = aH + b1
		local b_ = aH - b1
		local c0 = aI + b1
		local c1 = aI - b1
		local aL = 0.3
		DebugDrawLine(bZ, c0, 255, 0, 0, false, aL)
		DebugDrawLine(c0, c1, 255, 0, 0, false, aL)
		DebugDrawLine(c1, b_, 255, 0, 0, false, aL)
		DebugDrawLine(b_, bZ, 255, 0, 0, false, aL)
	end
	return FindUnitsInLine(
		bU:GetTeamNumber(),
		aH,
		aI,
		nil,
		bV,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
end
function FindEnemiesInSector(bU, aO, aQ, aP, aR, bY)
	if bY == nil then
		bY = false
	end
	if not IsValid(bU) then
		return {}
	end
	if bY then
		DebugDrawCircle(aO, Vector(255, 0, 0), 32, aQ, false, 0.5)
		local az = aP:Normalized()
		local b1 = RotatePosition(vec3_zero, QAngle(0, 90, 0), az) * aQ
		local c0 = aO + az * aQ + b1
		local c1 = aO + az * aQ - b1
		DebugDrawLine(aO, c0, 255, 0, 0, false, 0.5)
		DebugDrawLine(aO, c1, 255, 0, 0, false, 0.5)
	end
	return FindUnitsInSector(
		bU:GetTeamNumber(),
		aO,
		aQ,
		aP,
		aR,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)
end
function FindEnemiesInTruncatedSector(bU, aO, b4, b5, aP, aR, bY)
	if bY == nil then
		bY = false
	end
	if not IsValid(bU) then
		return {}
	end
	if bY and not VectorIsZero(aP) and b5 > 0 and aR > 0 then
		local az = aP:Normalized()
		local aT = aR / 2
		local b6 = Rotation2D(az, aT, true)
		local b7 = Rotation2D(az, -aT, true)
		local b8 = aO + b6 * b5
		local b9 = aO + b7 * b5
		local ba = aO + b6 * b4
		local bb = aO + b7 * b4
		local aL = 0.5
		local c2 = 12
		DebugDrawLine(ba, b8, 255, 0, 0, true, aL)
		DebugDrawLine(bb, b9, 255, 0, 0, true, aL)
		DebugDrawLine(ba, bb, 255, 0, 0, true, aL)
		do
			local n = 0
			while n < c2 do
				local c3 = aT - aR * n / c2
				local c4 = aT - aR * (n + 1) / c2
				local c5 = aO + Rotation2D(az, c3, true) * b5
				local c6 = aO + Rotation2D(az, c4, true) * b5
				DebugDrawLine(c5, c6, 255, 0, 0, true, aL)
				n = n + 1
			end
		end
	end
	return FindUnitsInTruncatedSector(
		bU:GetTeamNumber(),
		aO,
		b4,
		b5,
		aP,
		aR,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)
end
function DoCleaveAction(c7, bB, bM, bN, bI, aD, bh, bi, bj, c8)
	if bh == nil then
		bh = DOTA_UNIT_TARGET_TEAM_ENEMY
	end
	if bi == nil then
		bi = DOTA_UNIT_TARGET_HEROES_AND_CREEPS
	end
	if bj == nil then
		bj = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE
	end
	local be = math.max(bM / 2, math.max(bN / 2, math.sqrt(bit.bxor(bit.bxor(bI, 2 + bN / 2), 2))))
	local c9 = c8 or c7:GetAbsOrigin()
	local bF = bB:GetAbsOrigin() - c9
	bF.z = 0
	bF = bF:Normalized()
	local ca = c9 + bF * bI
	local w = RotatePosition(vec3_zero, QAngle(0, 90, 0), bF)
	local bQ = { c9 + w * bM, ca + w * bN, ca - w * bN, c9 - w * bM }
	local bA = FindUnitsInRadius(c7:GetTeamNumber(), c9, nil, be + 100, bh, bi, bj, FIND_CLOSEST, false)
	for n = 0, #bA - 1, 1 do
		local bm = bA[n + 1]
		if bm ~= bB then
			if IsPointInPolygon(bm:GetAbsOrigin(), bQ) then
				if aD(bm) == true then
					break
				end
			end
		end
	end
end
if TimerEventListenerIDs == nil then
	TimerEventListenerIDs = {}
end
function TimerEvent(cb, aD, cc)
	local cd = GameRules:GetGameModeEntity()
	local x = cd:Timer(cb, function()
		if cc ~= nil then
			return aD(cc)
		end
		return aD()
	end)
	TimerEventListenerIDs[#TimerEventListenerIDs + 1] = x
	return x
end
function GameTimerEvent(cb, aD, cc)
	local cd = GameRules:GetGameModeEntity()
	local x = cd:GameTimer(cb, function()
		if cc ~= nil then
			return aD(cc)
		end
		return aD()
	end)
	TimerEventListenerIDs[#TimerEventListenerIDs + 1] = x
	return x
end
function FireInputNameOnly(aA, ce)
	if type(aA) == "number" then
		local a3 = EntIndexToHScript(aA)
		if IsValid(a3) then
			aA = a3
		else
			return
		end
	end
	if IsValid(aA) then
		local cf = aA:GetEntityHandle()
		FireEntityIOInputNameOnly(cf, ce)
	end
end
function FireInputString(aA, ce, cg)
	print((((("FireInputString: " .. tostring(aA)) .. " ") .. ce) .. " ") .. cg)
	if type(aA) == "number" then
		local a3 = EntIndexToHScript(aA)
		if a3 ~= nil then
			aA = a3
		else
			return
		end
	end
	if aA ~= nil then
		local cf = aA:GetEntityHandle()
		FireEntityIOInputString(cf, ce, cg)
	end
end
function FindInfoTarget(ch)
	local ci = Entities:FindAllByClassname("info_target")
	for n, w in ipairs(ci) do
		return w:GetName() == ch and w or nil
	end
end
function _GreatestCommonDivisor(a3, af)
	while af ~= 0 do
		a3, af = af, a3 % af
	end
	return a3
end
function _LeastCommonMultiple(a3, af)
	return math.abs(a3 * af) / _GreatestCommonDivisor(a3, af)
end
function GreatestCommonDivisor(...)
	local cj = { ... }
	local aZ = #cj
	if aZ == 0 then
		return 0 / 0
	elseif aZ == 1 then
		return cj[1]
	end
	local t = cj[1]
	do
		local n = 1
		while n < aZ do
			t = _GreatestCommonDivisor(t, cj[n + 1])
			n = n + 1
		end
	end
	return t
end
function LeastCommonMultiple(...)
	local cj = { ... }
	local aZ = #cj
	if aZ == 0 then
		return 0 / 0
	elseif aZ == 1 then
		return cj[1]
	end
	local t = cj[1]
	do
		local n = 1
		while n < aZ do
			t = _LeastCommonMultiple(t, cj[n + 1])
			n = n + 1
		end
	end
	return t
end
addedValueFunctionMap = { attack = "GetAttackDamage", health = "GetMaxHealth", shield = "GetShield" }
function GetAbilityValues(ck, cl, bU)
	if cl == 0 or ck == nil then
		return 0
	end
	if type(ck) == "table" then
		local cm = i(tostring(ck.value), " ")
		local S = toFiniteNumber(cm[math.min(cl, #cm)])
		if bU == nil then
			return S
		end
		local cn = 0
		local co = 0
		for J, w in pairs(ck) do
			local cp = j(J, 0, 1)
			local cq = j(J, 1)
			local cr = i(tostring(w), " ")
			local cs = toFiniteNumber(cr[math.min(cl, #cr)])
			if addedValueFunctionMap[cq] then
				local aD = _G[addedValueFunctionMap[cq]]
				if cp == "_" or cp == "+" then
					S = S + toFiniteNumber(aD(nil, bU) * cs, 0)
				elseif cp == "*" then
					cn = cn + cs
				end
			elseif PROPERTY_FUNCTION_MAP[cq] then
				if cp == "_" or cp == "+" then
					S = S + PROPERTY_FUNCTION_MAP[cq](bU)
				elseif cp == "*" then
					cn = cn + PROPERTY_FUNCTION_MAP[cq](bU) * cs
				elseif cp == "/" then
					co = co + PROPERTY_FUNCTION_MAP[cq](bU) * cs
				end
			end
		end
		return S * (1 + cn / 100) / (1 + co / 100)
	else
		local cm = i(tostring(ck), " ")
		local S = toFiniteNumber(cm[math.min(cl, #cm)])
		return S
	end
end
function ErrorMessage(z, ct, cu, cv)
	if cu == nil then
		cu = "General.Cancel"
	end
	if z == nil then
		return
	end
	if ct == nil then
		CustomGameEventManager:Send_ServerToAllClients("error_message", { message = z, sound = cu, vars = cv })
	else
		local cw = PlayerResource:GetPlayer(ct)
		if cw ~= nil then
			CustomGameEventManager:Send_ServerToPlayer(cw, "error_message", { message = z, sound = cu, vars = cv })
		end
	end
end
function GetItemPropType(cx)
	local cy = tostring(cx)
	if #cy == 6 then
		cy = string.sub(cy, 1, 1)
	else
		cy = string.sub(cy, 1, 2)
	end
	return cy
end
function GetItemEquipmentPart(cx)
	return string.sub(tostring(cx), 5, 5)
end
function GetPropRarity(cx)
	local cy = GetItemPropType(cx)
	if cy == "9" then
		return toFiniteNumber(string.sub(tostring(cx), 6, 6), 1)
	elseif cy == "19" or cy == "20" then
		return toFiniteNumber(string.sub(tostring(cx), -1), 1)
	end
	local cz = toFiniteNumber
	local cA = KeyValues.info_item_rarity[cx]
	if cA ~= nil then
		cA = cA.rarity
	end
	return cz(cA, 1)
end