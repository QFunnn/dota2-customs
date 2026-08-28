--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_022"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_022"
d(j, h)
function j.prototype.EventListener(self)
	return {
		hero_level_up = function(k, l)
			local m = self:GetCaster()
			if m ~= l.unit then
				return
			end
			local n = m:GetLevel()
			local o = self:GetSpecialValueFor("required_level")
			if n ~= o then
				return
			end
			local p = m:GetPlayerID()
			if p == nil then
				return
			end
			Bless:DrawBlessSelection(p, 3)
			local q = PlayerResource:GetSelectedHeroEntity(p)
			if IsValid(q) then
				q:EmitSoundParams("ui.badge_levelup", 0, 0.5, 0)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f