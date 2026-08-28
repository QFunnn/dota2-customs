--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_dodge"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_ice_dodge"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dash_end = function(k, l)
			if l.caster == self:GetCaster() then
				local m = self:GetCaster()
				local n = self:GetSpecialValueFor("frozen")
				local o = self:GetSpecialValueFor("damage")
				m:FrozenBurst(o, n, m:GetAbsOrigin())
				m:EmitSound("Ability.FrostNova")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f