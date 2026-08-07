--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_4"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 22,
		["34"] = 22,
		["35"] = 22,
		["36"] = 22,
		["37"] = 23,
		["38"] = 24,
		["39"] = 24,
		["40"] = 24,
		["41"] = 24,
		["42"] = 24,
		["45"] = 19,
		["46"] = 27,
		["47"] = 28,
		["48"] = 29,
		["49"] = 29,
		["50"] = 29,
		["51"] = 29,
		["52"] = 29,
		["54"] = 27,
		["55"] = 17,
		["56"] = 10,
		["57"] = 10,
		["58"] = 10,
		["59"] = 10,
		["60"] = 10,
		["61"] = 10,
		["62"] = 10,
		["63"] = 17,
		["65"] = 17,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_4 = c()
local n = g.treasure_4
n.name = "treasure_4"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_4"
end
n = e({ j(nil) }, n)
g.treasure_4 = n
g.modifier_treasure_4 = c()
local o = g.modifier_treasure_4
o.name = "modifier_treasure_4"
d(o, l)
function o.prototype.OnCreated(self)
	if IsServer() then
		local p = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		self.itemName = PlayerData:getEquipmentPoolWithLevel(p.playerID, self:GetAbilitySpecialValueFor("level2"))
			:random()
		if self.itemName then
			p:modifyOverrideItem(self.itemName, self:GetAbilitySpecialValueFor("level"), false)
		end
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() and self.itemName then
		PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
			:modifyOverrideItem(self.itemName, self:GetAbilitySpecialValueFor("level"), true)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_4 = o
return g