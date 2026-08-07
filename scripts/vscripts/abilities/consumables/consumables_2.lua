--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/consumables/consumables_2"
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
		["19"] = 9,
		["20"] = 10,
		["21"] = 10,
		["22"] = 10,
		["23"] = 10,
		["24"] = 10,
		["25"] = 11,
		["26"] = 12,
		["27"] = 12,
		["28"] = 12,
		["29"] = 12,
		["30"] = 12,
		["31"] = 13,
		["32"] = 14,
		["33"] = 14,
		["34"] = 14,
		["35"] = 15,
		["36"] = 16,
		["37"] = 14,
		["38"] = 14,
		["39"] = 5,
		["40"] = 4,
		["41"] = 3,
		["42"] = 4,
		["44"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
g.consumables_2 = c()
local k = g.consumables_2
k.name = "consumables_2"
d(k, i)
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = self:GetSpecialValueFor("speed")
	local o = ParticleManager:CreateParticle(
		"particles/econ/events/frostivus/frostivus_fireworks.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(o, 0, l:GetAbsOrigin())
	ParticleManager:SetParticleControl(o, 1, m)
	ParticleManager:SetParticleControl(o, 2, Vector(n, 0, 0))
	l:EmitSound("FrostivusConsumable.Fireworks.Cast")
	GameTimer(CalcDistance(m, l) / n, function()
		ParticleManager:DestroyParticle(o, false)
		l:EmitSound("FrostivusConsumable.Fireworks.Explode")
	end)
end
k = e({ j(nil) }, k)
g.consumables_2 = k
return g