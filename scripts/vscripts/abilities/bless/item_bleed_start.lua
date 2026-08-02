--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_start"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_bleed_start"
d(k, j)
function k.prototype.EventListener(self)
	return {
		dungeon_room_start = function(l, m)
			local n = self:GetCaster()
			n:GiveMana(self:GetSpecialValueFor("fury"))
		end,
	}
end
k = e({ h(nil) }, k)
return f