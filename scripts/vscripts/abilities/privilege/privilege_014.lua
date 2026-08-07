--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_014"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_014"
d(j, h)
function j.prototype.EventListener(self)
	return {
		GameModeStarted = function(k, l)
			local m = self:GetSpecialValueFor("chance")
			local n = 3
			if self:PRD(m) then
				n = n + 1
			end
			Bless:DrawBlessSelection(self.playerID, n)
		end,
	}
end
j = e({ i(nil) }, j)
return f