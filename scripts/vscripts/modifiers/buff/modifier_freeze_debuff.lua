--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_freeze_debuff"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_freeze_debuff"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsClient() then
		local l = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_buff_model.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			l,
			0,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			true
		)
		self:AddParticle(l, false, false, -1, false, false)
	end
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true, [MODIFIER_STATE_STUNNED] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
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