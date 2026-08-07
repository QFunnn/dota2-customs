--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_blazescale_bracers"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_blazescale_bracers"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dungeon_room_start = function()
			local k = self:GetCaster()
			local l = self:GetSpecialValueFor("shield_amount")
			k:AddShield(l, "item_artifact_blazescale_bracers", "override", "permanent")
		end,
	}
end
j = e({ i(nil) }, j)
return f