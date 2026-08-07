--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_blind_custom"
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
		["20"] = 13,
		["21"] = 21,
		["22"] = 22,
		["23"] = 21,
		["24"] = 12,
		["25"] = 4,
		["26"] = 4,
		["27"] = 4,
		["28"] = 4,
		["29"] = 4,
		["30"] = 4,
		["31"] = 4,
		["32"] = 4,
		["33"] = 12,
		["35"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_blind_custom = c()
local k = g.modifier_blind_custom
k.name = "modifier_blind_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
	else
	end
end
function k.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_MISS] = BUFF_VALUE.BlindChance }
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	k
)
g.modifier_blind_custom = k
return g