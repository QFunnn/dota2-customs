--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_demonblood_heart"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_demonblood_heart"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.chance = self:GetSpecialValueFor("chance")
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			if
				l.attacker == self:GetCaster()
				and bit.band(l.damage_flags, EOM_DAMAGE_FLAGS.RING_DAMAGE) == EOM_DAMAGE_FLAGS.RING_DAMAGE
				and self:PRD(self.chance)
			then
				l.target:TriggerBleed(l.attacker)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f