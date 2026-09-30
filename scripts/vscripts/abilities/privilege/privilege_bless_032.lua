--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_032"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_bless_032"
d(j, h)
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_BOOST_MULT] = function(k, l)
			if
				l ~= nil
				and IsValid(l.target)
				and BattleGem:IsRunning(self:GetPlayerID())
				and BattleGem:IsActiveEnemy(l.target)
			then
				return self:GetSpecialValueFor("damage_pct")
			end
			return 0
		end,
	}
end
j = e({ i(nil) }, j)
return f