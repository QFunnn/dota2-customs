--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_spawn_bonus_outpost"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_bonus_outpost"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
	else
		local l = ParticleManager:CreateParticleForce(
			"particles/world_outpost/world_outpost_radiant_ambient.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(
			l,
			0,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_fx",
			self.parent:GetAbsOrigin(),
			false
		)
		self:AddParticle(l, false, false, -1, false, false)
	end
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function j.prototype.GetActivityTranslationModifiers(self)
	return "captured"
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_INVULNERABLE] = true }
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