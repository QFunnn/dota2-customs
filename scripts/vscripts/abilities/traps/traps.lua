--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

simple_trap_shot = class({})

function simple_trap_shot:Precache(context)
	PrecacheResource("particle", "particles/traps_zone_2/auto_shot_trap.vpcf", context)
	PrecacheResource("particle", "particles/traps/temple_trap_arrow.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_demonartist/demonartist_darkartistry_proj.vpcf", context)
end

function simple_trap_shot:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function simple_trap_shot:OnSpellStart()
	if not IsServer() then
		return
	end

	self.start_radius = self:GetSpecialValueFor("start_radius")
	self.end_radius = self:GetSpecialValueFor("end_radius")
	self.speed = self:GetSpecialValueFor("speed")

	local vPos = self:GetCursorPosition()
	local vDirection = vPos - self:GetCaster():GetOrigin()
	vDirection.z = 0.0
	vDirection = vDirection:Normalized()

	local info = {
		EffectName = self.particle,
		Ability = self,
		vSpawnOrigin = self:GetCaster():GetOrigin(),
		fStartRadius = self.start_radius,
		fEndRadius = self.end_radius,
		vVelocity = vDirection * self.speed,
		fDistance = self.shot_range,
		Source = self:GetCaster(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	}

	if self.sound then
		self:GetCaster():EmitSound(self.sound)
	else
		self:GetCaster():EmitSound("Tower.Fire.Attack")
	end
	ProjectileManager:CreateLinearProjectile(info)
end

function simple_trap_shot:OnProjectileHit(hTarget, vLocation)
	if not IsServer() then
		return
	end

	if hTarget ~= nil and (not hTarget:IsMagicImmune()) then
		if hTarget:FindAbilityByName("sasori_red_secret_technique") then
			return false
		end

		local damage = 0
		local damage_type = DAMAGE_TYPE_PURE

		if self.damage_prc >= 100 then
			hTarget:Kill(nil, self:GetCaster())
			return false
		end

		if self.damage_prc > 0 then
			damage = hTarget:GetMaxHealth() * self.damage_prc / 100
		else
			damage = self.damage + self:GetSpecialValueFor("diff_boost_damage")
		end

		if self.damage_type then
			damage_type = self.damage_type
		end

		local damageTable = {
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = damage_type,
			ability = self,
		}
		ApplyDamage(damageTable)
	end
	return false
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

LinkLuaModifier("modifier_circle_trap_lua", "abilities/traps/traps", LUA_MODIFIER_MOTION_NONE)

circle_trap_lua = class({})

function circle_trap_lua:Precache(context)
	PrecacheResource("particle", "particles/trap_sunray.vpcf", context)
end

function circle_trap_lua:GetIntrinsicModifierName()
	return "modifier_circle_trap_lua"
end

---------------------------------------------------------------------------------------

modifier_circle_trap_lua = class({})

function modifier_circle_trap_lua:IsHidden()
	return false
end

function modifier_circle_trap_lua:IsPurgable()
	return false
end

function modifier_circle_trap_lua:OnCreated(kv)
	local caster = self:GetCaster()
	local pathLength = 300
	local particleName = "particles/trap_sunray.vpcf"
	local deltaTime = 0.03

	local possible_speeds = { -3.6, -3.2, -2.8, -2.4, -2.0, 2.0, 2.4, 2.8, 3.2, 3.6 }

	if caster:GetName() == "npc_dota_first_circle_trap" then
		possible_speeds = { -2.0, -1.6, -1.2, 1.2, 1.6, 2.0 }
	end

	local random_index = RandomInt(1, #possible_speeds)
	self.speed = possible_speeds[random_index]

	caster:SetContextThink(DoUniqueString("updateSunRay"), function()
		if GameRules:State_Get() ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
			return 1
		end

		if not self.pfx then
			self.pfx = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
			self.attach_point = caster:ScriptLookupAttachment("attach_head")
			self:AddParticle(self.pfx, false, false, -1, false, false)
		end

		local angle = caster:GetAngles()
		local new_angle = RotateOrientation(angle, QAngle(0, self.speed, 0))
		caster:SetAngles(new_angle[1], new_angle[2], new_angle[3])

		local attach_pos = caster:GetAttachmentOrigin(self.attach_point)
		ParticleManager:SetParticleControl(self.pfx, 0, attach_pos)

		local casterOrigin = caster:GetAbsOrigin()
		local casterForward = caster:GetForwardVector()
		local endcapPos = casterOrigin + casterForward * pathLength
		endcapPos = GetGroundPosition(endcapPos, nil)
		endcapPos.z = casterOrigin.z + 100 -- endcapPos.z + 92

		ParticleManager:SetParticleControl(self.pfx, 1, endcapPos)

		local units = FindUnitsInLine(
			caster:GetTeamNumber(),
			casterOrigin,
			endcapPos,
			nil,
			50,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE
		)

		for _, unit in pairs(units) do
			if not unit:FindAbilityByName("sasori_red_secret_technique") then
				ApplyDamage({
					victim = unit,
					attacker = caster,
					ability = self:GetAbility(),
					damage = unit:GetMaxHealth(),
					damage_type = DAMAGE_TYPE_PURE,
				})
			end
		end

		return deltaTime
	end, 0.1)
end

function modifier_circle_trap_lua:OnDestroy()
	-- self.pfx managed by AddParticle — движок очищает автоматически
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_pendulum_trap_lua", LUA_MODIFIER_MOTION_NONE)

pendulum_trap = class({})

function pendulum_trap:CastFilterResultTarget(hTarget)
	if IsServer() then
		local nResult = UnitFilter(
			hTarget,
			self:GetAbilityTargetTeam(),
			self:GetAbilityTargetType(),
			self:GetAbilityTargetFlags(),
			self:GetCaster():GetTeamNumber()
		)
		return nResult
	end
	return UF_SUCCESS
end

function pendulum_trap:GetCastRange(vLocation, hTarget)
	return self.BaseClass.GetCastRange(self, vLocation, hTarget)
end

function pendulum_trap:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		if not hTarget:TriggerSpellAbsorb(self) then
			local damage_delay = self:GetSpecialValueFor("damage_delay")
			hTarget:AddNewModifier(self:GetCaster(), self, "modifier_pendulum_trap_lua", { duration = damage_delay })
		end

		local nFXIndex = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood01.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(
			nFXIndex,
			1,
			hTarget,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			hTarget:GetOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(nFXIndex)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local triggerActive = true

function Fire(trigger)
	local triggerName = thisEntity:GetName()
	local target = Entities:FindByName(nil, triggerName .. "_target")
	local spikes = triggerName .. "_model"
	if target ~= nil and triggerActive == true then
		local spikeTrap = thisEntity:FindAbilityByName("spike_trap")
		thisEntity:CastAbilityOnPosition(target:GetOrigin(), spikeTrap, -1)
		EmitSoundOn("Conquest.SpikeTrap.Plate", spikeTrap)
		DoEntFire(spikes, "SetAnimation", "spiketrap_activate", 0, self, self)
		triggerActive = false
		thisEntity:SetContextThink("ResetTrapModel", function()
			ResetTrapModel()
		end, 4)
	end
end

function ResetTrapModel()
	triggerActive = true
end

LinkLuaModifier("modifier_spike_trap_lua", "abilities/traps/traps", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spike_trap_thinker_lua", "abilities/traps/traps", LUA_MODIFIER_MOTION_NONE)

spike_trap = class({})

function spike_trap:GetAOERadius()
	return self:GetSpecialValueFor("light_strike_array_aoe")
end

function spike_trap:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function spike_trap:OnSpellStart()
	self.light_strike_array_aoe = self:GetSpecialValueFor("light_strike_array_aoe")
	self.light_strike_array_delay_time = self:GetSpecialValueFor("light_strike_array_delay_time")

	local kv = {}
	CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_spike_trap_thinker_lua",
		kv,
		self:GetCursorPosition(),
		self:GetCaster():GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------

modifier_spike_trap_lua = class({})

function modifier_spike_trap_lua:IsDebuff()
	return true
end

function modifier_spike_trap_lua:IsHidden()
	return true
end

function modifier_spike_trap_lua:IsStunDebuff()
	return true
end

function modifier_spike_trap_lua:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_spike_trap_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_spike_trap_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_spike_trap_lua:GetOverrideAnimation(params)
	return ACT_DOTA_DISABLED
end

function modifier_spike_trap_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

--------------------------------------------------------------------------------

modifier_spike_trap_thinker_lua = class({})

function modifier_spike_trap_thinker_lua:IsHidden()
	return true
end

function modifier_spike_trap_thinker_lua:OnCreated(kv)
	self.light_strike_array_aoe = self:GetAbility():GetSpecialValueFor("light_strike_array_aoe")
	self.light_strike_array_damage = self:GetAbility():GetSpecialValueFor("light_strike_array_damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.light_strike_array_stun_duration = self:GetAbility():GetSpecialValueFor("light_strike_array_stun_duration")
	self.light_strike_array_delay_time = self:GetAbility():GetSpecialValueFor("light_strike_array_delay_time")
	if IsServer() then
		self:StartIntervalThink(self.light_strike_array_delay_time)
		local sound_cast = "Ability.PreLightStrikeArray"
		-- EmitSoundOnLocationForAllies( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
		EmitSoundOn(sound_cast, self:GetCaster())
	end
end

function modifier_spike_trap_thinker_lua:OnIntervalThink()
	if IsServer() then
		GridNav:DestroyTreesAroundPoint(self:GetParent():GetOrigin(), self.light_strike_array_aoe, false)
		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			self:GetParent(),
			self.light_strike_array_aoe,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		if #enemies > 0 then
			for _, enemy in pairs(enemies) do
				if enemy ~= nil and (not enemy:IsMagicImmune()) and (not enemy:IsInvulnerable()) then
					if not enemy:FindAbilityByName("sasori_red_secret_technique") then
						local damage = {
							victim = enemy,
							attacker = self:GetCaster(),
							damage = self.light_strike_array_damage,
							damage_type = DAMAGE_TYPE_MAGICAL,
							ability = self:GetAbility(),
						}

						ApplyDamage(damage)
						enemy:AddNewModifier(
							self:GetCaster(),
							self:GetAbility(),
							"modifier_spike_trap_lua",
							{ duration = self.light_strike_array_stun_duration }
						)
					end
				end
			end
		end
		-- EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Conquest.SpikeTrap.Activate.Generic", self:GetCaster() )
		EmitSoundOn("Conquest.SpikeTrap.Activate.Generic", self:GetCaster())
		UTIL_Remove(self:GetParent())
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_simple_roll_shot_thinker", "abilities/traps/traps", LUA_MODIFIER_MOTION_NONE)

simple_roll_shot = class({})

function simple_roll_shot:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf", context)
	PrecacheResource("sound", "Hero_Invoker.ChaosMeteor.Loop", context)
end

function simple_roll_shot:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	CreateModifierThinker(caster, self, "modifier_simple_roll_shot_thinker", {}, point, caster:GetTeamNumber(), false)
end

--------------------------------------------------------------------------------

modifier_simple_roll_shot_thinker = class({})

function modifier_simple_roll_shot_thinker:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.ability = self:GetAbility()
	self.caster_origin = self:GetCaster():GetOrigin()
	self.parent_origin = self:GetParent():GetOrigin()

	self.direction = (self.parent_origin - self.caster_origin):Normalized()
	self.direction.z = 0

	self.radius = 120
	self.shot_range = self.ability.shot_range
	self.travel_speed = self.ability.travel_speed
	self.damage_interval = 0.3

	self.fallen = false

	self:StartIntervalThink(self.damage_interval)
end

function modifier_simple_roll_shot_thinker:OnIntervalThink()
	if not self.fallen then
		self.fallen = true
		self:PlayEffects2()
		self:StartIntervalThink(self.damage_interval)
		self:PerformTick()
	else
		self:PerformTick()
	end
end

function modifier_simple_roll_shot_thinker:PerformTick()
	local parent = self:GetParent()
	local current_pos = parent:GetOrigin()

	local next_pos = current_pos + self.direction * self.travel_speed * self.damage_interval
	parent:SetOrigin(next_pos)

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		current_pos,
		parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		if not enemy:FindAbilityByName("sasori_red_secret_technique") then
			enemy:Kill(nil, self:GetCaster())
		end
	end

	if (next_pos - self.parent_origin):Length2D() > self.shot_range then
		self:Destroy()
	end
end

function modifier_simple_roll_shot_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("Hero_Invoker.ChaosMeteor.Loop", self:GetParent())
end

function modifier_simple_roll_shot_thinker:PlayEffects2()
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControlForward(pfx, 0, self.direction)
	ParticleManager:SetParticleControl(pfx, 1, self.direction * self.travel_speed)
	self:AddParticle(pfx, false, false, -1, false, false)
	EmitSoundOn("Hero_Invoker.ChaosMeteor.Loop", self:GetParent())
end