--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_custom_no_health_bar"
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
		["12"] = 4,
		["13"] = 12,
		["14"] = 4,
		["15"] = 12,
		["16"] = 13,
		["17"] = 14,
		["18"] = 13,
		["19"] = 12,
		["20"] = 4,
		["21"] = 4,
		["22"] = 4,
		["23"] = 4,
		["24"] = 4,
		["25"] = 4,
		["26"] = 4,
		["27"] = 4,
		["28"] = 12,
		["30"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_custom_no_health_bar = c()
local k = g.modifier_custom_no_health_bar
k.name = "modifier_custom_no_health_bar"
d(k, i)
function k.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_NO_HEALTH_BAR] = true }
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
g.modifier_custom_no_health_bar = k
return g