--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_indomitable_badge"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_indomitable_badge"
d(j, h)
function j.prototype.EventListener(self)
	return {
		hero_respawn = function(k, l)
			if l.unit == self:GetCaster() then
				self:SetStackCount(1, false)
				self:StartThink(self:GetSpecialValueFor("duration"), "cooldown", function()
					self:SetStackCount(0, false)
					return -1
				end)
			end
		end,
	}
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_AMPLIFY] = self:GetSpecialValueFor("damage_amplify") * self:GetStackCount() }
end
j = e({ i(nil) }, j)
return f