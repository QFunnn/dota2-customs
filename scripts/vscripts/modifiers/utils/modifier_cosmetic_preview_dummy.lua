--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_cosmetic_preview_dummy"
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
		["12"] = 13,
		["13"] = 4,
		["14"] = 13,
		["15"] = 15,
		["16"] = 16,
		["17"] = 15,
		["18"] = 21,
		["19"] = 22,
		["20"] = 23,
		["22"] = 21,
		["23"] = 26,
		["24"] = 27,
		["25"] = 26,
		["26"] = 31,
		["27"] = 32,
		["28"] = 31,
		["29"] = 34,
		["30"] = 35,
		["31"] = 34,
		["32"] = 39,
		["33"] = 40,
		["34"] = 39,
		["35"] = 13,
		["36"] = 4,
		["37"] = 4,
		["38"] = 4,
		["39"] = 4,
		["40"] = 4,
		["41"] = 4,
		["42"] = 4,
		["43"] = 4,
		["44"] = 13,
		["46"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_cosmetic_preview_dummy = c()
local k = g.modifier_cosmetic_preview_dummy
k.name = "modifier_cosmetic_preview_dummy"
d(k, i)
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_UNSELECTABLE] = true }
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self.parent:SetBaseManaRegen(0)
	end
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROVIDES_FOW_POSITION }
end
function k.prototype.GetModifierProvidesFOWVision(self)
	return 1
end
function k.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function k.prototype.EOM_GetModifierMinHealth(self, l)
	return 100
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
g.modifier_cosmetic_preview_dummy = k
return g