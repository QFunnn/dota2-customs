--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_spider_amulet"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_spider_amulet"
d(j, h)
function j.prototype.OnDestroy(self)
	self:GetCaster():RemoveShield("item_spider_amulet")
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if l.target == m and l.damage > 0 then
				m:AddShield(self:GetSpecialValueFor("shield"), "item_spider_amulet")
				self:SetStackCount(m:GetShield("item_spider_amulet"))
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f