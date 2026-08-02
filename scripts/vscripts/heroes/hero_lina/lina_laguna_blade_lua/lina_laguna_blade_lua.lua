--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function LightningJump(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local jump_delay = ability:GetLevelSpecialValueFor("jump_delay", (ability:GetLevel() - 1))
	local radius = ability:GetLevelSpecialValueFor("radius", (ability:GetLevel() - 1))
	local damage_laguna = ability:GetLevelSpecialValueFor("damage", (ability:GetLevel() - 1))
		+ caster:ExtraIntelligenceDamage()
			* ability:GetLevelSpecialValueFor("ExtraIntelligenceDamage", (ability:GetLevel() - 1))
	local talent = caster:FindAbilityByName("special_bonus_lina_7")
	if talent and talent:GetLevel() > 0 then
		damage_laguna = damage_laguna + 1200
	end

	-- Applies damage to the current target
	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage_laguna,
		damage_type = ability:GetAbilityDamageType(),
	})
	-- Removes the hidden modifier
	target:RemoveModifierByName("modifier_arc_lightning_datadriven")

	-- Waits on the jump delay
	Timers:CreateTimer(jump_delay, function()
		-- Finds the current instance of the ability by ensuring both current targets are the same
		local current
		for i = 0, ability.instance do
			if ability.target[i] ~= nil then
				if ability.target[i] == target then
					current = i
				end
			end
		end

		-- Adds a global array to the target, so we can check later if it has already been hit in this instance
		if target.hit == nil then
			target.hit = {}
		end
		-- Sets it to true for this instance
		target.hit[current] = true

		-- Decrements our jump count for this instance
		ability.jump_count[current] = ability.jump_count[current] - 1

		-- Checks if there are jumps left
		if ability.jump_count[current] > 0 then
			-- Finds units in the radius to jump to
			local units = FindUnitsInRadius(
				caster:GetTeamNumber(),
				target:GetAbsOrigin(),
				target,
				radius,
				ability:GetAbilityTargetTeam(),
				ability:GetAbilityTargetType(),
				ability:GetAbilityTargetFlags(),
				0,
				false
			)
			local closest = radius
			local new_target
			for i, unit in ipairs(units) do
				-- Positioning and distance variables
				local unit_location = unit:GetAbsOrigin()
				local vector_distance = target:GetAbsOrigin() - unit_location
				local distance = (vector_distance):Length2D()
				-- Checks if the unit is closer than the closest checked so far
				if distance < closest then
					-- If the unit has not been hit yet, we set its distance as the new closest distance and it as the new target
					if unit.hit == nil then
						new_target = unit
						closest = distance
					elseif unit.hit[current] == nil then
						new_target = unit
						closest = distance
					end
				end
			end

			if new_target ~= nil then
				local lightningBolt = ParticleManager:CreateParticle(keys.particle, PATTACH_WORLDORIGIN, target)
				ParticleManager:SetParticleControl(
					lightningBolt,
					0,
					Vector(
						target:GetAbsOrigin().x,
						target:GetAbsOrigin().y,
						target:GetAbsOrigin().z + target:GetBoundingMaxs().z
					)
				)
				ParticleManager:SetParticleControl(
					lightningBolt,
					1,
					Vector(
						new_target:GetAbsOrigin().x,
						new_target:GetAbsOrigin().y,
						new_target:GetAbsOrigin().z + new_target:GetBoundingMaxs().z
					)
				)

				ability.target[current] = new_target

				ability:ApplyDataDrivenModifier(caster, new_target, "modifier_arc_lightning_datadriven", {})
			else
				ability.target[current] = nil
			end
		else
			ability.target[current] = nil
		end
	end)
end

function NewInstance(keys)
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target

	if ability.instance == nil then
		ability.instance = 0
		ability.jump_count = {}
		ability.target = {}
	else
		ability.instance = ability.instance + 1
	end

	ability.jump_count[ability.instance] = ability:GetLevelSpecialValueFor("jump_count", (ability:GetLevel() - 1))

	local talent = caster:FindAbilityByName("special_bonus_lina_8")
	if talent and talent:GetLevel() > 0 then
		ability.jump_count[ability.instance] = ability:GetLevelSpecialValueFor("jump_count", (ability:GetLevel() - 1))
			+ 3
	end

	ability.target[ability.instance] = target

	-- Creates the particle between the caster and the first target
	local lightningBolt = ParticleManager:CreateParticle(keys.particle, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(
		lightningBolt,
		0,
		Vector(caster:GetAbsOrigin().x, caster:GetAbsOrigin().y, caster:GetAbsOrigin().z + caster:GetBoundingMaxs().z)
	)
	ParticleManager:SetParticleControl(
		lightningBolt,
		1,
		Vector(target:GetAbsOrigin().x, target:GetAbsOrigin().y, target:GetAbsOrigin().z + target:GetBoundingMaxs().z)
	)
end