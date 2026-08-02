--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_44"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["41"] = 20,
		["42"] = 32,
		["43"] = 33,
		["44"] = 34,
		["45"] = 35,
		["46"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 39,
		["50"] = 40,
		["53"] = 32,
		["54"] = 19,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 19,
		["64"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_44 = c()
local n = g.trait_44
n.name = "trait_44"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_44"
end
n = e({ j(nil) }, n)
g.trait_44 = n
g.modifier_trait_44 = c()
local o = g.modifier_trait_44
o.name = "modifier_trait_44"
d(o, l)
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		if r then
			r:modifyOverrideItem("null", 1, false)
			r:modifyOverrideItem("null", 2, false)
			r:modifyOverrideItem("item_equipment_128", 3, false)
			r:modifyOverrideItem("null", 4, false)
		end
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		if r then
			r:modifyOverrideItem("null", 1, true)
			r:modifyOverrideItem("null", 2, true)
			r:modifyOverrideItem("item_equipment_128", 3, true)
			r:modifyOverrideItem("null", 4, true)
		end
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_44 = o
return g