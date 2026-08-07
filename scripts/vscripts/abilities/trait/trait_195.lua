--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_195"
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
		["19"] = 6,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["27"] = 10,
		["28"] = 17,
		["29"] = 10,
		["30"] = 17,
		["31"] = 18,
		["32"] = 19,
		["35"] = 20,
		["36"] = 20,
		["37"] = 21,
		["39"] = 21,
		["41"] = 22,
		["43"] = 22,
		["45"] = 18,
		["46"] = 17,
		["47"] = 10,
		["48"] = 10,
		["49"] = 10,
		["50"] = 10,
		["51"] = 10,
		["52"] = 10,
		["53"] = 10,
		["54"] = 17,
		["56"] = 17,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_195 = c()
local n = g.trait_195
n.name = "trait_195"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_195"
end
n = e({ j(nil) }, n)
g.trait_195 = n
g.modifier_trait_195 = c()
local o = g.modifier_trait_195
o.name = "modifier_trait_195"
d(o, l)
function o.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local p = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	local q = p and p.hero
	local r = q and q:FindModifierByName("modifier_broodmother_talent")
	if r ~= nil then
		r:ForceRefresh()
	end
	local s = q and q:FindModifierByName("modifier_broodmother_talent_5")
	if s ~= nil then
		s:ForceRefresh()
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_195 = o
return g