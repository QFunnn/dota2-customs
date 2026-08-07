--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/demo/modifier_dummy_damage"
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
		["15"] = 12,
		["16"] = 13,
		["17"] = 12,
		["18"] = 18,
		["19"] = 19,
		["20"] = 20,
		["21"] = 20,
		["22"] = 19,
		["23"] = 18,
		["24"] = 23,
		["25"] = 24,
		["26"] = 23,
		["27"] = 26,
		["28"] = 27,
		["29"] = 26,
		["30"] = 29,
		["31"] = 30,
		["32"] = 31,
		["33"] = 29,
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
local i = h.registerEOMModifier
local j = h.EOMModifier
g.modifier_dummy_damage = c()
local k = g.modifier_dummy_damage
k.name = "modifier_dummy_damage"
d(k, j)
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MIN_HEALTH, MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end
function k.prototype.EDeclareEvents(self)
	return { [MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function k.prototype.GetMinHealth(self)
	return 1
end
function k.prototype.GetModifierConstantHealthRegen(self)
	return 1000
end
function k.prototype.OnTakeDamage(self, l)
	local m = self:GetParent()
	m:StartGesture(ACT_DOTA_FLINCH)
end
k = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	k
)
g.modifier_dummy_damage = k
return g