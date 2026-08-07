--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_respawn"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_holy_respawn"
d(j, h)
function j.prototype.OnCreated(self)
	Player:ModifyHeart(self:GetCaster():GetPlayerOwnerID(), 1)
end
function j.prototype.EventListener(self)
	return {
		hero_respawn = function(k, l)
			local m = self:GetCaster()
			if m == l.unit then
				m:AddInvulnerable(self:GetSpecialValueFor("duration"))
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f