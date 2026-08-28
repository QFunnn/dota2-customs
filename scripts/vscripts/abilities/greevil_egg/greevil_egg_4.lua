--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_egg/greevil_egg_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 7,
		["18"] = 7,
		["19"] = 7,
		["21"] = 4,
	}
)
local f = {}
local g = require("abilities.greevil_egg.greevil_egg_base")
local h = g.GreevilEggBase
f.greevil_egg_4 = c()
local i = f.greevil_egg_4
i.name = "greevil_egg_4"
d(i, h)
function i.prototype.OnRoundGain(self, j)
	local k = self:getSpecialValueFor("base")
	if k > 0 then
		PlayerData:modifyGreevilEnergy(self:getPlayerID(), k)
	end
end
return f