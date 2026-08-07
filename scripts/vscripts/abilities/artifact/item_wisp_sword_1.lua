--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_wisp_sword_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_wisp_sword_1"
d(j, h)
function j.prototype.OnCreated(self)
	if IsServer() then
		self:StartThink(self:GetSpecialValueFor("interval"), function()
			self:GetCaster():CallSword(self:GetSpecialValueFor("count"))
			return self:GetSpecialValueFor("interval")
		end)
	end
end
j = e({ i(nil) }, j)
return f