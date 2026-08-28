--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_poison"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_holy_poison"
d(k, j)
function k.prototype.EventListener(self)
	return {
		poison_event = function(l, m)
			local n = self:GetCaster()
			if m.caster == n then
				n:DealDamage(
					m.target,
					nil,
					self:GetSpecialValueFor("poison"),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					EOM_DAMAGE_FLAGS.POISON_DAMAGE
				)
				n:Weaken(m.target)
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f