--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


new_year_snowball = class({})

function new_year_snowball:OnSpellStart()
	ProjectileManager:CreateTrackingProjectile({
		EffectName = "particles/econ/events/snowball/snowball_projectile.vpcf",
		Ability = self,
		Source = self:GetCaster(),
		Target = self:GetCursorTarget(),
		iMoveSpeed = 1000,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
	})

	EmitSoundOn("Frostivus.Item.Snowball.Cast", self:GetCaster())
end

function new_year_snowball:OnProjectileHit(target)
	if not target then
		return
	end
	EmitSoundOn("Frostivus.Item.Snowball.Target", target)
end