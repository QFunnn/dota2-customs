--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_broken_custom"
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
		["13"] = 13,
		["14"] = 4,
		["15"] = 13,
		["16"] = 14,
		["17"] = 15,
		["18"] = 16,
		["19"] = 17,
		["22"] = 14,
		["23"] = 21,
		["24"] = 22,
		["25"] = 23,
		["26"] = 24,
		["29"] = 21,
		["30"] = 28,
		["31"] = 29,
		["32"] = 28,
		["33"] = 13,
		["34"] = 4,
		["35"] = 4,
		["36"] = 4,
		["37"] = 4,
		["38"] = 4,
		["39"] = 4,
		["40"] = 4,
		["41"] = 4,
		["42"] = 4,
		["43"] = 13,
		["45"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_broken_custom = c()
local k = g.modifier_broken_custom
k.name = "modifier_broken_custom"
d(k, i)
function k.prototype.OnCreated(self)
	if IsServer() then
		if not self.parent:HasModifier("modifier_state_immunity_custom") then
			CombatLog:recordState(self.parent, self.caster, "Broken", "add")
		end
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		if not self.parent:HasModifier("modifier_state_immunity_custom") then
			CombatLog:recordState(self.parent, nil, "Broken", "loss")
		end
	end
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
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
				DestroyOnExpire = false,
			}
		),
	},
	k
)
g.modifier_broken_custom = k
return g