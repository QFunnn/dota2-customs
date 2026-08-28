--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100074"
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
		["19"] = 11,
		["20"] = 13,
		["21"] = 21,
		["22"] = 13,
		["23"] = 21,
		["24"] = 22,
		["25"] = 23,
		["26"] = 24,
		["27"] = 25,
		["28"] = 26,
		["29"] = 27,
		["30"] = 22,
		["31"] = 29,
		["32"] = 30,
		["33"] = 29,
		["34"] = 34,
		["35"] = 35,
		["36"] = 34,
		["37"] = 37,
		["38"] = 38,
		["39"] = 37,
		["40"] = 40,
		["41"] = 41,
		["42"] = 42,
		["43"] = 43,
		["44"] = 44,
		["45"] = 45,
		["46"] = 40,
		["47"] = 21,
		["48"] = 13,
		["49"] = 13,
		["50"] = 13,
		["51"] = 13,
		["52"] = 13,
		["53"] = 13,
		["54"] = 13,
		["55"] = 13,
		["56"] = 21,
		["58"] = 21,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = "models/heroes/terrorblade/terrorblade.vmdl"
local l = "models/heroes/terrorblade/demon.vmdl"
local m = "models/eom/hero/terrorblade_1/terrorblade_1.vmdl"
local n = "models/eom/hero/terrorblade_morph_1/tb_samurai_samurai_demon.vmdl"
local o = 0.82
local p = "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf"
local q = "models/eom/hero/terrorblade_morph_1/particles/terrorblade_morph_2_reflection_fx.vpcf"
local r = "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf"
local s = "models/eom/hero/terrorblade_morph_1/particles/terrorblade_morph_2_attack_1_fx.vpcf"
g.modifier_5100074 = c()
local t = g.modifier_5100074
t.name = "modifier_5100074"
d(t, i)
function t.prototype.OnCreated(self, u)
	local v = self:GetParent()
	Wearable:registerUnitModelModifier(v, k, m)
	Wearable:registerUnitModelModifier(v, l, n)
	Wearable:registerParticleModifier(v, r, s)
	Wearable:registerParticleModifier(v, p, q)
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL] = m }
end
function t.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function t.prototype.GetModifierModelScale(self)
	return self:GetParent():GetModelName() == n and (o - 1) * 100 or 0
end
function t.prototype.OnDestroy(self)
	local v = self:GetParent()
	Wearable:unregisterUnitModelModifier(v, k)
	Wearable:unregisterUnitModelModifier(v, l)
	Wearable:unregisterParticleModifier(v, r)
	Wearable:unregisterParticleModifier(v, p)
end
t = e(
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
	t
)
g.modifier_5100074 = t
return g