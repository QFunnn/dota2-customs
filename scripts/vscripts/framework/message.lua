--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/message"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = {}
local h = require("lib.tstl-utils")
local i = h.reloadable
local j = c()
j.name = "MMessage"
d(j, CModule)
function j.prototype.SendGameplayText(self, k, l)
	local m = PlayerResource:GetPlayer(k)
	if m == nil then
		return
	end
	local n = { text = l }
	CustomGameEventManager:Send_ServerToPlayer(m, "ReceiveGameplayText", n)
end
j = e({ i }, j)
if Message == nil then
	Message = f(j)
end
return g