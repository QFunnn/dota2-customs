--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_consume"
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
k.name = "item_zeus_consume"
d(k, i)
function k.prototype.EventListener(self)
	return {
		expose_effect = function(l, m)
			if m.attacker == self:GetCaster() and self:PRD(self.chance) then
				local n = m.attacker
				local o = m.target
				self:StartThink(0, DoUniqueString(""), function(p)
					if IsValid(n) and IsValid(o) then
						local q = self:GetSpecialValueFor("damage")
						n:LightningStrike(o, q, EOM_DAMAGE_FLAGS.NO_EXPOSE)
					end
					return -1
				end)
			end
		end,
	}
end
e({ h(nil) }, k.prototype, "chance", nil)
k = e({ j(nil) }, k)
return f