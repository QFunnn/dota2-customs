--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100043"
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
		["12"] = 12,
		["13"] = 4,
		["14"] = 12,
		["16"] = 12,
		["17"] = 14,
		["18"] = 4,
		["19"] = 15,
		["20"] = 16,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 16,
		["25"] = 15,
		["26"] = 18,
		["27"] = 19,
		["28"] = 18,
		["29"] = 23,
		["30"] = 24,
		["31"] = 23,
		["32"] = 12,
		["33"] = 4,
		["34"] = 4,
		["35"] = 4,
		["36"] = 4,
		["37"] = 4,
		["38"] = 4,
		["39"] = 4,
		["40"] = 4,
		["41"] = 12,
		["43"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100043 = c()
local k = g.modifier_5100043
k.name = "modifier_5100043"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.modifierd = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf",
		"models/eom/hero/juggernaut_3/particles/juggernaut_3_blade_fury_abyssal.vpcf"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function k.prototype.GetModifierModelScale(self)
	return 40
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
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_5100043 = k
return g