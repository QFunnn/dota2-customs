--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_poison"
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
k.name = "item_zeus_poison"
d(k, i)
function k.prototype.EventListener(self)
	return {
		damage_event = function(l, m)
			if
				m.attacker == self:GetCaster()
				and BitAndEquals(m.damage_flags, EOM_DAMAGE_FLAGS.POISON_DAMAGE)
				and self:PRD(self.chance)
			then
				self:GetCaster():LightningStrike(m.target, self:GetSpecialValueFor("damage"))
			end
		end,
	}
end
e({ h(nil) }, k.prototype, "chance", nil)
k = e({ j(nil) }, k)
return f