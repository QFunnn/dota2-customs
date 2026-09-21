--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
				local p = m.target
				if not IsValid(p) or not p:IsAlive() then
					return
				end
				local q = "ice_thaw_" .. tostring(self:entindex())
				local r = p._ThinkList
				if (r and r[q]) ~= nil then
					return
				end
				p:StartThink(0.15, q, function()
					if not IsValid(self) or not IsValid(n) or not n:IsAlive() or not IsValid(p) or not p:IsAlive() then
						return -1
					end
					n:IceStrike(p, self, o)
					return -1
				end)
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f