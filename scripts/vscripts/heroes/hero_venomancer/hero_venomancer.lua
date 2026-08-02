--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_venomancer_venomous_gale_lua",
	"heroes/hero_venomancer/hero_venomancer",
	LUA_MODIFIER_MOTION_NONE
)

venomancer_venomous_gale_lua = class({})

function venomancer_venomous_gale_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf", context)
end

function venomancer_venomous_gale_lua:Spawn()
	self.particles = {
		"particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf",
		"particles/units/heroes/hero_venomancer/venomancer_venomous_gale_impact.vpcf",
		"particles/units/heroes/hero_venomancer/venomancer_gale_poison_debuff.vpcf",
	}

	self.sounds = {
		"Hero_Venomancer.VenomousGale",
		"Hero_Venomancer.VenomousGaleImpact",
	}
	if not IsServer() then
		return
	end
end

function venomancer_venomous_gale_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function venomancer_venomous_gale_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	local radius = self:GetSpecialValueFor("radius")
	local speed = self:GetSpecialValueFor("speed")
	local range = self:GetCastRange(point, target)
	local vision = 280

	local direction = point - caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),

		bDeleteOnHit = false,

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

		EffectName = self.particles[1],
		fDistance = range,
		fStartRadius = radius,
		fEndRadius = radius,
		vVelocity = direction * speed,

		bProvidesVision = true,
		iVisionRadius = vision,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}
	ProjectileManager:CreateLinearProjectile(info)
	EmitSoundOn(self.sounds[1], caster)
end

function venomancer_venomous_gale_lua:OnProjectileHit(target, location)
	if not target then
		return
	end
	local duration = self:GetSpecialValueFor("duration")

	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_venomancer_venomous_gale_lua", -- modifier name
		{ duration = duration } -- kv
	)
	self:PlayEffects(target)
end

function venomancer_venomous_gale_lua:PlayEffects(target)
	local effect_cast = ParticleManager:CreateParticle(self.particles[2], PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(self.sounds[2], target)
end

---------------------------------------------------------------------

modifier_venomancer_venomous_gale_lua = class({})

function modifier_venomancer_venomous_gale_lua:IsHidden()
	return false
end

function modifier_venomancer_venomous_gale_lua:IsDebuff()
	return true
end

function modifier_venomancer_venomous_gale_lua:IsStunDebuff()
	return false
end

function modifier_venomancer_venomous_gale_lua:IsPurgable()
	return true
end

function modifier_venomancer_venomous_gale_lua:OnCreated(kv)
	self.particles = self:GetAbility().particles
	self.sounds = self:GetAbility().sounds

	self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	self.tick_damage = self:GetAbility():GetSpecialValueFor("tick_damage")
	self.init_damage = self:GetAbility():GetSpecialValueFor("strike_damage")
	self.slow = self:GetAbility():GetSpecialValueFor("movement_slow")
	self.slow_tick = 0.3

	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.init_damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}

	ApplyDamage(self.damageTable)

	self.damageTable.damage = self.tick_damage
	self:StartIntervalThink(self.tick_interval)
end

function modifier_venomancer_venomous_gale_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_venomancer_venomous_gale_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_venomancer_venomous_gale_lua:GetModifierMoveSpeedBonus_Percentage()
	local time = (GameRules:GetGameTime() - self:GetLastAppliedTime())
	local slow = math.min(0, self.slow + time / self.slow_tick)
	return slow
end

function modifier_venomancer_venomous_gale_lua:OnIntervalThink()
	ApplyDamage(self.damageTable)

	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
		self:GetParent(),
		self.damageTable.damage,
		self:GetCaster():GetPlayerOwner()
	)
end

function modifier_venomancer_venomous_gale_lua:GetEffectName()
	return self.particles[3]
end

function modifier_venomancer_venomous_gale_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_venomancer_poison_tick", "heroes/hero_venomancer/hero_venomancer", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_venomancer_poison_tick_debuff",
	"heroes/hero_venomancer/hero_venomancer",
	LUA_MODIFIER_MOTION_NONE
)

venomancer_poison_tick = class({})

function venomancer_poison_tick:GetIntrinsicModifierName()
	return "modifier_venomancer_poison_tick"
end

-------------------------------------------------------------------------------

modifier_venomancer_poison_tick = class({})

function modifier_venomancer_poison_tick:IsHidden()
	return true
end

function modifier_venomancer_poison_tick:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_venomancer_poison_tick:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() or params.target:IsBuilding() or params.target:IsOther() then
		return
	end

	local duration = self:GetAbility():GetSpecialValueFor("duration")
	local modifier = params.target:FindModifierByName("modifier_venomancer_poison_tick_debuff")

	if not modifier then
		params.target:AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_venomancer_poison_tick_debuff",
			{ duration = duration }
		)
	else
		if modifier:GetStackCount() < self:GetAbility():GetSpecialValueFor("count") then
			modifier:IncrementStackCount()
		end
		modifier:SetDuration(duration, true)
	end
end

-------------------------------------------------------------------------------

modifier_venomancer_poison_tick_debuff = class({})

function modifier_venomancer_poison_tick_debuff:IsHidden()
	return false
end
function modifier_venomancer_poison_tick_debuff:IsDebuff()
	return true
end
function modifier_venomancer_poison_tick_debuff:IsPurgable()
	return true
end

function modifier_venomancer_poison_tick_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.debuff = self.ability:GetSpecialValueFor("debuff")

	self.parent.orchid_damage_storage = 0
	self:SetStackCount(1)

	self:StartIntervalThink(1)
end

function modifier_venomancer_poison_tick_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end

	local damageTable = {
		victim = self.parent,
		attacker = self.caster,
		damage = self.ability:GetSpecialValueFor("damage") * self:GetStackCount(),
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	}
	ApplyDamage(damageTable)

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self.parent, damageTable.damage, nil)
end

function modifier_venomancer_poison_tick_debuff:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_venomancer_poison_tick_debuff:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * self.debuff * -1
end

function modifier_venomancer_poison_tick_debuff:GetModifierMagicalResistanceBonus()
	return self:GetStackCount() * self.debuff * -1
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_venomancer_plague_ward_lua",
	"heroes/hero_venomancer/hero_venomancer",
	LUA_MODIFIER_MOTION_NONE
)

venomancer_plague_ward_lua = class({})

function venomancer_plague_ward_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_base_attack.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_ward_cast.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context)
	PrecacheResource("model", "models/heroes/venomancer/venomancer_ward.vmdl", context)
end

function venomancer_plague_ward_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local projectile_info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_venomancer/venomancer_base_attack.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
		bDodgeable = true,
	}
	ProjectileManager:CreateTrackingProjectile(projectile_info)

	caster:EmitSound("Hero_Venomancer.Plague_Ward")
end

function venomancer_plague_ward_lua:OnProjectileHit(target)
	if not target or target:IsInvulnerable() or target:TriggerSpellAbsorb(self) then
		return
	end

	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local count = self:GetSpecialValueFor("plague_count")
	local radius = self:GetSpecialValueFor("spawn_radius")
	local damage_pct = self:GetSpecialValueFor("damage") / 100

	local hero_damage = caster:GetAverageTrueAttackDamage(caster) * damage_pct
	local hero_attack_speed = caster:GetAttackSpeed(true) * 100

	local nova_ability = caster:FindAbilityByName("venomancer_poison_nova_lua")
	local nova_level = 0
	if nova_ability then
		nova_level = nova_ability:GetLevel()
	end

	for i = 1, count do
		local angle = i * (360 / count)
		local offset = Vector(math.cos(math.rad(angle)), math.sin(math.rad(angle)), 0) * radius
		local spawn_pos = target:GetAbsOrigin() + offset

		local ward = CreateUnitByName(
			"npc_dota_venomancer_plague_ward_1_custom",
			spawn_pos,
			true,
			caster,
			caster,
			caster:GetTeamNumber()
		)

		if nova_level > 0 then
			local ward_nova = ward:AddAbility("venomancer_poison_nova_lua")
			if ward_nova then
				ward_nova:SetLevel(nova_level)
				-- ward_nova:SetActivated(false)
			end
		end

		ward:AddNewModifier(caster, self, "modifier_kill", { duration = duration })
		ward:AddNewModifier(caster, self, "modifier_invulnerable", { duration = duration })
		ward:AddNewModifier(caster, self, "modifier_venomancer_plague_ward_lua", {}):SetStackCount(hero_attack_speed)

		ward:SetBaseDamageMin(hero_damage - 5)
		ward:SetBaseDamageMax(hero_damage + 5)

		-- ward:SetForceAttackTarget(target)

		local fx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_venomancer/venomancer_ward_cast.vpcf",
			PATTACH_ABSORIGIN,
			ward
		)
		ParticleManager:ReleaseParticleIndex(fx)
	end

	target:EmitSound("Hero_Venomancer.Plague_Ward")
	return true
end

-------------------------------------------------------------------------------

modifier_venomancer_plague_ward_lua = class({})

function modifier_venomancer_plague_ward_lua:IsHidden()
	return true
end

function modifier_venomancer_plague_ward_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_venomancer_plague_ward_lua:GetModifierSpellAmplify_Percentage()
	if IsServer() and self:GetCaster() then
		return self:GetCaster():GetSpellAmplification(false) * 100
	end
	return 0
end

function modifier_venomancer_plague_ward_lua:GetModifierAttackSpeedBonus_Constant()
	if not IsServer() then
		return
	end
	return self:GetStackCount()
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_venomancer_poison_nova_lua",
	"heroes/hero_venomancer/hero_venomancer",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_generic_ring_lua", "heroes/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)

venomancer_poison_nova_lua = class({})

function venomancer_poison_nova_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_poison_venomancer.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf", context)
end

function venomancer_poison_nova_lua:Spawn()
	if not IsServer() then
		return
	end
end

function venomancer_poison_nova_lua:GetCastRange(pos, target)
	return self:GetSpecialValueFor("radius")
end

function venomancer_poison_nova_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_venomancer_4")
	if talent ~= nil and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 30
	end
	return self.BaseClass.GetCooldown(self, level)
end

function venomancer_poison_nova_lua:OnSpellStart()
	local caster = self:GetCaster()

	self:SpawnPoisonRing(caster)

	local talent = caster:FindAbilityByName("special_bonus_unique_venomancer_7")
	if talent and talent:GetLevel() > 0 then
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			FIND_UNITS_EVERYWHERE,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_ALL,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			FIND_ANY_ORDER,
			false
		)
		for _, unit in pairs(units) do
			if
				unit:GetUnitName() == "npc_dota_venomancer_plague_ward_1_custom"
				and unit:GetOwner() == caster
				and unit:IsAlive()
			then
				self:SpawnPoisonRing(unit)
			end
		end
	end
end

function venomancer_poison_nova_lua:SpawnPoisonRing(source)
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local speed = self:GetSpecialValueFor("speed")
	local start_radius = self:GetSpecialValueFor("start_radius")
	local end_radius = self:GetSpecialValueFor("radius")

	local ring = source:AddNewModifier(caster, self, "modifier_generic_ring_lua", {
		start_radius = start_radius,
		end_radius = end_radius,
		speed = speed,
		target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		IsCircle = 0,
	})

	ring:SetCallback(function(enemy)
		enemy:AddNewModifier(caster, self, "modifier_venomancer_poison_nova_lua", { duration = duration })
		EmitSoundOn("Hero_Venomancer.PoisonNovaImpact", enemy)
	end)

	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		source
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(speed, 1, speed))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Venomancer.PoisonNova", source)
end

function venomancer_poison_nova_lua:PlayEffects(modifier, speed)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(speed, 1, speed))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Venomancer.PoisonNova", self:GetCaster())
end

-------------------------------------------------

modifier_venomancer_poison_nova_lua = class({})

function modifier_venomancer_poison_nova_lua:IsHidden()
	return false
end

function modifier_venomancer_poison_nova_lua:IsDebuff()
	return true
end

function modifier_venomancer_poison_nova_lua:IsStunDebuff()
	return false
end

function modifier_venomancer_poison_nova_lua:IsPurgable()
	return false
end

function modifier_venomancer_poison_nova_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_venomancer_poison_nova_lua:OnCreated(kv)
	self.parent = self:GetParent()
	local damage = self:GetAbility():GetSpecialValueFor("damage")

	if not IsServer() then
		return
	end

	local interval = 1
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL,
	}
	self:StartIntervalThink(interval)
	self:OnIntervalThink()
end

function modifier_venomancer_poison_nova_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_venomancer_poison_nova_lua:OnIntervalThink()
	if self.parent:IsMagicImmune() then
		return
	end
	ApplyDamage(self.damageTable)
end

function modifier_venomancer_poison_nova_lua:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf"
end

function modifier_venomancer_poison_nova_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_venomancer_poison_nova_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_venomancer.vpcf"
end

function modifier_venomancer_poison_nova_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end