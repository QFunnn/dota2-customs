--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_crit_dodge"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_crit_dodge"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dash_start = function(k, l)
			if l.caster == self:GetCaster() then
				self:SetStackCount(1)
				self:StartThink(self:GetSpecialValueFor("duration"), function()
					self:SetStackCount(0)
					return -1
				end)
			end
		end,
	}
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.CRIT_CHANCE] = self:GetSpecialValueFor("crit_chance") * self:GetStackCount() }
end
j = e({ i(nil) }, j)
return f