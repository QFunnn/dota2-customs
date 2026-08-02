--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_017"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_017"
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
			local p = l.item
			local q = p:GetName()
			if q ~= "item_gold_pouch_single" then
				return
			end
			local r = self:GetSpecialValueFor("extra_gold")
			local s = self:GetSpecialValueFor("extra_count")
			if self.consumedCount < s then
				self.consumedCount = self.consumedCount + 1
				Player:ModifyGold(o, r)
				local t = PlayerResource:GetSelectedHeroEntity(o)
				if IsValid(t) then
					SendOverheadEventMessage(PlayerResource:GetPlayer(o), OVERHEAD_ALERT_GOLD, t, r, t:GetPlayerOwner())
				end
				Notification:CombatToPlayer(
					o,
					{ message = "Notify_privilege_017", item_name = "item_gold_pouch", int_extra_gold = r }
				)
			end
		end,
		GameModeExited = function(k, l)
			self.consumedCount = 0
			print(string.format("[privilege_017] Player %d GameEnd, consumedCount reset", self:GetPlayerID()))
		end,
		GameModeStarted = function(k, l)
			self.consumedCount = 0
			print(string.format("[privilege_017] Player %d GameStart, consumedCount reset", self:GetPlayerID()))
		end,
	}
end
j = e({ i(nil) }, j)
return f