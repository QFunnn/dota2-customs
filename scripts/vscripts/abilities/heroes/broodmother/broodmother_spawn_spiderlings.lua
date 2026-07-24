--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


broodmother_spawn_spiderlings = class({})

LinkLuaModifier("modifier_broodmother_spawn_spiderlings_lua", "abilities/heroes/broodmother/modifier_broodmother_spawn_spiderlings", LUA_MODIFIER_MOTION_NONE)

function broodmother_spawn_spiderlings:Spawn()
	if IsClient() then return end

	self.summon_list = {}
end

function broodmother_spawn_spiderlings:OnSpellStart()
	local caster = self:GetCaster()

	ProjectileManager:CreateTrackingProjectile({
		Source = caster,
		Target = self:GetCursorTarget(),
		Ability = self,
		bDodgeable = true,
		EffectName = "particles/units/heroes/hero_broodmother/broodmother_web_cast.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
	})

	caster:EmitSound("Hero_Broodmother.SpawnSpiderlingsCast")
end

function broodmother_spawn_spiderlings:OnProjectileHit(target, location)
	if not target then return end
	if target:IsInvulnerable() or target:IsOutOfGame() or target:TriggerSpellAbsorb(self) then return end

	local caster = self:GetCaster()
	local buff_duration = self:GetSpecialValueFor("buff_duration") * (1 - target:GetStatusResistance())

	target:AddNewModifier(caster, self, "modifier_broodmother_spawn_spiderlings_lua", {duration = buff_duration})

	ApplyDamage({
		attacker = caster,
		victim = target,
		damage = self:GetSpecialValueFor("damage"),
		damage_type = self:GetAbilityDamageType(),
		damage_flags = self:GetAbilityTargetFlags(),
		ability = self,
	})

	target:EmitSound("Hero_Broodmother.SpawnSpiderlingsImpact")
end

function broodmother_spawn_spiderlings:SpawnSpiderlings(target)
	self:ValidateCurrentSummons()

	local caster = self:GetCaster()
	local count = self:GetSpecialValueFor("count")
	local spiderling_duration = self:GetSpecialValueFor("spiderling_duration")
	local spiderling_health = self:GetSpecialValueFor("tooltip_spiderling_hp")
	local bonus_damage = self:GetSpecialValueFor("damage_bonus")


	local spawn_count = math.max(count - #self.summon_list, 0)
	local meat_count = count - spawn_count

	for i = 1, spawn_count do
		local spiderling = CreateUnitByName("npc_dota_broodmother_spiderling", target:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
		spiderling:SetControllableByPlayer(caster:GetPlayerOwnerID(), false)

		spiderling:SetBaseMaxHealth(spiderling_health)
		spiderling:SetHealth(spiderling_health)

		spiderling:SetBaseDamageMin(spiderling:GetBaseDamageMin() + bonus_damage)
		spiderling:SetBaseDamageMax(spiderling:GetBaseDamageMax() + bonus_damage)

		spiderling.original_attack_damage = (spiderling:GetBaseDamageMin() + spiderling:GetBaseDamageMax()) / 2

		spiderling:AddNewModifier(caster, self, "modifier_kill", {duration = spiderling_duration})

		local level = self:GetLevel()
		for i = 0, spiderling:GetAbilityCount() - 1 do
			local ability = spiderling:GetAbilityByIndex(i)
			if ability then ability:SetLevel(level) end
		end

		target:EmitSound("Hero_Broodmother.SpawnSpiderlings")
		table.insert(self.summon_list, spiderling)
	end

	if meat_count <= 0 then return end

	local health_bonus = spiderling_health * meat_count / #self.summon_list
	local damage_bonus = self.summon_list[1].original_attack_damage * meat_count / #self.summon_list

	local has_spiderling_debuff = target:HasModifier("modifier_broodmother_spiderling_debuff_lua")

	for _, spiderling in ipairs(self.summon_list) do
		spiderling:SetBaseMaxHealth(spiderling:GetBaseMaxHealth() + health_bonus)
		spiderling:SetMaxHealth(spiderling:GetBaseMaxHealth())
		spiderling:Heal(health_bonus, nil)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, spiderling, health_bonus, nil)
		ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, spiderling)

		spiderling:SetBaseDamageMin(spiderling:GetBaseDamageMin() + damage_bonus)
		spiderling:SetBaseDamageMax(spiderling:GetBaseDamageMax() + damage_bonus)

		if not has_spiderling_debuff then -- spiderling debuff also extends duration on target death, so omit of present
			local buff_modifier = spiderling:FindModifierByName("modifier_broodmother_spiderling_lua")
			if buff_modifier and not buff_modifier:IsNull() then buff_modifier:ExtendLifetime() end
		end
	end
end

function broodmother_spawn_spiderlings:ValidateCurrentSummons()
	for unit_index = #(self.summon_list or {}), 1, -1 do
		local unit = self.summon_list[unit_index]
		if not unit or unit:IsNull() or not unit:IsAlive() then
			table.remove(self.summon_list, unit_index)
		end
	end
end