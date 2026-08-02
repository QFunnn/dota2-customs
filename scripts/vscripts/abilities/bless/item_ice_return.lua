--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_return"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_ice_return"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enableTime = GameRules:GetGameTime()
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if m ~= l.target then
				return
			end
			if self.enableTime > GameRules:GetGameTime() then
				return
			end
			local n = self:GetSpecialValueFor("frozen")
			local o = self:GetSpecialValueFor("damage")
			self.enableTime = GameRules:GetGameTime() + COUNTER_CD
			m:FrozenBurst(o, n, l.attacker:GetAbsOrigin())
			m:EmitSound("Ability.FrostNova")
		end,
	}
end
j = e({ i(nil) }, j)
return f