--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_potion"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_poison_potion"
d(j, h)
function j.prototype.EventListener(self)
	return {
		potion_heal = function(k, l)
			local m = self:GetCaster()
			if m == l.caster and self:GetStackCount() < self:GetSpecialValueFor("max_count") then
				self:IncrementStackCount()
			end
		end,
	}
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_AMPLIFY] = self:GetSpecialValueFor("damage_pct") * self:GetStackCount() }
end
j = e({ i(nil) }, j)
return f