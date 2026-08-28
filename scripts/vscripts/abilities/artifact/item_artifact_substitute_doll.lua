--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_substitute_doll"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_substitute_doll"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enable = true
end
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.AVOID_DAMAGE] = function(k, l)
			if self.enable and l and l.damage >= self:GetCaster():GetHealth() then
				local m = self:GetCaster()
				ParticleManager:CreateParticle(
					"particles/econ/items/antimage/antimage_ti7/antimage_blink_start_ti7.vpcf",
					PATTACH_ABSORIGIN,
					m
				)
				m:EmitSound("Greevil.Strike.Start")
				FindClearSpaceForUnit(
					m,
					m:GetAbsOrigin() + RandomVector(RandomInt(0, self:GetSpecialValueFor("teleport_radius"))),
					true
				)
				m:SetHealth(m:GetMaxHealth() * self:GetSpecialValueFor("heal_pct") * 0.01)
				self.enable = false
				return 1
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f