--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_030"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_privilege")
local i = h.EOMPrivilege
local j = h.RegisterPrivilege
local k = c()
k.name = "privilege_bless_030"
d(k, i)
function k.prototype.GetDamageBonus(self)
	local l = #e(Bless:GetPlayerBlessNames(self:GetPlayerID()), function(m, n)
		return Bless:IsBlessOfSuit(n, "Wind")
	end)
	return l * self:GetSpecialValueFor("damage_per_bless")
end
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.PHYSICAL_DAMAGE_AMPLIFY] = function()
			return self:GetDamageBonus()
		end,
		[PropertyFunction.MAGICAL_DAMAGE_AMPLIFY] = function()
			return self:GetDamageBonus()
		end,
	}
end
k = f({ j(nil) }, k)
return g