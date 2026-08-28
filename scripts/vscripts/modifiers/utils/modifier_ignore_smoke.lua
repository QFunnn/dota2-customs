--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_ignore_smoke"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_ignore_smoke"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsClient() then
		local l = ParticleManager:CreateParticle(
			"particles/generic_gameplay/ignore_smoke.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(l, false, false, -1, false, false)
	end
end
function j.prototype.StaticState(self)
	return { [StateEnum.SMOKE_IMMUNE] = true }
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
				RemoveOnDeath = false,
			}
		),
	},
	j
)
return f