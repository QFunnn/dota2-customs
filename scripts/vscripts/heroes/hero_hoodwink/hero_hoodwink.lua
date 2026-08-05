--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_hoodwink_acorn_shot_lua", "heroes/hero_hoodwink/hero_hoodwink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_hoodwink_acorn_shot_lua_thinker",
	"heroes/hero_hoodwink/hero_hoodwink",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_hoodwink_acorn_shot_lua_debuff",
	"heroes/hero_hoodwink/hero_hoodwink",
	LUA_MODIFIER_MOTION_NONE
)

hoodwink_acorn_shot_lua = class({})

function hoodwink_acorn_shot_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	self.tree_duration = 20
	self.tree_vision = 300

	local thinker = CreateModifierThinker(
		caster,
		self,
		"modifier_hoodwink_acorn_shot_lua_thinker",
		{},
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
	local mod = thinker:FindModifierByName("modifier_hoodwink_acorn_shot_lua_thinker")

	if not target then
		target = thinker
		thinker:SetOrigin(point)
	end
	mod.source = caster
	mod.target = target

	local sound_cast = "Hero_Hoodwink.AcornShot.Cast"
	EmitSoundOn(sound_cast, caster)
end

function hoodwink_acorn_shot_lua:OnProjectileHit_ExtraData(target, location, ExtraData)
	local caster = self:GetCaster()
	local thinker = EntIndexToHScript(ExtraData.thinker)
	local mod = thinker:FindModifierByName("modifier_hoodwink_acorn_shot_lua_thinker")
	if not mod then
		return
	end

	thinker:SetOrigin(location)
	mod:Bounce()

	if ExtraData.first == 1 then
		if target == thinker then
			self:CreateTree(location)
			return
		end
		if not target then
			self:CreateTree(location)
			mod.target = thinker
			return
		end

		if target:TriggerSpellAbsorb(self) then
			mod:Destroy()
			return
		end
	end

	if not target then
		mod:Destroy()
		return
	end

	local duration = self:GetSpecialValueFor("debuff_duration")

	local mod = caster:AddNewModifier(caster, self, "modifier_hoodwink_acorn_shot_lua", {})
	caster:PerformAttack(target, true, true, true, true, false, false, true)
	mod:Destroy()

	if not target:IsMagicImmune() then
		target:AddNewModifier(caster, self, "modifier_hoodwink_acorn_shot_lua_debuff", { duration = duration })
		local sound_slow = "Hero_Hoodwink.AcornShot.Slow"
		EmitSoundOn(sound_slow, target)
	end
	local sound_target = "Hero_Hoodwink.AcornShot.Target"
	EmitSoundOn(sound_target, target)
end

function hoodwink_acorn_shot_lua:CreateTree(location)
	AddFOWViewer(self:GetCaster():GetTeamNumber(), location, self.tree_vision, self.tree_duration, false)
	local tree =
		CreateTempTreeWithModel(location, self.tree_duration, "models/heroes/hoodwink/hoodwink_tree_model.vmdl")
	local units = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		location,
		self:GetCaster(),
		100,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)
	for _, unit in pairs(units) do
		FindClearSpaceForUnit(unit, unit:GetOrigin(), true)
	end
	self:PlayEffects1(tree, location)
	self:PlayEffects2(tree, location)
end

function hoodwink_acorn_shot_lua:PlayEffects1(tree, location)
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_tree.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, tree)
	ParticleManager:SetParticleControl(effect_cast, 0, tree:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(1, 1, 1))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function hoodwink_acorn_shot_lua:PlayEffects2(tree, location)
	local particle_cast = "particles/tree_fx/tree_simple_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, tree:GetOrigin() + Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-----------------------------------------------------------------

modifier_hoodwink_acorn_shot_lua = class({})

function modifier_hoodwink_acorn_shot_lua:IsHidden()
	return true
end

function modifier_hoodwink_acorn_shot_lua:IsPurgable()
	return false
end

function modifier_hoodwink_acorn_shot_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_hoodwink_acorn_shot_lua:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_hoodwink_acorn_shot_lua:GetModifierProcAttack_Feedback(params)
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_DAMAGE,
		params.target,
		params.damage,
		self:GetCaster():GetPlayerOwner()
	)
end

--------------------------------------------------------------------------------

modifier_hoodwink_acorn_shot_lua_debuff = class({})

function modifier_hoodwink_acorn_shot_lua_debuff:IsHidden()
	return false
end

function modifier_hoodwink_acorn_shot_lua_debuff:IsDebuff()
	return true
end

function modifier_hoodwink_acorn_shot_lua_debuff:IsStunDebuff()
	return false
end

function modifier_hoodwink_acorn_shot_lua_debuff:IsPurgable()
	return true
end

function modifier_hoodwink_acorn_shot_lua_debuff:OnCreated(kv)
	self.slow = -self:GetAbility():GetSpecialValueFor("slow")
	if not IsServer() then
		return
	end
end

function modifier_hoodwink_acorn_shot_lua_debuff:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_hoodwink_acorn_shot_lua_debuff:OnRemoved() end

function modifier_hoodwink_acorn_shot_lua_debuff:OnDestroy() end

function modifier_hoodwink_acorn_shot_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_hoodwink_acorn_shot_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_hoodwink_acorn_shot_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_slow.vpcf"
end

function modifier_hoodwink_acorn_shot_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------

modifier_hoodwink_acorn_shot_lua_thinker = class({})

function modifier_hoodwink_acorn_shot_lua_thinker:OnCreated(kv)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.projectile_name = "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_tracking.vpcf"

	self.projectile_speed = self:GetAbility():GetSpecialValueFor("projectile_speed")
	self.bounces = self:GetAbility():GetSpecialValueFor("bounce_count") + 1
	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.delay = self:GetAbility():GetSpecialValueFor("bounce_delay")
	self.range = self:GetAbility():GetSpecialValueFor("bounce_range")

	if not IsServer() then
		return
	end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	-- precache projectile
	self.info = {
		-- Target = self.target,
		-- Source = self.parent,
		Ability = self.ability,

		EffectName = self.projectile_name,
		iMoveSpeed = self.projectile_speed,
		bDodgeable = true, -- Optional

		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,

		bVisibleToEnemies = true, -- Optional
		bProvidesVision = true, -- Optional
		iVisionRadius = 400, -- Optional
		iVisionTeamNumber = self.caster:GetTeamNumber(), -- Optional
		ExtraData = {
			thinker = self.parent:entindex(),
		},
	}
	self:StartIntervalThink(0)
end

function modifier_hoodwink_acorn_shot_lua_thinker:OnRefresh(kv) end

function modifier_hoodwink_acorn_shot_lua_thinker:OnRemoved() end

function modifier_hoodwink_acorn_shot_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end

function modifier_hoodwink_acorn_shot_lua_thinker:OnIntervalThink()
	self.bounces = self.bounces - 1
	if self.bounces < 0 then
		self:Destroy()
		return
	end

	self:StartIntervalThink(-1)

	local first = 0
	if not self.first then
		self.first = true
		first = 1
		self.info.iMoveSpeed = self.projectile_speed
	else
		self.source = self.target

		-- Find enemies
		local enemies = FindUnitsInRadius(
			self.caster:GetTeamNumber(), -- int, your team number
			self.target:GetOrigin(), -- point, center point
			self.target, -- handle, cacheUnit. (not known)
			self.range, -- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
			0, -- int, order filter
			false -- bool, can grow cache
		)
		if #enemies < 1 then
			self:Destroy()
			return
		end

		local next_target
		for _, enemy in pairs(enemies) do
			if enemy ~= self.target then
				next_target = enemy
				break
			end
		end
		if not next_target then
			self:Destroy()
			return
		end
		self.target = next_target

		self.info.iMoveSpeed = self.caster:GetProjectileSpeed()
	end

	self.info.Source = self.source
	self.info.Target = self.target
	self.info.ExtraData.first = first
	ProjectileManager:CreateTrackingProjectile(self.info)

	local sound_cast = "Hero_Hoodwink.AcornShot.Bounce"
	EmitSoundOn(sound_cast, self.source)
end

function modifier_hoodwink_acorn_shot_lua_thinker:Bounce()
	self:StartIntervalThink(self.delay)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_hoodwink_bushwhack_lua_thinker",
	"heroes/hero_hoodwink/hero_hoodwink",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_hoodwink_bushwhack_lua_debuff",
	"heroes/hero_hoodwink/hero_hoodwink",
	LUA_MODIFIER_MOTION_HORIZONTAL
)

hoodwink_bushwhack_lua = class({})

function hoodwink_bushwhack_lua:GetAOERadius()
	return self:GetSpecialValueFor("trap_radius")
end

function hoodwink_bushwhack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local delay = (point - caster:GetOrigin()):Length2D() / projectile_speed
	local target = CreateModifierThinker(
		caster,
		self,
		"modifier_hoodwink_bushwhack_lua_thinker",
		{ duration = delay },
		point,
		caster:GetTeamNumber(),
		false
	)
end

----------------------------------------------------------------------------------------

modifier_hoodwink_bushwhack_lua_debuff = class({})

function modifier_hoodwink_bushwhack_lua_debuff:IsHidden()
	return false
end

function modifier_hoodwink_bushwhack_lua_debuff:IsDebuff()
	return true
end

function modifier_hoodwink_bushwhack_lua_debuff:IsStunDebuff()
	return true
end

function modifier_hoodwink_bushwhack_lua_debuff:IsPurgable()
	return true
end

function modifier_hoodwink_bushwhack_lua_debuff:OnCreated(kv)
	self.parent = self:GetParent()
	self.height = self:GetAbility():GetSpecialValueFor("visual_height")
	self.rate = self:GetAbility():GetSpecialValueFor("animation_rate")

	self.distance = 150
	self.speed = 900
	self.interval = 0.1

	if not IsServer() then
		return
	end
	self.tree = EntIndexToHScript(kv.tree)
	self.tree_origin = self.tree:GetOrigin()
	if not self:ApplyHorizontalMotionController() then
		return
	end

	self:StartIntervalThink(self.interval)

	self:PlayEffects1()
end

function modifier_hoodwink_bushwhack_lua_debuff:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_hoodwink_bushwhack_lua_debuff:OnRemoved() end

function modifier_hoodwink_bushwhack_lua_debuff:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():RemoveHorizontalMotionController(self)
end

function modifier_hoodwink_bushwhack_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_FIXED_DAY_VISION,
		MODIFIER_PROPERTY_FIXED_NIGHT_VISION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_VISUAL_Z_DELTA,
	}
	return funcs
end

function modifier_hoodwink_bushwhack_lua_debuff:GetFixedDayVision()
	return 0
end

function modifier_hoodwink_bushwhack_lua_debuff:GetFixedNightVision()
	return 0
end

function modifier_hoodwink_bushwhack_lua_debuff:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_hoodwink_bushwhack_lua_debuff:GetOverrideAnimationRate()
	return self.rate
end

function modifier_hoodwink_bushwhack_lua_debuff:GetVisualZDelta()
	return self.height
end

function modifier_hoodwink_bushwhack_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

function modifier_hoodwink_bushwhack_lua_debuff:OnIntervalThink()
	if not self.tree.IsStanding then
		if self.tree:IsNull() then
			self:Destroy()
		end
	elseif not self.tree:IsStanding() then
		self:Destroy()
	end
end

function modifier_hoodwink_bushwhack_lua_debuff:UpdateHorizontalMotion(me, dt)
	local origin = me:GetOrigin()
	local dir = self.tree_origin - origin
	local dist = dir:Length2D()
	dir.z = 0
	dir = dir:Normalized()
	if dist < self.distance then
		self:GetParent():RemoveHorizontalMotionController(self)
		self:PlayEffects2(dir)
		return
	end
	local target = dir * self.speed * dt
	me:SetOrigin(origin + target)
end

function modifier_hoodwink_bushwhack_lua_debuff:OnHorizontalMotionInterrupted()
	self:GetParent():RemoveHorizontalMotionController(self)
end

function modifier_hoodwink_bushwhack_lua_debuff:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_target.vpcf"
	local sound_cast = "Hero_Hoodwink.Bushwhack.Target"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(effect_cast, 15, self.tree_origin)
	self:AddParticle(effect_cast, false, false, -1, false, false)
	EmitSoundOn(sound_cast, self.parent)
end

function modifier_hoodwink_bushwhack_lua_debuff:PlayEffects2(dir)
	local particle_cast = "particles/tree_fx/tree_simple_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-----------------------------------------------------

modifier_hoodwink_bushwhack_lua_thinker = class({})

function modifier_hoodwink_bushwhack_lua_thinker:IsHidden()
	return false
end

function modifier_hoodwink_bushwhack_lua_thinker:IsDebuff()
	return false
end

function modifier_hoodwink_bushwhack_lua_thinker:IsStunDebuff()
	return false
end

function modifier_hoodwink_bushwhack_lua_thinker:IsPurgable()
	return true
end

function modifier_hoodwink_bushwhack_lua_thinker:OnCreated(kv)
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.damage = self:GetAbility():GetSpecialValueFor("total_damage")
	self.duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
	self.speed = self:GetAbility():GetSpecialValueFor("projectile_speed")
	self.radius = self:GetAbility():GetSpecialValueFor("trap_radius")

	if not IsServer() then
		return
	end

	self.location = self:GetParent():GetOrigin()
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	self:PlayEffects1()
end

function modifier_hoodwink_bushwhack_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	AddFOWViewer(self.caster:GetTeamNumber(), self.location, self.radius, self.duration, false)
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.location,
		self:GetParent(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	if #enemies < 1 then
		self:PlayEffects2(false)
		return
	end

	local trees = GridNav:GetAllTreesAroundPoint(self.location, self.radius, false)
	if #trees < 1 then
		self:PlayEffects2(false)
		return
	end

	local damageTable = {
		-- victim = target,
		attacker = self.caster,
		damage = self.damage,
		damage_type = self.abilityDamageType,
		ability = self.ability, --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		local origin = enemy:GetOrigin()
		local mytree = trees[1]
		local mytreedist = (trees[1]:GetOrigin() - origin):Length2D()
		for _, tree in pairs(trees) do
			local treedist = (tree:GetOrigin() - origin):Length2D()
			if treedist < mytreedist then
				mytree = tree
				mytreedist = treedist
			end
		end
		if not enemy:IsAncient() then
			enemy:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_hoodwink_bushwhack_lua_debuff",
				{ duration = self.duration, tree = mytree:entindex() }
			)
		end
	end
	self:PlayEffects2(true)
	UTIL_Remove(self:GetParent())
end

function modifier_hoodwink_bushwhack_lua_thinker:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_projectile.vpcf"
	local sound_cast = "Hero_Hoodwink.Bushwhack.Cast"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 0, self.caster:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(self.speed, 0, 0))
	self:AddParticle(effect_cast, false, false, -1, false, false)
	EmitSoundOn(sound_cast, self.caster)
end

function modifier_hoodwink_bushwhack_lua_thinker:PlayEffects2(success)
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_fail.vpcf"
	local sound_cast = "Hero_Hoodwink.Bushwhack.Cast"
	local sound_location = "Hero_Hoodwink.Bushwhack.Impact"
	if success then
		particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack.vpcf"
	end
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self.location)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	StopSoundOn(sound_cast, self.caster)
	-- EmitSoundOnLocationWithCaster( self.location, sound_location, self.caster )
	EmitSoundOn(sound_location, self.caster)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_hoodwink_scurry_lua_buff", "heroes/hero_hoodwink/hero_hoodwink", LUA_MODIFIER_MOTION_NONE)

hoodwink_scurry_lua = class({})

function hoodwink_scurry_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_hoodwink_scurry_lua_buff", { duration = duration })
end

---------------------------------------------------------

modifier_hoodwink_scurry_lua_buff = class({})

function modifier_hoodwink_scurry_lua_buff:IsHidden()
	return false
end

function modifier_hoodwink_scurry_lua_buff:IsPurgable()
	return false
end

function modifier_hoodwink_scurry_lua_buff:OnCreated(kv)
	self.movespeed = self:GetAbility():GetSpecialValueFor("movement_speed_pct")
	self.evasion = self:GetAbility():GetSpecialValueFor("evasion")

	if not IsServer() then
		return
	end
	EmitSoundOn("Hero_Hoodwink.Scurry.Cast", self:GetParent())
end

function modifier_hoodwink_scurry_lua_buff:OnDestroy()
	if not IsServer() then
		return
	end
	EmitSoundOn("Hero_Hoodwink.Scurry.End", self:GetParent())
end

function modifier_hoodwink_scurry_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
	return funcs
end

function modifier_hoodwink_scurry_lua_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_hoodwink_scurry_lua_buff:GetModifierEvasion_Constant()
	return self.evasion
end

function modifier_hoodwink_scurry_lua_buff:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
	}
	return state
end

function modifier_hoodwink_scurry_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_hoodwink/hoodwink_scurry_aura.vpcf"
end

function modifier_hoodwink_scurry_lua_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

LinkLuaModifier("modifier_hoodwink_sharpshooter_lua", "heroes/hero_hoodwink/hero_hoodwink", LUA_MODIFIER_MOTION_NONE)

hoodwink_sharpshooter_lua = class({})

function hoodwink_sharpshooter_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	self.count = self:GetSpecialValueFor("count")

	-- caster:AddNewModifier(caster, self, "modifier_hoodwink_sharpshooter_lua", {duration  = self.count * 0.3})

	self.projectile_speed = self:GetSpecialValueFor("arrow_speed")
	self.projectile_range = self:GetSpecialValueFor("arrow_range")
	self.projectile_width = self:GetSpecialValueFor("arrow_width")

	self.current_count = 0

	local angles = {
		[1] = 0,
		[2] = 5,
		[3] = 355,
		[4] = 10,
		[5] = 350,
		[6] = 5,
		[7] = 355,
	}

	Timers:CreateTimer(0, function()
		if self.current_count < self.count then
			self.current_count = self.current_count + 1

			local velocity = RotatePosition(
				Vector(0, 0, 0),
				QAngle(0, angles[self.current_count], 0),
				caster:GetForwardVector()
			) * self.projectile_speed

			local info = {
				EffectName = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf",
				Ability = self,
				vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
				fStartRadius = self.projectile_width,
				fEndRadius = self.projectile_width,
				vVelocity = velocity,
				fDistance = self.projectile_range,
				Source = self:GetCaster(),
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iUnitTargetType = DOTA_UNIT_TARGET_BASIC,
				bDeleteOnHit = true,
				fExpireTime = GameRules:GetGameTime() + 3.0,
			}

			ProjectileManager:CreateLinearProjectile(info)
			EmitSoundOn("Hero_Hoodwink.Sharpshooter.Cast", self:GetCaster())

			return 0.2
		else
			return nil
		end
	end)
end

function hoodwink_sharpshooter_lua:OnProjectileHit(hTarget, vLocation)
	if not IsServer() then
		return
	end
	if hTarget then
		ApplyDamage({
			victim = hTarget,
			attacker = self:GetCaster(),
			ability = self,
			damage_type = self:GetAbilityDamageType(),
			damage = self:GetSpecialValueFor("damage"),
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
		})
	end
end

-----------------------------------------------------------------------------------

-- modifier_hoodwink_sharpshooter_lua = class({})

-- function modifier_hoodwink_sharpshooter_lua:IsHidden()
-- return false
-- end

-- function modifier_hoodwink_sharpshooter_lua:IsStunDebuff()
-- return false
-- end

-- function modifier_hoodwink_sharpshooter_lua:IsPurgable()
-- return false
-- end

-- function modifier_hoodwink_sharpshooter_lua:DeclareFunctions()
-- local funcs = {
-- MODIFIER_PROPERTY_DISABLE_TURNING,
-- MODIFIER_PROPERTY_MOVESPEED_LIMIT,
-- }
-- return funcs
-- end

-- function modifier_hoodwink_sharpshooter_lua:GetModifierMoveSpeed_Limit()
-- return 0.1
-- end

-- function modifier_hoodwink_sharpshooter_lua:GetModifierDisableTurning()
-- return 1
-- end

-- function modifier_hoodwink_sharpshooter_lua:CheckState()
-- local state = {
-- [MODIFIER_STATE_DISARMED] = true,
-- }
-- return state
-- end