--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pugna_nether_blast", "heroes/hero_pugna/hero_pugna", LUA_MODIFIER_MOTION_NONE)

pugna_nether_blast_lua = class({})

function pugna_nether_blast_lua:GetAbilityTextureName()
	return "pugna_nether_blast"
end

function pugna_nether_blast_lua:GetAOERadius()
	return self:GetSpecialValueFor("main_blast_radius")
end

function pugna_nether_blast_lua:IsNetherWardStealable()
	return true
end

function pugna_nether_blast_lua:IsHiddenWhenStolen()
	return false
end

function pugna_nether_blast_lua:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local target_point = self:GetCursorPosition()
	local sound_precast = "Hero_Pugna.NetherBlastPreCast"
	local sound_cast = "Hero_Pugna.NetherBlast"
	local particle_pre_blast = "particles/units/heroes/hero_pugna/pugna_netherblast_pre.vpcf"
	local particle_blast = "particles/units/heroes/hero_pugna/pugna_netherblast.vpcf"

	local mini_blast_count = 0
	local blast_delay = ability:GetSpecialValueFor("blast_delay")

	local mini_blast_distance = ability:GetSpecialValueFor("mini_blast_distance")
	local mini_blast_radius = ability:GetSpecialValueFor("mini_blast_radius")
	local main_blast_radius = ability:GetSpecialValueFor("main_blast_radius")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_pugna_6")
	if talent and talent:GetLevel() > 0 then
		mini_blast_count = 3
	end

	if not IsServer() then
		return
	end
	local damage = ability:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	EmitSoundOn(sound_cast, caster)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_point,
		nil,
		mini_blast_distance + mini_blast_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for i = 1, mini_blast_count do
		local angle_gaps = 360 / mini_blast_count

		local qangle = QAngle(0, (i - 1) * angle_gaps, 0)
		local direction = (target_point - caster:GetAbsOrigin()):Normalized()

		local spawn_point = target_point + direction * mini_blast_distance

		local mini_blast_center = RotatePosition(target_point, qangle, spawn_point)

		local particle_blast_fx = ParticleManager:CreateParticle(particle_blast, PATTACH_ABSORIGIN, caster)
		ParticleManager:SetParticleControl(particle_blast_fx, 0, mini_blast_center)
		ParticleManager:SetParticleControl(particle_blast_fx, 1, Vector(mini_blast_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle_blast_fx)

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			mini_blast_center,
			nil,
			mini_blast_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			local damageTable = {
				victim = enemy,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				attacker = caster,
				ability = ability,
			}
			ApplyDamage(damageTable)
		end
	end

	-- Add main blast preparation particle and sound only to allies
	local particle_pre_blast_fx = ParticleManager:CreateParticle(particle_pre_blast, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(particle_pre_blast_fx, 0, target_point)
	ParticleManager:SetParticleControl(particle_pre_blast_fx, 1, Vector(main_blast_radius, blast_delay, 1))
	ParticleManager:ReleaseParticleIndex(particle_pre_blast_fx)

	-- EmitSoundOnLocationForAllies(caster:GetAbsOrigin(), sound_precast, caster)
	EmitSoundOn(sound_precast, caster)

	-- Create a timer to delay the main blast
	Timers:CreateTimer(blast_delay, function()
		-- Blow up! Add particle effect
		local particle_blast_fx = ParticleManager:CreateParticle(particle_blast, PATTACH_ABSORIGIN, caster)
		ParticleManager:SetParticleControl(particle_blast_fx, 0, target_point)
		ParticleManager:SetParticleControl(particle_blast_fx, 1, Vector(main_blast_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle_blast_fx)

		-- Find all enemies, including buildings
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target_point,
			nil,
			main_blast_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			local blast_damage = damage

			local damageTable = {
				victim = enemy,
				damage = blast_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				attacker = caster,
				ability = ability,
			}

			ApplyDamage(damageTable)
		end
	end)
end

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_decrepify_lua", "heroes/hero_pugna/hero_pugna", LUA_MODIFIER_MOTION_NONE)

pugna_decrepify_lua = class({})

function pugna_decrepify_lua:IsHiddenWhenStolen()
	return false
end

function pugna_decrepify_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	EmitSoundOn("Hero_Pugna.Decrepify", self:GetCaster())

	local target = self:GetCursorTarget()
	target:AddNewModifier(
		caster,
		self,
		"modifier_decrepify_lua",
		{ duration = duration * (1 - target:GetStatusResistance()) }
	)
end

-------------------------------------------------------------------------------------------------------------------

modifier_decrepify_lua = class({})

function modifier_decrepify_lua:GetEffectName()
	return "particles/units/heroes/hero_pugna/pugna_decrepify.vpcf"
end

function modifier_decrepify_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_decrepify_lua:OnCreated()
	self.heal_amp = self:GetAbility():GetSpecialValueFor("heal_amp")
	self.spell_amp = self:GetAbility():GetSpecialValueFor("spell_amp")
	self.enemy_slow_pct = self:GetAbility():GetSpecialValueFor("enemy_slow_pct")

	if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		self.is_ally = true
	else
		self.is_ally = false
	end
end

function modifier_decrepify_lua:IsDebuff()
	if self.is_ally then
		return false
	else
		return true
	end
end

function modifier_decrepify_lua:CheckState()
	return {
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_decrepify_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_decrepify_lua:GetModifierIncomingDamage_Percentage(keys)
	if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL and not self.is_ally then
		return self.spell_amp
	end
end

function modifier_decrepify_lua:GetModifierMoveSpeedBonus_Percentage()
	if self.is_ally then
		return nil
	else
		return self.enemy_slow_pct * -1
	end
end

function modifier_decrepify_lua:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_decrepify_lua:GetModifierHPRegenAmplify_Percentage()
	return self.heal_amp
end

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_pugna_nether_ward_lua", "heroes/hero_pugna/hero_pugna", LUA_MODIFIER_MOTION_NONE)

pugna_nether_ward_lua = class({})

function pugna_nether_ward_lua:OnSpellStart()
	local caster = self:GetCaster()
	local position = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	EmitSoundOn("Hero_Pugna.NetherWard", caster)

	local unit_name = "npc_dota_mjz_pugna_nether_ward"
	local unit = CreateUnitByName(unit_name, position, false, caster, caster, caster:GetTeamNumber())
	if unit and IsValidEntity(unit) then
		FindClearSpaceForUnit(unit, position, false)
		unit:AddNewModifier(caster, self, "modifier_kill", { duration = duration })
		unit:AddNewModifier(caster, self, "modifier_pugna_nether_ward_lua", { duration = duration })
	end
end

-----------------------------------------------------------------------------------------

modifier_pugna_nether_ward_lua = class({})

function modifier_pugna_nether_ward_lua:IsHidden()
	return true
end
function modifier_pugna_nether_ward_lua:IsPurgable()
	return false
end

function modifier_pugna_nether_ward_lua:GetEffectName()
	return "particles/units/heroes/hero_pugna/pugna_ward_ambient.vpcf"
end
function modifier_pugna_nether_ward_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pugna_nether_ward_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_BONUS_DAY_VISION,
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_pugna_nether_ward_lua:GetModifierAttackRangeBonus()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_pugna_nether_ward_lua:GetBonusDayVision()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_pugna_nether_ward_lua:GetBonusNightVision()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_pugna_nether_ward_lua:OnTakeDamage(event)
	if not IsServer() then
		return nil
	end
	if event.unit ~= self:GetParent() then
		return nil
	end
	if event.attacker:IsIllusion() then
		return nil
	end
	local target = event.unit
	local attacker = event.attacker
	self:_OnAttacked(attacker)
end

function modifier_pugna_nether_ward_lua:OnAttacked(event)
	if not IsServer() then
		return nil
	end
	if event.target ~= self:GetParent() then
		return nil
	end
	if event.attacker:IsIllusion() then
		return nil
	end
	local target = event.target
	local attacker = event.attacker
end

function modifier_pugna_nether_ward_lua:OnCreated(table)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local radius = ability:GetSpecialValueFor("radius")
	local interval = ability:GetSpecialValueFor("interval")
	local attacks_to_destroy = ability:GetSpecialValueFor("attacks_to_destroy")
	parent.attack_counter = attacks_to_destroy

	if not IsServer() then
		return
	end

	local health = attacks_to_destroy
	parent:SetBaseMaxHealth(health)
	parent:SetMaxHealth(health)
	parent:SetHealth(health)
	parent:ModifyHealth(health, ability, false, 0)

	self:OnIntervalThink()
	self:StartIntervalThink(interval)
end

function modifier_pugna_nether_ward_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self:StartIntervalThink(-1)
	parent:ForceKill(false)
end

function modifier_pugna_nether_ward_lua:OnIntervalThink()
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()

	local radius = ability:GetSpecialValueFor("radius")
	local max_count = ability:GetSpecialValueFor("count")

	local enemy_list = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		radius,
		ability:GetAbilityTargetTeam(),
		ability:GetAbilityTargetType(),
		ability:GetAbilityTargetFlags(),
		FIND_ANY_ORDER,
		false
	)

	local count = 0
	for _, enemy in pairs(enemy_list) do
		if count < max_count then
			count = count + 1
			self:_FireEffect(enemy)
			self:_ApplyDamage(enemy)
		end
	end
end

function modifier_pugna_nether_ward_lua:_OnAttacked(attacker)
	local parent = self:GetParent()
	local ability = self:GetAbility()

	if parent.attack_counter > 1 then
		parent.attack_counter = parent.attack_counter - 1
		parent:SetHealth(parent.attack_counter)
		parent:ModifyHealth(parent.attack_counter, ability, false, 0)
	end
end

function modifier_pugna_nether_ward_lua:_FireEffect(target)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()

	local ward = parent
	-- There are some light/medium/heavy unused versions
	local p_list = {
		"particles/units/heroes/hero_pugna/pugna_ward_attack.vpcf",
		"particles/units/heroes/hero_pugna/pugna_ward_attack_light.vpcf",
		"particles/units/heroes/hero_pugna/pugna_ward_attack_medium.vpcf",
		"particles/units/heroes/hero_pugna/pugna_ward_attack_heavy.vpcf",
	}
	local p_id = RandomInt(1, #p_list)
	local p_name = p_list[p_id]
	local p_attack = ParticleManager:CreateParticle(p_name, PATTACH_ABSORIGIN_FOLLOW, ward)
	ParticleManager:SetParticleControl(p_attack, 1, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(p_attack)

	--target:EmitSound("Hero_Pugna.NetherWard.Target")
	-- caster:EmitSound("Hero_Pugna.NetherWard.Attack")
	ward:EmitSound("Hero_Pugna.NetherWard.Attack")
end

function modifier_pugna_nether_ward_lua:_ApplyDamage(target)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()

	local base_damage = ability:GetSpecialValueFor("base_damage")
	local intelligence_damage = ability:GetSpecialValueFor("intelligence_damage")
	local damage = base_damage + self:GetCaster():ExtraIntelligenceDamage() * intelligence_damage

	ApplyDamage({
		attacker = caster,
		victim = target,
		ability = ability,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage = damage,
	})
end

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

pugna_life_drain_lua = class({})
LinkLuaModifier("modifier_pugna_life_drain_lua", "heroes/hero_pugna/hero_pugna", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pugna_life_drain_lua_self", "heroes/hero_pugna/hero_pugna", LUA_MODIFIER_MOTION_NONE)

function pugna_life_drain_lua:GetAbilityTextureName()
	return "pugna_life_drain"
end

function pugna_life_drain_lua:IsHiddenWhenStolen()
	return false
end

function pugna_life_drain_lua:GetAssociatedPrimaryAbilities()
	return "pugna_life_drain_lua_end"
end

function pugna_life_drain_lua:OnChannelFinish(bInterrupted)
	self:GetCaster():RemoveModifierByName("modifier_pugna_life_drain_lua_self")
end

function pugna_life_drain_lua:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local target = self:GetCursorTarget()
	local sound_cast = "Hero_Pugna.LifeDrain.Cast"
	self.modifier_lifedrain = "modifier_pugna_life_drain_lua"

	EmitSoundOn(sound_cast, caster)

	if caster:GetTeamNumber() ~= target:GetTeamNumber() then
		if target:TriggerSpellAbsorb(ability) then
			return nil
		end
	end

	caster:AddNewModifier(caster, ability, "modifier_pugna_life_drain_lua_self", {})
	target:AddNewModifier(caster, ability, self.modifier_lifedrain, {})
end

------------------------------------------------------------------

modifier_pugna_life_drain_lua_self = class({})

function modifier_pugna_life_drain_lua_self:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_pugna_life_drain_lua_self:IsHidden()
	return true
end

function modifier_pugna_life_drain_lua_self:IsPurgable()
	return false
end

-----------------------------------------------------------------

modifier_pugna_life_drain_lua = class({})

function modifier_pugna_life_drain_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_pugna_life_drain_lua:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.sound_target = "Hero_Pugna.LifeDrain.Target"
	self.sound_loop = "Hero_Pugna.LifeDrain.Loop"
	self.particle_drain = "particles/units/heroes/hero_pugna/pugna_life_drain.vpcf"
	self.particle_give = "particles/units/heroes/hero_pugna/pugna_life_give.vpcf"

	self.health_drain = self.ability:GetSpecialValueFor("health_drain")
	self.tick_rate = self.ability:GetSpecialValueFor("tick_rate")
	self.break_distance_extend = self.ability:GetSpecialValueFor("break_distance_extend")

	if self.parent:GetTeamNumber() == self.caster:GetTeamNumber() then
		self.is_ally = true
	else
		self.is_ally = false
	end

	if IsServer() then
		EmitSoundOn(self.sound_target, self.parent)

		StopSoundOn(self.sound_loop, self.parent)
		EmitSoundOn(self.sound_loop, self.parent)

		if self.is_ally then
			self.particle_drain_fx = ParticleManager:CreateParticle(self.particle_give, PATTACH_ABSORIGIN, self.caster)
			ParticleManager:SetParticleControlEnt(
				self.particle_drain_fx,
				0,
				self.caster,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				self.caster:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				self.particle_drain_fx,
				1,
				self.parent,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				self.parent:GetAbsOrigin(),
				true
			)
		else
			self.particle_drain_fx = ParticleManager:CreateParticle(self.particle_drain, PATTACH_ABSORIGIN, self.caster)
			ParticleManager:SetParticleControlEnt(
				self.particle_drain_fx,
				0,
				self.caster,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				self.caster:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				self.particle_drain_fx,
				1,
				self.parent,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				self.parent:GetAbsOrigin(),
				true
			)
		end

		Timers:CreateTimer(self.tick_rate, function()
			self:StartIntervalThink(self.tick_rate)
		end)
	else
		self:StartIntervalThink(self.tick_rate)
	end
end

function modifier_pugna_life_drain_lua:OnIntervalThink()
	if self.caster:HasModifier("modifier_pugna_life_drain_lua_self") then
		if IsServer() then
			if
				self.parent:IsIllusion()
				and self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber()
				and not Custom_bIsStrongIllusion(self.parent)
			then
				self.parent:Kill(self.ability, self.caster)
				return nil
			end

			if self.caster:IsStunned() or self.caster:IsSilenced() then
				self:Destroy()
			end

			if self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber() and self.parent:IsInvisible() then
				self:Destroy()
			end

			if
				not self.caster:CanEntityBeSeenByMyTeam(self.parent)
				or self.parent:IsInvulnerable()
				or self.parent:IsMagicImmune()
			then
				self:Destroy()
			end

			local cast_range = self.ability:GetCastRange(self.caster:GetAbsOrigin(), self.parent)
			local distance = (self.parent:GetAbsOrigin() - self.caster:GetAbsOrigin()):Length2D()

			if distance > (cast_range + self.break_distance_extend) then
				self:Destroy()
			end

			if not self.caster:IsAlive() then
				self:Destroy()
			end

			local damage = self.health_drain * self.tick_rate

			if self.is_ally then
				local damageTable = {
					victim = self.caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					attacker = self.caster,
					ability = self.ability,
				}

				local actual_damage = ApplyDamage(damageTable)

				local missing_health = self.parent:GetMaxHealth() - self.parent:GetHealth()

				self.parent:Heal(actual_damage, self.caster)

				if missing_health < actual_damage then
					local recover_mana = actual_damage - missing_health
					self.parent:GiveMana(recover_mana)
				end
			else
				local damageTable = {
					victim = self.parent,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					attacker = self.caster,
					ability = self.ability,
				}

				local actual_damage = ApplyDamage(damageTable)

				local missing_health = self.caster:GetMaxHealth() - self.caster:GetHealth()

				self.caster:Heal(actual_damage, self.caster)

				if missing_health < actual_damage then
					local recover_mana = actual_damage - missing_health
					self.caster:GiveMana(recover_mana)
				end
			end
		end
	else
		self:Destroy()
	end
end

function modifier_pugna_life_drain_lua:CheckState()
	if self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
		return {
			[MODIFIER_STATE_PROVIDES_VISION] = true,
			[MODIFIER_STATE_INVISIBLE] = false,
		}
	end
end

function modifier_pugna_life_drain_lua:IsHidden()
	return true
end
function modifier_pugna_life_drain_lua:IsPurgable()
	return false
end
function modifier_pugna_life_drain_lua:IsDebuff()
	if self.is_ally then
		return false
	else
		return true
	end
end

function modifier_pugna_life_drain_lua:OnDestroy()
	if not IsServer() then
		return
	end
	self.caster:RemoveModifierByName("modifier_pugna_life_drain_lua_self")

	ParticleManager:DestroyParticle(self.particle_drain_fx, false)
	ParticleManager:ReleaseParticleIndex(self.particle_drain_fx)

	StopSoundOn(self.sound_target, self.parent)
	StopSoundOn(self.sound_loop, self.parent)
end