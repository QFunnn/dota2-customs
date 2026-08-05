--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_disruptor_thunder_strike_lua",
	"heroes/hero_disruptor/hero_disruptor",
	LUA_MODIFIER_MOTION_NONE
)

disruptor_thunder_strike_lua = class({})

function disruptor_thunder_strike_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", context)
end

function disruptor_thunder_strike_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	target:AddNewModifier(caster, self, "modifier_disruptor_thunder_strike_lua", {})
	EmitSoundOn("Hero_Disruptor.ThunderStrike.Cast", caster)
end

--------------------------------------------------------------------------------

modifier_disruptor_thunder_strike_lua = class({})

function modifier_disruptor_thunder_strike_lua:IsHidden()
	return false
end

function modifier_disruptor_thunder_strike_lua:IsDebuff()
	return true
end

function modifier_disruptor_thunder_strike_lua:IsStunDebuff()
	return false
end

function modifier_disruptor_thunder_strike_lua:IsPurgable()
	return true
end

function modifier_disruptor_thunder_strike_lua:RemoveOnDeath()
	return false
end

function modifier_disruptor_thunder_strike_lua:DestroyOnExpire()
	return false
end

function modifier_disruptor_thunder_strike_lua:OnCreated(kv)
	self.count = self:GetAbility():GetSpecialValueFor("strikes")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	local interval = self:GetAbility():GetSpecialValueFor("strike_interval")

	if not IsServer() then
		return
	end
	local damage = self:GetAbility():GetSpecialValueFor("strike_damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")

	if IsServer() then
		self.damageTable = {
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(),
		}

		local duration = (self.count - 1) * interval
		self:SetDuration(duration, true)
		self:StartIntervalThink(interval)
		self:OnIntervalThink()

		self.sound_loop = "Hero_Disruptor.ThunderStrike.Thunderator"
		EmitSoundOn(self.sound_loop, self:GetParent())
	end
end

function modifier_disruptor_thunder_strike_lua:OnRefresh(kv)
	self.count = self:GetAbility():GetSpecialValueFor("strikes")
	local interval = self:GetAbility():GetSpecialValueFor("strike_interval")

	if IsServer() then
		local damage = self:GetAbility():GetSpecialValueFor("strike_damage")
			+ self:GetCaster():ExtraIntelligenceDamage()
				* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
		self.damageTable.damage = damage
		local duration = (self.count - 1) * interval
		self:SetDuration(duration, true)
		self:StartIntervalThink(interval)
		self:OnIntervalThink()
	end
end

function modifier_disruptor_thunder_strike_lua:OnDestroy()
	if not IsServer() then
		return
	end
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius + 200, 4, false)
	StopSoundOn(self.sound_loop, self:GetParent())
end

function modifier_disruptor_thunder_strike_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}

	return funcs
end

function modifier_disruptor_thunder_strike_lua:GetModifierProvidesFOWVision()
	return 1
end

function modifier_disruptor_thunder_strike_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
	}

	return state
end

function modifier_disruptor_thunder_strike_lua:OnIntervalThink()
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
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)
	end

	self:PlayEffects()

	self.count = self.count - 1
	if self.count < 1 then
		self:Destroy()
	end
end

function modifier_disruptor_thunder_strike_lua:GetEffectName()
	return "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_buff.vpcf"
end

function modifier_disruptor_thunder_strike_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_disruptor_thunder_strike_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControl(effect_cast, 2, self:GetParent():GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local sound_cast = "Hero_Disruptor.ThunderStrike.Target"
	-- EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_magnetic_collect_thinker", "heroes/hero_disruptor/hero_disruptor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_magnetic_collect_effect", "heroes/hero_disruptor/hero_disruptor", LUA_MODIFIER_MOTION_NONE)

disruptor_magnetic_collect = class({})

function disruptor_magnetic_collect:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/razor/razor_arcana/razor_arcana_eye_of_the_storm_rain_v2.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context)
end

function disruptor_magnetic_collect:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function disruptor_magnetic_collect:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_magnetic_collect_thinker",
		{ duration = duration },
		point,
		caster:GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------

modifier_magnetic_collect_thinker = class({})

function modifier_magnetic_collect_thinker:IsHidden()
	return false
end
function modifier_magnetic_collect_thinker:IsDebuff()
	return false
end
function modifier_magnetic_collect_thinker:IsPurgable()
	return false
end

function modifier_magnetic_collect_thinker:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.radius = self.ability:GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("strike_damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
	self.interval = self.ability:GetSpecialValueFor("strike_interval")

	self.damageTable = {
		attacker = self.caster,
		damage = self.damage,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}

	self:StartIntervalThink(self.interval)
	self:PlayEffects1()
end

function modifier_magnetic_collect_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("Hero_Disruptor.Glimpse.Target", self.parent)
end

function modifier_magnetic_collect_thinker:OnIntervalThink()
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.parent:GetOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_disruptor_6")
	if talent and talent:GetLevel() > 0 then
		for _, enemy in pairs(enemies) do
			if enemy then
				self.damageTable.victim = enemy
				ApplyDamage(self.damageTable)
				self:PlayEffects2(enemy)
			end
		end
	else
		if #enemies > 0 then
			local target = enemies[1]
			self.damageTable.victim = target
			ApplyDamage(self.damageTable)
			self:PlayEffects2(target)
		end
	end
end

function modifier_magnetic_collect_thinker:IsAura()
	return true
end
function modifier_magnetic_collect_thinker:GetModifierAura()
	return "modifier_magnetic_collect_effect"
end
function modifier_magnetic_collect_thinker:GetAuraRadius()
	return self.radius
end
function modifier_magnetic_collect_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_magnetic_collect_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_magnetic_collect_thinker:GetAuraDuration()
	return 0.1
end

function modifier_magnetic_collect_thinker:PlayEffects1()
	local particle_cast = "particles/econ/items/razor/razor_arcana/razor_arcana_eye_of_the_storm_rain_v2.vpcf"
	local sound_cast = "Hero_Disruptor.Glimpse.Target"

	self.pfx = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.radius, 1, 1))

	self:AddParticle(self.pfx, false, false, -1, false, false)
	EmitSoundOn(sound_cast, self.parent)
end

function modifier_magnetic_collect_thinker:PlayEffects2(enemy)
	local particle_cast = "particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf"
	local sound_cast = "Hero_razor.lightning"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetOrigin() + Vector(0, 0, 500))

	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		enemy,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, enemy)
end

--------------------------------------------------------------------------------

modifier_magnetic_collect_effect = class({})

function modifier_magnetic_collect_effect:IsHidden()
	return false
end
function modifier_magnetic_collect_effect:IsDebuff()
	return true
end
function modifier_magnetic_collect_effect:IsPurgable()
	return false
end

function modifier_magnetic_collect_effect:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_magnetic_collect_effect:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_magnetic_collect_effect:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_disruptor_kinetic_field_lua",
	"heroes/hero_disruptor/hero_disruptor",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_resist", "heroes/hero_disruptor/hero_disruptor", LUA_MODIFIER_MOTION_NONE)

disruptor_kinetic_field_lua = class({})

function disruptor_kinetic_field_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function disruptor_kinetic_field_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_disruptor_kinetic_field_lua",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_resist", { duration = duration })
		local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_disruptor_8")
		if talent and talent:GetLevel() > 0 then
			local strike = self:GetCaster():FindAbilityByName("disruptor_thunder_strike_lua")
			if strike ~= nil and strike:GetLevel() > 0 then
				enemy:AddNewModifier(self:GetCaster(), strike, "modifier_disruptor_thunder_strike_lua", {})
			end
		end
	end
end

--------------------------------------------------------------------------------

modifier_disruptor_kinetic_field_lua = class({})

function modifier_disruptor_kinetic_field_lua:IsHidden()
	return true
end

function modifier_disruptor_kinetic_field_lua:IsDebuff()
	return true
end

function modifier_disruptor_kinetic_field_lua:IsPurgable()
	return true
end

function modifier_disruptor_kinetic_field_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_disruptor_kinetic_field_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.owner = kv.isProvidedByAura ~= 1

	if self.owner then
		self.delay = self:GetAbility():GetSpecialValueFor("formation_time")
		self.duration = self:GetAbility():GetSpecialValueFor("duration")
		self:SetDuration(self.delay + self.duration, false)
		self.formed = false
		self:StartIntervalThink(self.delay)
		self:PlayEffects1()
		self.sound_loop = "Hero_Disruptor.KineticField"
		EmitSoundOn(self.sound_loop, self:GetParent())
	else
		self.aura_origin = Vector(kv.aura_origin_x, kv.aura_origin_y, 0)
		self.parent = self:GetParent()
		self.width = 100
		self.max_speed = 550
		self.min_speed = 0.1
		self.max_min = self.max_speed - self.min_speed
		self.inside = (self.parent:GetOrigin() - self.aura_origin):Length2D() < self.radius
	end
end

function modifier_disruptor_kinetic_field_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self.owner then
		StopSoundOn(self.sound_loop, self:GetParent())
		local sound_end = "Hero_Disruptor.KineticField.End"
		EmitSoundOn(sound_end, self:GetParent())
		UTIL_Remove(self:GetParent())
	end
end

function modifier_disruptor_kinetic_field_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_disruptor_kinetic_field_lua:GetModifierMoveSpeed_Limit(params)
	if not IsServer() then
		return
	end
	if self.owner then
		return 0
	end

	local parent_vector = self.parent:GetOrigin() - self.aura_origin
	local parent_direction = parent_vector:Normalized()

	local actual_distance = parent_vector:Length2D()
	local wall_distance = actual_distance - self.radius
	local over_walls = false
	if self.inside ~= (wall_distance < 0) then
		if math.abs(wall_distance) > self.width then
			self.inside = not self.inside
		else
			over_walls = true
		end
	end

	wall_distance = math.abs(wall_distance)
	if wall_distance > self.width then
		return 0
	end

	local parent_angle = 0
	if self.inside then
		parent_angle = VectorToAngles(parent_direction).y
	else
		parent_angle = VectorToAngles(-parent_direction).y
	end
	local unit_angle = self:GetParent():GetAnglesAsVector().y
	local wall_angle = math.abs(AngleDiff(parent_angle, unit_angle))

	local limit = 0
	if wall_angle <= 90 then
		if over_walls then
			limit = self.min_speed
			self:RemoveMotions()
		else
			limit = (wall_distance / self.width) * self.max_min + self.min_speed
		end
	else
		limit = 0
	end
	return limit
end

function modifier_disruptor_kinetic_field_lua:RemoveMotions()
	local modifiers = self.parent:FindAllModifiers()
	for _, modifier in pairs(modifiers) do
		-- print("modifier:",modifier,modifier:GetName())
	end
end

function modifier_disruptor_kinetic_field_lua:OnIntervalThink()
	self:StartIntervalThink(-1)
	self.formed = true
	self:PlayEffects2()
end

function modifier_disruptor_kinetic_field_lua:IsAura()
	return self.owner and self.formed
end

function modifier_disruptor_kinetic_field_lua:GetModifierAura()
	return "modifier_disruptor_kinetic_field_lua"
end

function modifier_disruptor_kinetic_field_lua:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_kinetic_field_lua:GetAuraDuration()
	return 0.3
end

function modifier_disruptor_kinetic_field_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_kinetic_field_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_kinetic_field_lua:GetAuraSearchFlags()
	return 0
end

function modifier_disruptor_kinetic_field_lua:GetAuraEntityReject(hEntity)
	return false
end

function modifier_disruptor_kinetic_field_lua:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_kineticfield_formation.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(self.delay, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_disruptor_kinetic_field_lua:PlayEffects2()
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_kineticfield.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(self.duration, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

--------------------------------------------------------------------------------

modifier_resist = class({})

function modifier_resist:IsHidden()
	return false
end

function modifier_resist:IsDebuff()
	return true
end

function modifier_resist:IsPurgable()
	return true
end

function modifier_resist:OnCreated(kv)
	self.resist = self:GetAbility():GetSpecialValueFor("resist") * -1
end

function modifier_resist:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function modifier_resist:GetModifierMagicalResistanceBonus()
	return self.resist
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_disruptor_static_storm_lua", "heroes/hero_disruptor/hero_disruptor", LUA_MODIFIER_MOTION_NONE)

disruptor_static_storm_lua = class({})

function disruptor_static_storm_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_disruptor_4")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 20
	end
	return self.BaseClass.GetCooldown(self, level)
end

function disruptor_static_storm_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function disruptor_static_storm_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	CreateModifierThinker(caster, self, "modifier_disruptor_static_storm_lua", {}, point, caster:GetTeamNumber(), false)

	EmitSoundOn("Hero_Disruptor.StaticStorm.Cast", caster)
end

--------------------------------------------------------------------------------

modifier_disruptor_static_storm_lua = class({})

function modifier_disruptor_static_storm_lua:IsHidden()
	return false
end

function modifier_disruptor_static_storm_lua:IsDebuff()
	return true
end

function modifier_disruptor_static_storm_lua:IsStunDebuff()
	return false
end

function modifier_disruptor_static_storm_lua:IsPurgable()
	return true
end

function modifier_disruptor_static_storm_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.owner = kv.isProvidedByAura ~= 1
	if not self.owner then
		return
	end

	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.pulses = self:GetAbility():GetSpecialValueFor("pulses")
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	local damage = self:GetAbility():GetSpecialValueFor("damage_max")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")

	local interval = duration / self.pulses
	local max_tick_damage = damage * interval
	self.tick_damage = max_tick_damage / self.pulses
	self.pulse = 0

	self.damageTable = {
		attacker = self:GetCaster(),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}

	self:StartIntervalThink(interval)
	self:PlayEffects1(duration)
	self.sound_loop = "Hero_Disruptor.StaticStorm"
	EmitSoundOn(self.sound_loop, self:GetParent())
end

function modifier_disruptor_static_storm_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self.owner then
		StopSoundOn(self.sound_loop, self:GetParent())
		local sound_stop = "Hero_Disruptor.StaticStorm.End"
		EmitSoundOn(sound_stop, self:GetParent())

		UTIL_Remove(self:GetParent())
	end
end

function modifier_disruptor_static_storm_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}
	return state
end

function modifier_disruptor_static_storm_lua:OnIntervalThink()
	self.pulse = self.pulse + 1

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

	self.damageTable.damage = self.tick_damage * self.pulse

	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)
		self:PlayEffects2(enemy)
	end

	if self.pulse >= self.pulses then
		self:Destroy()
	end
end

function modifier_disruptor_static_storm_lua:IsAura()
	return self.owner
end

function modifier_disruptor_static_storm_lua:GetModifierAura()
	return "modifier_disruptor_static_storm_lua"
end

function modifier_disruptor_static_storm_lua:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_static_storm_lua:GetAuraDuration()
	return 0.3
end

function modifier_disruptor_static_storm_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_static_storm_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_static_storm_lua:PlayEffects1(duration)
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_static_storm.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(duration, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_disruptor_static_storm_lua:PlayEffects2(target)
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_static_storm_bolt_hero.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_OVERHEAD_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end