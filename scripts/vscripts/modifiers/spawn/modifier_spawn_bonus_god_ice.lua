--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_spawn_bonus_god_ice"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_bonus_god_ice"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.parent:FadeGesture(ACT_DOTA_SPAWN)
		self.parent:StartGesture(ACT_DOTA_IDLE)
		self.parent:SetForwardVector(vec3_bottom)
	else
		local l = ParticleManager:CreateParticleForce(
			"particles/econ/items/effigies/status_fx_effigies/status_effect_statue_compendium_2014_radiant.vpcf",
			PATTACH_INVALID,
			self.parent
		)
		self:AddParticle(l, false, true, 10, false, false)
		local m =
			ParticleManager:CreateParticleForce("particles/map/bonus_god_pedestal.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(m, 0, self.parent:GetAbsOrigin())
		self:AddParticle(m, false, false, -1, false, false)
	end
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_VISUAL_Z_DELTA }
end
function j.prototype.GetVisualZDelta(self)
	return -64
end
function j.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FROZEN] = self:GetElapsedTime() > 0.5,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	j
)
return f