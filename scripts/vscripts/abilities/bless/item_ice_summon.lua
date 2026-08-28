--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_summon"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_ice_summon"
d(j, h)
function j.prototype.EventListener(self)
	return {
		frozen_event = function(k, l)
			local m = self:GetCaster()
			if l.caster ~= m then
				return
			end
			local n = self:GetSpecialValueFor("chance")
			local o = self:GetSpecialValueFor("damage")
			if self:PRD(n) then
				local p = l.target
				m:IceStrike(p, self, o)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f