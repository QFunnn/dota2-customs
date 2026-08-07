--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_blitz_knuckles_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_blitz_knuckles_custom"
d(j, h)
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			local n = self:GetSpecialValueFor("chance")
			if m == l.attacker and l.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and self:PRD(n) then
				local o = CalcDistance(m, l.target) + self:GetSpecialValueFor("radius")
				local p = self:GetSpecialValueFor("damage")
				local q = self:GetSpecialValueFor("count")
				m:EnergyStrike(
					l.target,
					o,
					self,
					q,
					p,
					"particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf",
					{ jumpDelay = 0.25, jumpRadius = 650, soundName = "Hero_Zuus.ArcLightning.Cast" }
				)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f