--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/permanent/modifier_demon_master_permanent"
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
		["18"] = 15,
		["19"] = 16,
		["20"] = 15,
		["21"] = 20,
		["22"] = 21,
		["23"] = 20,
		["24"] = 11,
		["25"] = 3,
		["26"] = 3,
		["27"] = 3,
		["28"] = 3,
		["29"] = 3,
		["30"] = 3,
		["31"] = 3,
		["32"] = 3,
		["33"] = 11,
		["35"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_demon_master_permanent = c()
local k = g.modifier_demon_master_permanent
k.name = "modifier_demon_master_permanent"
d(k, i)
function k.prototype.GetTexture(self)
	return "demon_master_permanent"
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE }
end
function k.prototype.EOM_GetModifierOutgoingPhysicalDamagePercentage(self, l)
	return self:GetStackCount()
end
k = e(
	{
		j(
			a,
			{
				IsHidden = false,
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
g.modifier_demon_master_permanent = k
return g