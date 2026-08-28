--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_190"
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
		["41"] = 18,
		["42"] = 17,
		["43"] = 10,
		["44"] = 10,
		["45"] = 10,
		["46"] = 10,
		["47"] = 10,
		["48"] = 10,
		["49"] = 10,
		["50"] = 17,
		["52"] = 17,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_190 = c()
local n = g.trait_190
n.name = "trait_190"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_190"
end
n = e({ j(nil) }, n)
g.trait_190 = n
g.modifier_trait_190 = c()
local o = g.modifier_trait_190
o.name = "modifier_trait_190"
d(o, l)
function o.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local p = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	local q = p and p.hero
	local r = q and q:FindModifierByName("modifier_pudge_talent")
	if r ~= nil then
		r:ForceRefresh()
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_190 = o
return g