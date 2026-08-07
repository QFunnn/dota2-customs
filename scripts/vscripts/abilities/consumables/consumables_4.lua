--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/consumables/consumables_4"
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
		["17"] = 7,
		["18"] = 8,
		["19"] = 8,
		["20"] = 8,
		["21"] = 8,
		["22"] = 8,
		["23"] = 9,
		["24"] = 5,
		["25"] = 4,
		["26"] = 3,
		["27"] = 4,
		["29"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
g.consumables_4 = c()
local k = g.consumables_4
k.name = "consumables_4"
d(k, i)
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = ParticleManager:CreateParticle(
		"particles/econ/events/new_bloom/firecracker_explode.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(m, 0, l:GetAbsOrigin() + RandomVector(100))
	l:EmitSound("SeasonalConsumable.Firecrackers.Explode")
end
k = e({ j(nil) }, k)
g.consumables_4 = k
return g