--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_creep_sand_corpse_eater_lua", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

creep_sand_corpse_eater_lua = class({})

function creep_sand_corpse_eater_lua:GetIntrinsicModifierName()
	return "modifier_creep_sand_corpse_eater_lua"
end

--------------------------------------------------------------------------------

modifier_creep_sand_corpse_eater_lua = class({})

function modifier_creep_sand_corpse_eater_lua:IsHidden()
	return false
end
function modifier_creep_sand_corpse_eater_lua:IsPurgable()
	return false
end
function modifier_creep_sand_corpse_eater_lua:RemoveOnDeath()
	return false
end

function modifier_creep_sand_corpse_eater_lua:OnCreated()
	self.bonus_hp = 0
	self.bonus_damage = 0
	self.bonus_armor = 0
	self.model_scale = 0
	if IsServer() then
		self:SetHasCustomTransmitterData(true)
	end
end

function modifier_creep_sand_corpse_eater_lua:AddCustomTransmitterData()
	return {
		bonus_hp = self.bonus_hp,
		bonus_damage = self.bonus_damage,
		bonus_armor = self.bonus_armor,
		model_scale = self.model_scale,
	}
end

function modifier_creep_sand_corpse_eater_lua:HandleCustomTransmitterData(data)
	self.bonus_hp = data.bonus_hp
	self.bonus_damage = data.bonus_damage
	self.bonus_armor = data.bonus_armor
	self.model_scale = data.model_scale
end

function modifier_creep_sand_corpse_eater_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_creep_sand_corpse_eater_lua:OnDeath(params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local unit = params.unit
	local ability = self:GetAbility()

	if not unit or unit == parent or unit:GetTeamNumber() ~= parent:GetTeamNumber() then
		return
	end
	if unit:IsIllusion() or unit:IsBuilding() then
		return
	end
	if not parent:IsAlive() then
		return
	end

	local radius = ability:GetSpecialValueFor("radius")
	if (parent:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() > radius then
		return
	end

	local pct = ability:GetSpecialValueFor("attr_steal_pct") / 100

	local added_hp = unit:GetMaxHealth() * pct
	local added_damage = (unit:GetBaseDamageMax() + unit:GetBaseDamageMin()) / 2 * pct
	local added_armor = unit:GetPhysicalArmorValue(false) * pct
	local added_scale = ability:GetSpecialValueFor("model_scale_inc")

	self.bonus_hp = self.bonus_hp + added_hp
	self.bonus_damage = self.bonus_damage + added_damage
	self.bonus_armor = self.bonus_armor + added_armor
	self.model_scale = math.min(self.model_scale + added_scale, 300)

	self:SendBuffRefreshToClients()

	local heal_pct = ability:GetSpecialValueFor("heal_pct") / 100
	local heal_amt = parent:GetMaxHealth() * heal_pct
	parent:Heal(heal_amt + added_hp, ability)

	parent:EmitSound("Hero_Pudge.Swallow")
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, heal_amt + added_hp, nil)
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_life_stealer/ls_infest_emerg_blood.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_creep_sand_corpse_eater_lua:GetModifierExtraHealthBonus()
	return self.bonus_hp
end
function modifier_creep_sand_corpse_eater_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_creep_sand_corpse_eater_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_creep_sand_corpse_eater_lua:GetModifierModelScale()
	return self.model_scale
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_sand_pack_call_lua", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_sand_pack_buff_lua", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)

creep_sand_pack_call_lua = class({})

function creep_sand_pack_call_lua:GetIntrinsicModifierName()
	return "modifier_creep_sand_pack_call_lua"
end

--------------------------------------------------------------------------------

modifier_creep_sand_pack_call_lua = class({})

function modifier_creep_sand_pack_call_lua:IsHidden()
	return true
end

function modifier_creep_sand_pack_call_lua:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end

function modifier_creep_sand_pack_call_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()

	if params.unit ~= parent or not ability:IsCooldownReady() then
		return
	end

	local threshold = ability:GetSpecialValueFor("hp_threshold_pct")
	if parent:GetHealthPercent() <= threshold then
		ability:UseResources(false, false, false, true)

		local radius = ability:GetSpecialValueFor("radius")
		local duration = ability:GetSpecialValueFor("duration")
		local attacker = params.attacker

		parent:EmitSound("Hero_Lycan.Howl")

		local allies = FindUnitsInRadius(
			parent:GetTeamNumber(),
			parent:GetAbsOrigin(),
			parent,
			radius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, ally in pairs(allies) do
			if attacker and attacker:IsAlive() then
				ally:AddNewModifier(parent, ability, "modifier_creep_sand_pack_buff_lua", {
					duration = duration,
					target_index = attacker:entindex(),
				})
			end
		end
	end
end

--------------------------------------------------------------------------------

modifier_creep_sand_pack_buff_lua = class({})

function modifier_creep_sand_pack_buff_lua:OnCreated(kv)
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.ms = ability:GetSpecialValueFor("bonus_speed_pct")
	self.as = ability:GetSpecialValueFor("bonus_attack_speed")

	if not IsServer() then
		return
	end

	if kv.target_index then
		self.target = EntIndexToHScript(kv.target_index)

		if self.target and not self.target:IsNull() and self.target:IsAlive() then
			self:GetParent():SetForceAttackTarget(self.target)
			self:GetParent():MoveToTargetToAttack(self.target)
			self:StartIntervalThink(0.5)
		end
	else
		self:Destroy()
	end
end

function modifier_creep_sand_pack_buff_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	if
		not self.target
		or self.target:IsNull()
		or not self.target:IsAlive()
		or self.target:IsInvulnerable()
		or self.target:IsAttackImmune()
	then
		self:Destroy()
		return
	end

	if self:GetParent():GetAggroTarget() ~= self.target then
		self:GetParent():MoveToTargetToAttack(self.target)
	end
end

function modifier_creep_sand_pack_buff_lua:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():SetForceAttackTarget(nil)
	self:GetParent():Stop()
end

function modifier_creep_sand_pack_buff_lua:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

function modifier_creep_sand_pack_buff_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_creep_sand_pack_buff_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms
end
function modifier_creep_sand_pack_buff_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as
end
function modifier_creep_sand_pack_buff_lua:GetEffectName()
	return "particles/units/heroes/hero_lycan/lycan_howl_buff.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_sand_impale_lua", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)

creep_sand_impale_lua = class({})

function creep_sand_impale_lua:GetIntrinsicModifierName()
	return "modifier_creep_sand_impale_lua"
end

function creep_sand_impale_lua:OnProjectileHit(target, location)
	if target and not target:IsMagicImmune() then
		local damage = self:GetSpecialValueFor("impale_damage") + self:GetSpecialValueFor("diff_boost_damage")

		ApplyDamage({
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})

		target:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_stunned",
			{ duration = self:GetSpecialValueFor("stun_duration") }
		)
		target:EmitSound("Hero_NyxAssassin.Impale.Target")
	end
	return false
end

--------------------------------------------------------------------------------

modifier_creep_sand_impale_lua = class({})

function modifier_creep_sand_impale_lua:IsHidden()
	return true
end

function modifier_creep_sand_impale_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end

	self:StartIntervalThink(0.1)
end

function modifier_creep_sand_impale_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}
end

function modifier_creep_sand_impale_lua:GetModifierInvisibilityLevel()
	return 1
end

function modifier_creep_sand_impale_lua:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_creep_sand_impale_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self.parent:IsAlive() or not self.ability:IsCooldownReady() then
		return
	end

	if self.parent:HasModifier("modifier_creep_sand_shift_motion") then
		return
	end

	local radius = self.ability:GetSpecialValueFor("radius")
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)

	if #enemies > 0 then
		local target_pos = enemies[1]:GetAbsOrigin()
		local dir = (target_pos - self.parent:GetAbsOrigin()):Normalized()
		self.parent:EmitSound("Hero_NyxAssassin.Impale")
		ProjectileManager:CreateLinearProjectile({
			Ability = self.ability,
			EffectName = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf",
			vSpawnOrigin = self.parent:GetAbsOrigin(),
			fDistance = radius,
			fStartRadius = 125,
			fEndRadius = 125,
			Source = self.parent,
			vVelocity = dir * 1600,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		})
		self.ability:UseResources(false, false, false, true)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_sand_shift_lua", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_sand_shift_motion", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_HORIZONTAL)

creep_sand_shift_lua = class({})

function creep_sand_shift_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_sandking/sandking_sandstorm.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_sandking/sandking_sandstorm_start.vpcf", context)
end

function creep_sand_shift_lua:GetIntrinsicModifierName()
	return "modifier_creep_sand_shift_lua"
end

--------------------------------------------------------------------------------

modifier_creep_sand_shift_lua = class({})

function modifier_creep_sand_shift_lua:IsHidden()
	return false
end

function modifier_creep_sand_shift_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self:StartIntervalThink(0.1)
end

function modifier_creep_sand_shift_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self.parent:IsAlive() or not self.ability:IsCooldownReady() then
		return
	end

	local threshold = self.ability:GetSpecialValueFor("hp_threshold")
	local radius = self.ability:GetSpecialValueFor("radius")

	if self.parent:GetHealthPercent() <= threshold then
		self.ability:UseResources(false, false, false, true)

		local caster = self:GetCaster()
		local origin = caster:GetAbsOrigin()

		local random_vec = RandomVector(RandomInt(300, radius))
		local target_point = origin + random_vec
		target_point.z = GetGroundHeight(target_point, nil)
		local speed = self.ability:GetSpecialValueFor("speed")

		local direction = (target_point - origin):Normalized()
		local distance = (target_point - origin):Length2D()

		local duration = distance / speed

		caster:AddNewModifier(caster, self:GetAbility(), "modifier_creep_sand_shift_motion", {
			x = target_point.x,
			y = target_point.y,
			z = target_point.z,
			duration = duration,
		})
	end
end

--------------------------------------------------------------------------------

modifier_creep_sand_shift_motion = class({})

function modifier_creep_sand_shift_motion:IsHidden()
	return false
end

function modifier_creep_sand_shift_motion:IsPurgable()
	return false
end

function modifier_creep_sand_shift_motion:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_creep_sand_shift_motion:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.pos = Vector(kv.x, kv.y, kv.z)
	self.speed = self.ability:GetSpecialValueFor("speed")

	self.parent:EmitSound("Ability.SandKing_SandStorm.start")
	self.parent:EmitSound("Hero_SandKing.SandStorm.loop")

	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_sandstorm.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(),
		true
	)

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end

function modifier_creep_sand_shift_motion:UpdateHorizontalMotion(me, dt)
	if not IsServer() then
		return
	end

	local my_pos = me:GetAbsOrigin()
	local distance_vec = self.pos - my_pos
	local distance = distance_vec:Length2D()
	local direction = distance_vec:Normalized()

	if distance < (self.speed * dt) then
		me:SetOrigin(self.pos)
		self:Destroy()
		return
	end

	local next_pos = my_pos + direction * self.speed * dt
	next_pos.z = GetGroundHeight(next_pos, me)

	me:SetOrigin(next_pos)
	me:FaceTowards(self.pos)

	ParticleManager:SetParticleControl(self.effect_cast, 1, direction * self.speed)
end

function modifier_creep_sand_shift_motion:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_creep_sand_shift_motion:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveHorizontalMotionController(self)

	self.parent:StopSound("Hero_SandKing.SandStorm.loop")
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end

	local pfx2 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_sandstorm_start.vpcf",
		PATTACH_ABSORIGIN,
		self.parent
	)
	ParticleManager:ReleaseParticleIndex(pfx2)
	self.parent:EmitSound("Ability.SandKing_SandStorm.stop")

	FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
end

function modifier_creep_sand_shift_motion:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_creep_sand_shift_motion:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_creep_sand_shift_motion:GetModifierModelChange()
	return "models/development/invisiblebox.vmdl"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_sand_toss_lua", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)

creep_sand_toss_lua = class({})

function creep_sand_toss_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_sand_toss_lua:OnSpellStart()
	local caster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("toss_damage") + self:GetSpecialValueFor("diff_boost_damage")
	local radius_search = self:GetSpecialValueFor("find_radius")
	local tossPosition = hTarget:GetOrigin()
	local foundTrap = false

	local all_entities = Entities:FindAllInSphere(tossPosition, radius_search)

	for _, ent in pairs(all_entities) do
		local entName = ent:GetName()
		if entName and string.find(entName, "trigger_spike_trap") then
			tossPosition = ent:GetOrigin()
			foundTrap = true
			break
		end
	end

	local kv = {
		vLocX = tossPosition.x,
		vLocY = tossPosition.y,
		vLocZ = tossPosition.z,
		duration = duration,
		damage = damage,
	}

	hTarget:AddNewModifier(caster, self, "modifier_creep_sand_toss_lua", kv)

	EmitSoundOn("Ability.TossThrow", caster)
end
--------------------------------------------------------------------------------------------

modifier_creep_sand_toss_lua = class({})

function modifier_creep_sand_toss_lua:IsDebuff()
	return true
end
function modifier_creep_sand_toss_lua:IsStunDebuff()
	return true
end
function modifier_creep_sand_toss_lua:RemoveOnDeath()
	return false
end
function modifier_creep_sand_toss_lua:IsHidden()
	return true
end
function modifier_creep_sand_toss_lua:IgnoreTenacity()
	return true
end
function modifier_creep_sand_toss_lua:IsMotionController()
	return true
end
function modifier_creep_sand_toss_lua:GetMotionControllerPriority()
	return DOTA_MOTION_CONTROLLER_PRIORITY_MEDIUM
end
function modifier_creep_sand_toss_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_creep_sand_toss_lua:OnCreated(kv)
	self.toss_minimum_height_above_lowest = 500
	self.toss_minimum_height_above_highest = 100
	self.toss_acceleration_z = 4000
	self.toss_max_horizontal_acceleration = 3000

	if IsServer() then
		self.ability = self:GetAbility()
		self.parent = self:GetParent()

		EmitSoundOn("Hero_Tiny.Toss.Target", self:GetParent())

		self.vStartPosition = GetGroundPosition(self:GetParent():GetOrigin(), self:GetParent())
		self.flCurrentTimeHoriz = 0.0
		self.flCurrentTimeVert = 0.0

		self.vLoc = Vector(kv.vLocX, kv.vLocY, kv.vLocZ)
		self.damage = kv.damage
		self.vLastKnownTargetPos = self.vLoc

		local duration = self:GetAbility():GetSpecialValueFor("duration")
		local flDesiredHeight = self.toss_minimum_height_above_lowest * duration * duration
		local flLowZ = math.min(self.vLastKnownTargetPos.z, self.vStartPosition.z)
		local flHighZ = math.max(self.vLastKnownTargetPos.z, self.vStartPosition.z)
		local flArcTopZ = math.max(flLowZ + flDesiredHeight, flHighZ + self.toss_minimum_height_above_highest)

		local flArcDeltaZ = flArcTopZ - self.vStartPosition.z
		self.flInitialVelocityZ = math.sqrt(2.0 * flArcDeltaZ * self.toss_acceleration_z)

		local flDeltaZ = self.vLastKnownTargetPos.z - self.vStartPosition.z
		local flSqrtDet = math.sqrt(
			math.max(0, (self.flInitialVelocityZ * self.flInitialVelocityZ) - 2.0 * self.toss_acceleration_z * flDeltaZ)
		)
		self.flPredictedTotalTime = math.max(
			(self.flInitialVelocityZ + flSqrtDet) / self.toss_acceleration_z,
			(self.flInitialVelocityZ - flSqrtDet) / self.toss_acceleration_z
		)

		self.vHorizontalVelocity = (self.vLastKnownTargetPos - self.vStartPosition) / self.flPredictedTotalTime
		self.vHorizontalVelocity.z = 0.0

		self.frametime = FrameTime()
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_creep_sand_toss_lua:OnIntervalThink()
	if IsServer() then
		self:HorizontalMotion(self.parent, self.frametime)
		self:VerticalMotion(self.parent, self.frametime)
	end
end

function modifier_creep_sand_toss_lua:TossLand()
	if IsServer() then
		if self.toss_land_commenced then
			return nil
		end

		self.toss_land_commenced = true
		local caster = self:GetCaster()
		local radius = self:GetAbility():GetSpecialValueFor("radius")

		local damage_table = {
			attacker = caster,
			damage = self.damage,
			damage_type = self.ability:GetAbilityDamageType(),
			ability = self.ability,
		}

		damage_table.victim = self.parent
		ApplyDamage(damage_table)

		local victims = FindUnitsInRadius(
			caster:GetTeamNumber(),
			self.parent:GetAbsOrigin(),
			self.parent,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			0,
			1,
			false
		)
		for _, victim in pairs(victims) do
			if victim ~= self.parent then
				damage_table.victim = victim
				ApplyDamage(damage_table)
			end
		end

		EmitSoundOn("Ability.TossImpact", self.parent)

		FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)

		self:Destroy()
	end
end

function modifier_creep_sand_toss_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_creep_sand_toss_lua:GetOverrideAnimation(params)
	return ACT_DOTA_FLAIL
end

function modifier_creep_sand_toss_lua:GetEffectName()
	return "particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf"
end

function modifier_creep_sand_toss_lua:CheckState()
	-- if IsServer() then
	if self:GetCaster() ~= nil and self:GetParent() ~= nil then
		if
			self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber()
			and (not self:GetParent():IsMagicImmune())
		then
			return { [MODIFIER_STATE_STUNNED] = true }
		else
			return { [MODIFIER_STATE_ROOTED] = true }
		end
	end
	-- end
	return {}
end

--------------------------------------------------------------------------------

function modifier_creep_sand_toss_lua:HorizontalMotion(me, dt)
	if IsServer() then
		self.flCurrentTimeHoriz = math.min(self.flCurrentTimeHoriz + dt, self.flPredictedTotalTime)
		local t = self.flCurrentTimeHoriz / self.flPredictedTotalTime
		local vStartToTarget = self.vLastKnownTargetPos - self.vStartPosition
		local vDesiredPos = self.vStartPosition + t * vStartToTarget

		local vOldPos = me:GetOrigin()
		local vToDesired = vDesiredPos - vOldPos
		vToDesired.z = 0.0
		local vDesiredVel = vToDesired / dt
		local vVelDif = vDesiredVel - self.vHorizontalVelocity
		local flVelDif = vVelDif:Length2D()
		vVelDif = vVelDif:Normalized()
		local flVelDelta = math.min(flVelDif, self.toss_max_horizontal_acceleration)

		self.vHorizontalVelocity = self.vHorizontalVelocity + vVelDif * flVelDelta * dt
		local vNewPos = vOldPos + self.vHorizontalVelocity * dt
		me:SetOrigin(vNewPos)
	end
end

function modifier_creep_sand_toss_lua:VerticalMotion(me, dt)
	if IsServer() then
		self.flCurrentTimeVert = self.flCurrentTimeVert + dt
		local bGoingDown = (-self.toss_acceleration_z * self.flCurrentTimeVert + self.flInitialVelocityZ) < 0

		local vNewPos = me:GetOrigin()
		vNewPos.z = self.vStartPosition.z
			+ (
				-0.5 * self.toss_acceleration_z * (self.flCurrentTimeVert * self.flCurrentTimeVert)
				+ self.flInitialVelocityZ * self.flCurrentTimeVert
			)

		local flGroundHeight = GetGroundHeight(vNewPos, self:GetParent())
		local bLanded = false
		if vNewPos.z < flGroundHeight and bGoingDown == true then
			vNewPos.z = flGroundHeight
			bLanded = true
		end

		me:SetOrigin(vNewPos)
		if bLanded == true then
			self:TossLand()
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_sand_shimmer_aura_lua", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_sand_shimmer_aura_lua_buff", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)

creep_sand_shimmer_aura_lua = class({})

function creep_sand_shimmer_aura_lua:GetIntrinsicModifierName()
	return "modifier_creep_sand_shimmer_aura_lua"
end

--------------------------------------------------------------------------------

modifier_creep_sand_shimmer_aura_lua = class({})

function modifier_creep_sand_shimmer_aura_lua:IsHidden()
	return true
end

function modifier_creep_sand_shimmer_aura_lua:IsPurgable()
	return false
end

function modifier_creep_sand_shimmer_aura_lua:IsAura()
	return true
end

function modifier_creep_sand_shimmer_aura_lua:GetModifierAura()
	return "modifier_creep_sand_shimmer_aura_lua_buff"
end

function modifier_creep_sand_shimmer_aura_lua:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_creep_sand_shimmer_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_creep_sand_shimmer_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_creep_sand_shimmer_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

--------------------------------------------------------------------------------

modifier_creep_sand_shimmer_aura_lua_buff = class({})

function modifier_creep_sand_shimmer_aura_lua_buff:IsHidden()
	return false
end

function modifier_creep_sand_shimmer_aura_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
end

function modifier_creep_sand_shimmer_aura_lua_buff:GetModifierEvasion_Constant()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("evasion_chance")
	end
	return 0
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_mirage_weaver_blind", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)

creep_sand_illusion_lua = class({})

function creep_sand_illusion_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_sand_illusion_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local outgoing = self:GetSpecialValueFor("outgoing_damage") + self:GetSpecialValueFor("diff_boost_damage") - 100
	local incoming = self:GetSpecialValueFor("incoming_damage") - 100
	local blind_duration = self:GetSpecialValueFor("blind_duration")

	CreateIllusions(caster, target, {
		outgoing_damage = outgoing,
		incoming_damage = incoming,
		bFullHealth = true,
		nBonusGold = 0,
		nBonusXP = 0,
	}, 1, 64, false, true)

	target:AddNewModifier(caster, self, "modifier_mirage_weaver_blind", { duration = blind_duration })
end

--------------------------------------------------------------------------------

modifier_mirage_weaver_blind = class({})

function modifier_mirage_weaver_blind:IsHidden()
	return false
end

function modifier_mirage_weaver_blind:IsDebuff()
	return true
end

function modifier_mirage_weaver_blind:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
	}
end

function modifier_mirage_weaver_blind:GetModifierMiss_Percentage()
	return 100
end

function modifier_mirage_weaver_blind:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_debuff.vpcf"
end

function modifier_mirage_weaver_blind:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_all_reduction_aura_passive", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_all_reduction_aura_debuff", "abilities/creeps/zone_7/zone_7", LUA_MODIFIER_MOTION_NONE)

all_reduction_aura = class({})

function all_reduction_aura:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_chronosphere.vpcf", context)
end

function all_reduction_aura:GetIntrinsicModifierName()
	return "modifier_all_reduction_aura_passive"
end

--------------------------------------------------------------------------------

modifier_all_reduction_aura_passive = class({})

function modifier_all_reduction_aura_passive:IsHidden()
	return false
end

function modifier_all_reduction_aura_passive:IsAura()
	return true
end

function modifier_all_reduction_aura_passive:GetModifierAura()
	return "modifier_all_reduction_aura_debuff"
end

function modifier_all_reduction_aura_passive:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("presence_radius")
end

function modifier_all_reduction_aura_passive:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_all_reduction_aura_passive:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_all_reduction_aura_passive:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_all_reduction_aura_passive:GetAuraDuration()
	return 0.1
end

function modifier_all_reduction_aura_passive:OnCreated()
	if not IsServer() then
		return
	end
	if not self:GetAbility() then
		return
	end

	self.radius = self:GetAbility():GetSpecialValueFor("presence_radius")
	local caster = self:GetParent()
	self.particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_faceless_void/faceless_void_chronosphere.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_origin",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, self.radius, self.radius))
	self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_all_reduction_aura_passive:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_all_reduction_aura_passive:OnDeath(params)
	if not IsServer() then
		return
	end
	if params.unit == self:GetParent() then
		if self.particle then
			ParticleManager:DestroyParticle(self.particle, true)
			ParticleManager:ReleaseParticleIndex(self.particle)
			self.particle = nil
		end
	end
end
--------------------------------------------------------------------------------

modifier_all_reduction_aura_debuff = class({})

function modifier_all_reduction_aura_debuff:IsHidden()
	return false
end

function modifier_all_reduction_aura_debuff:IsDebuff()
	return true
end

function modifier_all_reduction_aura_debuff:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	local base_reduction = ability:GetSpecialValueFor("reduction")
	local diff_boost = ability:GetSpecialValueFor("diff_boost_damage")

	self.total_armor_reduction = (base_reduction + diff_boost)
end

function modifier_all_reduction_aura_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_all_reduction_aura_debuff:GetModifierMagicalResistanceBonus()
	return -self.total_armor_reduction
end

function modifier_all_reduction_aura_debuff:GetModifierPhysicalArmorBonus()
	return -self.total_armor_reduction
end