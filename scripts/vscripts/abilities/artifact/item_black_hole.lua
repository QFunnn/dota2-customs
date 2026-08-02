--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_black_hole"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_black_hole"
d(j, h)
function j.prototype.OnCreated(self)
	self:StartThink(0.1, function()
		self:SetStackCount(Bullet:GetRingBulletCount(self:GetCaster()), true)
	end)
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_AMPLIFY] = self:GetStackCount() * self:GetSpecialValueFor("damage_per_ring") }
end
j = e({ i(nil) }, j)
return f