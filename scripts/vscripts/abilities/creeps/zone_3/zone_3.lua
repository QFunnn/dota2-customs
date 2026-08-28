--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

creep_ice_shards_lua = class({})

function creep_ice_shards_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_tusk/tusk_ice_shards_projectile.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_tusk/tusk_ice_shards.vpcf", context)
end

function creep_ice_shards_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_ice_shards_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local caster_pos = caster:GetAbsOrigin()

	local direction = point - caster_pos
	direction.z = 0
	local distance = direction:Length2D()
	direction = direction:Normalized()

	local max_range = self:GetCastRange(point, nil)
	if distance > max_range then
		distance = max_range
	end

	self.direction = direction
	local projectile_table = {
		Ability = self,
		EffectName = "particles/units/heroes/hero_tusk/tusk_ice_shards_projectile.vpcf",
		vSpawnOrigin = caster_pos,
		fDistance = distance,
		fStartRadius = self:GetSpecialValueFor("shard_width"),
		fEndRadius = self:GetSpecialValueFor("shard_width"),
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		fExpireTime = GameRules:GetGameTime() + 5,
		bDeleteOnHit = false,
		vVelocity = direction * self:GetSpecialValueFor("shard_speed"),
		bProvidesVision = true,
		iVisionRadius = self:GetSpecialValueFor("shard_width"),
		iVisionTeamNumber = caster:GetTeamNumber(),
	}

	ProjectileManager:CreateLinearProjectile(projectile_table)
	caster:EmitSound("Hero_Tusk.IceShards.Projectile")
end

function creep_ice_shards_lua:OnProjectileHit(hTarget, vLocation)
	if hTarget then
		local damage_table = {
			victim = hTarget,
			attacker = self:GetCaster(),
			ability = self,
			damage = self:GetSpecialValueFor("shard_damage") + self:GetSpecialValueFor("diff_boost_damage"),
			damage_type = self:GetAbilityDamageType(),
		}
		ApplyDamage(damage_table)

		local offset_location = vLocation + self.direction * 100
		self:SpawnIceBarrier(offset_location)
		return true
	else
		self:SpawnIceBarrier(vLocation)
		return true
	end
end

function creep_ice_shards_lua:SpawnIceBarrier(vLocation)
	local caster = self:GetCaster()
	caster:StopSound("Hero_Tusk.IceShards.Projectile")
	caster:EmitSound("Hero_Tusk.IceShards")

	local duration = self:GetSpecialValueFor("shard_duration")
	local shard_distance = 150
	local shard_angle_step = 30

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tusk/tusk_ice_shards.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, Vector(duration, 0, 0))

	for i = 1, 7 do
		local angle = (i - 4) * shard_angle_step
		local direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), self.direction)
		local position = GetGroundPosition(vLocation + direction * shard_distance, nil)
		ParticleManager:SetParticleControl(particle, i, position)
		local blocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", { origin = position })
		local ice_model = SpawnEntityFromTableSynchronous("prop_dynamic", {
			model = "models/particle/ice_shards.vmdl",
			origin = position,
			angles = Vector(0, RandomInt(0, 360), 0),
			modelscale = 15.0,
		})

		Timers:CreateTimer(duration, function()
			if blocker and not blocker:IsNull() then
				UTIL_Remove(blocker)
			end
			if ice_model and not ice_model:IsNull() then
				UTIL_Remove(ice_model)
			end
		end)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_walrus_punch_lua_logic", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_walrus_punch_lua_airtime", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_BOTH)

creep_walrus_punch_lua = class({})

function creep_walrus_punch_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/tuskarr/tusk_ti9_immortal/tusk_ti9_walruspunch_start.vpcf",
		context
	)
end

function creep_walrus_punch_lua:GetIntrinsicModifierName()
	return "modifier_creep_walrus_punch_lua_logic"
end

--------------------------------------------------------------------------------

modifier_creep_walrus_punch_lua_logic = class({})

function modifier_creep_walrus_punch_lua_logic:IsHidden()
	return true
end

function modifier_creep_walrus_punch_lua_logic:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
end

function modifier_creep_walrus_punch_lua_logic:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PREATTACK_BONUSDAMAGE,
	}
end

function modifier_creep_walrus_punch_lua_logic:OnAttackStart(keys)
	if keys.attacker ~= self:GetParent() then
		return
	end

	local ability = self:GetAbility()
	if ability:IsCooldownReady() and not self:GetParent():PassivesDisabled() then
		self.punch_attack = true
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_4)
	else
		self.punch_attack = false
	end
end

function modifier_creep_walrus_punch_lua_logic:GetModifierPreAttack_BonusDamage()
	if self.punch_attack then
		return self:GetAbility():GetSpecialValueFor("bonus_damage")
			+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	end
	return 0
end

function modifier_creep_walrus_punch_lua_logic:GetModifierPreAttack_CriticalStrike(keys)
	if self.punch_attack then
		return self:GetAbility():GetSpecialValueFor("crit_multiplier")
	end
end

function modifier_creep_walrus_punch_lua_logic:OnAttackLanded(keys)
	if keys.attacker ~= self:GetParent() then
		return
	end

	if self.punch_attack then
		local caster = self:GetParent()
		local target = keys.target
		local ability = self:GetAbility()
		self.punch_attack = false
		ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))

		if target and target:IsAlive() then
			target:EmitSound("Hero_Tusk.WalrusPunch.Target")
			local pfx = ParticleManager:CreateParticle(
				"particles/econ/items/tuskarr/tusk_ti9_immortal/tusk_ti9_walruspunch_start.vpcf",
				PATTACH_ABSORIGIN,
				target
			)
			ParticleManager:ReleaseParticleIndex(pfx)

			local air_time = ability:GetSpecialValueFor("air_time")
			target:AddNewModifier(caster, ability, "modifier_creep_walrus_punch_lua_airtime", { duration = air_time })
		end
	end
end

--------------------------------------------------------------------------------

modifier_creep_walrus_punch_lua_airtime = class({})

function modifier_creep_walrus_punch_lua_airtime:IsStunDebuff()
	return true
end
function modifier_creep_walrus_punch_lua_airtime:IsPurgable()
	return true
end

function modifier_creep_walrus_punch_lua_airtime:OnCreated()
	if not IsServer() then
		return
	end

	self.parent = self:GetParent()
	self.vVelocity = 1200
	self.gravity = 2400
	self.ground_z = GetGroundHeight(self.parent:GetAbsOrigin(), self.parent)
	self.current_z = self.ground_z

	self.rotation_speed = 1000
	self.current_angle = self.parent:GetAngles().y

	self:StartIntervalThink(0.03)
end

function modifier_creep_walrus_punch_lua_airtime:OnIntervalThink()
	if not IsServer() then
		return
	end
	local dt = 0.03
	self.current_z = self.current_z + self.vVelocity * dt
	self.vVelocity = self.vVelocity - self.gravity * dt

	self.current_angle = self.current_angle + self.rotation_speed * dt
	self.parent:SetAngles(0, self.current_angle, 0)

	local pos = self.parent:GetAbsOrigin()
	pos.z = self.current_z
	self.parent:SetAbsOrigin(pos)

	if self.current_z <= self.ground_z and self.vVelocity < 0 then
		self:Destroy()
	end
end

function modifier_creep_walrus_punch_lua_airtime:OnDestroy()
	if not IsServer() then
		return
	end

	self.parent:SetAngles(0, self.current_angle, 0)

	local pos = self.parent:GetAbsOrigin()
	pos.z = self.ground_z
	self.parent:SetAbsOrigin(pos)
	FindClearSpaceForUnit(self.parent, pos, true)
end

function modifier_creep_walrus_punch_lua_airtime:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_creep_walrus_punch_lua_airtime:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_creep_walrus_punch_lua_airtime:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_creep_walrus_punch_lua_airtime:GetEffectName()
	return "particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf"
end

function modifier_creep_walrus_punch_lua_airtime:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_tag_team_lua", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_tag_team_lua_debuff", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_tag_team_lua_slow", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)

creep_tag_team_lua = class({})

function creep_tag_team_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_tusk/tusk_tag_team.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts", context)
end

function creep_tag_team_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_tag_team_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("debuff_duration")

	caster:EmitSound("Hero_Tusk.TagTeam.Cast")
	caster:AddNewModifier(caster, self, "modifier_creep_tag_team_lua", { duration = duration })
end

--------------------------------------------------------------------------------

modifier_creep_tag_team_lua = class({})

function modifier_creep_tag_team_lua:IsHidden()
	return false
end
function modifier_creep_tag_team_lua:IsPurgable()
	return false
end

function modifier_creep_tag_team_lua:OnCreated()
	-- Кеш до серверной проверки: GetAuraRadius зовётся и на клиенте.
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local radius = self.radius

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tusk/tusk_tag_team.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))
	self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_creep_tag_team_lua:OnRefresh()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_creep_tag_team_lua:IsAura()
	return true
end
function modifier_creep_tag_team_lua:GetModifierAura()
	return "modifier_creep_tag_team_lua_debuff"
end
function modifier_creep_tag_team_lua:GetAuraRadius()
	return self.radius
end
function modifier_creep_tag_team_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_creep_tag_team_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

modifier_creep_tag_team_lua_debuff = class({})

function modifier_creep_tag_team_lua_debuff:IsHidden()
	return false
end

function modifier_creep_tag_team_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_creep_tag_team_lua_debuff:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	if keys.target ~= self:GetParent() then
		return
	end

	local target = self:GetParent()
	local attacker = keys.attacker
	local ability = self:GetAbility()

	if attacker:GetTeamNumber() == ability:GetCaster():GetTeamNumber() then
		local damage = ability:GetSpecialValueFor("bonus_damage") + ability:GetSpecialValueFor("diff_boost_damage")
		local slow_duration = ability:GetSpecialValueFor("slow_duration")

		ApplyDamage({
			victim = target,
			attacker = attacker,
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = ability,
		})

		target:EmitSound("Hero_Tusk.TagTeam.Target")
		target:AddNewModifier(
			ability:GetCaster(),
			ability,
			"modifier_creep_tag_team_lua_slow",
			{ duration = slow_duration }
		)
	end
end

--------------------------------------------------------------------------------

modifier_creep_tag_team_lua_slow = class({})

function modifier_creep_tag_team_lua_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_creep_tag_team_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("movement_slow")
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_crystal_nova_lua", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)

creep_crystal_nova_lua = class({})

function creep_crystal_nova_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_crystal_nova_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function creep_crystal_nova_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("nova_damage") + self:GetSpecialValueFor("diff_boost_damage")
	local radius = self:GetSpecialValueFor("radius")
	local debuffDuration = self:GetSpecialValueFor("duration")
	local vision_radius = 500
	local vision_duration = 2

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		0,
		0,
		false
	)

	if not IsServer() then
		return
	end

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
		enemy:AddNewModifier(caster, self, "modifier_creep_crystal_nova_lua", { duration = debuffDuration })
	end

	AddFOWViewer(self:GetCaster():GetTeamNumber(), point, vision_radius, vision_duration, true)
	self:PlayEffects(point, radius, debuffDuration)
end

function creep_crystal_nova_lua:PlayEffects(point, radius, duration)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, duration, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local sound_cast = "Hero_Crystal.CrystalNova"
	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

------------------------------------------------------------------------------

modifier_creep_crystal_nova_lua = class({})

function modifier_creep_crystal_nova_lua:IsHidden()
	return false
end

function modifier_creep_crystal_nova_lua:IsDebuff()
	return true
end

function modifier_creep_crystal_nova_lua:IsPurgable()
	return true
end

function modifier_creep_crystal_nova_lua:OnCreated(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("attackspeed_slow")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
end

function modifier_creep_crystal_nova_lua:OnRefresh(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("attackspeed_slow")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
end

function modifier_creep_crystal_nova_lua:OnDestroy(kv) end

function modifier_creep_crystal_nova_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_creep_crystal_nova_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end

function modifier_creep_crystal_nova_lua:GetModifierAttackSpeedBonus_Constant()
	return -self.as_slow
end

function modifier_creep_crystal_nova_lua:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_creep_crystal_nova_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_freezing_field_lua", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_freezing_field_lua_effect", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)

creep_freezing_field_lua = class({})

function creep_freezing_field_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_freezing_field_lua:OnSpellStart()
	local caster = self:GetCaster()
	self.modifier =
		caster:AddNewModifier(caster, self, "modifier_creep_freezing_field_lua", { duration = self:GetChannelTime() })
end

function creep_freezing_field_lua:OnChannelFinish(bInterrupted)
	return
end

-----------------------------------------------------

modifier_creep_freezing_field_lua = class({})

function modifier_creep_freezing_field_lua:IsHidden()
	return true
end

function modifier_creep_freezing_field_lua:IsDebuff()
	return false
end

function modifier_creep_freezing_field_lua:IsPurgable()
	return false
end

function modifier_creep_freezing_field_lua:RemoveOnDeath()
	return true
end

function modifier_creep_freezing_field_lua:IsAura()
	return true
end

function modifier_creep_freezing_field_lua:GetModifierAura()
	return "modifier_creep_freezing_field_lua_effect"
end

function modifier_creep_freezing_field_lua:GetAuraRadius()
	return self.slow_radius
end

function modifier_creep_freezing_field_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_creep_freezing_field_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP
end

function modifier_creep_freezing_field_lua:GetAuraDuration()
	return self.slow_duration
end

function modifier_creep_freezing_field_lua:OnCreated(kv)
	self.slow_radius = self:GetAbility():GetSpecialValueFor("radius")
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.explosion_radius = self:GetAbility():GetSpecialValueFor("explosion_radius")
	self.explosion_interval = self:GetAbility():GetSpecialValueFor("explosion_interval")
	self.explosion_min_dist = self:GetAbility():GetSpecialValueFor("explosion_min_dist")
	self.explosion_max_dist = self:GetAbility():GetSpecialValueFor("explosion_max_dist")
	self.explosion_damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	if not IsServer() then
		return
	end

	self.try_damage = self.explosion_damage

	self.quartal = -1

	if IsServer() then
		self.damageTable = {
			attacker = self:GetCaster(),
			damage = self.try_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		}

		self:StartIntervalThink(self.explosion_interval)
		self:OnIntervalThink()
		self:PlayEffects1()
	end
end

function modifier_creep_freezing_field_lua:OnDestroy(kv)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:StopEffects1()
	end
end

function modifier_creep_freezing_field_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	-- если кастер умер (или исчез) — прекращаем каст: уничтожаем модификатор,
	-- его OnDestroy остановит think, эффекты и ауру
	local caster = self:GetCaster()
	if not caster or caster:IsNull() or not caster:IsAlive() then
		self:Destroy()
		return
	end

	self.quartal = self.quartal + 1
	if self.quartal > 3 then
		self.quartal = 0
	end
	local a = RandomInt(0, 90) + self.quartal * 90
	local r = RandomInt(self.explosion_min_dist, self.explosion_max_dist)
	local point = Vector(math.cos(a), math.sin(a), 0):Normalized() * r

	point = self:GetCaster():GetOrigin() + point
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		point,
		nil,
		self.explosion_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)
	end
	self:PlayEffects2(point)
end

function modifier_creep_freezing_field_lua:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf"
	self.sound_cast = "hero_Crystal.freezingField.wind"

	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.slow_radius, self.slow_radius, 1))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)
	EmitSoundOn(self.sound_cast, self:GetCaster())
end

function modifier_creep_freezing_field_lua:PlayEffects2(point)
	local particle_cast = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	local sound_cast = "hero_Crystal.freezingField.explosion"
	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

function modifier_creep_freezing_field_lua:StopEffects1()
	StopSoundOn(self.sound_cast, self:GetCaster())
end

----------------------------------------------------------

modifier_creep_freezing_field_lua_effect = class({})

function modifier_creep_freezing_field_lua_effect:IsHidden()
	return false
end

function modifier_creep_freezing_field_lua_effect:IsDebuff()
	return true
end

function modifier_creep_freezing_field_lua_effect:IsPurgable()
	return true
end

function modifier_creep_freezing_field_lua_effect:OnCreated(kv)
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
	self.as_slow = self:GetAbility():GetSpecialValueFor("attack_slow")
end

function modifier_creep_freezing_field_lua_effect:OnRefresh(kv)
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
	self.as_slow = self:GetAbility():GetSpecialValueFor("attack_slow")
end

function modifier_creep_freezing_field_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_creep_freezing_field_lua_effect:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_creep_freezing_field_lua_effect:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_creep_freezing_field_lua_effect:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_creep_freezing_field_lua_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_ice_vortex_lua_thinker", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_ice_vortex_lua_debuff", "abilities/creeps/zone_3/zone_3", LUA_MODIFIER_MOTION_NONE)

creep_ice_vortex_lua = class({})

function creep_ice_vortex_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function creep_ice_vortex_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("vortex_duration")

	caster:EmitSound("Hero_Ancient_Apparition.IceVortexCast")

	CreateModifierThinker(
		caster,
		self,
		"modifier_creep_ice_vortex_lua_thinker",
		{ duration = duration },
		point,
		caster:GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------

modifier_creep_ice_vortex_lua_thinker = class({})

function modifier_creep_ice_vortex_lua_thinker:IsHidden()
	return true
end

function modifier_creep_ice_vortex_lua_thinker:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.radius = ability:GetSpecialValueFor("radius")
	if not IsServer() then
		return
	end

	self:GetParent():EmitSound("Hero_Ancient_Apparition.IceVortex")
	self:GetParent():EmitSound("Hero_Ancient_Apparition.IceVortex.lp")

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 5, Vector(self.radius, 0, 0))
	self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_creep_ice_vortex_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():StopSound("Hero_Ancient_Apparition.IceVortex.lp")
end

function modifier_creep_ice_vortex_lua_thinker:IsAura()
	return true
end
function modifier_creep_ice_vortex_lua_thinker:GetAuraRadius()
	return self.radius
end
function modifier_creep_ice_vortex_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_creep_ice_vortex_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_creep_ice_vortex_lua_thinker:GetModifierAura()
	return "modifier_creep_ice_vortex_lua_debuff"
end

--------------------------------------------------------------------------------

modifier_creep_ice_vortex_lua_debuff = class({})

function modifier_creep_ice_vortex_lua_debuff:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.ms_slow = ability:GetSpecialValueFor("movement_speed_pct")
		self.resist = ability:GetSpecialValueFor("spell_resist_pct")
	else
		-- Значения по умолчанию, если способность пропала в момент спавна дебаффа
		self.ms_slow = 0
		self.resist = 0
	end
end

function modifier_creep_ice_vortex_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_creep_ice_vortex_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -(self.ms_slow or 0)
end

function modifier_creep_ice_vortex_lua_debuff:GetModifierMagicalResistanceBonus()
	return -(self.resist or 0)
end

function modifier_creep_ice_vortex_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end