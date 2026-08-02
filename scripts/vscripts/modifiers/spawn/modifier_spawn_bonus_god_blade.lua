--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_spawn_bonus_god_blade"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_bonus_god_blade"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.parent:SetForwardVector(vec3_bottom)
		self.parent:FadeGesture(ACT_DOTA_SPAWN)
		self.parent:AddActivityModifier("arcana_style")
		self.parent:AddActivityModifier("red")
		self.parent:StartGesture(ACT_DOTA_LOADOUT)
	else
		local l = ParticleManager:CreateParticleForce(
			"particles/econ/items/effigies/status_fx_effigies/status_effect_statue_compendium_2014_radiant.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		self:AddParticle(l, false, true, 10, false, false)
	end
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_VISUAL_Z_DELTA }
end
function j.prototype.GetVisualZDelta(self)
	return 100
end
function j.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FROZEN] = self:GetElapsedTime() > 0.3,
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