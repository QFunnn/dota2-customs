--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_skin"
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
		["12"] = 3,
		["13"] = 11,
		["15"] = 11,
		["16"] = 12,
		["17"] = 3,
		["18"] = 13,
		["19"] = 14,
		["20"] = 15,
		["21"] = 16,
		["22"] = 16,
		["24"] = 13,
		["25"] = 19,
		["26"] = 20,
		["27"] = 21,
		["28"] = 22,
		["29"] = 22,
		["31"] = 19,
		["32"] = 25,
		["33"] = 26,
		["35"] = 25,
		["36"] = 29,
		["37"] = 30,
		["38"] = 29,
		["39"] = 34,
		["40"] = 35,
		["41"] = 34,
		["42"] = 37,
		["43"] = 38,
		["44"] = 37,
		["45"] = 42,
		["46"] = 43,
		["47"] = 42,
		["48"] = 11,
		["49"] = 3,
		["50"] = 3,
		["51"] = 3,
		["52"] = 3,
		["53"] = 3,
		["54"] = 3,
		["55"] = 3,
		["56"] = 3,
		["57"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = c()
k.name = "modifier_skin"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.cosmeticIDs = {}
end
function k.prototype.OnCreated(self, l)
	self:SetHasCustomTransmitterData(true)
	if IsServer() then
		local m = self.cosmeticIDs
		m[#m + 1] = l.id
	end
end
function k.prototype.OnRefresh(self, l)
	self:SetHasCustomTransmitterData(true)
	if IsServer() then
		local n = self.cosmeticIDs
		n[#n + 1] = l.id
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function k.prototype.AddCustomTransmitterData(self)
	return { cosmeticIDs = self.cosmeticIDs }
end
function k.prototype.HandleCustomTransmitterData(self, o)
	self.cosmeticIDs = o.cosmeticIDs
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function k.prototype.GetActivityTranslationModifiers(self)
	return table.concat(self.cosmeticIDs, " ")
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
return g