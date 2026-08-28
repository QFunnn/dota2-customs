--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_55"
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
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 32,
		["39"] = 36,
		["40"] = 37,
		["41"] = 38,
		["44"] = 27,
		["45"] = 42,
		["46"] = 43,
		["47"] = 44,
		["48"] = 45,
		["49"] = 46,
		["50"] = 47,
		["53"] = 42,
		["54"] = 19,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 19,
		["64"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_55 = c()
local n = g.trait_55
n.name = "trait_55"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_55"
end
n = e({ j(nil) }, n)
g.trait_55 = n
g.modifier_trait_55 = c()
local o = g.modifier_trait_55
o.name = "modifier_trait_55"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.level = self:GetAbilitySpecialValueFor("level")
	self.level2 = self:GetAbilitySpecialValueFor("level2")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		local s = PlayerData:getEquipmentPoolWithLevel(q, self.level2)
		self.itemName = s:random()
		if self.itemName then
			r:modifyOverrideItem(self.itemName, self.level, false)
		end
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		if self.itemName then
			local q = self:GetParent():GetPlayerOwnerID()
			local r = PlayerData:getHero(q)
			r:modifyOverrideItem(self.itemName, self.level, true)
		end
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_55 = o
return g