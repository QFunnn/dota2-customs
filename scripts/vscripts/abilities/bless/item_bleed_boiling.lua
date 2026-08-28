--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_boiling"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_bleed_boiling"
d(j, h)
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(k, l)
			local m = self:GetCaster()
			if m ~= l.caster or l.abilityTag ~= AbilityTag.Ultimate then
				return
			end
			m:GiveMana(self:GetSpecialValueFor("fury"))
		end,
	}
end
j = e({ i(nil) }, j)
return f