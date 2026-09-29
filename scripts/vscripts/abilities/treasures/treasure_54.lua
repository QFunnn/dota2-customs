--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_54"
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
		["20"] = 11,
		["21"] = 11,
		["22"] = 11,
		["23"] = 11,
		["24"] = 12,
		["25"] = 12,
		["26"] = 12,
		["27"] = 12,
		["28"] = 13,
		["31"] = 17,
		["32"] = 18,
		["33"] = 18,
		["34"] = 18,
		["35"] = 18,
		["36"] = 18,
		["37"] = 18,
		["38"] = 18,
		["39"] = 18,
		["40"] = 5,
		["41"] = 4,
		["42"] = 3,
		["43"] = 4,
		["45"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.treasure_54 = c()
local k = g.treasure_54
k.name = "treasure_54"
d(k, i)
function k.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local l = self:GetCaster():GetPlayerOwnerID()
	local m = math.max(0, PlayerData:GetLossHealth(l))
	local n = math.min(
		math.floor(m / self:GetSpecialValueFor("health")) * self:GetSpecialValueFor("gold"),
		self:GetSpecialValueFor("limit")
	)
	if n <= 0 then
		return
	end
	PlayerData:modifyGold(l, n)
	Notification:combatToPlayer(
		l,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
			int_gold = n,
		}
	)
end
k = e({ j(nil) }, k)
g.treasure_54 = k
return g