--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_022"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_022"
d(j, h)
function j.prototype.EventListener(self)
	return {
		bless_suit_changed = function(k, l)
			local m = l.playerID
			local n = PlayerResource:GetSelectedHeroEntity(m)
			local o = Bless:GetSuitLevel(m, "wind")
			local p = self:GetSpecialValueFor("attack_speed_scale")
			if IsValid(n) and o > 0 then
				PropertySystem:AddStaticProperty(n:entindex(), "attackspeed", "privilege_weapon_022", o * p)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f