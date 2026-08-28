--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100075"
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
		["13"] = 5,
		["14"] = 6,
		["15"] = 7,
		["16"] = 8,
		["17"] = 9,
		["18"] = 10,
		["19"] = 12,
		["20"] = 20,
		["21"] = 12,
		["22"] = 20,
		["23"] = 21,
		["24"] = 22,
		["25"] = 23,
		["26"] = 24,
		["27"] = 25,
		["28"] = 26,
		["29"] = 21,
		["30"] = 28,
		["31"] = 29,
		["32"] = 28,
		["33"] = 33,
		["34"] = 34,
		["35"] = 35,
		["36"] = 36,
		["37"] = 37,
		["38"] = 38,
		["39"] = 33,
		["40"] = 20,
		["41"] = 12,
		["42"] = 12,
		["43"] = 12,
		["44"] = 12,
		["45"] = 12,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 20,
		["51"] = 20,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = "models/heroes/terrorblade/terrorblade.vmdl"
local l = "models/heroes/terrorblade/demon.vmdl"
local m = "models/eom/hero/terrorblade_1/terrorblade_1.vmdl"
local n = "models/eom/hero/terrorblade_morph_1/terrorblade_morph_1.vmdl"
local o = "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf"
local p = "models/eom/hero/terrorblade_morph_1/particles/terrorblade_morph_1_attack_03_fx.vpcf"
local q = "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf"
local r = "models/eom/hero/terrorblade_morph_1/particles/terrorblade_morph_1_attack_1_fx.vpcf"
g.modifier_5100075 = c()
local s = g.modifier_5100075
s.name = "modifier_5100075"
d(s, i)
function s.prototype.OnCreated(self, t)
	local u = self:GetParent()
	Wearable:registerUnitModelModifier(u, k, m)
	Wearable:registerUnitModelModifier(u, l, n)
	Wearable:registerParticleModifier(u, q, r)
	Wearable:registerParticleModifier(u, o, p)
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL] = m }
end
function s.prototype.OnDestroy(self)
	local u = self:GetParent()
	Wearable:unregisterUnitModelModifier(u, k)
	Wearable:unregisterUnitModelModifier(u, l)
	Wearable:unregisterParticleModifier(u, q)
	Wearable:unregisterParticleModifier(u, o)
end
s = e(
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
	s
)
g.modifier_5100075 = s
return g