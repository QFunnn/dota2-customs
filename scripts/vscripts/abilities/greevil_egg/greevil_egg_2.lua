--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_egg/greevil_egg_2"
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
		["14"] = 6,
		["15"] = 7,
		["18"] = 11,
		["19"] = 12,
		["20"] = 13,
		["23"] = 16,
		["24"] = 17,
		["25"] = 18,
		["26"] = 19,
		["27"] = 19,
		["28"] = 19,
		["29"] = 19,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["34"] = 22,
		["35"] = 22,
		["37"] = 4,
	}
)
local f = {}
local g = require("abilities.greevil_egg.greevil_egg_base")
local h = g.GreevilEggBase
f.greevil_egg_2 = c()
local i = f.greevil_egg_2
i.name = "greevil_egg_2"
d(i, h)
function i.prototype.OnRoundGain(self, j)
	local k = j - 1
	if GameState:isNeutralRound(k) or GameState:isRoshanRound(k) then
		return
	end
	local l = PlayerData:getplayerData(self:getPlayerID())
	local m = l and l.loseStack or 0
	if m <= 0 then
		return
	end
	local n = Greevil:getPlayerData(self:getPlayerID())
	if not n.shop_enabled then
		local o = self:getSpecialValueFor("lv1")
		PlayerData:modifyGreevilEnergy(self:getPlayerID(), o)
	else
		local p = self:getSpecialValueFor("lv2")
		PlayerData:modifyGreevilEnergy(self:getPlayerID(), p)
	end
end
return f