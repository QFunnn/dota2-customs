--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_040"
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
m.name = "privilege_040"
d(m, j)
function m.prototype.OnCreated(self)
	self.triggeredCount = 0
end
function m.prototype.EventListener(self)
	return {
		bless_selection_refreshed = function(n, o)
			self:GrantRefreshGold(o.playerID)
		end,
		ability_upgrade_selection_refreshed = function(n, o)
			self:GrantRefreshGold(o.playerID)
		end,
	}
end
function m.prototype.GrantRefreshGold(self, p)
	if p ~= self:GetPlayerID() then
		return
	end
	if self.triggeredCount >= self.valid_count then
		return
	end
	self.triggeredCount = self.triggeredCount + 1
	Player:ModifyGold(p, self.gold, true, true)
end
e({ k(nil) }, m.prototype, "gold", nil)
e({ k(nil) }, m.prototype, "valid_count", nil)
m = e({ h, l(nil) }, m)
return f