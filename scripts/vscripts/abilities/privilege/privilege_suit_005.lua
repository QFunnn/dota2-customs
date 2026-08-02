--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_005"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = c()
l.name = "privilege_suit_005"
d(l, j)
function l.prototype.OnCreated(self)
	local m = self:GetSpecialValueFor("interval")
	local n = self:GetCaster()
	if IsValid(n) then
		self.timer = n:GameTimer("privilege_suit_005", m, function()
			self:SnowballLaunch()
			return m
		end)
	end
end
function l.prototype.OnDestroy(self)
	local n = self:GetCaster()
	if self.timer and IsValid(n) then
		n:StopTimer(self.timer)
		self.timer = nil
	end
end
function l.prototype.SnowballLaunch(self)
	local n = self:GetCaster()
	if not IsValid(n) then
		return
	end
	local o = self:GetSpecialValueFor("snowball_count")
	local p = self:GetSpecialValueFor("frozen_stacks")
	local q = self:GetSpecialValueFor("radius")
	local r = FindEnemiesInRadius(n, n:GetAbsOrigin(), q)
	local s = self:GetSnowballDamage()
	do
		local t = 0
		while t < o do
			local u = GetRandomElement(r)
			if IsValid(u) then
				if t == 0 then
					n:ThrowSnowball(u, nil, p, s)
				else
					n:GameTimer("privilege_suit_005_snowball", 0.2 * t, function()
						n:ThrowSnowball(u, nil, p, s)
					end)
				end
			end
			t = t + 1
		end
	end
end
function l.prototype.GetSnowballDamage(self)
	local v = self:GetSpecialValueFor("damage")
	local w = self:GetSuitEffectCount()
	if w >= 3 then
		return v * 4
	end
	if w >= 2 then
		return v * 2
	end
	return v
end
function l.prototype.GetSuitEffectCount(self)
	local x = Equipment.equipment_suit_effect.suit_5
	if x == nil then
		return Privilege:HasPrivilege("privilege_suit_005", self.playerID) and 1 or 0
	end
	local y = 0
	local z = { x.lv2, x.lv4, x.lv6 }
	for A, B in ipairs(z) do
		if B ~= nil and Privilege:HasPrivilege(B, self.playerID) then
			y = y + 1
		end
	end
	return y
end
l = e({ h, k(nil) }, l)
return f