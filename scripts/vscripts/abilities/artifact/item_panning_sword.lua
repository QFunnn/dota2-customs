--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_panning_sword"
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
k.name = "item_panning_sword"
d(k, i)
function k.prototype.EventListener(self)
	return {
		entity_killed = function(l, m)
			if m.attacker == self:GetCaster() and self:PRD(self.chance) then
				Player:ModifyGold(m.attacker:GetPlayerOwnerID(), self.gold)
				Notification:CombatToPlayer(
					m.attacker:GetPlayerOwnerID(),
					{ message = "Notify_item_ofrenda_shovel_custom", item_name = "item_panning_sword", int_value = self.gold }
				)
			end
		end,
	}
end
e({ h(nil) }, k.prototype, "chance", nil)
e({ h(nil) }, k.prototype, "gold", nil)
k = e({ j(nil) }, k)
return f