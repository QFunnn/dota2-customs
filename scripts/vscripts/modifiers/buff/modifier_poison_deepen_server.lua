--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_poison_deepen_server"
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
		["20"] = 14,
		["21"] = 19,
		["22"] = 20,
		["23"] = 19,
		["24"] = 24,
		["25"] = 25,
		["26"] = 24,
		["27"] = 13,
		["28"] = 4,
		["29"] = 4,
		["30"] = 4,
		["31"] = 4,
		["32"] = 4,
		["33"] = 4,
		["34"] = 4,
		["35"] = 4,
		["36"] = 4,
		["37"] = 13,
		["39"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_poison_deepen_server = c()
local k = g.modifier_poison_deepen_server
k.name = "modifier_poison_deepen_server"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(l.iStackCount)
	end
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DEEPEN }
end
function k.prototype.EOM_GetModifierPoisonDeepen(self, l)
	return self:GetStackCount()
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	k
)
g.modifier_poison_deepen_server = k
return g