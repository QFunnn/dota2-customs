--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_abyss_flash"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_abyss_flash"
d(j, h)
function j.prototype.OnCreated(self, k)
	self:UpdateValues(k)
	if IsServer() then
	else
		local l = ParticleManager:CreateParticleForce(
			"particles/units/enemy/elite_ambient_b0.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			l,
			1,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			self.parent:GetAbsOrigin(),
			false
		)
		self:AddParticle(l, false, false, -1, false, false)
		local m = ParticleManager:CreateParticleForce(
			"particles/status_fx/status_effect_faceless_timewalk.vpcf",
			PATTACH_INVALID,
			self.parent
		)
		self:AddParticle(m, false, true, 10, false, false)
	end
end
function j.prototype.OnRefresh(self, k)
	self:UpdateValues(k)
end
function j.prototype.UpdateValues(self, k)
	self.healthMultiplier = toFiniteNumber(k.healthMultiplier, 100)
	self.attackMultiplier = toFiniteNumber(k.attackMultiplier, 50)
	self.modelScale = toFiniteNumber(k.modelScale, 40)
end
function j.prototype.StaticProperty(self)
	return {
		[PropertyFunction.HEALTH] = KeyValues.units[self:GetParent():GetUnitName()].StatusHealth
			* self.healthMultiplier
			* 0.01,
		[PropertyFunction.DAMAGE_AMPLIFY] = self.attackMultiplier,
	}
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function j.prototype.GetModifierModelScale(self)
	return self.modelScale
end
function j.prototype.StaticState(self)
	return { [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
end
j = e(
	{
		i(
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
	j
)
return f