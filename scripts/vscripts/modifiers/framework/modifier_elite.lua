--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_elite"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Number
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = c()
k.name = "modifier_elite"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartThink(0, function()
			self:GetParent():AddShield(self:GetParent():GetMaxHealth() * 2, "elite", "override", "permanent")
			return -1
		end)
	else
		local m = ParticleManager:CreateParticleForce(
			"particles/units/enemy/elite_ambient.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			m,
			1,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			self.parent:GetAbsOrigin(),
			false
		)
		self:AddParticle(m, false, false, -1, false, false)
		local n = ParticleManager:CreateParticleForce(
			"particles/status_fx/status_effect_faceless_timewalk.vpcf",
			PATTACH_INVALID,
			self.parent
		)
		self:AddParticle(n, false, true, 10, false, false)
	end
end
function k.prototype.StaticProperty(self)
	return {
		[PropertyFunction.HEALTH] = e(-KeyValues.units[self:GetParent():GetUnitName()].StatusHealth) * 0.5,
		[PropertyFunction.DAMAGE_AMPLIFY] = 50,
	}
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function k.prototype.GetModifierModelScale(self)
	return 25
end
k = f(
	{
		j(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
return g