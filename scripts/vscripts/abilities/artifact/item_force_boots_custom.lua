--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_force_boots_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_force_boots_custom"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dash_start = function(k, l)
			if l.caster ~= self:GetCaster() then
				return
			end
			self:SetStackCount(1)
		end,
		dash_end = function(k, l)
			if l.caster ~= self:GetCaster() then
				return
			end
			self:SetStackCount(0)
		end,
	}
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.RING_SPEED_AMPLIFY] = self:GetStackCount()
		* self:GetSpecialValueFor("ring_speed_amplify") }
end
j = e({ i(nil) }, j)
return f