--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_raid_aura", "abilities/bosses/raid_boss.lua", LUA_MODIFIER_MOTION_NONE)

raid_aura = class({})

function raid_aura:GetIntrinsicModifierName()
	return "modifier_raid_aura"
end

------------------------------

modifier_raid_aura = class({})

function modifier_raid_aura:IsHidden()
	return true
end

function modifier_raid_aura:IsPurgable()
	return false
end

function modifier_raid_aura:OnCreated(kv)
	self:StartIntervalThink(0.1)
end

function modifier_raid_aura:OnIntervalThink()
	if IsServer() then
		local heroes = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetAbsOrigin(),
			self:GetCaster(),
			1500,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO
				+ DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
				+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
				+ DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER,
			false
		)
		self:GetCaster():SetBaseMagicalResistanceValue(100 - 5 * #heroes)
		self:GetCaster():SetPhysicalArmorBaseValue(250 - 30 * #heroes)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
fire_raze = class({})

function fire_raze:OnSpellStart()
	local caster = self:GetCaster()
	local numProjectiles = RandomInt(10, 20)
	EmitSoundOn("Conquest.FireTrap.Generic", caster)

	for i = 1, numProjectiles do
		if RandomInt(0, 1) == 1 then
			effect = "particles/base_attacks/ranged_tower_good_linear.vpcf"
			damage_type = DAMAGE_TYPE_MAGICAL
		else
			effect = "particles/base_attacks/ranged_tower_bad_linear.vpcf"
			damage_type = DAMAGE_TYPE_PHYSICAL
		end

		local projectileInfo = {
			Ability = self,
			EffectName = effect,
			vSpawnOrigin = caster:GetAbsOrigin(),
			fDistance = 2000,
			fStartRadius = 64,
			fEndRadius = 64,
			Source = caster,
			bHasFrontalCone = false,
			bReplaceExisting = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_ALL,
			fExpireTime = GameRules:GetGameTime() + 10.0,
			bDeleteOnHit = false,
			vVelocity = RandomVector(1) * 500,
			bProvidesVision = false,
			iVisionRadius = 1000,
			iVisionTeamNumber = caster:GetTeamNumber(),
			ExtraData = { damage_type = damage_type },
		}
		ProjectileManager:CreateLinearProjectile(projectileInfo)
	end
end

function fire_raze:OnProjectileHit_ExtraData(hTarget, vLocation, data)
	if hTarget and not hTarget:IsInvulnerable() then
		local damage = {
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = hTarget:GetMaxHealth() * 0.25,
			damage_type = data.damage_type,
			ability = self,
		}
		ApplyDamage(damage)
	end
	return false
end

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

fire_storm = class({})

function fire_storm:OnSpellStart()
	local hCaster = self:GetCaster()
	local point = hCaster:GetOrigin()
	local numMeteors = 9
	local meteorRadius = 315

	for i = 1, numMeteors do
		local spot = point + RandomVector(RandomInt(150, 750))

		if debug_drawing == true then
			DebugDrawCircle(spot, Vector(255, 100, 0), 1, 215, true, 5)
		end

		local shadowEffect = ParticleManager:CreateParticle("particles/meteor_shadow.vpcf", PATTACH_ABSORIGIN, hCaster)
		ParticleManager:SetParticleControl(shadowEffect, 0, spot + Vector(0, 0, 200))

		local meteorEffect =
			ParticleManager:CreateParticle("particles/invoker_chaos_meteor_fly2.vpcf", PATTACH_ABSORIGIN, hCaster)
		ParticleManager:SetParticleControl(meteorEffect, 0, spot + Vector(0, 0, 2000))
		ParticleManager:SetParticleControl(meteorEffect, 1, spot)
		ParticleManager:SetParticleControl(meteorEffect, 2, Vector(4, 0, 0))

		Timers:CreateTimer(4, function()
			local crashEffect = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf",
				PATTACH_ABSORIGIN,
				hCaster
			)
			ParticleManager:SetParticleControl(crashEffect, 0, spot + Vector(0, 0, 200))

			local unitTable = FindUnitsInRadius(
				hCaster:GetTeamNumber(),
				spot,
				hCaster,
				meteorRadius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_ALL,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			for k, unit in pairs(unitTable) do
				local damageTable = {
					victim = unit,
					attacker = hCaster,
					damage = unit:GetMaxHealth() * 0.3,
					damage_type = DAMAGE_TYPE_PURE,
				}
				ApplyDamage(damageTable)
			end
			return
		end)
	end
end