--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_5"
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
		["11"] = 4,
		["12"] = 5,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["22"] = 12,
		["23"] = 12,
		["24"] = 12,
		["25"] = 12,
		["26"] = 12,
		["27"] = 12,
		["29"] = 6,
		["30"] = 5,
		["31"] = 4,
		["32"] = 5,
		["34"] = 5,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.treasure_5 = c()
local k = g.treasure_5
k.name = "treasure_5"
d(k, i)
function k.prototype.Spawn(self)
	if IsServer() then
		local l = self:GetCaster():GetPlayerOwnerID()
		local m = self:GetSpecialValueFor("regen")
		local n = PlayerResource:GetSelectedHeroEntity(l)
		PlayerData:modifyHealth(l, m)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, n, m, n:GetPlayerOwner())
	end
end
k = e({ j(nil) }, k)
g.treasure_5 = k
return g