--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_ultimate"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_holy_ultimate"
d(j, h)
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(k, l)
			local m = self:GetCaster()
			if m ~= l.caster or l.abilityTag ~= AbilityTag.Ultimate then
				return
			end
			self:SetStackCount(self:GetSpecialValueFor("count"))
			self:DestroyParticle()
			self.particleID = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				m
			)
			m:EmitSound("Hero_Omniknight.GuardianAngel.Cast")
			self:StartThink(self:GetSpecialValueFor("duration"), "duration", function()
				self:SetStackCount(0)
				self:DestroyParticle()
				return -1
			end)
		end,
	}
end
function j.prototype.DestroyParticle(self)
	if self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, false)
		self.particleID = nil
	end
end
function j.prototype.OnDestroy(self)
	self:DestroyParticle()
end
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.AVOID_DAMAGE] = function()
			if self:GetStackCount() > 0 then
				self:DecrementStackCount()
				if self:GetStackCount() <= 0 then
					self:DestroyParticle()
				end
				return 1
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f