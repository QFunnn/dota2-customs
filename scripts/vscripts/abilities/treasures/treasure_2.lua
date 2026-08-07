--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_2"
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
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["30"] = 18,
		["31"] = 19,
		["32"] = 19,
		["34"] = 18,
		["35"] = 22,
		["36"] = 23,
		["37"] = 22,
		["38"] = 28,
		["39"] = 29,
		["40"] = 29,
		["42"] = 28,
		["43"] = 17,
		["44"] = 10,
		["45"] = 10,
		["46"] = 10,
		["47"] = 10,
		["48"] = 10,
		["49"] = 10,
		["50"] = 10,
		["51"] = 17,
		["53"] = 17,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_2 = c()
local n = g.treasure_2
n.name = "treasure_2"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_2"
end
n = e({ j(nil) }, n)
g.treasure_2 = n
g.modifier_treasure_2 = c()
local o = g.modifier_treasure_2
o.name = "modifier_treasure_2"
d(o, l)
function o.prototype.OnCreated(self)
	if IsServer() then
		PlayerData:updateNetTable(self:GetParent():GetPlayerOwnerID())
	end
end
function o.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_SHOP_REFRESH_COST_PERCENTAGE] = -self:GetAbilitySpecialValueFor(
			"refresh_gold_reduce"
		),
	}
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		PlayerData:updateNetTable(self:GetParent():GetPlayerOwnerID())
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_2 = o
return g