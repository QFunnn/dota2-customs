--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_thaw"
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
k.name = "item_ice_thaw"
d(k, j)
function k.prototype.EventListener(self)
	return {
		frozen_attenation = function(l, m)
			local n = self:GetCaster()
			if m.caster == n then
				local o = self:GetSpecialValueFor("damage")
				local n = self:GetCaster()
				local p = m.target
				local q = self:GetSpecialValueFor("count")
				p:StartThink(0.15, DoUniqueString(""), function()
					n:IceStrike(p, self, o)
					q = q - 1
					if q <= 0 then
						return -1
					end
				end)
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f