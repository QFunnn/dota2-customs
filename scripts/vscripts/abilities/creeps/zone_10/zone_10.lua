--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_meat_hook_lua", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_creep_meat_hook_lua_self", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)

creep_meat_hook_lua = class({})

function creep_meat_hook_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_meat_hook_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_pudge/pudge_meathook.vpcf", context)
end

function creep_meat_hook_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	local projectile_name = ""
	local projectile_distance = self:GetSpecialValueFor("hook_distance")
	local projectile_speed = self:GetSpecialValueFor("hook_speed")
	local projectile_radius = self:GetSpecialValueFor("hook_width")

	local origin = caster:GetOrigin()
	local dir = point - origin
	dir.z = 0
	local projectile_direction = dir:Normalized()

	local target = origin + projectile_direction * projectile_distance

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),

		bDeleteOnHit = true,

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_radius,
		fEndRadius = projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
	}
	local id = ProjectileManager:CreateLinearProjectile(info)

	local data = {}
	data.cast_location = origin
	self.projectiles[id] = data

	local duration = projectile_distance / projectile_speed
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_creep_meat_hook_lua_self", -- modifier name
		{ duration = duration } -- kv
	)
	self:PlayEffects(target, data)
end

creep_meat_hook_lua.projectiles = {}

function creep_meat_hook_lua:OnProjectileHitHandle(target, location, handle)
	local data = self.projectiles[handle]
	if not data then
		return true
	end

	if not target then
		-- remove ref
		self.projectiles[handle] = nil

		-- set effects
		self:SetEffects1(data)

		return true
	end

	if target == self:GetCaster() then
		return false
	end

	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_creep_meat_hook_lua",
		{ handle = handle } -- kv
	)

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self,
		}
		ApplyDamage(damageTable)

		if target:IsCreep() and not target:IsCreepHero() and not target:IsAncient() then
			target:Kill(self, self:GetCaster())
		end
	end

	self:SetEffects2(data, target)
	return true
end

function creep_meat_hook_lua:PlayEffects(point, data)
	local particle_cast = "particles/units/heroes/hero_pudge/pudge_meathook.vpcf"
	local sound_cast = "Hero_Pudge.AttackHookExtend"
	local speed = self:GetSpecialValueFor("hook_speed")
	local distance = self:GetSpecialValueFor("hook_distance")
	local radius = self:GetSpecialValueFor("hook_width")
	local duration = distance / speed * 2

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl(effect_cast, 1, point)
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(speed, distance, radius))
	ParticleManager:SetParticleControl(effect_cast, 3, Vector(duration, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 4, Vector(1, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 5, Vector(0, 0, 0))
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		7,
		self:GetCaster(),
		PATTACH_CUSTOMORIGIN,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleAlwaysSimulate(effect_cast)
	ParticleManager:SetParticleShouldCheckFoW(effect_cast, false)

	-- Create Sound
	EmitSoundOn(sound_cast, self:GetCaster())

	-- store effect
	data.effect_cast = effect_cast
end

function creep_meat_hook_lua:SetEffects1(data)
	-- set return effect
	ParticleManager:SetParticleControlEnt(
		data.effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(data.effect_cast)

	EmitSoundOn("Hero_Pudge.AttackHookRetract", self:GetCaster())
end

function creep_meat_hook_lua:SetEffects2(data, target)
	-- set effects
	ParticleManager:SetParticleControlEnt(
		data.effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl(data.effect_cast, 4, Vector(0, 0, 0))
	ParticleManager:SetParticleControl(data.effect_cast, 5, Vector(1, 0, 0))

	EmitSoundOn("Hero_Pudge.AttackHookImpact", target)
	EmitSoundOn("Hero_Pudge.AttackHookRetract", self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_creep_meat_hook_lua = class({})

function modifier_creep_meat_hook_lua:IsHidden()
	return false
end

function modifier_creep_meat_hook_lua:IsDebuff()
	return self.enemy
end

function modifier_creep_meat_hook_lua:IsStunDebuff()
	return true
end

function modifier_creep_meat_hook_lua:IsPurgable()
	return true
end

function modifier_creep_meat_hook_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_creep_meat_hook_lua:RemoveOnDeath()
	return false
end

function modifier_creep_meat_hook_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.offset = 80
	self.threshold = 80
	self.speed = self:GetAbility():GetSpecialValueFor("hook_speed")

	if not IsServer() then
		return
	end

	-- get position data
	self.data = self.ability.projectiles[kv.handle]
	if not self.data then
		self.failed = true
		self:Destroy()
		return
	end
	self.origin = self.data.cast_location

	-- remove ref
	self.ability.projectiles[kv.handle] = nil

	-- get additional data
	self.enemy = self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber()
	self.stunned = self.enemy and (not self.parent:IsMagicImmune())
	self.interrupted = false

	-- calculate direction
	self.direction = self.origin - self.parent:GetOrigin()
	self.direction.z = 0

	self.distance = self.direction:Length2D() - self.offset
	self.direction = self.direction:Normalized()

	-- calculate duration
	self.duration = self.distance / self.speed
	self:SetDuration(self.duration, true)

	-- set facing direction
	self.parent:SetForwardVector(self.direction)

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self:GetParent():RemoveHorizontalMotionController(self)
	end
end

function modifier_creep_meat_hook_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self.failed then
		return
	end
	ParticleManager:DestroyParticle(self.data.effect_cast, true)
	ParticleManager:ReleaseParticleIndex(self.data.effect_cast)

	if not self.interrupted then
		self:GetParent():RemoveHorizontalMotionController(self)
	end

	FindClearSpaceForUnit(self.parent, self.origin - self.direction * self.offset, true)

	EmitSoundOn("Hero_Pudge.AttackHookRetractStop", self.caster)
end

function modifier_creep_meat_hook_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_creep_meat_hook_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_creep_meat_hook_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.stunned,
	}

	return state
end

function modifier_creep_meat_hook_lua:UpdateHorizontalMotion(me, dt)
	if self.interrupted then
		return
	end

	local nextpos = me:GetOrigin() + self.direction * self.speed * dt
	nextpos = GetGroundPosition(nextpos, me)
	me:SetOrigin(nextpos)

	if (self.caster:GetOrigin() - self.origin):Length2D() > self.threshold then
		ParticleManager:SetParticleControlEnt(
			self.data.effect_cast,
			0,
			self:GetCaster(),
			PATTACH_WORLDORIGIN,
			"attach_hitloc",
			self.origin, -- unknown
			true -- unknown, true
		)
		ParticleManager:SetParticleControl(self.data.effect_cast, 0, self.origin)
	end
end

function modifier_creep_meat_hook_lua:OnHorizontalMotionInterrupted()
	ParticleManager:SetParticleControlEnt(
		self.data.effect_cast,
		0,
		self:GetCaster(),
		PATTACH_WORLDORIGIN,
		"attach_hitloc",
		self.origin, -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.data.effect_cast,
		1,
		self:GetCaster(),
		PATTACH_WORLDORIGIN,
		"attach_hitloc",
		self.origin, -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl(self.data.effect_cast, 0, self.origin)
	ParticleManager:SetParticleControl(self.data.effect_cast, 1, self.origin)

	self:GetParent():RemoveHorizontalMotionController(self)
	self.interrupted = true
end

--------------------------------------------------------------------------------

modifier_creep_meat_hook_lua_self = class({})

function modifier_creep_meat_hook_lua_self:IsHidden()
	return true
end

function modifier_creep_meat_hook_lua_self:IsDebuff()
	return false
end

function modifier_creep_meat_hook_lua_self:IsPurgable()
	return false
end

function modifier_creep_meat_hook_lua_self:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_dismember_lua", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_dismember_lua_buff", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_dismember_lua_pull", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_HORIZONTAL)

creep_dismember_lua = class({})

function creep_dismember_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_pudge/pudge_dismember.vpcf", context)
end

function creep_dismember_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_dismember_lua:GetChannelTime()
	return 3
end

function creep_dismember_lua:OnSpellStart()
	if self:GetCaster():IsAlive() then
		self.target = self:GetCursorTarget()
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_creep_dismember_lua_buff", {})
		self.target:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_creep_dismember_lua",
			{ duration = self:GetChannelTime() - FrameTime() }
		)

		self.pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pudge/pudge_dismember.vpcf",
			PATTACH_ABSORIGIN,
			self.target
		)
		ParticleManager:SetParticleControlEnt(
			self.pfx,
			0,
			self:GetCaster(),
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			self:GetCaster():GetAbsOrigin(),
			true
		)
	end
end

function creep_dismember_lua:OnChannelFinish(bInterrupted)
	local target_buff = nil
	if self.target then
		target_buff = self.target:FindModifierByNameAndCaster("modifier_creep_dismember_lua", self:GetCaster())
		if bInterrupted then
			self.target:RemoveModifierByName("modifier_creep_dismember_lua")
		end
	end

	local caster_buff = self:GetCaster()
		:FindModifierByNameAndCaster("modifier_creep_dismember_lua_buff", self:GetCaster())

	if target_buff then
		target_buff:Destroy()
	end
	if caster_buff then
		caster_buff:Destroy()
	end

	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
end

--------------------------------------------------

modifier_creep_dismember_lua = class({})

function modifier_creep_dismember_lua:IgnoreTenacity()
	return true
end
function modifier_creep_dismember_lua:IsDebuff()
	return true
end
function modifier_creep_dismember_lua:IsHidden()
	return false
end

function modifier_creep_dismember_lua:OnCreated()
	self.dismember_damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	if IsServer() then
		self.standard_tick_interval = self:GetAbility():GetSpecialValueFor("tick")
		self.tick_interval = self.standard_tick_interval * (1 - self:GetParent():GetStatusResistance())
		self:StartIntervalThink(self.tick_interval)
		self:OnIntervalThink()
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_creep_dismember_lua_pull",
			{ duration = self:GetAbility():GetChannelTime() - FrameTime() }
		)
	end
end

function modifier_creep_dismember_lua:OnIntervalThink()
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dismember_damage / 2,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self:GetAbility(),
	}
	ApplyDamage(damageTable)
	if not self:GetCaster():IsAlive() then
		self:Destroy()
	end
end

function modifier_creep_dismember_lua:OnDestroy()
	if IsServer() then
		if self:GetCaster():IsChanneling() then
			self:GetAbility():EndChannel(false)
			self:GetCaster():MoveToPositionAggressive(self:GetParent():GetAbsOrigin())
		end
	end
end

function modifier_creep_dismember_lua:CheckState()
	local state = { [MODIFIER_STATE_STUNNED] = true }
	return state
end

function modifier_creep_dismember_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_creep_dismember_lua:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

----------------------------------------

modifier_creep_dismember_lua_buff = class({})

function modifier_creep_dismember_lua_buff:IsDebuff()
	return false
end
function modifier_creep_dismember_lua_buff:IsHidden()
	return true
end
function modifier_creep_dismember_lua_buff:IsPurgable()
	return false
end
function modifier_creep_dismember_lua_buff:IsStunDebuff()
	return false
end

function modifier_creep_dismember_lua_buff:DeclareFunctions()
	local table = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
	return table
end

function modifier_creep_dismember_lua_buff:GetActivityTranslationModifiers()
	if self:GetCaster():HasItemInInventory("item_imba_aether_lens") then
		return "long_dismember"
	else
		return ""
	end
end

function modifier_creep_dismember_lua_buff:GetOverrideAnimation()
	return ACT_DOTA_CHANNEL_ABILITY_4
end

-------------------------------------------------------------------------------------

modifier_creep_dismember_lua_pull = class({})

function modifier_creep_dismember_lua_pull:OnCreated(params)
	if not IsServer() then
		return
	end

	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self.pull_units_per_second = 75
	self.pull_distance_limit = 125

	if self:ApplyHorizontalMotionController() == false then
		self:Destroy()
		return
	end
end

function modifier_creep_dismember_lua_pull:UpdateHorizontalMotion(me, dt)
	if not IsServer() then
		return
	end

	local distance = self.caster:GetOrigin() - me:GetOrigin()

	if distance:Length2D() > self.pull_distance_limit and self.parent:HasModifier("modifier_creep_dismember_lua") then
		me:SetOrigin(me:GetOrigin() + distance:Normalized() * self.pull_units_per_second * dt)
	else
		self:Destroy()
	end
end

function modifier_creep_dismember_lua_pull:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveHorizontalMotionController(self)
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_rot_lua", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_rot_lua_effect", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)

creep_rot_lua = class({})

function creep_rot_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_pudge/pudge_rot.vpcf", context)
end

function creep_rot_lua:GetIntrinsicModifierName()
	return "modifier_creep_rot_lua"
end

-------------------------------------------------------------------------------------

modifier_creep_rot_lua = class({})

function modifier_creep_rot_lua:IsHidden()
	return false
end
function modifier_creep_rot_lua:IsPurgable()
	return false
end

function modifier_creep_rot_lua:OnCreated(kv)
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.rot_radius = self.ability:GetSpecialValueFor("radius")
	self.rot_damage_pct = self.ability:GetSpecialValueFor("damage")
	self.rot_tick = 0.5

	if IsServer() then
		self.damage_per_tick = (self.rot_damage_pct / 100) * self.rot_tick
		self.parent:EmitSound("Hero_Pudge.Rot")

		self.pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pudge/pudge_rot.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.rot_radius, 1, self.rot_radius))
		self:AddParticle(self.pfx, false, false, -1, false, false)

		self:StartIntervalThink(self.rot_tick)
	end
end

function modifier_creep_rot_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self.parent:IsAlive() then
		return
	end

	local damage_per_tick = self.damage_per_tick

	local units = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		self.rot_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)

	for _, u in pairs(units) do
		ApplyDamage({
			victim = u,
			attacker = self.parent,
			damage = u:GetMaxHealth() * damage_per_tick,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
		u:AddNewModifier(self.parent, self.ability, "modifier_creep_rot_lua_effect", { duration = 3.0 })
	end
end

function modifier_creep_rot_lua:OnDestroy()
	if IsServer() then
		if self.parent and not self.parent:IsNull() and not self.parent:IsAlive() then
			self.parent:StopSound("Hero_Pudge.Rot")
		end
		if self.pfx then
			ParticleManager:DestroyParticle(self.pfx, true)
			ParticleManager:ReleaseParticleIndex(self.pfx)
		end
	end
end
-------------------------------------------------------------------------------------

modifier_creep_rot_lua_effect = class({})

function modifier_creep_rot_lua_effect:IsHidden()
	return false
end
function modifier_creep_rot_lua_effect:IsDebuff()
	return true
end
function modifier_creep_rot_lua_effect:IsPurgable()
	return true
end

function modifier_creep_rot_lua_effect:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.tick_counter = 0
	self:SetStackCount(1)
end

function modifier_creep_rot_lua_effect:OnRefresh(kv)
	if not IsServer() then
		return
	end

	self:SetDuration(3.0, true)

	self.tick_counter = self.tick_counter + 1
	if self.tick_counter >= 2 then
		self:IncrementStackCount()
		self.tick_counter = 0
	end
end

function modifier_creep_rot_lua_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_creep_rot_lua_effect:GetModifierBonusStats_Strength()
	return -self:GetStackCount()
end

function modifier_creep_rot_lua_effect:GetModifierBonusStats_Agility()
	return -self:GetStackCount()
end

function modifier_creep_rot_lua_effect:GetModifierBonusStats_Intellect()
	return -self:GetStackCount()
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_spider_egg_lua", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)

creep_spider_egg_lua = class({})

function creep_spider_egg_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf", context)
end

function creep_spider_egg_lua:GetIntrinsicModifierName()
	return "modifier_creep_spider_egg_lua"
end

-------------------------------------------------------------------------

modifier_creep_spider_egg_lua = class({})

function modifier_creep_spider_egg_lua:IsHidden()
	return true
end

function modifier_creep_spider_egg_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = false,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
	return state
end

function modifier_creep_spider_egg_lua:OnCreated(kv)
	if IsServer() then
		local caster = self:GetCaster()
		if not caster:HasModifier("modifier_boss_damage_boost") then
			caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
		end

		self.spider_min = self:GetAbility():GetSpecialValueFor("spider_min")
		self.spider_max = self:GetAbility():GetSpecialValueFor("spider_max")
		self.trigger_radius = self:GetAbility():GetSpecialValueFor("trigger_radius")
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
			+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self:StartIntervalThink(0.5)
	end
end

function modifier_creep_spider_egg_lua:OnIntervalThink()
	if IsServer() then
		local enemies = _G.OldFindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			self:GetParent(),
			self.trigger_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			0,
			false
		)
		if #enemies > 0 then
			self:Burst()
			self:StartIntervalThink(-1)
		end
	end
end

function modifier_creep_spider_egg_lua:Burst()
	if IsServer() then
		for i = 0, RandomInt(self.spider_min, self.spider_max) do
			local hUnit = CreateUnitByName(
				"npc_zone_10_creep_2_minion",
				self:GetParent():GetOrigin(),
				true,
				nil,
				nil,
				self:GetParent():GetTeamNumber()
			)

			if self:GetParent().solo_event_player_id then
				hUnit.solo_event_player_id = self:GetParent().solo_event_player_id
			end
		end

		local nFXIndex = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(nFXIndex, 0, self:GetParent():GetOrigin())
		ParticleManager:SetParticleControl(nFXIndex, 1, Vector(self.radius / 2, 0.4, self.radius))
		ParticleManager:ReleaseParticleIndex(nFXIndex)

		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			self:GetParent(),
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			0,
			false
		)
		for _, enemy in pairs(enemies) do
			if enemy ~= nil then
				ApplyDamage({
					victim = enemy,
					attacker = self:GetCaster(),
					damage = self.damage,
					damage_type = DAMAGE_TYPE_PURE,
				})
			end
		end

		EmitSoundOn("Hero_Broodmother.SpawnSpiderlings", self:GetParent())
		EmitSoundOn("EggSack.Burst", self:GetParent())
		self:GetParent():AddNoDraw()
		self:GetParent():ForceKill(false)
	end
end

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
LinkLuaModifier("modifier_creep_nightmare_lua", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)

creep_nightmare_lua = class({})

function creep_nightmare_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then
		return
	end
	local duration = self:GetSpecialValueFor("duration")

	target:AddNewModifier(caster, self, "modifier_creep_nightmare_lua", { duration = duration })
end

--------------------------------------------------------------------------------------

modifier_creep_nightmare_lua = class({})

function modifier_creep_nightmare_lua:IsHidden()
	return false
end
function modifier_creep_nightmare_lua:IsDebuff()
	return true
end
function modifier_creep_nightmare_lua:IsPurgable()
	return true
end

function modifier_creep_nightmare_lua:OnCreated(kv)
	self.inv_time = self:GetAbility():GetSpecialValueFor("nightmare_invuln_time")
	self.anim_rate = self:GetAbility():GetSpecialValueFor("animation_rate")
	self.pull_speed = self:GetAbility():GetSpecialValueFor("pull_speed")

	if IsServer() then
		self.caster = self:GetCaster()
		self.parent = self:GetParent()
		self.invulnerable = true

		Timers:CreateTimer(self.inv_time, function()
			self.invulnerable = false
		end)

		EmitSoundOn("Hero_Bane.Nightmare", self.parent)
		EmitSoundOn("Hero_Bane.Nightmare.Loop", self.parent)
		self:StartIntervalThink(0.03)
	end
end

function modifier_creep_nightmare_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.caster and self.caster:IsAlive() then
		local target_pos = self.caster:GetAbsOrigin()
		local parent_pos = self.parent:GetAbsOrigin()
		local direction = target_pos - parent_pos
		direction.z = 0

		if direction:Length2D() > 150 then
			direction = direction:Normalized()
			self.parent:SetAbsOrigin(parent_pos + direction * (self.pull_speed * 0.03))
			self.parent:SetForwardVector(direction)
		end
	end
end

function modifier_creep_nightmare_lua:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("Hero_Bane.Nightmare.Loop", self:GetParent())

	if not self.transfer then
		EmitSoundOn("Hero_Bane.Nightmare.End", self:GetParent())
	end
	ResolveNPCPositions(self:GetParent():GetAbsOrigin(), 128)
end

function modifier_creep_nightmare_lua:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = self.invulnerable,
		[MODIFIER_STATE_NIGHTMARED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_creep_nightmare_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
end

function modifier_creep_nightmare_lua:GetModifierMoveSpeed_Absolute()
	return 0.1
end

function modifier_creep_nightmare_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_creep_nightmare_lua:GetOverrideAnimationRate()
	return self.anim_rate
end

function modifier_creep_nightmare_lua:GetEffectName()
	return "particles/units/heroes/hero_bane/bane_nightmare.vpcf"
end

function modifier_creep_nightmare_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_midnight_lua_thinker", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)

creep_midnight_lua = class({})

function creep_midnight_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf", context)
end

function creep_midnight_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_midnight_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_creep_midnight_lua_thinker", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end

----------------------------------------------------------------------------

modifier_creep_midnight_lua_thinker = class({})

function modifier_creep_midnight_lua_thinker:IsHidden()
	return true
end

function modifier_creep_midnight_lua_thinker:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	local interval = 1

	if IsServer() then
		self.damageTable = {
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(),
		}
		self:StartIntervalThink(interval)
		self:PlayEffects()
	end
end

function modifier_creep_midnight_lua_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove(self:GetParent())
	end
end

function modifier_creep_midnight_lua_thinker:OnIntervalThink()
	if not IsServer() then
		return
	end
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		self:GetParent(), -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)
	end
end

function modifier_creep_midnight_lua_thinker:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
	EmitSoundOn("Hero_Enigma.Midnight_Pulse", self:GetParent())
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_poison_sting_lua", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_poison_sting_lua_debuff", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)

creep_poison_sting_lua = class({})

function creep_poison_sting_lua:GetIntrinsicModifierName()
	return "modifier_creep_poison_sting_lua"
end

--------------------------------------------------------------------------------------------------

modifier_creep_poison_sting_lua = class({})

function modifier_creep_poison_sting_lua:IsHidden()
	return true
end

function modifier_creep_poison_sting_lua:IsDebuff()
	return false
end

function modifier_creep_poison_sting_lua:IsStunDebuff()
	return false
end

function modifier_creep_poison_sting_lua:IsPurgable()
	return false
end

function modifier_creep_poison_sting_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.team = self:GetCaster():GetTeamNumber()

	self.duration = self:GetAbility():GetSpecialValueFor("duration")

	if not IsServer() then
		return
	end

	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
end

function modifier_creep_poison_sting_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_creep_poison_sting_lua:OnRemoved() end

function modifier_creep_poison_sting_lua:OnDestroy() end

function modifier_creep_poison_sting_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_creep_poison_sting_lua:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	if self.caster:PassivesDisabled() then
		return
	end

	local filter =
		UnitFilter(params.target, self.abilityTargetTeam, self.abilityTargetType, self.abilityTargetFlags, self.team)
	if filter ~= UF_SUCCESS then
		return
	end

	params.target:AddNewModifier(
		self.caster, -- player source
		self.ability, -- ability source
		"modifier_creep_poison_sting_lua_debuff", -- modifier name
		{ duration = self.duration } -- kv
	)
end

--------------------------------------------------------------------

modifier_creep_poison_sting_lua_debuff = class({})

function modifier_creep_poison_sting_lua_debuff:IsHidden()
	return false
end

function modifier_creep_poison_sting_lua_debuff:IsDebuff()
	return true
end

function modifier_creep_poison_sting_lua_debuff:IsStunDebuff()
	return false
end

function modifier_creep_poison_sting_lua_debuff:IsPurgable()
	return true
end

function modifier_creep_poison_sting_lua_debuff:OnCreated(kv)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	local damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.slow = self:GetAbility():GetSpecialValueFor("movement_speed")

	if not IsServer() then
		return
	end

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_HPLOSS,
	}
	self:StartIntervalThink(1)
	self:OnIntervalThink()
end

function modifier_creep_poison_sting_lua_debuff:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_creep_poison_sting_lua_debuff:OnRemoved() end

function modifier_creep_poison_sting_lua_debuff:OnDestroy() end

function modifier_creep_poison_sting_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_creep_poison_sting_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_creep_poison_sting_lua_debuff:OnIntervalThink()
	local actual_damage = ApplyDamage(self.damageTable)
	if actual_damage > 0 then
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self.parent, actual_damage, self.caster)
	end
end

function modifier_creep_poison_sting_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff.vpcf"
end

function modifier_creep_poison_sting_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------
--------------------------------------------------------------------

LinkLuaModifier("modifier_creep_gale_lua", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)

creep_gale_lua = class({})

function creep_gale_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_gale_lua:Spawn()
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

function creep_gale_lua:OnSpellStart()
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

function creep_gale_lua:OnProjectileHit(target, location)
	if not target then
		return
	end

	local duration = self:GetSpecialValueFor("duration")

	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_creep_gale_lua", -- modifier name
		{ duration = duration } -- kv
	)
	self:PlayEffects(target)
end

function creep_gale_lua:PlayEffects(target)
	local effect_cast = ParticleManager:CreateParticle(self.particles[2], PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(self.sounds[2], target)
end

--------------------------------------------------------------------

modifier_creep_gale_lua = class({})

function modifier_creep_gale_lua:IsHidden()
	return false
end

function modifier_creep_gale_lua:IsDebuff()
	return true
end

function modifier_creep_gale_lua:IsStunDebuff()
	return false
end

function modifier_creep_gale_lua:IsPurgable()
	return true
end

function modifier_creep_gale_lua:OnCreated(kv)
	self.particles = self:GetAbility().particles
	self.sounds = self:GetAbility().sounds
	self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	self.tick_damage = self:GetAbility():GetSpecialValueFor("tick_damage")
	self.init_damage = self:GetAbility():GetSpecialValueFor("strike_damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
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
		ability = self:GetAbility(), --Optional.
	}

	ApplyDamage(self.damageTable)

	self.damageTable.damage = self.tick_damage

	self:StartIntervalThink(self.tick_interval)
end

function modifier_creep_gale_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_creep_gale_lua:GetModifierMoveSpeedBonus_Percentage()
	local time = (GameRules:GetGameTime() - self:GetLastAppliedTime())
	local slow = math.min(0, self.slow + time / self.slow_tick)
	return slow
end

function modifier_creep_gale_lua:OnIntervalThink()
	local actual_damage = ApplyDamage(self.damageTable)
	if actual_damage > 0 then
		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
			self:GetParent(),
			actual_damage,
			self:GetCaster():GetPlayerOwner()
		)
	end
end

function modifier_creep_gale_lua:GetEffectName()
	return self.particles[3]
end

function modifier_creep_gale_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------
--------------------------------------------------------------------

creep_summon_eggs_lua = class({})

function creep_summon_eggs_lua:OnSpellStart()
	if IsServer() then
		local nEggSpawns = self:GetSpecialValueFor("count")
		for i = 1, nEggSpawns do
			local hEgg = CreateUnitByName(
				"npc_dota_zone_10_unit_2",
				self:GetCaster():GetAbsOrigin(),
				true,
				self:GetCaster(),
				self:GetCaster(),
				self:GetCaster():GetTeamNumber()
			)

			if self:GetCaster().solo_event_player_id then
				hEgg.solo_event_player_id = self:GetCaster().solo_event_player_id
			end

			if hEgg ~= nil then
				local vRandomOffset = Vector(RandomInt(-600, 600), RandomInt(-600, 600), 0)
				local vSpawnPoint = self:GetCaster():GetAbsOrigin() + vRandomOffset
				FindClearSpaceForUnit(hEgg, vSpawnPoint, true)

				-- local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_visage/visage_summon_familiars.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
				-- ParticleManager:SetParticleControl( nFXIndex, 0, vSpawnPoint )
				-- ParticleManager:ReleaseParticleIndex( nFXIndex )
			end
		end
	end
end

--------------------------------------------------------------------
--------------------------------------------------------------------

LinkLuaModifier("modifier_creep_spider_spray_lua", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_spider_spray_lua_stack", "abilities/creeps/zone_10/zone_10", LUA_MODIFIER_MOTION_NONE)

creep_spider_spray_lua = class({})

function creep_spider_spray_lua:GetIntrinsicModifierName()
	return "modifier_creep_spider_spray_lua"
end

--------------------------------------------------------------------

modifier_creep_spider_spray_lua = class({})

function modifier_creep_spider_spray_lua:IsHidden()
	return true
end

function modifier_creep_spider_spray_lua:IsDebuff()
	return false
end

function modifier_creep_spider_spray_lua:IsPurgable()
	return false
end

function modifier_creep_spider_spray_lua:OnCreated()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end

	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.stack_damage = self:GetAbility():GetSpecialValueFor("stack_damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.base_damage = self:GetAbility():GetSpecialValueFor("damage")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_creep_spider_spray_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_creep_spider_spray_lua:OnDeath(keys)
	if not IsServer() then
		return
	end
	if self:GetParent() == keys.unit then
		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			self:GetParent(),
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			0,
			false
		)
		local damageTable = {
			attacker = self:GetParent(),
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}

		for _, enemy in pairs(enemies) do
			local stack = 0
			local modifier = enemy:FindModifierByName("modifier_creep_spider_spray_lua_stack")
			if modifier ~= nil then
				stack = modifier:GetStackCount()
				modifier:IncrementStackCount()
			end
			damageTable.victim = enemy
			damageTable.damage = self.base_damage + stack * self.stack_damage
			ApplyDamage(damageTable)

			if modifier == nil then
				local mod = enemy:AddNewModifier(
					self:GetParent(),
					self,
					"modifier_creep_spider_spray_lua_stack",
					{ duration = self.duration }
				)
				mod:IncrementStackCount()
			end
		end
		self:PlayEffects()
	end
end

function modifier_creep_spider_spray_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_alchemist/alchemist_acid_spray_c.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))

	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
	EmitSoundOn("Hero_Alchemist.AcidSpray", self:GetParent())
end

-----------------------------------------------------------

modifier_creep_spider_spray_lua_stack = class({})

function modifier_creep_spider_spray_lua_stack:IsHidden()
	return false
end

function modifier_creep_spider_spray_lua_stack:IsPurgable()
	return false
end