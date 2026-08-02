--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_team_card_attribute"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Number
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["13"] = 4,
		["14"] = 12,
		["15"] = 4,
		["16"] = 12,
		["18"] = 12,
		["19"] = 13,
		["20"] = 14,
		["21"] = 4,
		["22"] = 15,
		["23"] = 16,
		["24"] = 17,
		["25"] = 18,
		["26"] = 19,
		["28"] = 21,
		["30"] = 23,
		["31"] = 15,
		["32"] = 25,
		["33"] = 26,
		["34"] = 25,
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["38"] = 30,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 42,
		["47"] = 44,
		["49"] = 34,
		["50"] = 47,
		["51"] = 48,
		["52"] = 49,
		["53"] = 50,
		["54"] = 51,
		["56"] = 53,
		["57"] = 47,
		["58"] = 12,
		["59"] = 4,
		["60"] = 4,
		["61"] = 4,
		["62"] = 4,
		["63"] = 4,
		["64"] = 4,
		["65"] = 4,
		["66"] = 4,
		["67"] = 12,
		["69"] = 12,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_team_card_attribute = c()
local l = h.modifier_team_card_attribute
l.name = "modifier_team_card_attribute"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.originAttributeData = "{}"
	self.parsedAttributeData = {}
end
function l.prototype.OnCreated(self, m)
	self.parsedAttributeData = {}
	if IsServer() then
		if m.attributeList ~= nil then
			self.originAttributeData = m.attributeList
		end
		self:ParseAttributeData()
	end
	self:SetHasCustomTransmitterData(true)
end
function l.prototype.AddCustomTransmitterData(self)
	return { originAttributeData = self.originAttributeData }
end
function l.prototype.HandleCustomTransmitterData(self, n)
	self.originAttributeData = n.originAttributeData
	self:ParseAttributeData()
end
function l.prototype.ParseAttributeData(self)
	local o = self:GetParent()
	self.parsedAttributeData = {}
	local n = json.decode(self.originAttributeData)
	self.parsedAttributeData = n
	for p, q in pairs(self.parsedAttributeData) do
		local r = e(p)
		RegisterModifierProperty(o, self, r)
		self[EOMModifierFunctionName[r]] = function()
			return q
		end
	end
end
function l.prototype.OnDestroy(self)
	local o = self:GetParent()
	for p, s in pairs(self.parsedAttributeData) do
		local r = e(p)
		UnregisterModifierProperty(o, self, r)
	end
	self.parsedAttributeData = {}
end
l = f(
	{
		k(
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
	l
)
h.modifier_team_card_attribute = l
return h