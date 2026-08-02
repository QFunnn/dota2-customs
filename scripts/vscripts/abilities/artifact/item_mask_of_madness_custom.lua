--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_mask_of_madness_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_mask_of_madness_custom"
d(j, h)
function j.prototype.OnDestroy(self)
	self:DestroyParticle()
end
function j.prototype.EventListener(self)
	return {
		attack_event = function(k, l)
			local m = self:GetCaster()
			if l.attacker ~= m then
				return
			end
			local n = self:GetSpecialValueFor("fury_cost")
			if m:GetMana() >= n and self:IsCooldownReady() and self:GetStackCount() <= 0 then
				m:SpendMana(n, self)
				self:UseCooldown()
				self:SetStackCount(1)
				self:DestroyParticle()
				local o = ParticleManager:CreateParticle(
					"particles/econ/items/drow/drow_head_mania/mask_of_madness_active_mania.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlEnt(
					o,
					0,
					m,
					PATTACH_POINT_FOLLOW,
					"attach_attack1",
					m:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					o,
					1,
					m,
					PATTACH_POINT_FOLLOW,
					"attach_attack2",
					m:GetAbsOrigin(),
					true
				)
				self.particleID = o
				m:EmitSound("DOTA_Item.MaskOfMadness.Activate")
				self:StartThink(self:GetSpecialValueFor("duration"), "buff", function()
					self:SetStackCount(0)
					self:DestroyParticle()
					return -1
				end)
			end
		end,
	}
end
function j.prototype.DestroyParticle(self)
	if self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, false)
		self.particleID = nil
	end
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACKSPEED] = self:GetSpecialValueFor("attackspeed") * self:GetStackCount() }
end
j = e({ i(nil) }, j)
return f