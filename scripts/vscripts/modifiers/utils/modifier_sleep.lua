--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_sleep"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_sleep"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsClient() then
		local l = ParticleManager:CreateParticleForce(
			"particles/generic_gameplay/generic_sleep.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self.parent
		)
		self:AddParticle(l, false, false, -1, false, false)
	end
end
function j.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true }
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