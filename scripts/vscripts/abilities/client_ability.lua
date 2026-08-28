--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/client_ability"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "client_ability"
d(j, h)
function j.prototype.GetAbilityTextureName(self)
	if _G.ClientRequestEventResult ~= nil then
		local k = _G.ClientRequestEventResult
		_G.ClientRequestEventResult = nil
		return k
	end
	return ""
end
j = e({ i(nil) }, j)
return f