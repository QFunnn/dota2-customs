--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_thunder_blessing"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_zeus_thunder_blessing"
d(j, h)
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if m ~= l.target then
				return
			end
			if not self:IsCooldownReady() then
				return
			end
			local n = self:GetSpecialValueFor("radius")
			local o = self:GetSpecialValueFor("expose_stack")
			local p = FindEnemiesInRadius(m, m:GetAbsOrigin(), n)
			for k, q in ipairs(p) do
				m:AddExpose(q, o)
			end
			self:StartCooldown(self:GetSpecialValueFor("cd"))
		end,
	}
end
j = e({ i(nil) }, j)
return f