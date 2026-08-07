--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_shield"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__ArrayReduce
local g = b.__TS__ArraySplice
local h = b.__TS__DecorateLegacy
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.registerModifier
local l = require("modifiers.eom_modifier.eom_modifier")
local m = l.EOMModifier
local n = c()
n.name = "modifier_shield"
d(n, m)
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self.shields = {}
		self:AddShield(o.shield, o.id, o.method, o.type)
		self:StartIntervalThink(
			SHIELD_DECAY_INTERVAL * (1 + GetShieldAttenuationIntervalAmplify(self:GetParent()) * 0.01)
		)
	end
	self:GetParent().__shield_modofier = self
end
function n.prototype.OnDestroy(self)
	self:GetParent().__shield_modofier = nil
end
function n.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local p = self:GetTotalShieldAmount()
	if p <= 0 then
		self:Destroy()
		return
	end
	local q = self:GetParent()
	local r = GetShieldNoAttenuationChance(q)
	if r > 0 and RollPercentage(r) then
		self:StartIntervalThink(
			SHIELD_DECAY_INTERVAL * (1 + GetShieldAttenuationIntervalAmplify(self:GetParent()) * 0.01)
		)
		return
	end
	local s = GetShieldAttenuationReduction(self:GetParent()) * 0.01
	local t = math.max(p * SHIELD_DECAY_RATE * 0.01, q:GetMaxHealth() * SHIELD_DECAY_MIN)
		* math.min(1, math.max(0, 1 - s))
	self:DecayShields(t)
	self:StartIntervalThink(SHIELD_DECAY_INTERVAL * (1 + GetShieldAttenuationIntervalAmplify(self:GetParent()) * 0.01))
end
function n.prototype.DecayShields(self, u)
	local v = e(self.shields, function(w, x)
		return x.type ~= "permanent"
	end)
	local y = f(v, function(w, z, x)
		return z + x.amount
	end, 0)
	if y <= 0 then
		return
	end
	do
		local A = #self.shields - 1
		while A >= 0 do
			do
				local B = self.shields[A + 1]
				if B.type == "permanent" then
					goto C
				end
				local D = B.amount / y
				local E = u * D
				B.amount = B.amount - E
				if B.amount < 1 then
					g(self.shields, A, 1)
				end
			end
			::C::
			A = A - 1
		end
	end
	self:SyncStackCount()
	if #self.shields == 0 then
		self:Destroy()
	end
end
function n.prototype.OnRefresh(self, o)
	if IsServer() then
		self:AddShield(o.shield, o.id, o.method, o.type)
	end
end
function n.prototype.AddShield(self, F, G, H, I)
	local J = I or "normal"
	local K = -1
	do
		local A = 0
		while A < #self.shields do
			if self.shields[A + 1].id == G then
				K = A
				break
			end
			A = A + 1
		end
	end
	if K ~= -1 then
		if H == "override" then
			self.shields[K + 1].amount = F
			self.shields[K + 1].type = J
		else
			local L, M = self.shields[K + 1], "amount"
			L[M] = L[M] + F
		end
	else
		local N = self.shields
		N[#N + 1] = { id = G, amount = F, type = J }
	end
	self:SyncStackCount()
	if #self.shields == 0 then
		self:Destroy()
	end
end
function n.prototype.ConsumeShield(self, O)
	local P = O
	do
		local A = 0
		while A < #self.shields do
			do
				local B = self.shields[A + 1]
				if B.amount <= 0 then
					goto Q
				end
				if P >= B.amount then
					P = P - B.amount
					g(self.shields, A, 1)
					A = A - 1
				else
					B.amount = B.amount - P
					P = 0
					break
				end
			end
			::Q::
			A = A + 1
		end
	end
	self:SyncStackCount()
	if #self.shields == 0 then
		self:Destroy()
	end
	return P
end
function n.prototype.ReduceShield(self, F, G, R)
	if R == nil then
		R = false
	end
	if F <= 0 then
		return
	end
	if G ~= nil then
		do
			local A = 0
			while A < #self.shields do
				if self.shields[A + 1].id == G then
					if not R and self.shields[A + 1].type == "permanent" then
						return
					end
					local S, T = self.shields[A + 1], "amount"
					S[T] = S[T] - F
					if self.shields[A + 1].amount < 1 then
						g(self.shields, A, 1)
					end
					break
				end
				A = A + 1
			end
		end
	else
		if R then
			local p = self:GetTotalShieldAmount()
			if p <= 0 then
				return
			end
			do
				local A = #self.shields - 1
				while A >= 0 do
					local D = self.shields[A + 1].amount / p
					local U, V = self.shields[A + 1], "amount"
					U[V] = U[V] - F * D
					if self.shields[A + 1].amount < 1 then
						g(self.shields, A, 1)
					end
					A = A - 1
				end
			end
		else
			self:DecayShields(F)
		end
	end
	self:SyncStackCount()
	if #self.shields == 0 then
		self:Destroy()
	end
end
function n.prototype.RemoveShield(self, G)
	do
		local A = 0
		while A < #self.shields do
			if self.shields[A + 1].id == G then
				g(self.shields, A, 1)
				self:SyncStackCount()
				if #self.shields == 0 then
					self:Destroy()
				end
				return true
			end
			A = A + 1
		end
	end
	return false
end
function n.prototype.GetTotalShieldAmount(self)
	local W = 0
	do
		local A = 0
		while A < #self.shields do
			W = W + self.shields[A + 1].amount
			A = A + 1
		end
	end
	return W
end
function n.prototype.SyncStackCount(self)
	local X = LargeNumberHealth:ToProxyValue(self:GetParent(), self:GetTotalShieldAmount())
	self:SetStackCount(math.max(0, math.min(1000000000, math.floor(X))))
end
function n.prototype.GetShieldAmount(self, G)
	do
		local A = 0
		while A < #self.shields do
			if self.shields[A + 1].id == G then
				return self.shields[A + 1].amount
			end
			A = A + 1
		end
	end
	return 0
end
function n.prototype.StaticState(self)
	return { [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
end
n = h({ k(a) }, n)
return i