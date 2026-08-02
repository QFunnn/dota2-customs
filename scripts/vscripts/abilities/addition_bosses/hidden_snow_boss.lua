--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

hidden_snow_boss_ice_torrent = class({})

function hidden_snow_boss_ice_torrent:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function hidden_snow_boss_ice_torrent:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf",
		context
	)
end

function hidden_snow_boss_ice_torrent:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local team = caster:GetTeamNumber()

	local delay = self:GetSpecialValueFor("delay")
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local vision_duration = self:GetSpecialValueFor("vision_duration")

	for _, hero in pairs(HeroList:GetAllHeroes()) do
		if hero:IsRealHero() and hero:GetTeamNumber() == team then
			local player = hero:GetPlayerOwner()
			if player then
				local fxIndex = ParticleManager:CreateParticleForPlayer(
					"particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8.vpcf",
					PATTACH_WORLDORIGIN,
					nil,
					player
				)
				ParticleManager:SetParticleControl(fxIndex, 0, point)

				EmitSoundOnClient("hero_Crystal.CrystalNovaCast", player)

				Timers:CreateTimer(delay, function()
					ParticleManager:DestroyParticle(fxIndex, false)
					ParticleManager:ReleaseParticleIndex(fxIndex)
				end)
			end
		end
	end

	Timers:CreateTimer(delay, function()
		local sound_cast = "Hero_Crystal.CrystalNova"
		-- EmitSoundOnLocationWithCaster(point, sound_cast, caster)
		EmitSoundOn(sound_cast, caster)

		AddFOWViewer(team, point, radius, vision_duration, false)

		local nFXIndex = ParticleManager:CreateParticle(
			"particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(nFXIndex, 0, point)
		ParticleManager:SetParticleControl(nFXIndex, 1, Vector(radius, delay, radius))
		ParticleManager:ReleaseParticleIndex(nFXIndex)

		local enemies = FindUnitsInRadius(
			team,
			point,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			local damageTable = {
				victim = enemy,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			}
			ApplyDamage(damageTable)
		end
	end)
end

----------------------------------------------------------------------------
----------------------------------------------------------------------------

hidden_snow_boss_pinguin_wave = class({})

function hidden_snow_boss_pinguin_wave:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function hidden_snow_boss_pinguin_wave:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()

	local speed = self:GetSpecialValueFor("speed")
	local radius = self:GetSpecialValueFor("radius")
	local count = self:GetSpecialValueFor("count")
	local spawn_radius = self:GetSpecialValueFor("spawn_radius")

	caster:EmitSound("Hero_Tusk.IceShards.Projectile")

	for i = 1, count do
		local random_direction = RandomVector(1)
		local spawn_pos = origin + random_direction * spawn_radius

		local velocity_direction = (origin - spawn_pos):Normalized()

		local angles = { 20, -20 }

		for _, angle in pairs(angles) do
			local final_velocity = RotateVector2D(velocity_direction, angle)

			local projectile_info = {
				Ability = self,
				EffectName = "particles/econ/items/tuskarr/tusk_ti5_immortal/tusk_ice_shards_projectile_stout.vpcf",
				vSpawnOrigin = spawn_pos,
				fDistance = spawn_radius + 200,
				fStartRadius = radius,
				fEndRadius = radius,
				Source = caster,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				vVelocity = final_velocity * speed,
				bProvidesVision = false,
			}

			ProjectileManager:CreateLinearProjectile(projectile_info)
		end
	end
end

function RotateVector2D(v, angle)
	local theta = math.rad(angle)
	local cos_theta = math.cos(theta)
	local sin_theta = math.sin(theta)
	local x = v.x * cos_theta - v.y * sin_theta
	local y = v.x * sin_theta + v.y * cos_theta
	return Vector(x, y, v.z):Normalized()
end

function hidden_snow_boss_pinguin_wave:OnProjectileHit(hTarget, vLocation)
	if hTarget ~= nil then
		local caster = self:GetCaster()
		local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
		local damage_table = {
			victim = hTarget,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self,
		}
		ApplyDamage(damage_table)
	end
	return false
end

----------------------------------------------------------------------------
----------------------------------------------------------------------------