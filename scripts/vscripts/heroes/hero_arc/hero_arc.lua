--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_arc_flux_lua_debuff", "heroes/hero_arc/hero_arc", LUA_MODIFIER_MOTION_NONE)

arc_flux_lua = class({})

function arc_flux_lua:GetBehavior()
	local caster = self:GetCaster()
	local talent = caster:FindAbilityByName("special_bonus_unique_arc_7")
	if talent and talent:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function arc_flux_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")

	local caster = self:GetCaster()
	local talent = caster:FindAbilityByName("special_bonus_unique_arc_7")
	if talent and talent:GetLevel() > 0 then
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(caster, self, "modifier_arc_flux_lua_debuff", { duration = duration })
			self:PlayEffects(enemy)
		end

		if #enemies > 0 then
			EmitSoundOn("Hero_ArcWarden.Flux.Cast", caster)
		end
	else
		local target = self:GetCursorTarget()
		if target:TriggerSpellAbsorb(self) then
			return
		end
		target:AddNewModifier(caster, self, "modifier_arc_flux_lua_debuff", { duration = duration })
		self:PlayEffects(target)
		EmitSoundOn("Hero_ArcWarden.Flux.Cast", target)
	end
end

function arc_flux_lua:PlayEffects(target)
	EmitSoundOn("Hero_ArcWarden.Flux.Cast", target)
	local cast_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		cast_particle,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		cast_particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		cast_particle,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetAbsOrigin(),
		true
	)
end

--------------------------------------------------------------------------------

modifier_arc_flux_lua_debuff = class({})

function modifier_arc_flux_lua_debuff:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.movespeed = ability:GetSpecialValueFor("movespeed")
	self.attackspeed = ability:GetSpecialValueFor("attackspeed")
	self.damage = ability:GetSpecialValueFor("damage")

	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
	self:OnIntervalThink()
end

function modifier_arc_flux_lua_debuff:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
end

function modifier_arc_flux_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_arc_flux_lua_debuff:GetModifierMoveSpeedBonus_Constant()
	return -self.movespeed
end
function modifier_arc_flux_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self.attackspeed
end

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_arc_warden_magnetic_field_lua_thinker", "heroes/hero_arc/hero_arc", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_warden_magnetic_field_lua_buff", "heroes/hero_arc/hero_arc", LUA_MODIFIER_MOTION_NONE)

arc_warden_magnetic_field_lua = class({})

function arc_warden_magnetic_field_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function arc_warden_magnetic_field_lua:OnSpellStart()
	local caster = self:GetCaster()
	local position = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	caster:EmitSound("Hero_ArcWarden.MagneticField.Cast")

	local cast_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_magnetic_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		cast_particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(cast_particle)

	CreateModifierThinker(caster, self, "modifier_arc_warden_magnetic_field_lua_thinker", {
		duration = duration,
	}, position, caster:GetTeamNumber(), false)
end

------------------------------------------------------------------

modifier_arc_warden_magnetic_field_lua_thinker = class({})

function modifier_arc_warden_magnetic_field_lua_thinker:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	if not IsServer() then
		return
	end

	self:GetParent():EmitSound("Hero_ArcWarden.MagneticField")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, 1, 1))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_arc_warden_magnetic_field_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():StopSound("Hero_ArcWarden.MagneticField")
end

function modifier_arc_warden_magnetic_field_lua_thinker:IsAura()
	return true
end
function modifier_arc_warden_magnetic_field_lua_thinker:GetAuraDuration()
	return 0.1
end
function modifier_arc_warden_magnetic_field_lua_thinker:GetAuraRadius()
	return self.radius
end
function modifier_arc_warden_magnetic_field_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_arc_warden_magnetic_field_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING
end
function modifier_arc_warden_magnetic_field_lua_thinker:GetModifierAura()
	return "modifier_arc_warden_magnetic_field_lua_buff"
end

------------------------------------------------------------------

modifier_arc_warden_magnetic_field_lua_buff = class({})

function modifier_arc_warden_magnetic_field_lua_buff:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.attack_speed = ability:GetSpecialValueFor("attack_speed_bonus")
	self.damage = ability:GetSpecialValueFor("damage")
	self.evasion = ability:GetSpecialValueFor("evasion_chance")
	self.radius = ability:GetSpecialValueFor("radius")
end

function modifier_arc_warden_magnetic_field_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_arc_warden_magnetic_field_lua_buff:GetModifierBaseDamageOutgoing_Percentage()
	return self.damage
end

function modifier_arc_warden_magnetic_field_lua_buff:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

function modifier_arc_warden_magnetic_field_lua_buff:GetModifierEvasion_Constant(keys)
	if not IsServer() then
		return self.evasion
	end

	if keys.attacker and self:GetAuraOwner() then
		local distance = (keys.attacker:GetAbsOrigin() - self:GetAuraOwner():GetAbsOrigin()):Length2D()
		if distance > self.radius then
			return self.evasion
		end
	end
	return 0
end

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_ark_spark_lua_thinker", "heroes/hero_arc/hero_arc", LUA_MODIFIER_MOTION_NONE)

ark_spark_lua = class({})

function ark_spark_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_prj_burst.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_wraith.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_wraith_prj.vpcf", context)
end

function ark_spark_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local duration = 5

	local count = self:GetSpecialValueFor("count")

	caster:EmitSound("Hero_ArcWarden.SparkWraith.Cast")

	for i = 1, count do
		local spawn_pos = caster:GetAbsOrigin() + RandomVector(RandomFloat(50, 150))

		CreateModifierThinker(
			caster,
			self,
			"modifier_ark_spark_lua_thinker",
			{ duration = duration },
			spawn_pos,
			caster:GetTeamNumber(),
			false
		)
	end
end

function ark_spark_lua:OnProjectileHit(target, vLocation)
	if not target or target:IsInvulnerable() or target:TriggerSpellAbsorb(self) then
		return
	end

	local damage = self:GetSpecialValueFor("damage")
	ApplyDamage({
		attacker = self:GetCaster(),
		victim = target,
		ability = self,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
	})

	target:EmitSound("Hero_ArcWarden.SparkWraith.Damage")

	local burst_particle = ParticleManager:CreateParticle(
		"particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_prj_burst.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(burst_particle)
	return true
end

--------------------------------------------------------------------------------

modifier_ark_spark_lua_thinker = class({})

function modifier_ark_spark_lua_thinker:OnCreated()
	if not IsServer() then
		return
	end

	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.speed = self:GetAbility():GetSpecialValueFor("enemy_speed")
	self.is_flying = false

	self:GetParent():EmitSound("Hero_ArcWarden.SparkWraith.Loop")

	self.wraith_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_wraith.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.wraith_particle, 1, Vector(self.radius, 1, 1))
	self:AddParticle(self.wraith_particle, false, false, -1, false, false)

	self:StartIntervalThink(0.1)
end

function modifier_ark_spark_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():StopSound("Hero_ArcWarden.SparkWraith.Loop")
end

function modifier_ark_spark_lua_thinker:OnIntervalThink()
	if self.is_flying then
		return
	end

	local parent = self:GetParent()
	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	if #enemies > 0 then
		local target = enemies[1]
		self.is_flying = true

		local projectile = {
			Target = target,
			Source = parent,
			Ability = self:GetAbility(),
			EffectName = "particles/units/heroes/hero_arc_warden/arc_warden_wraith_prj.vpcf",
			iMoveSpeed = self.speed,
			bDodgeable = false,
			bProvidesVision = true,
			iVisionRadius = 200,
			iVisionTeamNumber = caster:GetTeamNumber(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
		}
		ProjectileManager:CreateTrackingProjectile(projectile)
		self:Destroy()
	end
end

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_arc_geminate_attack", "heroes/hero_arc/hero_arc", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_geminate_attack_delay", "heroes/hero_arc/hero_arc", LUA_MODIFIER_MOTION_NONE)

arc_geminate_attack = class({})

function arc_geminate_attack:GetIntrinsicModifierName()
	return "modifier_arc_geminate_attack"
end

--------------------------------------------------------------------------------

modifier_arc_geminate_attack = class({})

function modifier_arc_geminate_attack:IsHidden()
	return true
end

function modifier_arc_geminate_attack:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK }
end

function modifier_arc_geminate_attack:OnAttack(keys)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local ability = self:GetAbility()
	local target = keys.target

	if
		keys.attacker == parent
		and ability:IsFullyCastable()
		and not parent:IsIllusion()
		and not parent:PassivesDisabled()
		and not keys.no_attack_cooldown
		and not (target:IsWard() or target:IsBuilding())
	then
		local attack_count = ability:GetSpecialValueFor("attacks")
		local delay_step = ability:GetSpecialValueFor("delay")

		for i = 1, attack_count do
			parent:AddNewModifier(parent, ability, "modifier_arc_geminate_attack_delay", {
				delay = delay_step * i,
				target_index = target:entindex(),
			})
		end
		ability:UseResources(false, false, false, true)
	end
end

--------------------------------------------------------------------------------

modifier_arc_geminate_attack_delay = class({})

function modifier_arc_geminate_attack_delay:IsHidden()
	return true
end
function modifier_arc_geminate_attack_delay:IsPurgable()
	return false
end
function modifier_arc_geminate_attack_delay:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_arc_geminate_attack_delay:OnCreated(params)
	if not IsServer() then
		return
	end

	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")

	if params and params.target_index then
		self.target = EntIndexToHScript(params.target_index)
	end

	if params and params.delay then
		self:StartIntervalThink(params.delay)
	else
		self:Destroy()
	end
end

function modifier_arc_geminate_attack_delay:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.parent:IsAlive() and self.target and not self.target:IsNull() and self.target:IsAlive() then
		self.is_geminate_shot = true
		self.parent:PerformAttack(self.target, true, true, true, false, true, false, false)
		self.is_geminate_shot = false
	end

	self:Destroy()
end

function modifier_arc_geminate_attack_delay:DeclareFunctions()
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
end

function modifier_arc_geminate_attack_delay:GetModifierPreAttack_BonusDamage()
	if self.is_geminate_shot then
		return self.bonus_damage
	end
	return 0
end