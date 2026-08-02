--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_031"
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
l.name = "privilege_suit_031"
d(l, j)
function l.prototype.EventListener(self)
	return {
		GameModeStarted = function(m, n)
			local o = self:GetCaster()
			Bless:AddBless(o, { name = "item_bleed_fury_blessing", rarity = 1 })
		end,
	}
end
l = e({ h, k(nil) }, l)
return f