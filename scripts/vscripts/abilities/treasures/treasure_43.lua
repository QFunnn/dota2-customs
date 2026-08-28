--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_43"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 4,
		["13"] = 3,
		["14"] = 4,
		["15"] = 5,
		["16"] = 6,
		["19"] = 10,
		["20"] = 5,
		["21"] = 4,
		["22"] = 3,
		["23"] = 4,
		["25"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.treasure_43 = c()
local k = g.treasure_43
k.name = "treasure_43"
d(k, i)
function k.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	PlayerData:resetHeroTalent(self:GetCaster():GetPlayerOwnerID())
end
k = e({ j(nil) }, k)
g.treasure_43 = k
return g