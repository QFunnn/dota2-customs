--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_fate_coin"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_fate_coin"
d(j, h)
function j.prototype.OnCreated(self)
	local k = self:GetSpecialValueFor("chance_low")
	local l = self:GetSpecialValueFor("hp_low_pct")
	local m = self:GetSpecialValueFor("hp_high_pct")
	local n = self:GetCaster()
	if RollPercentage(k) then
		n:SetHealth(n:GetMaxHealth() * l * 0.01)
	else
		n:SetHealth(n:GetMaxHealth() * m * 0.01)
	end
end
j = e({ i(nil) }, j)
return f