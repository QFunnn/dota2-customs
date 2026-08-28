--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/utils/modifier_attribute_enemy.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__Number
local g = c.__TS__DecorateLegacy
local h = c.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["13"] = 4,
		["14"] = 12,
		["15"] = 4,
		["16"] = 12,
		["17"] = 13,
		["18"] = 14,
		["19"] = 13,
		["20"] = 18,
		["21"] = 19,
		["22"] = 18,
		["23"] = 12,
		["24"] = 4,
		["25"] = 4,
		["26"] = 4,
		["27"] = 4,
		["28"] = 4,
		["29"] = 4,
		["30"] = 4,
		["31"] = 4,
		["32"] = 12,
		["34"] = 12,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
i.modifier_attribute_enemy = d()
local m = i.modifier_attribute_enemy
m.name = "modifier_attribute_enemy"
e(m, k)
function m.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function m.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, n)
	return f(-GetCounterCriticalChance(self.caster, n))
end
m = g(
	{
		l(
			nil,
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
	m
)
i.modifier_attribute_enemy = m
return i