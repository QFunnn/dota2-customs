--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_019"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_019"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.consumedCount = 0
end
function j.prototype.EventListener(self)
	return {
		item_added = function(k, l)
			local m = l.unit
			local n = self:GetCaster()
			if not IsValid(n) or m ~= n then
				return
			end
			local o = n and n:GetPlayerID()
			if o == nil then
				return
			end
			local p = PlayerResource:GetSelectedHeroEntity(o)
			if not IsValid(p) then
				return
			end
			local q = l.item
			local r = q:GetName()
			if r ~= "item_tome_of_prop_single" then
				return
			end
			local s = self:GetSpecialValueFor("extra_attack")
			local t = self:GetSpecialValueFor("extra_count")
			if self.consumedCount >= t then
				return
			end
			self.consumedCount = self.consumedCount + 1
			p:AddProperty(PropertyFunction.ATTACK, s)
			Notification:CombatToPlayer(
				o,
				{ message = "Notify_privilege_019", item_name = "item_tome_of_prop", int_extra_attack = s }
			)
		end,
		GameModeExited = function(k, l)
			self.consumedCount = 0
			print(string.format("[privilege_019] Player %d GameEnd, consumedCount reset", self:GetPlayerID()))
		end,
		GameModeStarted = function(k, l)
			self.consumedCount = 0
			print(string.format("[privilege_019] Player %d GameStart, consumedCount reset", self:GetPlayerID()))
		end,
	}
end
j = e({ i(nil) }, j)
return f