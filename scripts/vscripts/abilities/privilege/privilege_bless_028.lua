--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_028"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.PrivilegeValue
local l = i.RegisterPrivilege
local m = c()
m.name = "privilege_bless_028"
d(m, j)
function m.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.triggerCount = 0
end
function m.prototype.EventListener(self)
	return {
		dragon_egg_hatched = function(n, o)
			if o.playerID ~= self:GetPlayerID() or o.hero ~= self:GetCaster() then
				return
			end
			if self.triggerCount >= self.max_count then
				return
			end
			local p = math.max(0, math.floor(self.baby_count))
			local q = math.max(0, p - o.baseCount)
			if q <= 0 then
				return
			end
			local r = 0
			do
				local s = 0
				while s < q do
					local t = o.hero:AddItemByName(o.babyItemName, o.babyRarity)
					if IsValid(t) then
						r = r + 1
					end
					s = s + 1
				end
			end
			if r <= 0 then
				return
			end
			self.triggerCount = self.triggerCount + 1
			Notification:CombatToPlayer(
				o.playerID,
				{
					message = "Notify_privilege_bless_028",
					item_name = o.babyItemName,
					item_name_rarity = o.babyRarity,
					int_value = o.baseCount + r,
				}
			)
		end,
	}
end
e({ k(nil) }, m.prototype, "baby_count", nil)
e({ k(nil) }, m.prototype, "max_count", nil)
m = e({ h, l(nil) }, m)
return f