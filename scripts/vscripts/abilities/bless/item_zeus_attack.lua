--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_zeus_attack"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.lastTriggerTime = -1
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if m == l.attacker and l.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				local n = GameRules:GetGameTime()
				if self.lastTriggerTime == n then
					return
				end
				self.lastTriggerTime = n
				local o = self:GetSpecialValueFor("damage")
				m:ArcLightning(l.target, o)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f