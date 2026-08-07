--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_122"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 23,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 32,
		["46"] = 21,
		["47"] = 38,
		["48"] = 39,
		["49"] = 40,
		["50"] = 41,
		["51"] = 42,
		["52"] = 43,
		["53"] = 44,
		["57"] = 38,
		["58"] = 19,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 19,
		["68"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_122 = c()
local n = g.trait_122
n.name = "trait_122"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_122"
end
n = e({ j(nil) }, n)
g.trait_122 = n
g.modifier_trait_122 = c()
local o = g.modifier_trait_122
o.name = "modifier_trait_122"
d(o, l)
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getplayerData(q)
		if r then
			local s = r.hero
			if s then
				local t = PlayerData:getEquipmentPoolWithLevel(q, 4)
				t:set("item_equipment_128", 0)
				self.equipment = t:random()
				if self.equipment then
					s:modifyOverrideItem(self.equipment, 4)
				end
			end
		end
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		if self.equipment then
			local s = PlayerData:getHero(q)
			if s then
				s:modifyOverrideItem(self.equipment, 4)
			end
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
g.modifier_trait_122 = o
return g