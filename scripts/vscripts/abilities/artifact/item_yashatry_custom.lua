--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_yashatry_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMItem
local j = g.registerEOMAbility
local k = c()
k.name = "item_yashatry_custom"
d(k, i)
function k.prototype.OnCreated(self)
	self:StartThink(0, function()
		self:SetStackCount(math.floor(GetMovespeed(self:GetCaster()) / self.threshold * self.damage_pct))
	end)
end
function k.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACK_AMPLIFY] = self:GetStackCount() }
end
e({ h(nil) }, k.prototype, "damage_pct", nil)
e({ h(nil) }, k.prototype, "threshold", nil)
k = e({ j(nil) }, k)
return f