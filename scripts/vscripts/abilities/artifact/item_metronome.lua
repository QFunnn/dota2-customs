--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_metronome"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_metronome"
d(j, h)
function j.prototype.EventListener(self)
	return {
		entity_killed = function(k, l)
			if l.attacker == self:GetCaster() then
				self:IncrementStackCount()
				self:SetCurrentCharges(self:GetStackCount())
			end
		end,
		damage_event = function(k, l)
			if l.target == self:GetCaster() then
				self:SetStackCount(0)
				self:SetCurrentCharges(0)
			end
		end,
	}
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACK_AMPLIFY] = self:GetStackCount() }
end
j = e({ i(nil) }, j)
return f