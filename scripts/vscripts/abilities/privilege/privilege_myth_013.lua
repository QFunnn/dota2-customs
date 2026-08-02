--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_013"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.PrivilegeValue
local j = g.RegisterPrivilege
local k = c()
k.name = "privilege_myth_013"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.effected = false
end
function k.prototype.EventListener(self)
	return {
		GameModeStarted = function(l, m)
			local n = self:GetCaster()
			if IsValid(n) and not self.effected then
				n:LightningCloud(self.value)
				self.effected = true
			end
		end,
		dungeon_room_start = function(l, m)
			local n = self:GetCaster()
			if IsValid(n) and not self.effected then
				n:LightningCloud(self.value)
				self.effected = true
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f