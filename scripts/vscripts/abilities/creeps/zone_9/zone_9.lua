--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_sticky_napalm_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_sticky_napalm_lua = class({})

function creep_sticky_napalm_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_batrider/batrider_stickynapalm_impact.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_batrider/batrider_stickynapalm_stack.vpcf", context)
end

function creep_sticky_napalm_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_sticky_napalm_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local speed = self:GetSpecialValueFor("projectile_speed")
	local spawn_origin = caster:GetAbsOrigin()

	local direction = point - spawn_origin
	direction.z = 0
	local distance = direction:Length2D()
	local velocity = direction:Normalized() * speed
	local duration = distance / speed

	caster:EmitSound("Hero_Batrider.StickyNapalm.Cast")

	local projectile_info = {
		Ability = self,
		EffectName = "",
		vSpawnOrigin = spawn_origin,
		fDistance = distance,
		fStartRadius = 100,
		fEndRadius = 100,
		Source = caster,
		vVelocity = velocity,
		bHasFrontalCone = false,
		bProvidesVision = true,
		iVisionRadius = 400,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}
	ProjectileManager:CreateLinearProjectile(projectile_info)

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_batrider/batrider_stickynapalm_projectile.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 2, spawn_origin)
	ParticleManager:SetParticleControl(pfx, 0, point)
	ParticleManager:SetParticleControl(pfx, 1, Vector(speed, 0, 0))

	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end

function creep_sticky_napalm_lua:OnProjectileHit(target, location)
	if not location then
		return
	end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	local sound_cast = "Hero_Batrider.StickyNapalm.Impact"
	-- EmitSoundOnLocationWithCaster(location, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_batrider/batrider_stickynapalm_impact.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, location)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		location,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_creep_sticky_napalm_lua", { duration = duration })
	end

	return true
end

--------------------------------------------------------------------------------

modifier_creep_sticky_napalm_lua = class({})

function modifier_creep_sticky_napalm_lua:IsHidden()
	return false
end
function modifier_creep_sticky_napalm_lua:IsPurgable()
	return true
end

function modifier_creep_sticky_napalm_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_stickynapalm.vpcf"
end

function modifier_creep_sticky_napalm_lua:OnCreated()
	self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
	self.mr_reduction = self:GetAbility():GetSpecialValueFor("mr_reduction")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_additional")
	self.turn_rate_pct = self:GetAbility():GetSpecialValueFor("turn_rate_pct")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_additional")
	self.move_speed = self:GetAbility():GetSpecialValueFor("move_speed")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_additional")

	if not IsServer() then
		return
	end

	self:SetStackCount(1)

	self.stack_particle = ParticleManager:CreateParticleForTeam(
		"particles/units/heroes/hero_batrider/batrider_stickynapalm_stack.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent(),
		self:GetCaster():GetTeamNumber()
	)
	self:UpdateStackParticle()
	self:AddParticle(self.stack_particle, false, false, -1, false, false)
end

function modifier_creep_sticky_napalm_lua:OnRefresh()
	if not IsServer() then
		return
	end

	if self:GetStackCount() < self.max_stacks then
		self:IncrementStackCount()
		self:UpdateStackParticle()
	end
end

function modifier_creep_sticky_napalm_lua:UpdateStackParticle()
	ParticleManager:SetParticleControl(
		self.stack_particle,
		1,
		Vector(math.floor(self:GetStackCount() / 10), self:GetStackCount() % 10, 0)
	)
end

function modifier_creep_sticky_napalm_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_creep_sticky_napalm_lua:GetModifierTurnRate_Percentage()
	return -(self:GetStackCount() * self.turn_rate_pct)
end

function modifier_creep_sticky_napalm_lua:GetModifierMagicalResistanceBonus()
	return -(self:GetStackCount() * self.mr_reduction)
end

function modifier_creep_sticky_napalm_lua:GetModifierMoveSpeedBonus_Percentage()
	return -(self:GetStackCount() * self.move_speed)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_unit_walking_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_unit_walking_lua = class({})

function creep_unit_walking_lua:GetIntrinsicModifierName()
	return "modifier_creep_unit_walking_lua"
end

--------------------------------------------------------------------------------

modifier_creep_unit_walking_lua = class({})

function modifier_creep_unit_walking_lua:IsHidden()
	return true
end
function modifier_creep_unit_walking_lua:IsPurgable()
	return false
end

function modifier_creep_unit_walking_lua:OnCreated()
	self.bonus_speed = self:GetAbility():GetSpecialValueFor("bonus_speed")
end

function modifier_creep_unit_walking_lua:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_creep_unit_walking_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_creep_unit_walking_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_speed
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_flaming_lasso_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_flaming_lasso_self_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_flaming_lasso_immune_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_flaming_lasso_lua = class({})

function creep_flaming_lasso_lua:CastFilterResultTarget(target)
	if
		IsServer()
		and target
		and not target:IsNull()
		and target:HasModifier("modifier_creep_flaming_lasso_immune_lua")
	then
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end

function creep_flaming_lasso_lua:GetCustomCastErrorTarget(target)
	if target and not target:IsNull() and target:HasModifier("modifier_creep_flaming_lasso_immune_lua") then
		return "#creep_flaming_lasso_target_immune"
	end
	return ""
end

function creep_flaming_lasso_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_batrider/batrider_flaming_lasso.vpcf", context)
end

function creep_flaming_lasso_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	-- нельзя применить в цель, пока на ней висит маркер-иммунитет.
	-- сбрасываем кулдаун и ману, чтобы крип не потратил КД впустую
	if target:HasModifier("modifier_creep_flaming_lasso_immune_lua") then
		return
	end
	if target:TriggerSpellAbsorb(self) then
		return
	end

	local duration = self:GetSpecialValueFor("duration")
	local base_damage = self:GetSpecialValueFor("base_damage")

	caster:EmitSound("Hero_Batrider.FlamingLasso.Cast")

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = base_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})

	local escape_point = Entities:FindByName(nil, "candy4"):GetOrigin() -- TODO поменять на другую точку чтобы неболо проблем при евенте
	caster:Stop()
	caster:MoveToPosition(escape_point)

	target:AddNewModifier(caster, self, "modifier_creep_flaming_lasso_lua", { duration = duration })
	caster:AddNewModifier(caster, self, "modifier_creep_flaming_lasso_self_lua", { duration = duration })

	-- маркер на цель: пока он есть (5 сек), лассо в неё применить нельзя
	local immune_duration = self:GetSpecialValueFor("immune_duration")
	if immune_duration <= 0 then
		immune_duration = 7
	end
	target:AddNewModifier(caster, self, "modifier_creep_flaming_lasso_immune_lua", { duration = immune_duration })
end

--------------------------------------------------------------------------------

modifier_creep_flaming_lasso_lua = class({})

function modifier_creep_flaming_lasso_lua:IsDebuff()
	return true
end
function modifier_creep_flaming_lasso_lua:IsStunDebuff()
	return true
end
function modifier_creep_flaming_lasso_lua:IsPurgable()
	return false
end

function modifier_creep_flaming_lasso_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.drag_distance = self.ability:GetSpecialValueFor("drag_distance")
	self.dist_unit = self.ability:GetSpecialValueFor("distance_unit")
	self.dmg_per_dist = self.ability:GetSpecialValueFor("damage_per_distance")

	self.last_pos = self.parent:GetAbsOrigin()
	self.total_distance = 0

	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_batrider/batrider_flaming_lasso.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		self.pfx,
		0,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.pfx,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(self.pfx, false, false, -1, false, false)

	self.parent:EmitSound("Hero_Batrider.FlamingLasso.Loop")
	self:StartIntervalThink(FrameTime())
end

function modifier_creep_flaming_lasso_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	local caster_origin = self.caster:GetAbsOrigin()
	local parent_origin = self.parent:GetAbsOrigin()

	local frame_dist = (parent_origin - self.last_pos):Length2D()
	self.total_distance = self.total_distance + frame_dist
	self.last_pos = parent_origin

	if not self.caster:IsAlive() or (caster_origin - parent_origin):Length2D() > 1000 then
		self:Destroy()
		return
	end

	local direction = (parent_origin - caster_origin):Normalized()
	local target_pos = caster_origin + direction * self.drag_distance
	self.parent:SetAbsOrigin(GetGroundPosition(target_pos, nil))
end

function modifier_creep_flaming_lasso_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local bonus_steps = math.floor(self.total_distance / self.dist_unit)
	local final_bonus_dmg = bonus_steps * self.dmg_per_dist

	if final_bonus_dmg > 0 then
		ApplyDamage({
			victim = self.parent,
			attacker = self.caster,
			damage = final_bonus_dmg,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
	end

	self.parent:StopSound("Hero_Batrider.FlamingLasso.Loop")
	self.parent:EmitSound("Hero_Batrider.FlamingLasso.End")

	FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
end

function modifier_creep_flaming_lasso_lua:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}
end

function modifier_creep_flaming_lasso_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end

function modifier_creep_flaming_lasso_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------

modifier_creep_flaming_lasso_self_lua = class({})

function modifier_creep_flaming_lasso_self_lua:IsHidden()
	return false
end
function modifier_creep_flaming_lasso_self_lua:IsPurgable()
	return false
end

function modifier_creep_flaming_lasso_self_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end

function modifier_creep_flaming_lasso_self_lua:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true, -- ЗАПРЕЩАЕТ любые команды игрока
		[MODIFIER_STATE_DISARMED] = true, -- Не дает атаковать во время бега
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true, -- Чтобы не застревал в цели
	}
end

function modifier_creep_flaming_lasso_self_lua:GetOverrideAnimation()
	return ACT_DOTA_LASSO_LOOP
end

--------------------------------------------------------------------------------

-- маркер-иммунитет на цели: пока висит, лассо в эту цель применить нельзя
modifier_creep_flaming_lasso_immune_lua = class({})

function modifier_creep_flaming_lasso_immune_lua:IsHidden()
	return false
end
function modifier_creep_flaming_lasso_immune_lua:IsDebuff()
	return false
end
function modifier_creep_flaming_lasso_immune_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_fireball_thinker", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_fireball_burn", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_fireball_lua = class({})

function creep_fireball_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_batrider/batrider_flamebreak.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context)
end

function creep_fireball_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_fireball_lua:GetAOERadius()
	return self:GetSpecialValueFor("burn_radius")
end

function creep_fireball_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()

	local speed = self:GetSpecialValueFor("projectile_speed")
	local radius = self:GetSpecialValueFor("projectile_radius")

	local direction = (point - origin)
	direction.z = 0
	local distance = direction:Length2D()
	direction = direction:Normalized()

	caster:EmitSound("Hero_DragonKnight.Fireball.Cast")

	local flamebreak_dummy =
		CreateUnitByName("npc_dummy_unit", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())

	local flamebreak_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_batrider/batrider_flamebreak.vpcf",
		PATTACH_WORLDORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(flamebreak_particle, 0, caster:GetAbsOrigin() + Vector(0, 0, 128))
	ParticleManager:SetParticleControl(flamebreak_particle, 1, Vector(speed))
	ParticleManager:SetParticleControl(flamebreak_particle, 5, point)

	if not self.projectile_table then
		self.projectile_table = {
			Ability = self,
			EffectName = nil,
			vSpawnOrigin = nil,
			fDistance = nil,
			fStartRadius = 0,
			fEndRadius = 0,
			Source = caster,
			bHasFrontalCone = false,
			bReplaceExisting = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_NONE,
			fExpireTime = nil,
			bDeleteOnHit = false,
			vVelocity = nil,
			bProvidesVision = true,
			iVisionRadius = 175,
			iVisionTeamNumber = caster:GetTeamNumber(),
			ExtraData = nil,
		}
	end

	self.projectile_table.vSpawnOrigin = caster:GetAbsOrigin()
	self.projectile_table.fDistance = (self:GetCursorPosition() - caster:GetAbsOrigin()):Length2D()
	self.projectile_table.fExpireTime = GameRules:GetGameTime() + 10.0
	self.projectile_table.vVelocity = (self:GetCursorPosition() - caster:GetAbsOrigin()):Normalized()
		* speed
		* Vector(1, 1, 0)
	self.projectile_table.ExtraData = {
		flamebreak_dummy_entindex = flamebreak_dummy:entindex(),
		flamebreak_particle = flamebreak_particle,
	}

	ProjectileManager:CreateLinearProjectile(self.projectile_table)
end

function creep_fireball_lua:OnProjectileThink_ExtraData(location, data)
	if data.flamebreak_dummy_entindex then
		EntIndexToHScript(data.flamebreak_dummy_entindex):SetAbsOrigin(location)
	end
end

function creep_fireball_lua:OnProjectileHit_ExtraData(target, location, data)
	local sound_cast = "Hero_Batrider.Flamebreak.Impact"
	-- EmitSoundOnLocationWithCaster(location, sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())

	if data.flamebreak_dummy_entindex then
		EntIndexToHScript(data.flamebreak_dummy_entindex):StopSound("Hero_Batrider.Flamebreak")
		EntIndexToHScript(data.flamebreak_dummy_entindex):RemoveSelf()
	end

	if data.flamebreak_particle then
		ParticleManager:DestroyParticle(data.flamebreak_particle, false)
		ParticleManager:ReleaseParticleIndex(data.flamebreak_particle)
	end

	local caster = self:GetCaster()
	local burn_duration = self:GetSpecialValueFor("burn_duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_creep_fireball_thinker",
		{ duration = burn_duration },
		location,
		caster:GetTeamNumber(),
		false
	)

	local sound_cast = "Hero_DragonKnight.Fireball.Target"
	-- EmitSoundOnLocationWithCaster(location, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)
end

--------------------------------------------------------------------------------

modifier_creep_fireball_thinker = class({})

function modifier_creep_fireball_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.caster_team = self:GetCaster():GetTeamNumber()
	self.radius = self.ability:GetSpecialValueFor("burn_radius")
	self.interval = self.ability:GetSpecialValueFor("interval")

	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(
		self.pfx,
		1,
		self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector()
	)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(self:GetDuration(), 0, 0))
	self:AddParticle(self.pfx, false, false, -1, false, false)

	self:StartIntervalThink(self.interval)
end

function modifier_creep_fireball_thinker:OnIntervalThink()
	local enemies = FindUnitsInRadius(
		self.caster_team,
		self.parent:GetAbsOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(self.caster, self.ability, "modifier_creep_fireball_burn", { duration = 1.0 })
	end
end

--------------------------------------------------------------------------------

modifier_creep_fireball_burn = class({})

function modifier_creep_fireball_burn:OnCreated()
	if not IsServer() then
		return
	end
	local dps = self:GetAbility():GetSpecialValueFor("damage_per_second")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	local interval = self:GetAbility():GetSpecialValueFor("interval")
	self.damage = dps * interval
	self:StartIntervalThink(interval)
end

function modifier_creep_fireball_burn:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
end

function modifier_creep_fireball_burn:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_fatal_bonds_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_fatal_bonds_lua = class({})

function creep_fatal_bonds_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_fatal_bonds_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_fatal_bonds_pulse.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit.vpcf", context)
end

function creep_fatal_bonds_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	target:EmitSound("Hero_Warlock.FatalBonds")

	local nearbyUnits = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetAbsOrigin(),
		target,
		self:GetSpecialValueFor("search_aoe"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)

	local duration = self:GetSpecialValueFor("duration")

	for i = 1, #nearbyUnits do
		local unit = nearbyUnits[i]

		unit.__fatalBondsTargets = nearbyUnits
		local modifier = unit:AddNewModifier(caster, self, "modifier_creep_fatal_bonds_lua", {
			duration = duration,
		})

		for _i = 1, #nearbyUnits do
			local _unit = nearbyUnits[i]

			local particleId = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_warlock/warlock_fatal_bonds_pulse.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				target
			)
			ParticleManager:SetParticleControlEnt(
				particleId,
				1,
				_unit,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				Vector(0, 0, 0),
				true
			)
			Timers:CreateTimer(0.4, function()
				ParticleManager:DestroyParticle(particleId, true)
				ParticleManager:ReleaseParticleIndex(particleId)
			end)
		end
	end
end

--------------------------------------------------------------------------------

modifier_creep_fatal_bonds_lua = class({})

function modifier_creep_fatal_bonds_lua:GetTexture()
	return "warlock_creep_fatal_bonds_lua"
end

function modifier_creep_fatal_bonds_lua:IsHidden()
	return false
end
function modifier_creep_fatal_bonds_lua:IsPurgable()
	return true
end
function modifier_creep_fatal_bonds_lua:RemoveOnDeath()
	return true
end

function modifier_creep_fatal_bonds_lua:GetEffectName()
	return "particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf"
end

function modifier_creep_fatal_bonds_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_creep_fatal_bonds_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_creep_fatal_bonds_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_creep_fatal_bonds_lua:OnCreated(keys)
	if IsClient() then
		self.damageSharePct = self:GetAbility():GetSpecialValueFor("damage_share_pct")
			+ self:GetAbility():GetSpecialValueFor("diff_boost_damage") / 100
	end

	if IsServer() then
		self.ability = self:GetAbility()
		self.caster = self.ability:GetCaster()

		local parent = self:GetParent()

		parent.__fatalBondsAccumulatedDamageNextTime = parent.__fatalBondsAccumulatedDamageNextTime or 0

		self.targets = parent.__fatalBondsTargets
		parent.__fatalBondsTargets = nil

		parent.__fatalBondsTargetsDamage = parent.__fatalBondsTargetsDamage or {}

		for i = 1, #self.targets do
			local unit = self.targets[i]

			parent.__fatalBondsTargetsDamage[unit] = parent.__fatalBondsTargetsDamage[unit] or 0
		end

		self.damageShare = (
			self.ability:GetSpecialValueFor("damage_share_pct")
			+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
		) / 100

		self.accumulateDamageTimeMin = self.ability:GetSpecialValueFor("accumulate_damage_time_min")
		self.accumulateDamageTimeMax = self.ability:GetSpecialValueFor("accumulate_damage_time_max")
	end
end

if IsServer() then
	function modifier_creep_fatal_bonds_lua:OnDeath(keys)
		local target = self:GetParent()
		if target ~= keys.unit then
			return
		end

		for i = 1, #self.targets do
			if self.targets[i] == target then
				table.remove(self.targets, i)
				break
			end
		end
	end

	function modifier_creep_fatal_bonds_lua:OnDestroy()
		local parent = self:GetParent()

		if parent:HasModifier("modifier_creep_fatal_bonds_lua") then
			return
		end

		parent.__fatalBondsAccumulatedDamageNextTime = nil
		parent.__fatalBondsTargetsDamage = nil
	end

	function modifier_creep_fatal_bonds_lua:OnTakeDamage(keys)
		local parent = self:GetParent()
		if parent ~= keys.unit then
			return
		end

		if bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
			return
		end

		local damage = keys.damage * self.damageShare

		local curTime = GameRules:GetGameTime()

		if curTime < parent.__fatalBondsAccumulatedDamageNextTime then
			for i = 1, #self.targets do
				local unit = self.targets[i]
				if IsValidEntity(unit) and unit ~= parent then
					parent.__fatalBondsTargetsDamage[unit] = parent.__fatalBondsTargetsDamage[unit] + damage
				end
			end
		else
			parent:EmitSound("Hero_Warlock.FatalBondsDamage")

			parent.__fatalBondsAccumulatedDamageNextTime = curTime
				+ RandomFloat(self.accumulateDamageTimeMin, self.accumulateDamageTimeMax)

			for i = 1, #self.targets do
				local unit = self.targets[i]
				if IsValidEntity(unit) and unit ~= parent then
					local particleId = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						parent
					)
					ParticleManager:SetParticleControlEnt(
						particleId,
						1,
						unit,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						Vector(0, 0, 0),
						true
					)
					Timers:CreateTimer(0.4, function()
						ParticleManager:DestroyParticle(particleId, true)
						ParticleManager:ReleaseParticleIndex(particleId)
					end)

					unit:EmitSound("Hero_Warlock.FatalBondsDamage")

					ApplyDamage({
						victim = unit,
						attacker = self.caster,
						damage = parent.__fatalBondsTargetsDamage[unit] + damage,
						damage_type = DAMAGE_TYPE_PURE,
						damage_flags = DOTA_DAMAGE_FLAG_REFLECTION
							+ DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
							+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
						ability = self.ability,
					})

					parent.__fatalBondsTargetsDamage[unit] = 0
				end
			end
		end
	end
end

if IsClient() then
	function modifier_creep_fatal_bonds_lua:OnTooltip()
		return self.damageSharePct
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

creep_rain_of_chaos_lua = class({})

function creep_rain_of_chaos_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf", context)
end

function creep_rain_of_chaos_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_rain_of_chaos_lua:IsHiddenWhenStolen()
	return false
end

function creep_rain_of_chaos_lua:IsNetherWardStealable()
	return false
end

function creep_rain_of_chaos_lua:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	local ability = self
	local sound_precast = "Hero_Warlock.RainOfChaos_buildup"
	EmitSoundOn(sound_precast, caster)
	return true
end

function creep_rain_of_chaos_lua:OnAbilityPhaseInterrupted()
	local caster = self:GetCaster()
	local ability = self
	local sound_precast = "Hero_Warlock.RainOfChaos_buildup"
	StopSoundOn(sound_precast, caster)
end

function creep_rain_of_chaos_lua:OnSpellStart()
	local target_point = self:GetCursorPosition()

	EmitSoundOn("Hero_Warlock.RainOfChaos", self:GetCaster())

	local particle_start_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start.vpcf",
		PATTACH_ABSORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(particle_start_fx, 0, target_point)
	ParticleManager:ReleaseParticleIndex(particle_start_fx)

	Timers:CreateTimer(0.5, function()
		GridNav:DestroyTreesAroundPoint(target_point, self:GetSpecialValueFor("aoe"), false)

		local particle_main_fx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf",
			PATTACH_ABSORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(particle_main_fx, 0, target_point)
		ParticleManager:SetParticleControl(particle_main_fx, 1, Vector(self:GetSpecialValueFor("aoe"), 0, 0))
		ParticleManager:ReleaseParticleIndex(particle_main_fx)

		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			target_point,
			nil,
			self:GetSpecialValueFor("aoe"),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_stunned",
				{ duration = self:GetSpecialValueFor("stun_duration") }
			)
		end

		local golem = CreateUnitByName(
			"npc_zone_9_creep_2_minion",
			target_point,
			true,
			self:GetCaster(),
			self:GetCaster(),
			self:GetCaster():GetTeamNumber()
		)

		if self:GetCaster().solo_event_player_id then
			golem.solo_event_player_id = self:GetCaster().solo_event_player_id
		end

		golem:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_kill",
			{ duration = self:GetSpecialValueFor("golem_duration") }
		)

		local bonus_hp = self:GetSpecialValueFor("golem_hp")
			+ (self:GetSpecialValueFor("golem_hp") * self:GetSpecialValueFor("diff_boost_damage") / 100)
		local bonus_damage = self:GetSpecialValueFor("golem_dmg")
			+ (self:GetSpecialValueFor("golem_dmg") * self:GetSpecialValueFor("diff_boost_damage") / 100)
		local bonus_armor = self:GetSpecialValueFor("golem_armor")
			+ (self:GetSpecialValueFor("golem_armor") * self:GetSpecialValueFor("diff_boost_damage") / 100)

		golem:SetBaseMaxHealth(bonus_hp)
		golem:SetMaxHealth(bonus_hp)
		golem:SetHealth(golem:GetMaxHealth())
		golem:SetBaseDamageMin(bonus_damage)
		golem:SetBaseDamageMax(bonus_damage)
		golem:SetPhysicalArmorBaseValue(bonus_armor)

		ResolveNPCPositions(target_point, 128)
	end)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_flaming_fists_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_flaming_fists_lua = class({})

function creep_flaming_fists_lua:GetIntrinsicModifierName()
	return "modifier_creep_flaming_fists_lua"
end

--------------------------------------------------------------------------------

modifier_creep_flaming_fists_lua = class({})

function modifier_creep_flaming_fists_lua:IsHidden()
	return true
end

function modifier_creep_flaming_fists_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

if IsServer() then
	function modifier_creep_flaming_fists_lua:OnAttackLanded(keys)
		if keys.attacker ~= self:GetParent() then
			return
		end
		if self:GetParent():PassivesDisabled() then
			return
		end

		local ability = self:GetAbility()
		local proc_chance = ability:GetSpecialValueFor("proc_chance")

		if RollPercentage(proc_chance) then
			local radius = ability:GetSpecialValueFor("radius")
			local damage = ability:GetSpecialValueFor("damage")
			local caster = self:GetParent()

			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				keys.target:GetAbsOrigin(),
				keys.target,
				radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)

			for _, enemy in pairs(enemies) do
				ApplyDamage({
					victim = enemy,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_PURE,
					ability = ability,
				})
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_immolation_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_immolation_lua_debuff", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_immolation_lua = class({})

function creep_immolation_lua:GetIntrinsicModifierName()
	return "modifier_creep_immolation_lua"
end

--------------------------------------------------------------------------------

modifier_creep_immolation_lua = class({})

function modifier_creep_immolation_lua:IsHidden()
	return true
end

function modifier_creep_immolation_lua:OnCreated()
	if not IsServer() then
		return
	end
end

function modifier_creep_immolation_lua:IsAura()
	return not self:GetParent():PassivesDisabled()
end
function modifier_creep_immolation_lua:GetModifierAura()
	return "modifier_creep_immolation_lua_debuff"
end
function modifier_creep_immolation_lua:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end
function modifier_creep_immolation_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_creep_immolation_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

modifier_creep_immolation_lua_debuff = class({})

function modifier_creep_immolation_lua_debuff:OnCreated()
	if not IsServer() then
		return
	end
	local interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	self.damage = self:GetAbility():GetSpecialValueFor("damage") * interval
	self:StartIntervalThink(interval)
end

function modifier_creep_immolation_lua_debuff:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_feast_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_feast_lua = class({})

function creep_feast_lua:GetIntrinsicModifierName()
	return "modifier_creep_feast_lua"
end

--------------------------------------------------------------------------------

modifier_creep_feast_lua = class({})

function modifier_creep_feast_lua:IsHidden()
	return true
end

function modifier_creep_feast_lua:IsPurgable()
	return false
end

function modifier_creep_feast_lua:OnCreated(kv)
	self.leech_percent = self:GetAbility():GetSpecialValueFor("hp_leech_percent") / 100
end

function modifier_creep_feast_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_creep_feast_lua:GetModifierProcAttack_BonusDamage_Physical(params)
	if IsServer() then
		if self:GetParent():PassivesDisabled() then
			return
		end

		local leech = params.target:GetHealth() * self.leech_percent
		self:GetParent():Heal(leech, self:GetParent())
		self:PlayEffects()
		return leech
	end
end

function modifier_creep_feast_lua:PlayEffects()
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_rage_lua", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_NONE)

creep_rage_lua = class({})

function creep_rage_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:Purge(false, true, false, false, false)

	caster:AddNewModifier(caster, self, "modifier_creep_rage_lua", { duration = duration })

	local sound_cast = "Hero_LifeStealer.Rage"
	EmitSoundOn(sound_cast, caster)
end

--------------------------------------------------------------------------------

modifier_creep_rage_lua = class({})

function modifier_creep_rage_lua:IsHidden()
	return false
end

function modifier_creep_rage_lua:IsDebuff()
	return false
end

function modifier_creep_rage_lua:IsPurgable()
	return false
end

function modifier_creep_rage_lua:OnCreated(kv)
	self.as_bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	-- if IsServer() then
	-- 	self:PlayEffects()
	-- end
end

function modifier_creep_rage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_creep_rage_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

function modifier_creep_rage_lua:CheckState()
	local state = {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
	return state
end

-- function modifier_creep_rage_lua:PlayEffects()
--     local parent = self:GetParent()
--     local effect_cast = ParticleManager:CreateParticle(
--         "particles/units/heroes/hero_life_stealer/life_stealer_rage.vpcf",
--         PATTACH_ABSORIGIN_FOLLOW,
--         parent
--     )

--     ParticleManager:SetParticleControlEnt(
--         effect_cast,
--         0,
--         parent,
--         PATTACH_ABSORIGIN_FOLLOW,
--         nil,
--         parent:GetAbsOrigin(),
--         true
--     )
--     self:AddParticle(effect_cast, false, false, -1, false, false)
-- end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

require("data")

spawn_tomb_units = class({})

LinkLuaModifier("modifier_spawn_tomb_units", "abilities/creeps/zone_9/zone_9", LUA_MODIFIER_MOTION_VERTICAL)

function spawn_tomb_units:GetIntrinsicModifierName()
	return "modifier_spawn_tomb_units"
end

--------------------------------------------------------------------------------

modifier_spawn_tomb_units = class({})

function modifier_spawn_tomb_units:IsHidden()
	return true
end

function modifier_spawn_tomb_units:IsPurgable()
	return false
end

function modifier_spawn_tomb_units:OnCreated(kv)
	self:StartIntervalThink(0.5)
end

function modifier_spawn_tomb_units:OnIntervalThink()
	if IsServer() then
		if self:GetAbility():IsCooldownReady() and self:GetParent():IsAlive() then
			local hEnemies = FindUnitsInRadius(
				self:GetParent():GetTeamNumber(),
				self:GetParent():GetOrigin(),
				self:GetParent(),
				1100,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_CLOSEST,
				false
			)
			if #hEnemies > 0 then
				local unit = CreateUnitByName(
					"npc_zone_9_tomb_minion",
					self:GetParent():GetAbsOrigin(),
					true,
					nil,
					nil,
					DOTA_TEAM_NEUTRALS
				)
				unit.force_drop_name = "npc_zone_9_tomb_minion_" .. self:GetParent().number
				Timers:CreateTimer({
					endTime = 10,
					callback = function()
						UTIL_Remove(unit)
					end,
				})
				local random_ability = passive[RandomInt(1, #passive)]
				rules:aura_dif(unit, random_ability)
				self:GetAbility():UseResources(false, false, false, true)
			end
		end
	end
end