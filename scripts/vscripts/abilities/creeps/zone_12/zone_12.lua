--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_rocket_barrage_lua", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_NONE)

creep_rocket_barrage_lua = class({})

function creep_rocket_barrage_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_rocket_barrage.vpcf",
		context
	)
end

function creep_rocket_barrage_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_rocket_barrage_lua:OnSpellStart()
	self:GetCaster():EmitSound("Hero_Gyrocopter.Rocket_Barrage")
	self:GetCaster()
		:AddNewModifier(self:GetCaster(), self, "modifier_creep_rocket_barrage_lua", { duration = self:GetDuration() })
end

--------------------------------------------------------------------------------

modifier_creep_rocket_barrage_lua = class({})

function modifier_creep_rocket_barrage_lua:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.rockets_per_second = self:GetAbility():GetSpecialValueFor("rockets_per_second")

	if not IsServer() then
		return
	end

	self.rocket_damage = self:GetAbility():GetSpecialValueFor("rocket_damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	self.weapons = { "attach_attack1", "attach_attack2" }

	self:StartIntervalThink(1 / self.rockets_per_second)
end

function modifier_creep_rocket_barrage_lua:OnIntervalThink()
	if not self:GetParent():IsOutOfGame() then
		self:GetParent():EmitSound("Hero_Gyrocopter.Rocket_Barrage.Launch")
		self.enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			self:GetParent(),
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_ANY_ORDER,
			false
		)
		if #self.enemies >= 1 then
			for _, enemy in pairs(self.enemies) do
				enemy:EmitSound("Hero_Gyrocopter.Rocket_Barrage.Impact")

				self.barrage_particle = ParticleManager:CreateParticle(
					"particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_rocket_barrage.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self:GetParent()
				)
				ParticleManager:SetParticleControlEnt(
					self.barrage_particle,
					0,
					self:GetParent(),
					PATTACH_ABSORIGIN_FOLLOW,
					self.weapons[RandomInt(1, #self.weapons)],
					self:GetParent():GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					self.barrage_particle,
					1,
					enemy,
					PATTACH_ABSORIGIN_FOLLOW,
					"attach_hitloc",
					enemy:GetAbsOrigin(),
					true
				)
				ParticleManager:ReleaseParticleIndex(self.barrage_particle)

				ApplyDamage({
					victim = enemy,
					damage = self.rocket_damage,
					damage_type = self:GetAbility():GetAbilityDamageType(),
					damage_flags = DOTA_DAMAGE_FLAG_NONE,
					attacker = self:GetCaster(),
					ability = self:GetAbility(),
				})
				break
			end
		end
	end
end

function modifier_creep_rocket_barrage_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_creep_rocket_barrage_lua:GetOverrideAnimation()
	return ACT_DOTA_OVERRIDE_ABILITY_1
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

creep_homing_missile_lua = class({})

function creep_homing_missile_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/clockwerk/clockwerk_paraflare/clockwerk_para_rocket_flare.vpcf",
		context
	)
end

function creep_homing_missile_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_homing_missile_lua:OnSpellStart()
	local caster = self:GetCaster()
	local launch_radius = self:GetSpecialValueFor("launch_radius")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		launch_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	local target = enemies[1]
	if not target then
		return
	end

	local sound_launch = "Hero_Gyrocopter.HomingMissile.Enemy"
	EmitSoundOn(sound_launch, caster)

	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/econ/items/clockwerk/clockwerk_paraflare/clockwerk_para_rocket_flare.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("speed"),
		bDodgeable = true,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = 400,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function creep_homing_missile_lua:OnProjectileHit(target, location)
	if not target then
		return
	end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("slow_radius")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local duration = self:GetSpecialValueFor("stun_duration")

	local explosion_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_gyrocopter/gyro_homing_missile_explosion.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(explosion_pfx, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(explosion_pfx)

	EmitSoundOn("Hero_Gyrocopter.HomingMissile.Destroy", self:GetCaster())
	StopSoundEvent("Hero_Gyrocopter.HomingMissile.Enemy", self:GetCaster())

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetOrigin(),
		target,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = duration })
	end

	return true
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_headshot_lua", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_headshot_lua_slow", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_NONE)

creep_headshot_lua = class({})

function creep_headshot_lua:GetIntrinsicModifierName()
	return "modifier_creep_headshot_lua"
end

-------------------------------------------------------------------------------

modifier_creep_headshot_lua = class({})

function modifier_creep_headshot_lua:IsHidden()
	return true
end

function modifier_creep_headshot_lua:IsPurgable()
	return false
end

function modifier_creep_headshot_lua:OnCreated(kv)
	self.proc_chance = self:GetAbility():GetSpecialValueFor("proc_chance")
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_creep_headshot_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

-------------------------------------------------------------------------------

modifier_creep_headshot_lua_slow = class({})

function modifier_creep_headshot_lua_slow:IsHidden()
	return true
end

function modifier_creep_headshot_lua_slow:IsDebuff()
	return true
end

function modifier_creep_headshot_lua_slow:IsPurgable()
	return true
end

function modifier_creep_headshot_lua_slow:OnCreated(kv)
	if IsServer() then
		self.slow = kv.slow
		EmitSoundOn("Hero_Sniper.HeadShot", self:GetParent())
	end
end

function modifier_creep_headshot_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_creep_headshot_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_creep_headshot_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_creep_headshot_lua_slow:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

creep_assassinate_lua = class({})

function creep_assassinate_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/sniper/sniper_charlie/sniper_assassinate_charlie.vpcf", context)
end

function creep_assassinate_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_assassinate_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not target or target:TriggerSpellAbsorb(self) then
		return
	end

	caster:EmitSound("Ability.Assassinate")

	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/econ/items/sniper/sniper_charlie/sniper_assassinate_charlie.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("speed"),
		bDodgeable = true,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function creep_assassinate_lua:OnProjectileHit(target, location)
	if not target or target:IsInvulnerable() then
		return
	end

	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(pfx)

	target:EmitSound("Hero_Sniper.AssassinateDamage")

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})

	target:AddNewModifier(caster, self, "modifier_stunned", { duration = 2 })
	return true
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_sunstrike_lua", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_VERTICAL)

creep_sunstrike_lua = class({})

function creep_sunstrike_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_sunstrike_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", context)
end

function creep_sunstrike_lua:OnSpellStart()
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_creep_sunstrike_lua", { duration = duration })
end

--------------------------------------------------------------------------------

modifier_creep_sunstrike_lua = class({})

function modifier_creep_sunstrike_lua:IsHidden()
	return true
end

function modifier_creep_sunstrike_lua:IsPurgable()
	return false
end

function modifier_creep_sunstrike_lua:OnCreated(kv)
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("sun_delay"))
end
function modifier_creep_sunstrike_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self:GetAbility()

	if not IsValidEntity(caster) or not IsValidEntity(ability) then
		return
	end

	local caster_team = caster:GetTeamNumber()
	local damage_radius = ability:GetSpecialValueFor("damage_radius")
	local delay = ability:GetSpecialValueFor("delay")
	local range = ability:GetSpecialValueFor("range")
	local damage = ability:GetSpecialValueFor("damage") + (ability:GetSpecialValueFor("diff_boost_damage") or 0)

	local hEnemies = FindUnitsInRadius(
		caster_team,
		caster:GetAbsOrigin(),
		caster,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	for _, target in ipairs(hEnemies) do
		local point = target:GetAbsOrigin()

		local startFX = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(startFX, 0, point)
		ParticleManager:SetParticleControl(startFX, 1, Vector(damage_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(startFX)

		local sound_cast = "Hero_Invoker.SunStrike.Charge"
		-- EmitSoundOnLocationWithCaster(point, sound_cast, caster)
		EmitSoundOn(sound_cast, caster)

		Timers:CreateTimer(delay, function()
			local endFX = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(endFX, 0, point)
			ParticleManager:SetParticleControl(endFX, 1, Vector(damage_radius, 0, 0))
			ParticleManager:ReleaseParticleIndex(endFX)

			local sound_cast = "Hero_Invoker.SunStrike.Ignite"
			-- EmitSoundOnLocationWithCaster(point, sound_cast, caster)
			EmitSoundOn(sound_cast, caster)

			local units = FindUnitsInRadius(
				caster_team,
				point,
				nil,
				damage_radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				0,
				false
			)

			for _, unit in ipairs(units) do
				if IsValidEntity(unit) and unit:IsAlive() then
					ApplyDamage({
						victim = unit,
						attacker = IsValidEntity(caster) and caster or nil,
						damage = damage,
						damage_type = DAMAGE_TYPE_PURE,
						ability = ability,
					})
				end
			end
		end)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_meteor_lua", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_meteor_lua_thinker", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_meteor_lua_burn", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_NONE)

creep_meteor_lua = class({})

function creep_meteor_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_meteor_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf", context)
end

function creep_meteor_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_creep_meteor_lua", { duration = duration })
end

--------------------------------------------------------------------------------

modifier_creep_meteor_lua = class({})

function modifier_creep_meteor_lua:IsHidden()
	return true
end

function modifier_creep_meteor_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.interval = self:GetAbility():GetSpecialValueFor("interval")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_creep_meteor_lua:OnIntervalThink()
	local caster = self:GetCaster()
	local caster_pos = caster:GetAbsOrigin()

	for i = 1, 2 do
		local random_vec = RandomVector(RandomFloat(0, self.radius))
		local target_point = caster_pos + random_vec

		CreateModifierThinker(
			caster,
			self:GetAbility(),
			"modifier_creep_meteor_lua_thinker",
			{},
			target_point,
			caster:GetTeamNumber(),
			false
		)
	end
end

--------------------------------------------------------------------------------

modifier_creep_meteor_lua_thinker = class({})

function modifier_creep_meteor_lua_thinker:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.ability = self:GetAbility()
	self.caster_origin = self:GetCaster():GetOrigin()
	self.parent_origin = self:GetParent():GetOrigin()
	self.caster = self:GetCaster()
	self.caster_team = self:GetCaster():GetTeamNumber()

	self.direction = (self.parent_origin - self.caster_origin):Normalized()
	self.direction.z = 0

	self.land_time = self.ability:GetSpecialValueFor("land_time")
	self.area_of_effect = self.ability:GetSpecialValueFor("area_of_effect")
	self.travel_distance = self.ability:GetSpecialValueFor("travel_distance")
	self.travel_speed = self.ability:GetSpecialValueFor("travel_speed")
	self.damage_interval = self.ability:GetSpecialValueFor("damage_interval")
	self.burn_duration = self.ability:GetSpecialValueFor("burn_duration")
	self.main_damage = self.ability:GetSpecialValueFor("main_damage")

	self.fallen = false

	self:StartIntervalThink(self.land_time)
	self:PlayEffects1()
end

function modifier_creep_meteor_lua_thinker:OnIntervalThink()
	if not self.fallen then
		self.fallen = true
		self:PlayEffects2()
		self:StartIntervalThink(self.damage_interval)
		self:PerformTick()
	else
		self:PerformTick()
	end
end

function modifier_creep_meteor_lua_thinker:PerformTick()
	local parent = self:GetParent()
	local current_pos = parent:GetOrigin()

	local next_pos = current_pos + self.direction * self.travel_speed * self.damage_interval
	parent:SetOrigin(next_pos)

	local enemies = FindUnitsInRadius(
		self.caster_team,
		current_pos,
		parent,
		self.area_of_effect,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = self.caster,
			damage = self.main_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
		enemy:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_creep_meteor_lua_burn",
			{ duration = self.burn_duration }
		)
	end

	if (next_pos - self.parent_origin):Length2D() > self.travel_distance then
		self:Destroy()
	end
end

function modifier_creep_meteor_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("Hero_Invoker.ChaosMeteor.Loop", self:GetParent())
	local sound_cast = "Hero_Invoker.ChaosMeteor.Destroy"
	-- EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self.caster)
	EmitSoundOn(sound_cast, self.caster)
end

function modifier_creep_meteor_lua_thinker:PlayEffects1()
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, self.caster_origin + Vector(0, 0, 1000))
	ParticleManager:SetParticleControl(pfx, 1, self.parent_origin)
	ParticleManager:SetParticleControl(pfx, 2, Vector(self.land_time, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	local sound_cast = "Hero_Invoker.ChaosMeteor.Cast"
	-- EmitSoundOnLocationWithCaster(self.caster_origin, sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())
end

function modifier_creep_meteor_lua_thinker:PlayEffects2()
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControlForward(pfx, 0, self.direction)
	ParticleManager:SetParticleControl(pfx, 1, self.direction * self.travel_speed)
	self:AddParticle(pfx, false, false, -1, false, false)

	local sound_cast = "Hero_Invoker.ChaosMeteor.Impact"
	-- EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())
	EmitSoundOn("Hero_Invoker.ChaosMeteor.Loop", self:GetParent())
end

------------------------------------------------------------------

modifier_creep_meteor_lua_burn = class({})

function modifier_creep_meteor_lua_burn:OnCreated()
	if not IsServer() then
		return
	end
	self.burn_dps = self:GetAbility():GetSpecialValueFor("burn_dps")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self:StartIntervalThink(1.0)
end

function modifier_creep_meteor_lua_burn:OnIntervalThink()
	local parent = self:GetParent()
	ApplyDamage({
		victim = parent,
		attacker = self:GetCaster(),
		damage = self.burn_dps,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
	EmitSoundOn("Hero_Invoker.ChaosMeteor.Damage", parent)
end

function modifier_creep_meteor_lua_burn:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_chaos_meteor_burn_debuff.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_echo_stomp_sleep", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_NONE)

creep_echo_stomp_lua = class({})

function creep_echo_stomp_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_echo_stomp_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local radius = self:GetSpecialValueFor("radius")
	local damage_radius = self:GetSpecialValueFor("damage_radius")
	local damage = self:GetSpecialValueFor("stomp_damage") + self:GetSpecialValueFor("diff_boost_damage")
	local duration = self:GetSpecialValueFor("duration")

	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_FARTHEST,
		false
	)

	if #enemies > 0 then
		local farthest_enemy = enemies[1]
		local target_point = farthest_enemy:GetOrigin()
		EmitSoundOn("Hero_ElderTitan.EchoStomp.Channel", self:GetCaster())

		local dummy = CreateUnitByName("npc_dummy_unit", target_point, true, caster, caster, caster:GetTeamNumber())
		dummy:AddNewModifier(dummy, self, "modifier_dummy", {})

		self.combined_particle =
			ParticleManager:CreateParticle("particles/creep_echo_stomp_lua.vpcf", PATTACH_ABSORIGIN_FOLLOW, dummy)
		Timers:CreateTimer(1.4, function()
			EmitSoundOn("Hero_ElderTitan.EchoStomp", caster)

			local particle_stomp_fx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_physical.vpcf",
				PATTACH_ABSORIGIN,
				dummy
			)
			ParticleManager:SetParticleControl(particle_stomp_fx, 0, dummy:GetAbsOrigin())
			ParticleManager:SetParticleControl(particle_stomp_fx, 1, Vector(radius, 1, 1))
			ParticleManager:SetParticleControl(particle_stomp_fx, 2, dummy:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(particle_stomp_fx)

			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				dummy:GetAbsOrigin(),
				nil,
				damage_radius,
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
					damage_type = self:GetAbilityDamageType(),
					ability = self,
				})

				enemy:AddNewModifier(caster, self, "modifier_creep_echo_stomp_sleep", { duration = duration })
			end

			if self.combined_particle then
				ParticleManager:DestroyParticle(self.combined_particle, false)
				ParticleManager:ReleaseParticleIndex(self.combined_particle)
				self.combined_particle = nil
			end
			FindClearSpaceForUnit(caster, dummy:GetOrigin(), true)
			UTIL_Remove(dummy)
		end)
	end
end

------------------------------------------------------------------------------

modifier_creep_echo_stomp_sleep = class({})

function modifier_creep_echo_stomp_sleep:IsHidden()
	return false
end
function modifier_creep_echo_stomp_sleep:IsPurgable()
	return true
end

function modifier_creep_echo_stomp_sleep:AddCustomTransmitterData()
	return {
		disarm = self.fDisarm,
	}
end

function modifier_creep_echo_stomp_sleep:HandleCustomTransmitterData(data)
	self.fDisarm = data.disarm
end

function modifier_creep_echo_stomp_sleep:OnCreated()
	self:SetHasCustomTransmitterData(true)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if ability then
		local base_disarm = ability:GetSpecialValueFor("dis_arm")
		local boost = ability:GetSpecialValueFor("diff_boost_additional")
		self.fDisarm = base_disarm + boost
	else
		self.fDisarm = 0
	end
	self:SendBuffRefreshToClients()
	self.pfx = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_sleep.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
end

function modifier_creep_echo_stomp_sleep:OnRefresh()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if ability then
		self.fDisarm = ability:GetSpecialValueFor("dis_arm") + ability:GetSpecialValueFor("diff_boost_additional")
		self:SendBuffRefreshToClients()
	end
end

function modifier_creep_echo_stomp_sleep:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_creep_echo_stomp_sleep:GetModifierPhysicalArmorBonus()
	return -(self.fDisarm or 0)
end

function modifier_creep_echo_stomp_sleep:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NIGHTMARED] = true,
	}
end

function modifier_creep_echo_stomp_sleep:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_bulwark_lua", "abilities/creeps/zone_12/zone_12", LUA_MODIFIER_MOTION_NONE)

creep_bulwark_lua = class({})

function creep_bulwark_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_mars/mars_shield_of_mars_small.vpcf", context)
end

function creep_bulwark_lua:GetIntrinsicModifierName()
	return "modifier_creep_bulwark_lua"
end

--------------------------------------------------------------------------------

modifier_creep_bulwark_lua = class({})

function modifier_creep_bulwark_lua:IsHidden()
	return false
end

function modifier_creep_bulwark_lua:IsDebuff()
	return false
end

function modifier_creep_bulwark_lua:IsStunDebuff()
	return false
end

function modifier_creep_bulwark_lua:IsPurgable()
	return false
end

function modifier_creep_bulwark_lua:OnCreated(kv)
	self.reduction_front = self:GetAbility():GetSpecialValueFor("physical_damage_reduction")
	self.reduction_side = self:GetAbility():GetSpecialValueFor("physical_damage_reduction_side")
	self.angle_front = self:GetAbility():GetSpecialValueFor("forward_angle") / 2
	self.angle_side = self:GetAbility():GetSpecialValueFor("side_angle") / 2
end

function modifier_creep_bulwark_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}
	return funcs
end

function modifier_creep_bulwark_lua:GetModifierPhysical_ConstantBlock(params)
	if params.inflictor then
		return 0
	end

	if params.target:PassivesDisabled() then
		return 0
	end

	local parent = params.target
	local attacker = params.attacker
	local reduction = 0

	local facing_direction = parent:GetAnglesAsVector().y
	local attacker_vector = (attacker:GetOrigin() - parent:GetOrigin())
	local attacker_direction = VectorToAngles(attacker_vector).y
	local angle_diff = math.abs(AngleDiff(facing_direction, attacker_direction))

	if angle_diff < self.angle_front then
		reduction = self.reduction_front
		self:PlayEffects(true)
	elseif angle_diff < self.angle_side then
		reduction = self.reduction_side
		self:PlayEffects(false)
	end
	return reduction * params.damage / 100
end

function modifier_creep_bulwark_lua:PlayEffects(front)
	local particle_cast = "particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf"
	local sound_cast = "Hero_Mars.Shield.Block"

	if not front then
		particle_cast = "particles/units/heroes/hero_mars/mars_shield_of_mars_small.vpcf"
		sound_cast = "Hero_Mars.Shield.BlockSmall"
	end

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetParent())
end