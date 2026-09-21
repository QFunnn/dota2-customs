--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_crit"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_zeus_crit"
d(j, h)
function j.prototype.EventListener(self)
	return {
		crit_event = function(k, l)
			local m = self:GetCaster()
			if m == l.attacker and IsValid(l.target) and l.target:IsAlive() then
				local n = self:GetSpecialValueFor("damage")
				m:LightningStrike(l.target, n, bit.bor(EOM_DAMAGE_FLAGS.NO_CRIT, EOM_DAMAGE_FLAGS.NO_EXPOSE))
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f