--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_courier_teleport"
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
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 13,
		["16"] = 14,
		["17"] = 15,
		["18"] = 16,
		["19"] = 17,
		["20"] = 18,
		["21"] = 19,
		["24"] = 13,
		["25"] = 23,
		["26"] = 24,
		["27"] = 25,
		["28"] = 26,
		["29"] = 27,
		["30"] = 28,
		["33"] = 23,
		["34"] = 11,
		["35"] = 3,
		["36"] = 3,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 11,
		["45"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_courier_teleport = c()
local k = g.modifier_courier_teleport
k.name = "modifier_courier_teleport"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self.oid = l.oid
		local n = KeyValues.CosmeticsKV[l.oid]
		if n and n.resource then
			Wearable:registerParticleModifier(
				m,
				"particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf",
				n.resource
			)
		end
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		local m = self:GetParent()
		local n = KeyValues.CosmeticsKV[self.oid]
		if n and n.resource then
			Wearable:unregisterParticleModifier(m, n.resource)
		end
	end
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_courier_teleport = k
return g