--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_gyrocopter_rocket_barrage_lua",
	"heroes/hero_gyrocopter/hero_gyrocopter",
	LUA_MODIFIER_MOTION_NONE
)

gyrocopter_rocket_barrage_lua = class({})

function gyrocopter_rocket_barrage_lua:OnSpellStart()
	local caster = self:GetCaster()
	caster:EmitSound("Hero_Gyrocopter.Rocket_Barrage")

	if caster:GetName() == "npc_dota_hero_gyrocopter" and RollPercentage(75) then
		local responses = {
			"gyrocopter_gyro_rocket_barrage_01",
			"gyrocopter_gyro_rocket_barrage_02",
			"gyrocopter_gyro_rocket_barrage_04",
		}
		EmitSoundOnClient(responses[RandomInt(1, #responses)], caster:GetPlayerOwner())
	end
	caster:AddNewModifier(caster, self, "modifier_gyrocopter_rocket_barrage_lua", { duration = self:GetDuration() })
end

function gyrocopter_rocket_barrage_lua:OnProjectileHit(target, location)
	if not target then
		return
	end

	target:EmitSound("Hero_Gyrocopter.Rocket_Barrage.Impact")

	ApplyDamage({
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor("rocket_damage"),
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	})

	return true
end

--------------------------------------------------------------------------------

modifier_gyrocopter_rocket_barrage_lua = class({})

function modifier_gyrocopter_rocket_barrage_lua:IsHidden()
	return false
end
function modifier_gyrocopter_rocket_barrage_lua:IsPurgable()
	return false
end

function modifier_gyrocopter_rocket_barrage_lua:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self.radius = self.ability:GetSpecialValueFor("radius")
	self.rockets_per_second = self.ability:GetSpecialValueFor("rockets_per_second")
	self.ballistic_duration = self.ability:GetSpecialValueFor("ballistic_duration")
	self.sniping_speed = self.ability:GetSpecialValueFor("sniping_speed")
	self.sniping_distance = self.ability:GetSpecialValueFor("sniping_distance")

	if not IsServer() then
		return
	end

	self.rocket_damage = self.ability:GetSpecialValueFor("rocket_damage")
	self.damage_type = self.ability:GetAbilityDamageType()
	self.weapons = { "attach_attack1", "attach_attack2" }

	self:StartIntervalThink(1 / self.rockets_per_second)
end

function modifier_gyrocopter_rocket_barrage_lua:OnIntervalThink()
	if self.parent:IsOutOfGame() or self.parent:IsStunned() or self.parent:IsSilenced() then
		return
	end

	self.parent:EmitSound("Hero_Gyrocopter.Rocket_Barrage.Launch")

	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)

	if #enemies > 0 then
		local enemy = enemies[RandomInt(1, #enemies)]
		enemy:EmitSound("Hero_Gyrocopter.Rocket_Barrage.Impact")

		local pfx = ParticleManager:CreateParticle(
			"particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_rocket_barrage.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			pfx,
			0,
			self.parent,
			PATTACH_POINT_FOLLOW,
			self.weapons[RandomInt(1, #self.weapons)],
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			pfx,
			1,
			enemy,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			enemy:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(pfx)

		ApplyDamage({
			victim = enemy,
			attacker = self.caster,
			damage = self.rocket_damage,
			damage_type = self.damage_type,
			ability = self.ability,
		})
	else
		local projectile_info = {
			EffectName = "particles/base_attacks/ranged_tower_bad_linear.vpcf",
			Ability = self.ability,
			Source = self.caster,
			vSpawnOrigin = self.parent:GetAttachmentOrigin(self.parent:ScriptLookupAttachment("attach_hitloc")),
			vVelocity = self.parent:GetForwardVector() * self.sniping_speed,
			fDistance = self.sniping_distance,
			fStartRadius = 50,
			fEndRadius = 50,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			bIgnoreSource = true,
		}
		ProjectileManager:CreateLinearProjectile(projectile_info)
	end
end

function modifier_gyrocopter_rocket_barrage_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end

function modifier_gyrocopter_rocket_barrage_lua:GetOverrideAnimation()
	return ACT_DOTA_OVERRIDE_ABILITY_1
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_gyrocopter_homing_missile_autocast",
	"heroes/hero_gyrocopter/hero_gyrocopter",
	LUA_MODIFIER_MOTION_NONE
)

gyrocopter_homing_missile_lua = class({})

function gyrocopter_homing_missile_lua:GetBehavior()
	local caster = self:GetCaster()
	local talent = caster:FindAbilityByName("special_bonus_unique_gyrocopter_4")
	if talent and talent:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AUTOCAST + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end

	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function gyrocopter_homing_missile_lua:GetIntrinsicModifierName()
	return "modifier_gyrocopter_homing_missile_autocast"
end

function gyrocopter_homing_missile_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not target then
		local radius = self:GetSpecialValueFor("launch_radius")
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetOrigin(),
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)
		target = enemies[1]
	end

	if not target then
		return
	end

	local speed = self:GetSpecialValueFor("speed")
	local pfx = "particles/econ/items/clockwerk/clockwerk_paraflare/clockwerk_para_rocket_flare.vpcf"

	StartSoundEvent("Hero_Gyrocopter.HomingMissile.Enemy", caster)

	ProjectileManager:CreateTrackingProjectile({
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = pfx,
		iMoveSpeed = speed,
		bDodgeable = true,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = 400,
		iVisionTeamNumber = caster:GetTeamNumber(),
	})
end

function gyrocopter_homing_missile_lua:OnProjectileHit(target, location)
	if not target then
		return
	end

	local radius = self:GetSpecialValueFor("slow_radius")
	local damage = self:GetSpecialValueFor("damage")
	local duration = self:GetSpecialValueFor("stun_duration")

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		target:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		})
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = duration })
	end

	EmitSoundOn("Hero_Gyrocopter.HomingMissile.Destroy", self:GetCaster())
	StopSoundEvent("Hero_Gyrocopter.HomingMissile.Enemy", self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_gyrocopter_homing_missile_autocast = class({})

function modifier_gyrocopter_homing_missile_autocast:IsHidden()
	return true
end
function modifier_gyrocopter_homing_missile_autocast:IsPurgable()
	return false
end
function modifier_gyrocopter_homing_missile_autocast:RemoveOnDeath()
	return false
end

function modifier_gyrocopter_homing_missile_autocast:OnCreated()
	if IsServer() then
		self:StartIntervalThink(0.2)
	end
end

function modifier_gyrocopter_homing_missile_autocast:OnIntervalThink()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self:GetAbility()

	if not ability:GetAutoCastState() or not ability:IsFullyCastable() or caster:IsSilenced() then
		return
	end

	local talent = caster:FindAbilityByName("special_bonus_unique_gyrocopter_4")
	if not talent or talent:GetLevel() == 0 then
		return
	end

	local radius = ability:GetSpecialValueFor("launch_radius")
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	if #enemies > 0 then
		caster:CastAbilityNoTarget(ability, -1)
	end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_gyrocopter_flak_cannon_lua",
	"heroes/hero_gyrocopter/hero_gyrocopter",
	LUA_MODIFIER_MOTION_NONE
)

gyrocopter_flak_cannon_lua = class({})

function gyrocopter_flak_cannon_lua:GetCooldown(level)
	local talent
	self:GetCaster():FindAbilityByName("special_bonus_unique_gyrocopter_7")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 5
	end
	return self.BaseClass.GetCooldown(self, level)
end

function gyrocopter_flak_cannon_lua:OnSpellStart()
	local caster = self:GetCaster()
	caster:EmitSound("Hero_Gyrocopter.FlackCannon.Activate")

	caster:RemoveModifierByName("modifier_gyrocopter_flak_cannon_lua")
	caster:AddNewModifier(caster, self, "modifier_gyrocopter_flak_cannon_lua", { duration = self:GetDuration() })
end

--------------------------------------------------------------------------------

modifier_gyrocopter_flak_cannon_lua = class({})

function modifier_gyrocopter_flak_cannon_lua:IsHidden()
	return false
end
function modifier_gyrocopter_flak_cannon_lua:IsPurgable()
	return false
end

function modifier_gyrocopter_flak_cannon_lua:GetEffectName()
	return "particles/units/heroes/hero_gyrocopter/gyro_flak_cannon_overhead.vpcf"
end

function modifier_gyrocopter_flak_cannon_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_gyrocopter_flak_cannon_lua:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.radius = self.ability:GetSpecialValueFor("radius")
	self.max_attacks = self.ability:GetSpecialValueFor("max_attacks")

	if not IsServer() then
		return
	end

	self:SetStackCount(self.max_attacks)
end

function modifier_gyrocopter_flak_cannon_lua:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK }
end

function modifier_gyrocopter_flak_cannon_lua:OnAttack(keys)
	if not IsServer() then
		return
	end

	if keys.attacker == self.parent and not keys.no_attack_cooldown then
		local enemies = FindUnitsInRadius(
			self.parent:GetTeamNumber(),
			self.parent:GetAbsOrigin(),
			self.parent,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
				+ DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
				+ DOTA_UNIT_TARGET_FLAG_NO_INVIS
				+ DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
			FIND_ANY_ORDER,
			false
		)

		local hit_any_enemy = false

		for _, enemy in pairs(enemies) do
			if enemy ~= keys.target and not enemy:IsCourier() then
				hit_any_enemy = true

				local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_gyrocopter_8")
				if talent and talent:GetLevel() > 0 then
					self.parent:PerformAttack(enemy, true, true, true, false, true, false, false)
				else
					self.parent:PerformAttack(enemy, false, false, true, false, true, false, false)
				end
			end
		end

		if hit_any_enemy then
			self.parent:EmitSound("Hero_Gyrocopter.FlackCannon")
		end

		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_gyrocopter_call_down_lua_thinker",
	"heroes/hero_gyrocopter/hero_gyrocopter",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_gyrocopter_call_down_lua_slow",
	"heroes/hero_gyrocopter/hero_gyrocopter",
	LUA_MODIFIER_MOTION_NONE
)

gyrocopter_call_down_lua = class({})

function gyrocopter_call_down_lua:GetCooldown(level)
	local caster = self:GetCaster()
	local cooldown = self.BaseClass.GetCooldown(self, level)
	local talent = caster:FindAbilityByName("special_bonus_unique_gyrocopter_3")

	if talent and talent:GetLevel() > 0 then
		return cooldown - 30
	end
	return cooldown
end

function gyrocopter_call_down_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function gyrocopter_call_down_lua:OnAbilityPhaseStart()
	self:GetCaster():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
	return true
end

function gyrocopter_call_down_lua:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
end

function gyrocopter_call_down_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	caster:EmitSound("Hero_Gyrocopter.CallDown.Fire")

	if caster:GetName() == "npc_dota_hero_gyrocopter" then
		local responses = {
			"gyrocopter_gyro_call_down_03",
			"gyrocopter_gyro_call_down_04",
			"gyrocopter_gyro_call_down_05",
			"gyrocopter_gyro_call_down_06",
			"gyrocopter_gyro_call_down_09",
		}
		EmitSoundOnClient(responses[RandomInt(1, #responses)], caster:GetPlayerOwner())
	end

	local delay = self:GetSpecialValueFor("missile_delay_tooltip")

	CreateModifierThinker(
		caster,
		self,
		"modifier_gyrocopter_call_down_lua_thinker",
		{ duration = delay * 2.5 },
		point,
		caster:GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------

modifier_gyrocopter_call_down_lua_thinker = class({})

function modifier_gyrocopter_call_down_lua_thinker:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	self.slow_duration_first = self.ability:GetSpecialValueFor("slow_duration_first")
	self.slow_duration_second = self.ability:GetSpecialValueFor("slow_duration_second")
	self.damage_first = self.ability:GetSpecialValueFor("damage_first")
	self.damage_second = self.ability:GetSpecialValueFor("damage_second")
	self.slow_first = self.ability:GetSpecialValueFor("slow_first")
	self.slow_second = self.ability:GetSpecialValueFor("slow_second")
	self.radius = self.ability:GetSpecialValueFor("radius")
	self.missile_delay = self.ability:GetSpecialValueFor("missile_delay_tooltip")

	if not IsServer() then
		return
	end

	self.damage_type = self.ability:GetAbilityDamageType()
	self.impact_count = 0

	-- Визуальный маркер для союзников/врагов
	self.marker_pfx = ParticleManager:CreateParticleForTeam(
		"particles/units/heroes/hero_gyrocopter/gyro_calldown_marker.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent(),
		self.caster:GetTeamNumber()
	)
	ParticleManager:SetParticleControl(self.marker_pfx, 1, Vector(self.radius, 1, self.radius * -1))
	self:AddParticle(self.marker_pfx, false, false, -1, false, false)

	-- Запуск ракет из аттачментов
	self:CreateMissileEffect("particles/units/heroes/hero_gyrocopter/gyro_calldown_first.vpcf", "attach_rocket1")
	self:CreateMissileEffect("particles/units/heroes/hero_gyrocopter/gyro_calldown_second.vpcf", "attach_rocket2")

	self:StartIntervalThink(self.missile_delay)
end

function modifier_gyrocopter_call_down_lua_thinker:CreateMissileEffect(particle_name, attach_name)
	local pfx = ParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(
		pfx,
		0,
		self.caster:GetAttachmentOrigin(self.caster:ScriptLookupAttachment(attach_name))
	)
	ParticleManager:SetParticleControl(pfx, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 5, Vector(self.radius, self.radius, self.radius))
	ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_gyrocopter_call_down_lua_thinker:OnIntervalThink()
	self.impact_count = self.impact_count + 1

	local origin = self:GetParent():GetAbsOrigin()
	local sound_cast = "Hero_Gyrocopter.CallDown.Damage"
	-- EmitSoundOnLocationWithCaster(origin, sound_cast, self.caster)
	EmitSoundOn(sound_cast, self.caster)

	local damage = (self.impact_count == 1) and self.damage_first or self.damage_second
	local slow_pct = (self.impact_count == 1) and self.slow_first or self.slow_second
	local slow_dur = (self.impact_count == 1) and self.slow_duration_first or self.slow_duration_second

	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		origin,
		self:GetParent(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(self.caster, self.ability, "modifier_gyrocopter_call_down_lua_slow", {
			duration = slow_dur * (1 - enemy:GetStatusResistance()),
			slow = slow_pct,
		})

		ApplyDamage({
			victim = enemy,
			attacker = self.caster,
			damage = damage,
			damage_type = self.damage_type,
			ability = self.ability,
		})

		if enemy:IsRealHero() and not enemy:IsAlive() then
			EmitSoundOnClient("gyrocopter_gyro_call_down_1" .. RandomInt(1, 2), self.caster:GetPlayerOwner())
		end
	end

	if self.impact_count >= 2 then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
end

--------------------------------------------------------------------------------

modifier_gyrocopter_call_down_lua_slow = class({})

function modifier_gyrocopter_call_down_lua_slow:OnCreated(keys)
	if IsServer() and keys.slow then
		self:SetStackCount(math.abs(keys.slow))
	end
end

function modifier_gyrocopter_call_down_lua_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_gyrocopter_call_down_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self:GetStackCount() * -1
end