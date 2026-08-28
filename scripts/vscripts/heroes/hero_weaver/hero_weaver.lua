--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_weaver_shukuchi_custom", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_shukuchi_thread_node", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_shukuchi_thread_slow", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)

weaver_shukuchi_custom = class({})

function weaver_shukuchi_custom:Precache(context)
	PrecacheResource("particle", "particles/weaver_wall.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_weaver/weaver_shukuchi_damage.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_weaver/weaver_shukuchi_slow.vpcf", context)
end

function weaver_shukuchi_custom:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()

	self.hero_hit_targets = {}
	self.wall_hit_targets = {}

	caster:EmitSound("Hero_Weaver.Shukuchi")
	caster:AddNewModifier(
		caster,
		self,
		"modifier_weaver_shukuchi_custom",
		{ duration = self:GetSpecialValueFor("duration") }
	)
end

--------------------------------------------------------------------------------

modifier_weaver_shukuchi_custom = class({})

function modifier_weaver_shukuchi_custom:IsPurgable()
	return false
end

function modifier_weaver_shukuchi_custom:OnCreated()
	self.speed = self:GetAbility():GetSpecialValueFor("speed")
	if not IsServer() then
		return
	end

	local ability = self:GetAbility()
	self.radius = ability:GetSpecialValueFor("radius")
	self.damage = ability:GetSpecialValueFor("damage")
	self.node_interval = 0.03

	self.last_pos = self:GetParent():GetAbsOrigin()
	self:StartIntervalThink(self.node_interval)
end

function modifier_weaver_shukuchi_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local current_pos = parent:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		current_pos,
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		local entIndex = enemy:entindex()
		if not ability.hero_hit_targets[entIndex] then
			ability.hero_hit_targets[entIndex] = true

			ApplyDamage({
				victim = enemy,
				attacker = caster,
				damage = self.damage,
				damage_type = ability:GetAbilityDamageType(),
				ability = ability,
			})

			local p = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_weaver/weaver_shukuchi_damage.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				enemy
			)
			ParticleManager:ReleaseParticleIndex(p)
		end
	end

	if (current_pos - self.last_pos):Length2D() > 10 then
		self:CreateWallSegment(self.last_pos, current_pos)
		self.last_pos = current_pos
	end
end

function modifier_weaver_shukuchi_custom:CreateWallSegment(vStart, vEnd)
	local ability = self:GetAbility()
	CreateModifierThinker(self:GetCaster(), ability, "modifier_weaver_shukuchi_thread_node", {
		duration = ability:GetSpecialValueFor("thread_duration"),
		start_x = vStart.x,
		start_y = vStart.y,
		start_z = vStart.z,
		end_x = vEnd.x,
		end_y = vEnd.y,
		end_z = vEnd.z,
	}, vStart, self:GetCaster():GetTeamNumber(), false)
end

function modifier_weaver_shukuchi_custom:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSLOWABLE] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
	}
end

function modifier_weaver_shukuchi_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
end

function modifier_weaver_shukuchi_custom:GetModifierMoveSpeedBonus_Constant()
	return self.speed
end
function modifier_weaver_shukuchi_custom:GetModifierInvisibilityLevel()
	return 1
end
function modifier_weaver_shukuchi_custom:OnAttack(keys)
	if keys.attacker == self:GetParent() then
		self:Destroy()
	end
end
function modifier_weaver_shukuchi_custom:OnAbilityFullyCast(keys)
	if keys.unit == self:GetParent() and keys.ability ~= self:GetAbility() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------

modifier_weaver_shukuchi_thread_node = class({})

function modifier_weaver_shukuchi_thread_node:OnCreated(params)
	if not IsServer() then
		return
	end
	self.start_pos = Vector(params.start_x, params.start_y, params.start_z)
	self.end_pos = Vector(params.end_x, params.end_y, params.end_z)

	local ability = self:GetAbility()
	self.radius = ability:GetSpecialValueFor("thread_radius")
	self.damage = ability:GetSpecialValueFor("thread_damage")
	self.slow_dur = ability:GetSpecialValueFor("thread_slow_duration")

	self.pfx = ParticleManager:CreateParticle("particles/weaver_wall.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, self.start_pos)
	ParticleManager:SetParticleControl(self.pfx, 1, self.end_pos)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(1, 1, 0))
	ParticleManager:SetParticleControl(self.pfx, 61, Vector(1, 0, 0))

	self:StartIntervalThink(0.1)
end

function modifier_weaver_shukuchi_thread_node:OnIntervalThink()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end

	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		self.start_pos,
		self.end_pos,
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)

	for _, enemy in pairs(enemies) do
		local entIndex = enemy:entindex()
		if not ability.wall_hit_targets[entIndex] then
			ability.wall_hit_targets[entIndex] = true

			ApplyDamage({
				victim = enemy,
				attacker = caster,
				damage = self.damage,
				damage_type = ability:GetAbilityDamageType(),
				ability = ability,
			})

			local p = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_weaver/weaver_shukuchi_damage.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				enemy
			)
			ParticleManager:ReleaseParticleIndex(p)

			enemy:AddNewModifier(caster, ability, "modifier_weaver_shukuchi_thread_slow", { duration = self.slow_dur })
		end
	end
end

function modifier_weaver_shukuchi_thread_node:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

--------------------------------------------------------------------------------

modifier_weaver_shukuchi_thread_slow = class({})

function modifier_weaver_shukuchi_thread_slow:IsDebuff()
	return true
end

function modifier_weaver_shukuchi_thread_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_weaver_shukuchi_thread_slow:GetModifierMoveSpeedBonus_Percentage()
	if not self:GetAbility() then
		return 0
	end
	return self:GetAbility():GetSpecialValueFor("thread_slow") * -1
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_weaver_geminate_attack_custom", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_geminate_web_slow", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)

weaver_geminate_attack_custom = class({})

function weaver_geminate_attack_custom:GetIntrinsicModifierName()
	return "modifier_weaver_geminate_attack_custom"
end

--------------------------------------------------------------------------------

modifier_weaver_geminate_attack_custom = class({})
function modifier_weaver_geminate_attack_custom:IsHidden()
	return true
end
function modifier_weaver_geminate_attack_custom:IsPurgable()
	return false
end
function modifier_weaver_geminate_attack_custom:IsPurgeException()
	return false
end
function modifier_weaver_geminate_attack_custom:RemoveOnDeath()
	return false
end

function modifier_weaver_geminate_attack_custom:OnCreated()
	if not IsServer() then
		return
	end
	self.web_counter = 0
end

function modifier_weaver_geminate_attack_custom:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK }
end

function modifier_weaver_geminate_attack_custom:OnAttack(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() then
		return
	end
	if params.no_attack_cooldown then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	local ability = self:GetAbility()
	if not ability:IsFullyCastable() then
		return
	end

	ability:UseResources(false, false, false, true)
	self.web_counter = self.web_counter + 1
	local do_web = (self.web_counter % 4 == 0)

	local multi_radius = ability:GetSpecialValueFor("multi_attack_radius")
	local web_slow_dur = ability:GetSpecialValueFor("web_slow_duration")
	local web_radius = ability:GetSpecialValueFor("web_radius")

	local extra_targets = ability:GetSpecialValueFor("extra_targets")

	local candidates = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		self:GetParent(),
		self:GetCaster():Script_GetAttackRange() + multi_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local count = 0
	for _, enemy in pairs(candidates) do
		if enemy ~= params.target then
			if count >= extra_targets then
				break
			end
			count = count + 1
			local e = enemy
			Timers:CreateTimer(0.05, function()
				if e and not e:IsNull() and e:IsAlive() and not e:IsAttackImmune() and not e:IsInvulnerable() then
					self:GetParent():PerformAttack(e, true, true, true, false, true, false, false)
				end
			end)
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_weaver_the_swarm_custom_unit", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_the_swarm_custom_debuff", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_the_swarm_custom_larva", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)

weaver_the_swarm_custom = class({})

function weaver_the_swarm_custom:OnSpellStart()
	if not IsServer() then
		return
	end
	local point = self:GetCursorPosition()
	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end
	self:GetCaster():EmitSound("Hero_Weaver.Swarm.Cast")

	for beetles = 1, self:GetSpecialValueFor("count") do
		local start_pos = self:GetCaster():GetAbsOrigin()
			+ RandomVector(RandomInt(0, self:GetSpecialValueFor("spawn_radius")))
		local beetle_dummy = CreateModifierThinker(
			self:GetCaster(),
			self,
			nil,
			{},
			self:GetCaster():GetAbsOrigin(),
			self:GetCaster():GetTeamNumber(),
			false
		)
		if beetles == 1 then
			beetle_dummy:EmitSound("Hero_Weaver.Swarm.Projectile")
		end
		local projectile_table = {
			Ability = self,
			EffectName = "particles/units/heroes/hero_weaver/weaver_swarm_projectile.vpcf",
			vSpawnOrigin = start_pos,
			fDistance = self:GetCastRange(point, self:GetCaster()) + self:GetCaster():GetCastRangeBonus(),
			fStartRadius = self:GetSpecialValueFor("radius"),
			fEndRadius = self:GetSpecialValueFor("radius"),
			Source = self:GetCaster(),
			bHasFrontalCone = false,
			bReplaceExisting = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			fExpireTime = GameRules:GetGameTime() + 10.0,
			bDeleteOnHit = false,
			vVelocity = (point - self:GetCaster():GetAbsOrigin()):Normalized()
				* self:GetSpecialValueFor("speed")
				* Vector(1, 1, 0),
			bProvidesVision = true,
			iVisionRadius = 321,
			iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
			ExtraData = { beetle_entindex = beetle_dummy:entindex() },
		}
		local projectileID = ProjectileManager:CreateLinearProjectile(projectile_table)
		beetle_dummy.projectileID = projectileID
	end
end

function weaver_the_swarm_custom:OnProjectileThink_ExtraData(location, data)
	if
		data.beetle_entindex
		and EntIndexToHScript(data.beetle_entindex)
		and not EntIndexToHScript(data.beetle_entindex):IsNull()
	then
		EntIndexToHScript(data.beetle_entindex):SetAbsOrigin(location)
	end
end

function weaver_the_swarm_custom:OnProjectileHit_ExtraData(target, location, data)
	local beetle_dummy = EntIndexToHScript(data.beetle_entindex)

	if not beetle_dummy or beetle_dummy:IsNull() then
		return
	end

	if target and not target:HasModifier("modifier_weaver_the_swarm_custom_debuff") then
		target:EmitSound("Hero_Weaver.SwarmAttach")
		self:SpawnBeetle(target)

		-- Ищем ID снаряда, сохраненный в финкере
		if beetle_dummy.projectileID then
			ProjectileManager:DestroyLinearProjectile(beetle_dummy.projectileID)
		end

		beetle_dummy:StopSound("Hero_Weaver.Swarm.Projectile")
		beetle_dummy:RemoveSelf()
		return true -- Возвращаем true, чтобы снаряд исчез при попадании
	elseif not target then
		-- Снаряд долетел до конца дистанции
		beetle_dummy:StopSound("Hero_Weaver.Swarm.Projectile")
		beetle_dummy:RemoveSelf()
	end
	return false
end

function weaver_the_swarm_custom:SpawnBeetle(target)
	local beetle = CreateUnitByName(
		"npc_dota_weaver_swarm",
		self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * 64,
		false,
		self:GetCaster(),
		self:GetCaster(),
		self:GetCaster():GetTeamNumber()
	)
	beetle:AddNewModifier(self:GetCaster(), self, "modifier_weaver_the_swarm_custom_unit", {
		destroy_attacks = self:GetSpecialValueFor("destroy_attacks"),
		target_entindex = target:entindex(),
	})
	beetle:SetForwardVector((target:GetAbsOrigin() - beetle:GetAbsOrigin()):Normalized())
	target:AddNewModifier(self:GetCaster(), self, "modifier_weaver_the_swarm_custom_debuff", {
		duration = self:GetSpecialValueFor("duration"),
		damage = self:GetSpecialValueFor("damage"),
		attack_rate = self:GetSpecialValueFor("attack_rate"),
		armor_reduction = self:GetSpecialValueFor("armor_reduction"),
		damage_type = self:GetAbilityDamageType(),
		beetle_entindex = beetle:entindex(),
	})
end

--------------------------------------------------------------------------------

modifier_weaver_the_swarm_custom_unit = class({})
function modifier_weaver_the_swarm_custom_unit:IsHidden()
	return true
end
function modifier_weaver_the_swarm_custom_unit:IsPurgable()
	return false
end

function modifier_weaver_the_swarm_custom_unit:GetEffectName()
	return "particles/units/heroes/hero_weaver/weaver_swarm_debuff.vpcf"
end

function modifier_weaver_the_swarm_custom_unit:OnCreated(params)
	if not IsServer() then
		return
	end
	self.destroy_attacks = params.destroy_attacks
	self.target = EntIndexToHScript(params.target_entindex)
	self.health_increments = self:GetParent():GetMaxHealth() / self.destroy_attacks
	self:StartIntervalThink(FrameTime())
end

function modifier_weaver_the_swarm_custom_unit:OnIntervalThink()
	if self.target and not self.target:IsNull() then
		if self.target:IsInvisible() and not self:GetParent():CanEntityBeSeenByMyTeam(self.target) then
			self:GetParent():ForceKill(false)
			self:Destroy()
		elseif self.target:IsAlive() then
			self:GetParent():SetAbsOrigin(self.target:GetAbsOrigin() + self.target:GetForwardVector() * 64)
			self:GetParent()
				:SetForwardVector((self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized())
		end
	end
end

function modifier_weaver_the_swarm_custom_unit:OnDestroy()
	if not IsServer() then
		return
	end
	if self.target and not self.target:IsNull() then
		-- Убираем дебафф жука
		if self.target:HasModifier("modifier_weaver_the_swarm_custom_debuff") then
			self.target:RemoveModifierByName("modifier_weaver_the_swarm_custom_debuff")
		end
		-- Оставляем Личинку на живой цели
		if self.target:IsAlive() then
			local ability = self:GetAbility()
			if ability and not ability:IsNull() then
				self.target:AddNewModifier(
					self:GetCaster(),
					ability,
					"modifier_weaver_the_swarm_custom_larva",
					{ duration = ability:GetSpecialValueFor("larva_duration") }
				)
			end
		end
	end
end

function modifier_weaver_the_swarm_custom_unit:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
end

function modifier_weaver_the_swarm_custom_unit:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_EVENT_ON_ATTACKED,
	}
end

function modifier_weaver_the_swarm_custom_unit:GetOverrideAnimation()
	return ACT_DOTA_IDLE
end
function modifier_weaver_the_swarm_custom_unit:GetAbsoluteNoDamageMagical()
	return 1
end
function modifier_weaver_the_swarm_custom_unit:GetAbsoluteNoDamagePhysical()
	return 1
end
function modifier_weaver_the_swarm_custom_unit:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_weaver_the_swarm_custom_unit:OnAttacked(params)
	if not IsServer() then
		return
	end
	if params.target == self:GetParent() then
		local new_health = self:GetParent():GetHealth() - self.health_increments
		if new_health <= 0 then
			self:GetParent():Kill(nil, params.attacker)
			self:Destroy()
		else
			self:GetParent():SetHealth(new_health)
		end
	end
end

--------------------------------------------------------------------------------

modifier_weaver_the_swarm_custom_debuff = class({})
function modifier_weaver_the_swarm_custom_debuff:IgnoreTenacity()
	return false
end
function modifier_weaver_the_swarm_custom_debuff:IsPurgable()
	return false
end

function modifier_weaver_the_swarm_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_weaver/weaver_swarm_infected_debuff.vpcf"
end

function modifier_weaver_the_swarm_custom_debuff:OnCreated(params)
	if not IsServer() then
		return
	end
	self.damage = params.damage
	self.attack_rate = params.attack_rate
	self.damage_type = params.damage_type
	self.armor_reduction = params.armor_reduction
	self.beetle = EntIndexToHScript(params.beetle_entindex)
	self.damage_table = {
		victim = self:GetParent(),
		damage = self.damage,
		damage_type = self.damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	}
	self:OnIntervalThink()
	self:StartIntervalThink(self.attack_rate)
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_weaver_the_swarm_custom_debuff:AddCustomTransmitterData()
	return { armor_reduction = self.armor_reduction }
end

function modifier_weaver_the_swarm_custom_debuff:HandleCustomTransmitterData(data)
	self.armor_reduction = data.armor_reduction
end

function modifier_weaver_the_swarm_custom_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
	ApplyDamage(self.damage_table)
end

function modifier_weaver_the_swarm_custom_debuff:OnDestroy()
	if not IsServer() then
		return
	end
	if self.beetle and not self.beetle:IsNull() and self.beetle:IsAlive() then
		self.beetle:ForceKill(false)
	end
end

function modifier_weaver_the_swarm_custom_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_weaver_the_swarm_custom_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction * self:GetStackCount() * -1
end

--------------------------------------------------------------------------------

modifier_weaver_the_swarm_custom_larva = class({})

function modifier_weaver_the_swarm_custom_larva:IsDebuff()
	return true
end
function modifier_weaver_the_swarm_custom_larva:IsPurgable()
	return false
end

function modifier_weaver_the_swarm_custom_larva:GetEffectName()
	return "particles/units/heroes/hero_weaver/weaver_swarm_debuff.vpcf"
end

function modifier_weaver_the_swarm_custom_larva:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_weaver_the_swarm_custom_larva:DeclareFunctions()
	return { MODIFIER_EVENT_ON_DEATH }
end

function modifier_weaver_the_swarm_custom_larva:OnDeath(keys)
	if not IsServer() then
		return
	end
	if keys.unit ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	-- Ищем ближайшую цель без жука
	local nearest = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		nil,
		1200,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for _, target in pairs(nearest) do
		if not target:HasModifier("modifier_weaver_the_swarm_custom_debuff") then
			ability:SpawnBeetle(target)
			break
		end
	end
	self:Destroy()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_weaver_time_lapse_custom", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_time_lapse_phantom", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_time_lapse_ally_tracking", "heroes/hero_weaver/hero_weaver", LUA_MODIFIER_MOTION_NONE)

weaver_time_lapse_custom = class({})

function weaver_time_lapse_custom:GetIntrinsicModifierName()
	return "modifier_weaver_time_lapse_custom"
end

function weaver_time_lapse_custom:GetBehavior()
	local base = DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT
		+ DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
		+ DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_weaver_7")
	if talent and talent:GetLevel() >= 1 then
		return base + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	return base + DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function weaver_time_lapse_custom:OnSpellStart()
	if not IsServer() then
		return
	end
	local target = self:GetCursorTarget()

	-- Каст на союзника (только с талантом)
	if target and target ~= self:GetCaster() then
		local track = target:FindModifierByName("modifier_weaver_time_lapse_ally_tracking")
		if track and track.instances_health and track.instances_health[1] then
			target:EmitSound("Hero_Weaver.TimeLapse")
			local cur = target:GetAbsOrigin()
			local old = track.instances_position[1]
			local p = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_weaver/weaver_timelapse.vpcf",
				PATTACH_WORLDORIGIN,
				target
			)
			ParticleManager:SetParticleControl(p, 0, cur)
			ParticleManager:SetParticleControl(p, 2, old)
			ParticleManager:ReleaseParticleIndex(p)
			ProjectileManager:ProjectileDodge(target)
			target:Purge(false, true, false, true, true)
			target:SetHealth(math.max(track.instances_health[1], 1))
			target:SetMana(track.instances_mana[1])
			FindClearSpaceForUnit(target, old, true)
		end
		return
	end

	-- Каст на себя
	self:GetCaster():Stop()
	if not self.intrinsic_modifier then
		self.intrinsic_modifier = self:GetCaster():FindModifierByName(self:GetIntrinsicModifierName())
	end
	if
		self.intrinsic_modifier
		and self.intrinsic_modifier.instances_health
		and self.intrinsic_modifier.instances_health[1]
		and self.intrinsic_modifier.instances_mana
		and self.intrinsic_modifier.instances_mana[1]
		and self.intrinsic_modifier.instances_position
		and self.intrinsic_modifier.instances_position[1]
	then
		self:GetCaster():EmitSound("Hero_Weaver.TimeLapse")

		local current_pos = self:GetCaster():GetAbsOrigin()
		local old_pos = self.intrinsic_modifier.instances_position[1]

		local time_lapse_particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_weaver/weaver_timelapse.vpcf",
			PATTACH_WORLDORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(time_lapse_particle, 0, current_pos)
		ParticleManager:SetParticleControl(time_lapse_particle, 2, old_pos)
		ParticleManager:ReleaseParticleIndex(time_lapse_particle)

		ProjectileManager:ProjectileDodge(self:GetCaster())
		self:GetCaster():Purge(false, true, false, true, true)
		self:GetCaster():Stop()
		self:GetCaster():SetHealth(math.max(self.intrinsic_modifier.instances_health[1], 1))
		self:GetCaster():SetMana(self.intrinsic_modifier.instances_mana[1])
		FindClearSpaceForUnit(self:GetCaster(), old_pos, true)

		-- Создаём фантома на прежней позиции (по паттерну TerrorBlade)
		local caster = self:GetCaster()
		local phantom_duration = self:GetSpecialValueFor("phantom_duration")
		local outgoing = self:GetSpecialValueFor("phantom_outgoing_damage")
		local incoming = self:GetSpecialValueFor("phantom_incoming_damage")

		local illusions = CreateIllusions(caster, caster, {
			outgoing_damage = 0,
			incoming_damage = incoming - 100,
			duration = phantom_duration,
		}, 1, 0, false, true)
		if illusions and illusions[1] and not illusions[1]:IsNull() then
			local illusion = illusions[1]
			FindClearSpaceForUnit(illusion, current_pos, true)
			illusion:AddNewModifier(caster, self, "modifier_weaver_time_lapse_phantom", {})

			local avg_dmg = caster:GetAverageTrueAttackDamage(nil) / 100 * outgoing
			local agi = caster:GetAgility()
			illusion:SetBaseDamageMin(avg_dmg - agi)
			illusion:SetBaseDamageMax(avg_dmg - agi)
		end
	end
end

--------------------------------------------------------------------------------

modifier_weaver_time_lapse_custom = class({})
function modifier_weaver_time_lapse_custom:IsHidden()
	return true
end
function modifier_weaver_time_lapse_custom:IsPurgable()
	return false
end
function modifier_weaver_time_lapse_custom:IsPurgeException()
	return false
end
function modifier_weaver_time_lapse_custom:RemoveOnDeath()
	return false
end

function modifier_weaver_time_lapse_custom:OnCreated()
	if not IsServer() then
		return
	end
	self.lapsed_time = 5
	self.instances_health = {}
	self.instances_mana = {}
	self.instances_position = {}
	self.interval = 0.1
	self.total_saved_points = self.lapsed_time / self.interval
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_weaver_time_lapse_custom:OnIntervalThink()
	if self:GetParent():IsAlive() then
		table.insert(self.instances_health, self:GetParent():GetHealth())
		table.insert(self.instances_mana, self:GetParent():GetMana())
		table.insert(self.instances_position, self:GetParent():GetAbsOrigin())
		if #self.instances_health >= self.total_saved_points then
			table.remove(self.instances_health, 1)
			table.remove(self.instances_mana, 1)
			table.remove(self.instances_position, 1)
		end
	end
end

-- Аура: трекинг союзников включается при наличии таланта 5
function modifier_weaver_time_lapse_custom:IsAura()
	return true
end
function modifier_weaver_time_lapse_custom:GetModifierAura()
	return "modifier_weaver_time_lapse_ally_tracking"
end
function modifier_weaver_time_lapse_custom:GetAuraRadius()
	return 99999
end
function modifier_weaver_time_lapse_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_weaver_time_lapse_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end
function modifier_weaver_time_lapse_custom:GetAuraEntityReject(entity)
	if entity == self:GetParent() then
		return true
	end
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_weaver_7")
	return not (talent and talent:GetLevel() >= 1)
end

--------------------------------------------------------------------------------
-- Трекинг союзника (применяется когда талант 5 взят)

modifier_weaver_time_lapse_ally_tracking = class({})
function modifier_weaver_time_lapse_ally_tracking:IsHidden()
	return true
end
function modifier_weaver_time_lapse_ally_tracking:IsPurgable()
	return false
end
function modifier_weaver_time_lapse_ally_tracking:RemoveOnDeath()
	return false
end

function modifier_weaver_time_lapse_ally_tracking:OnCreated()
	if not IsServer() then
		return
	end
	self.lapsed_time = 5
	self.instances_health = {}
	self.instances_mana = {}
	self.instances_position = {}
	self.interval = 0.1
	self.total_saved_points = self.lapsed_time / self.interval
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_weaver_time_lapse_ally_tracking:OnIntervalThink()
	if self:GetParent():IsAlive() then
		table.insert(self.instances_health, self:GetParent():GetHealth())
		table.insert(self.instances_mana, self:GetParent():GetMana())
		table.insert(self.instances_position, self:GetParent():GetAbsOrigin())
		if #self.instances_health >= self.total_saved_points then
			table.remove(self.instances_health, 1)
			table.remove(self.instances_mana, 1)
			table.remove(self.instances_position, 1)
		end
	end
end

--------------------------------------------------------------------------------
-- Модификатор фантома — убивает иллюзию когда время истекает

modifier_weaver_time_lapse_phantom = class({})
function modifier_weaver_time_lapse_phantom:IsHidden()
	return true
end
function modifier_weaver_time_lapse_phantom:IsDebuff()
	return false
end
function modifier_weaver_time_lapse_phantom:IsStunDebuff()
	return false
end
function modifier_weaver_time_lapse_phantom:IsPurgable()
	return false
end

function modifier_weaver_time_lapse_phantom:GetStatusEffectName()
	return "particles/units/heroes/hero_weaver/weaver_timelapse.vpcf"
end

function modifier_weaver_time_lapse_phantom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_weaver_time_lapse_phantom:StatusEffectPriority()
	return 10001
end

function modifier_weaver_time_lapse_phantom:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if parent and not parent:IsNull() and parent:IsAlive() then
		parent:ForceKill(false)
	end
end