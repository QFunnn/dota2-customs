--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


lua_snapfire_scatterblast = lua_snapfire_scatterblast or class({})

LinkLuaModifier(
	"modifier_lua_snapfire_scatterblast_slow",
	"heroes/hero_snapfire/hero_snapfire",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_snapfire_scatterblast_silence",
	"heroes/hero_snapfire/hero_snapfire",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_generic_custom_indicator",
	"components/modifiers/generic/modifier_generic_custom_indicator",
	LUA_MODIFIER_MOTION_NONE
)

function lua_snapfire_scatterblast:OnAbilityPhaseStart()
	EmitSoundOn("Hero_Snapfire.Shotgun.Load", self:GetCaster())
	return true
end

function lua_snapfire_scatterblast:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	local projectile_name = "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun.vpcf"
	local projectile_distance = self:GetCastRange(point, nil)
	local projectile_start_radius = self:GetSpecialValueFor("blast_width_initial") / 2
	local projectile_end_radius = self:GetSpecialValueFor("blast_width_end") / 2
	local projectile_speed = self:GetSpecialValueFor("blast_speed")
	local projectile_direction = point - origin
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),

		bDeleteOnHit = false,

		iUnitTargetTeam = self:GetAbilityTargetTeam(),
		iUnitTargetFlags = self:GetAbilityTargetFlags(),
		iUnitTargetType = self:GetAbilityTargetType(),

		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,

		bProvidesVision = false,
		ExtraData = {
			pos_x = origin.x,
			pos_y = origin.y,
		},
	}
	ProjectileManager:CreateLinearProjectile(info)
	EmitSoundOn("Hero_Snapfire.Shotgun.Fire", caster)
end

function lua_snapfire_scatterblast:OnProjectileHit_ExtraData(target, location, extraData)
	if not target then
		return
	end
	local caster = self:GetCaster()
	local location = target:GetOrigin()
	local point_blank_range = self:GetSpecialValueFor("point_blank_range")
	local point_blank_mult = self:GetSpecialValueFor("point_blank_dmg_bonus_pct") / 100
	local damage = self:GetSpecialValueFor("damage")
	local duration = self:GetSpecialValueFor("slow_duration")
	local modifier_name = "modifier_lua_snapfire_scatterblast_slow"

	local origin = Vector(extraData.pos_x, extraData.pos_y, 0)
	local length = (location - origin):Length2D()

	local point_blank = (length <= point_blank_range)
	if point_blank then
		damage = damage + point_blank_mult * damage

		local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_snapfire_3")
		if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
			modifier_name = "modifier_stunned"
		end
	end

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
	target:AddNewModifier(caster, self, modifier_name, { duration = duration })
	self:PlayEffects(target, point_blank)
end

function lua_snapfire_scatterblast:PlayEffects(target, point_blank)
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_impact.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_snapfire/hero_snapfire_shells_impact.vpcf"
	local particle_cast3 = "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_pointblank_impact_sparks.vpcf"
	local sound_target = "Hero_Snapfire.Shotgun.Target"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	if point_blank then
		local effect_cast = ParticleManager:CreateParticle(particle_cast2, PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			3,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0, 0, 0), -- unknown
			true -- unknown, true
		)
		ParticleManager:ReleaseParticleIndex(effect_cast)

		local effect_cast = ParticleManager:CreateParticle(particle_cast3, PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			4,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0, 0, 0), -- unknown
			true -- unknown, true
		)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end

	-- Create Sound
	EmitSoundOn(sound_target, target)
end

--------------------------------------------------------------------------------
modifier_lua_snapfire_scatterblast_slow = class({})

function modifier_lua_snapfire_scatterblast_slow:IsHidden()
	return false
end

function modifier_lua_snapfire_scatterblast_slow:IsDebuff()
	return true
end

function modifier_lua_snapfire_scatterblast_slow:IsStunDebuff()
	return false
end

function modifier_lua_snapfire_scatterblast_slow:IsPurgable()
	return true
end

function modifier_lua_snapfire_scatterblast_slow:OnCreated(kv)
	self.slow = -self:GetAbility():GetSpecialValueFor("movement_slow_pct")
end

function modifier_lua_snapfire_scatterblast_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_lua_snapfire_scatterblast_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_lua_snapfire_scatterblast_slow:GetEffectName()
	return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_lua_snapfire_scatterblast_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_lua_snapfire_scatterblast_slow:GetStatusEffectName()
	return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_lua_snapfire_scatterblast_slow:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LinkLuaModifier(
	"modifier_lua_snapfire_firesnap_cookie_damage",
	"heroes/hero_snapfire/hero_snapfire",
	LUA_MODIFIER_MOTION_NONE
)

lua_snapfire_firesnap_cookie = lua_snapfire_firesnap_cookie or class({})

function lua_snapfire_firesnap_cookie:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local info = {
		Target = target,
		Source = caster,
		Ability = self,

		EffectName = "particles/units/heroes/hero_snapfire/hero_snapfire_cookie_projectile.vpcf",
		iMoveSpeed = 1000,
		bDodgeable = false,
	}
	ProjectileManager:CreateTrackingProjectile(info)

	EmitSoundOn("Hero_Snapfire.FeedCookie.Cast", self:GetCaster())
end

function lua_snapfire_firesnap_cookie:OnProjectileHit(target, location)
	if not target then
		return
	end

	local heal = self:GetSpecialValueFor("hp")
	local duration = self:GetSpecialValueFor("duration")

	target:Heal(heal, self:GetCaster())
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, heal, nil)

	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_lua_snapfire_firesnap_cookie_damage",
		{ duration = duration }
	)

	self:PlayEffects1()
	self:PlayEffects2(target)
end

function lua_snapfire_firesnap_cookie:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_snapfire/hero_snapfire_cookie_selfcast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function lua_snapfire_firesnap_cookie:PlayEffects2(target)
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_cookie_buff.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_snapfire/hero_snapfire_cookie_receive.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local effect_cast = ParticleManager:CreateParticle(particle_cast2, PATTACH_ABSORIGIN_FOLLOW, target)
	EmitSoundOn("Hero_Snapfire.FeedCookie.Consume", target)
	return effect_cast
end

--------------------------------------------------------------------------------

modifier_lua_snapfire_firesnap_cookie_damage = class({})

function modifier_lua_snapfire_firesnap_cookie_damage:IsHidden()
	return false
end

function modifier_lua_snapfire_firesnap_cookie_damage:IsDebuff()
	return false
end

function modifier_lua_snapfire_firesnap_cookie_damage:IsPurgable()
	return true
end

function modifier_lua_snapfire_firesnap_cookie_damage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_lua_snapfire_firesnap_cookie_damage:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("damage")
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_lua_snapfire_lil_shredder", "heroes/hero_snapfire/hero_snapfire", LUA_MODIFIER_MOTION_NONE)

lua_snapfire_lil_shredder = class({})

function lua_snapfire_lil_shredder:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetDuration()

	caster:AddNewModifier(caster, self, "modifier_lua_snapfire_lil_shredder", { duration = duration })
end

--------------------------------------------------------------------------------
modifier_lua_snapfire_lil_shredder = class({})

function modifier_lua_snapfire_lil_shredder:IsHidden()
	return false
end

function modifier_lua_snapfire_lil_shredder:IsDebuff()
	return false
end

function modifier_lua_snapfire_lil_shredder:IsStunDebuff()
	return false
end

function modifier_lua_snapfire_lil_shredder:IsPurgable()
	return true
end

function modifier_lua_snapfire_lil_shredder:OnCreated(kv)
	self.attacks = self:GetAbility():GetSpecialValueFor("buffed_attacks")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.as_bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	self.range_bonus = self:GetAbility():GetSpecialValueFor("attack_range_bonus")
	self.bat = self:GetAbility():GetSpecialValueFor("base_attack_time")
	self.slow = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.damage_per_stack = self:GetAbility():GetSpecialValueFor("fury")

	if not IsServer() then
		return
	end

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_snapfire_8")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		self.damage = self:GetCaster():GetAverageTrueAttackDamage(nil)
	end

	self:SetStackCount(self.attacks)

	self.records = {}

	self:PlayEffects()
	EmitSoundOn("Hero_Snapfire.ExplosiveShells.Cast", self:GetParent())
end

function modifier_lua_snapfire_lil_shredder:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_lua_snapfire_lil_shredder:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("Hero_Snapfire.ExplosiveShells.Cast", self:GetParent())
end

function modifier_lua_snapfire_lil_shredder:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	}
	return funcs
end

function modifier_lua_snapfire_lil_shredder:OnAttack(params)
	if params.attacker ~= self:GetParent() then
		return
	end
	if self:GetStackCount() <= 0 then
		return
	end

	self.records[params.record] = true

	EmitSoundOn("Hero_Snapfire.ExplosiveShellsBuff.Attack", self:GetParent())

	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
	end
end

function modifier_lua_snapfire_lil_shredder:OnAttackLanded(params)
	if params.attacker ~= self:GetParent() then
		return
	end
	if self.records[params.record] then
		EmitSoundOn("Hero_Snapfire.ExplosiveShellsBuff.Target", params.target)
	end
end

function modifier_lua_snapfire_lil_shredder:OnAttackRecordDestroy(params)
	if self.records[params.record] then
		self.records[params.record] = nil

		if next(self.records) == nil and self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end

function modifier_lua_snapfire_lil_shredder:GetModifierProjectileName()
	if self:GetStackCount() <= 0 then
		return
	end
	return "particles/units/heroes/hero_snapfire/hero_snapfire_shells_projectile.vpcf"
end

function modifier_lua_snapfire_lil_shredder:GetModifierOverrideAttackDamage(keys)
	if self:GetStackCount() <= 0 then
		return
	end
	if not IsServer() then
		return
	end

	local target = keys.target

	local bonus_damage = 0

	if target:IsBuilding() or target:IsOther() or target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		return nil
	end

	local bonus_damage = (self.attacks - (self:GetStackCount() - 1)) * self.damage_per_stack

	return self.damage + bonus_damage
end

function modifier_lua_snapfire_lil_shredder:GetModifierAttackRangeBonus()
	if self:GetStackCount() <= 0 then
		return
	end
	return self.range_bonus
end

function modifier_lua_snapfire_lil_shredder:GetModifierAttackSpeedBonus_Constant()
	if self:GetStackCount() <= 0 then
		return
	end
	return self.as_bonus
end

function modifier_lua_snapfire_lil_shredder:GetModifierBaseAttackTimeConstant()
	if self:GetStackCount() <= 0 then
		return
	end
	local bat = self.bat
	local parent = self:GetParent()
	if parent and parent.dms_bat_factor then
		bat = bat * parent.dms_bat_factor
	end
	return bat
end

function modifier_lua_snapfire_lil_shredder:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_shells_buff.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		4,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		5,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_lua_snapfire_mortimer_kisses", "heroes/hero_snapfire/hero_snapfire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_lua_snapfire_mortimer_kisses_thinker",
	"heroes/hero_snapfire/hero_snapfire",
	LUA_MODIFIER_MOTION_NONE
)

lua_snapfire_mortimer_kisses = lua_snapfire_mortimer_kisses or class({})

function lua_snapfire_mortimer_kisses:GetIntrinsicModifierName()
	return "modifier_lua_snapfire_mortimer_kisses"
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_snapfire_mortimer_kisses = class({})

function modifier_lua_snapfire_mortimer_kisses:IsHidden()
	return false
end

function modifier_lua_snapfire_mortimer_kisses:IsPurgable()
	return false
end

function modifier_lua_snapfire_mortimer_kisses:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_lua_snapfire_mortimer_kisses:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if not self:GetAbility() then
		return
	end
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if params.attacker == self:GetCaster() and RandomInt(1, 100) <= self:GetAbility():GetSpecialValueFor("chance") then
		local projectile_speed = self:GetAbility():GetSpecialValueFor("projectile_speed")

		self.info = {
			Target = params.target,
			Source = self:GetCaster(),
			Ability = self:GetAbility(),

			EffectName = "particles/units/heroes/hero_snapfire/snapfire_lizard_blobs_arced.vpcf",
			iMoveSpeed = projectile_speed,
		}
		ProjectileManager:CreateTrackingProjectile(self.info)
	end
end

function lua_snapfire_mortimer_kisses:OnProjectileHit(target, location)
	if not target then
		return
	end

	local damage = self:GetSpecialValueFor("damage_per_impact")
	local duration = self:GetSpecialValueFor("burn_ground_duration")
	local impact_radius = self:GetSpecialValueFor("impact_radius")

	local damageTable = {
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		location,
		target,
		impact_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
	end

	-- local mod = target:AddNewModifier(self:GetCaster(), self, "modifier_lua_snapfire_mortimer_kisses_thinker", {duration = duration})

	CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_lua_snapfire_mortimer_kisses_thinker",
		{ duration = duration },
		target:GetOrigin(),
		self:GetCaster():GetTeamNumber(),
		false
	)

	GridNav:DestroyTreesAroundPoint(location, impact_radius, true)

	self:PlayEffects(location)
end

function lua_snapfire_mortimer_kisses:PlayEffects(loc)
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_impact.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_linger.vpcf"
	local sound_cast = "Hero_Snapfire.MortimerBlob.Impact"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 3, loc)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local effect_cast = ParticleManager:CreateParticle(particle_cast2, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, loc)
	ParticleManager:SetParticleControl(effect_cast, 1, loc)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local sound_location = "Hero_Snapfire.MortimerBlob.Impact"
	-- EmitSoundOnLocationWithCaster( loc, sound_location, self:GetCaster() )
	EmitSoundOn(sound_location, self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_lua_snapfire_mortimer_kisses_thinker = class({})

function modifier_lua_snapfire_mortimer_kisses_thinker:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("impact_radius")
	self.burn_interval = self:GetAbility():GetSpecialValueFor("burn_interval")
	self.burn_damage = self:GetAbility():GetSpecialValueFor("burn_damage")
	if not IsServer() then
		return
	end
	-- self:PlayEffects(0.5)
	self:StartIntervalThink(self.burn_interval)
end

function modifier_lua_snapfire_mortimer_kisses_thinker:OnIntervalThink()
	if IsServer() then
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			self:GetParent(),
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		for _, enemy in pairs(enemies) do
			ApplyDamage({
				attacker = self:GetCaster(),
				victim = enemy,
				damage = self.burn_damage * self.burn_interval,
				ability = self:GetAbility(),
				damage_type = DAMAGE_TYPE_MAGICAL,
			})
		end
	end
end

function modifier_lua_snapfire_mortimer_kisses_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end