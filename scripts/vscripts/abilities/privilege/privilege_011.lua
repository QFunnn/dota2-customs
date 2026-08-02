--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_011"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIndexOf
local f = b.__TS__StringTrim
local g = b.__TS__StringSplit
local h = b.__TS__DecorateLegacy
local i = {}
local j = require("lib.tstl-utils")
local k = j.reloadable
local l = require("abilities.eom_privilege")
local m = l.EOMPrivilege
local n = l.PrivilegeValue
local o = l.RegisterPrivilege
local p = { "item_healing_bandage", "item_regen_moss_medicine" }
local q = c()
q.name = "privilege_011"
d(q, m)
function q.prototype.EventListener(self)
	return {
		GameModeStarted = function()
			local r = self:GetCaster()
			if not IsValid(r) then
				return
			end
			do
				local s = 0
				while s < self.item_count do
					self:GrantRandomMeepoArtifact(r)
					s = s + 1
				end
			end
		end,
	}
end
function q.prototype.GrantRandomMeepoArtifact(self, r)
	local t = self.rarity
	local u = self:PRD(self.chance) and self.upgrade_rarity or t
	local v = self:GetAvailableMeepoArtifacts(u)
	if #v <= 0 and u ~= t then
		u = t
		v = self:GetAvailableMeepoArtifacts(u)
	end
	if #v <= 0 then
		return
	end
	local w = v[RandomInt(0, #v - 1) + 1]
	r:AddItemByName(w, u)
	Notification:CombatToPlayer(
		self:GetPlayerID(),
		{ message = "Notify_privilege_011", item_name = w, item_name_rarity = u }
	)
end
function q.prototype.GetAvailableMeepoArtifacts(self, x)
	local y = self:GetUnavailableArtifactNames()
	Artifact:AppendCurrentGameModeExcludedArtifacts(y)
	local v = {}
	for z, A in pairs(KeyValues.artifact) do
		do
			local w = tostring(z)
			local B = tostring
			local C = A.Access
			if C == nil then
				C = ""
			end
			if B(C) ~= "Meepo" then
				goto D
			end
			if e(p, w) ~= -1 then
				goto D
			end
			if e(y, w) ~= -1 then
				goto D
			end
			if not self:IsArtifactSupportsRarity(A.RarityRange, x) then
				goto D
			end
			v[#v + 1] = w
		end
		::D::
	end
	return v
end
function q.prototype.IsArtifactSupportsRarity(self, E, x)
	if E == nil or E == "" then
		return x == 1
	end
	local F = g(f(tostring(E)), "|")
	do
		local s = 0
		while s < #F do
			if toFiniteNumber(F[s + 1], -1) == x then
				return true
			end
			s = s + 1
		end
	end
	return false
end
h({ n(nil) }, q.prototype, "item_count", nil)
h({ n(nil) }, q.prototype, "rarity", nil)
h({ n(nil) }, q.prototype, "upgrade_rarity", nil)
h({ n(nil) }, q.prototype, "chance", nil)
q = h({ k, o(nil) }, q)
return i