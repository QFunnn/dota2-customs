--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_haste_custom"
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
		["17"] = 14,
		["18"] = 16,
		["20"] = 12,
		["21"] = 19,
		["22"] = 20,
		["23"] = 19,
		["24"] = 22,
		["25"] = 23,
		["26"] = 22,
		["27"] = 27,
		["28"] = 31,
		["29"] = 27,
		["30"] = 38,
		["31"] = 39,
		["32"] = 39,
		["33"] = 39,
		["34"] = 39,
		["35"] = 38,
		["36"] = 11,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 11,
		["47"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_haste_custom = c()
local k = g.modifier_haste_custom
k.name = "modifier_haste_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self:StartIntervalThink(1)
	end
end
function k.prototype.OnIntervalThink(self)
	self:IncrementStackCount()
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function k.prototype.GetModifierTotalPercentageManaRegen(self)
	return 0
end
function k.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return SPEED_UP_DAMAGE_PCT * math.max(self:GetStackCount() - SPEED_UP_TIME, 0)
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_haste_custom = k
return g