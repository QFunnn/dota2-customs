--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_crit_poison"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_crit_poison"
d(j, h)
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if l.attacker ~= m then
				return
			end
			if bit.band(l.damage_flags, EOM_DAMAGE_FLAGS.SWORD) ~= EOM_DAMAGE_FLAGS.SWORD then
				return
			end
			m:Poison(l.target, self:GetSpecialValueFor("poison"))
		end,
	}
end
j = e({ i(nil) }, j)
return f