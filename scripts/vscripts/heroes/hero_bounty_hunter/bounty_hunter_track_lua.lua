--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


bounty_hunter_track_lua = class({}) ---@class bounty_hunter_track_lua : CDOTA_Ability_Lua

function bounty_hunter_track_lua:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local pos = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	local speed = 1800

	local targets = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		radius,
		self:GetAbilityTargetTeam(),
		self:GetAbilityTargetType(),
		self:GetAbilityTargetFlags(),
		FIND_ANY_ORDER,
		false
	)

	self._track_duration = duration

	local castFx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(castFx)

	EmitSoundOn("Hero_BountyHunter.Target", caster)

	for _, target in ipairs(targets) do
		if target and not target:IsNull() and target:IsAlive() then
			ProjectileManager:CreateTrackingProjectile({
				Target = target,
				Source = caster,
				Ability = self,
				EffectName = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_cast.vpcf",
				iMoveSpeed = speed,
				bDodgeable = false,
				bProvidesVision = false,
				iVisionRadius = 0,
				iVisionTeamNumber = caster:GetTeamNumber(),

				ExtraData = {
					duration = duration,
				}
			})
		end
	end
end

function bounty_hunter_track_lua:OnProjectileHit_ExtraData(target, location, extra)
	if not IsServer() then return true end
	if not target or target:IsNull() or not target:IsAlive() then return true end

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return true end

	local duration = (extra and extra.duration) or self._track_duration or self:GetSpecialValueFor("duration")

	target:AddNewModifier(caster, self, "modifier_bounty_hunter_track", { duration = duration })
	return true
end

function bounty_hunter_track_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end