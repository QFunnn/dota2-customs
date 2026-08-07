--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100029"
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
		["15"] = 14,
		["16"] = 19,
		["17"] = 19,
		["18"] = 19,
		["19"] = 19,
		["20"] = 19,
		["21"] = 14,
		["22"] = 28,
		["23"] = 29,
		["24"] = 28,
		["25"] = 34,
		["26"] = 35,
		["27"] = 34,
		["28"] = 37,
		["29"] = 38,
		["30"] = 37,
		["31"] = 12,
		["32"] = 4,
		["33"] = 4,
		["34"] = 4,
		["35"] = 4,
		["36"] = 4,
		["37"] = 4,
		["38"] = 4,
		["39"] = 4,
		["40"] = 12,
		["42"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100029 = c()
local k = g.modifier_5100029
k.name = "modifier_5100029"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerSoundModifier(self:GetParent(), "Hero_Ursa.Overpower", "Hero_Lina.DragonSlave.FireHair")
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function k.prototype.GetModifierModelScale(self)
	return 20
end
function k.prototype.GetAttackSound(self)
	return "Hero_NagaSiren.Attack"
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
g.modifier_5100029 = k
return g