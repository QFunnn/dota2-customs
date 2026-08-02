--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_025"
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
m.name = "privilege_bless_025"
d(m, j)
function m.prototype.EventListener(self)
	return {
		GameModeStarted = function()
			PrivilegeRewardChoice:RequestEnqueue(
				self:GetPlayerID(),
				PrivilegeRewardKind.MeepoArtifact,
				self.rarity,
				self.item_count
			)
		end,
	}
end
e({ k(nil) }, m.prototype, "item_count", nil)
e({ k(nil) }, m.prototype, "rarity", nil)
m = e({ h, l(nil) }, m)
return f