--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_wind_zeus"
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
k.name = "item_wind_zeus"
d(k, j)
function k.prototype.OnCreated(self)
	local l = self:GetCaster()
	local m = self:GetSpecialValueFor("interval")
	self:StartThink(m, function()
		local n = self:GetSpecialValueFor("damage")
		local o = FindEnemiesInRadius(l, l:GetAbsOrigin(), self:GetSpecialValueFor("radius"))
		local p = GetRandomElement(o)
		if IsValid(p) then
			l:LightningStrike(p, n)
		end
	end)
end
k = e({ h(nil) }, k)
return f