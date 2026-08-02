--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_bloodpact_blade"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_bloodpact_blade"
d(j, h)
function j.prototype.EventListener(self)
	return {
		entity_killed = function(k, l)
			if l.attacker == self:GetCaster() then
				l.attacker:Heal(self:GetSpecialValueFor("heal_per_kill"), self)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f