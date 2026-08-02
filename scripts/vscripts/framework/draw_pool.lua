--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/draw_pool"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__New
local f = b.__TS__StringTrim
local g = b.__TS__StringSplit
local h = b.__TS__ArrayIndexOf
local i = b.__TS__DecorateLegacy
local j = {}
local k = require("class.weight_pool")
local l = k.CWeightPool
local m = require("lib.tstl-utils")
local n = m.reloadable
local o = c()
o.name = "MDrawPool"
d(o, CModule)
function o.prototype.init(self, p)
	local q = LoadKeyValues("scripts/npc/gameplay/reservoirs.kv")
	local r = LoadKeyValues("scripts/npc/gameplay/pools.kv")
	self._baseReservoirs = {}
	for s, t in pairs(q) do
		self._baseReservoirs[s] = e(l, t)
	end
	self._pools = {}
	for s, t in pairs(r) do
		self._pools[s] = e(l, t)
	end
	self._reservoirs = {}
	for s, u in pairs(self._baseReservoirs) do
		local v = e(l)
		local w
		u:Each(function(x, y, z)
			local A = self._pools[y]
			if A ~= nil and A.TotalWeight ~= 0 then
				w = w == nil and A.TotalWeight or LeastCommonMultiple(w, A.TotalWeight)
			end
		end, true)
		u:Each(function(x, y, B)
			local A = self._pools[y]
			if A ~= nil then
				A:Each(function(x, C, D)
					v:Add(C, w / A.TotalWeight * D * B)
				end, true)
			else
				v:Add(y, w == nil and B or B * w)
			end
		end, true)
		local E
		v:Each(function(x, C, F)
			E = E == nil and F or GreatestCommonDivisor(E, F)
		end, true)
		if E ~= nil then
			v:Each(function(x, C, F)
				v:Set(C, F / E)
			end, true)
		end
		self._reservoirs[s] = v
	end
	local G = LoadKeyValues("scripts/npc/items/artifact.kv")
	local H = {}
	for s, t in pairs(G) do
		if t.Access == "Shop" then
			H[s] = 1
		end
	end
	self._pools.items = e(l, H)
	local I = LoadKeyValues("scripts/npc/units/interact.kv")
	local J = {}
	for s, t in pairs(I) do
		if t.InteractType == "Faith" and t.Enable == 1 then
			J[s] = 1
		end
	end
	self._pools.faith = e(l, J)
	local K = {}
	for s, t in pairs(KeyValues.items) do
		if t.Access == "Bless" then
			K[s] = 1
		end
	end
	self._pools.bless = e(l, K)
end
function o.prototype.Draw(self, L, M)
	if self._reservoirs[L] ~= nil then
		return self._reservoirs[L]:Random(M)
	end
	if self._pools[L] ~= nil then
		return self._pools[L]:Random(M)
	end
	return
end
function o.prototype.MultipleDraw(self, L, N, M)
	if self._reservoirs[L] ~= nil then
		return self._reservoirs[L]:MultipleRandomWithoutReplacement(N, M)
	end
	if self._pools[L] ~= nil then
		return self._pools[L]:MultipleRandomWithoutReplacement(N, M)
	end
end
function o.prototype.DrawReservoirOnly(self, O, M)
	if self._baseReservoirs[O] == nil then
		return
	end
	return self._baseReservoirs[O]:Random(M)
end
function o.prototype.MultipleDrawReservoirOnly(self, O, N, M)
	if self._baseReservoirs[O] == nil then
		return
	end
	return self._baseReservoirs[O]:MultipleRandom(N, M)
end
function o.prototype.MultipleDrawReservoirOnlyWithoutReplacement(self, O, N, M)
	if self._baseReservoirs[O] == nil then
		return
	end
	return self._baseReservoirs[O]:MultipleRandomWithoutReplacement(N, M)
end
function o.prototype.DrawReservoir(self, O, M)
	if self._reservoirs[O] == nil then
		return
	end
	return self._reservoirs[O]:Random(M)
end
function o.prototype.MultipleDrawReservoir(self, O, N, M)
	if self._reservoirs[O] == nil then
		return
	end
	return self._reservoirs[O]:MultipleRandom(N, M)
end
function o.prototype.MultipleDrawReservoirWithoutReplacement(self, O, N, M)
	if self._reservoirs[O] == nil then
		return
	end
	return self._reservoirs[O]:MultipleRandomWithoutReplacement(N, M)
end
function o.prototype.DrawPool(self, P, M)
	if self._pools[P] == nil then
		return
	end
	return self._pools[P]:Random(M)
end
function o.prototype.GetPool(self, P)
	return self._pools[P]
end
function o.prototype.MultipleDrawPool(self, O, N, M)
	if self._pools[O] == nil then
		return
	end
	return self._pools[O]:MultipleRandom(N, M)
end
function o.prototype.MultipleDrawPoolWithoutReplacement(self, O, N, M)
	if self._pools[O] == nil then
		return
	end
	return self._pools[O]:MultipleRandomWithoutReplacement(N, M)
end
function o.prototype.GetGameReservoirOrPool(self, Q)
	return self._reservoirs[Q] or self._pools[Q]
end
function o.prototype.DrawReservoirOrPool(self, Q, M)
	if self._reservoirs[Q] ~= nil then
		return self._reservoirs[Q]:Random(M)
	end
	if self._pools[Q] ~= nil then
		return self._pools[Q]:Random(M)
	end
	return
end
function o.prototype.IsItemSupportsRarity(self, R, S)
	local T = KeyValues.items[R]
	local U
	if T ~= nil then
		U = T.RarityRange
	end
	local V = U
	if V == nil or V == "" then
		return S == 1
	end
	local W = g(f(tostring(V)), "|")
	do
		local X = 0
		while X < #W do
			if toFiniteNumber(W[X + 1], -1) == S then
				return true
			end
			X = X + 1
		end
	end
	return false
end
function o.prototype.PickShopItemNameByRarity(self, S, M)
	local H = DrawPool:GetPool("items")
	if H == nil then
		return nil
	end
	local Y = {}
	H:Each(function(x, R, F)
		if F <= 0 then
			return
		end
		if M ~= nil and h(M, R) ~= -1 then
			return
		end
		if self:IsItemSupportsRarity(R, S) then
			Y[#Y + 1] = R
		end
	end, true)
	if #Y <= 0 then
		return nil
	end
	return Y[RandomInt(0, #Y - 1) + 1]
end
o = i({ n }, o)
if DrawPool == nil then
	DrawPool = e(o)
end
return j