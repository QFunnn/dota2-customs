--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100561"
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
		["17"] = 16,
		["18"] = 16,
		["19"] = 16,
		["20"] = 16,
		["21"] = 15,
		["22"] = 13,
		["23"] = 4,
		["24"] = 4,
		["25"] = 4,
		["26"] = 4,
		["27"] = 4,
		["28"] = 4,
		["29"] = 4,
		["30"] = 4,
		["31"] = 4,
		["32"] = 13,
		["34"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100561 = c()
local k = g.modifier_5100561
k.name = "modifier_5100561"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerUnitModelWearableID(
		self:GetParent():GetPlayerOwnerID(),
		"models/heroes/antimage_female/antimage_female.vmdl",
		"28946,29279,29280,29281"
	)
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
				GetPriority = MODIFIER_PRIORITY_HIGH,
			}
		),
	},
	k
)
g.modifier_5100561 = k
return g