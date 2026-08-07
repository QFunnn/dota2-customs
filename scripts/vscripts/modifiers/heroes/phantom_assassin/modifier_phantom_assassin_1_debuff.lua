--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/heroes/phantom_assassin/modifier_phantom_assassin_1_debuff"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_phantom_assassin_1_debuff"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
	else
		local l = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		self:AddParticle(l, false, false, -1, false, false)
	end
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function j.prototype.GetModifierMoveSpeedBonus_Constant(self)
	return -self:GetAbilitySpecialValueFor("reduce_move_speed")
end
j = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	j
)
return f