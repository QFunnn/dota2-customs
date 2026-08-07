--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


abyss_mana_burn = class({})

function abyss_mana_burn:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function abyss_mana_burn:GetCooldown(level)
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	return tonumber(definition and definition.cooldown) or 0
end

function abyss_mana_burn:GetInitialBossCooldown()
	return self:GetCooldown(math.max(0, self:GetLevel() - 1)) * 0.5
end

function abyss_mana_burn:FindBestCastTarget()
	local caster = self:GetCaster()
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	if not IsValid(caster) or not definition then
		return nil
	end

	local search_radius = tonumber(definition.proc_params and definition.proc_params.search_radius) or 1200
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)

	for _, enemy in ipairs(enemies or {}) do
		if enemy:IsRealHero() and (enemy:GetMana() or 0) > 0 then
			return enemy
		end
	end

	return nil
end

function abyss_mana_burn:CastFromBossAI(target)
	local caster = self:GetCaster()
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	if not IsValid(caster, self, target) or not definition then
		return false
	end
	if not caster:IsAlive() or not target:IsAlive() then
		return false
	end

	local current_mana = tonumber(target:GetMana()) or 0
	if current_mana <= 0 then
		return false
	end

	local burn_amount = tonumber(definition.proc_params and definition.proc_params.mana_burn) or 75
	burn_amount = math.min(current_mana, burn_amount)

	caster:Stop()
	target:SetMana(math.max(0, current_mana - burn_amount))

	local particle_start = ParticleManager:CreateParticle(
		"particles/items_fx/generic_item_spell_caster.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		particle_start,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle_start,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(particle_start, 2, Vector(5, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle_start)

	local p = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(p)

	caster:EmitSound("UpBoss.Jolt.Target")
	target:EmitSound("UpBoss.ManaBurn.Target")

	self:StartCooldown(self:GetCooldown(math.max(0, self:GetLevel() - 1)))
	return true
end