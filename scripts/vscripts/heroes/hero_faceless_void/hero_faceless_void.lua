--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_time_walk_lua_damage_counter",
	"heroes/hero_faceless_void/hero_faceless_void",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_time_walk_lua_buff_as",
	"heroes/hero_faceless_void/hero_faceless_void",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_time_walk_lua_buff_ms",
	"heroes/hero_faceless_void/hero_faceless_void",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_time_walk_lua_cast",
	"heroes/hero_faceless_void/hero_faceless_void",
	LUA_MODIFIER_MOTION_HORIZONTAL
)
LinkLuaModifier("modifier_time_walk_lua_slow", "heroes/hero_faceless_void/hero_faceless_void", LUA_MODIFIER_MOTION_NONE)

time_walk_lua = class({})

function time_walk_lua:IsHiddenWhenStolen()
	return false
end
function time_walk_lua:IsNetherWardStealable()
	return false
end

function time_walk_lua:GetIntrinsicModifierName()
	if not self:GetCaster():IsIllusion() then
		return "modifier_time_walk_lua_damage_counter"
	end
end

function time_walk_lua:GetBehavior()
	if not self:GetCaster():HasScepter() then
		return self.BaseClass.GetBehavior(self)
	else
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + DOTA_ABILITY_BEHAVIOR_AOE
	end
end

function time_walk_lua:GetAOERadius()
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor("slow_radius")
	end
end

function time_walk_lua:GetCastAnimation()
	return ACT_DOTA_FLINCH
end

function time_walk_lua:OnAbilityPhaseStart()
	self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_1)
	return true
end

function time_walk_lua:GetCastRange(location, target)
	if IsClient() then
		local cast_range = self:GetSpecialValueFor("range") + self:GetCaster():GetCastRangeBonus()
		return cast_range
	end
end

function time_walk_lua:OnSpellStart()
	local caster = self:GetCaster()
	local slow_radius = self:GetSpecialValueFor("slow_radius")
	local position = self:GetCursorPosition()
	self.old_position = caster:GetAbsOrigin()

	caster:EmitSound("Hero_FacelessVoid.TimeWalk")

	local max_cast_range = self:GetSpecialValueFor("range") + caster:GetCastRangeBonus()

	caster:AddNewModifier(caster, self, "modifier_time_walk_lua_cast", {
		duration = math.min((position - caster:GetAbsOrigin()):Length2D(), max_cast_range) / self:GetSpecialValueFor(
			"speed"
		) + 0.5,
		x = position.x,
		y = position.y,
		z = position.z,
	})

	if caster.time_walk_damage_taken then
		caster:Heal(caster.time_walk_damage_taken, self)
	end

	local aoe_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_faceless_void/faceless_void_time_walk_slow.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(aoe_pfx, 1, Vector(slow_radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(aoe_pfx)
	ProjectileManager:ProjectileDodge(caster)
end

--------------------------------------------------------------------------------

modifier_time_walk_lua_damage_counter = class({})

function modifier_time_walk_lua_damage_counter:IsPurgable()
	return false
end
function modifier_time_walk_lua_damage_counter:IsDebuff()
	return false
end
function modifier_time_walk_lua_damage_counter:IsHidden()
	return true
end
function modifier_time_walk_lua_damage_counter:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end

function modifier_time_walk_lua_damage_counter:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.damage_time = self.ability:GetSpecialValueFor("backtrack_duration")

	if IsServer() then
		if not self.caster.time_walk_damage_taken then
			self.caster.time_walk_damage_taken = 0
		end
	end
end

function modifier_time_walk_lua_damage_counter:OnTakeDamage(keys)
	if IsServer() then
		if keys.unit == self.caster then
			local damage_taken = keys.damage
			self.caster.time_walk_damage_taken = self.caster.time_walk_damage_taken + damage_taken
			Timers:CreateTimer(self.damage_time, function()
				if self.caster.time_walk_damage_taken then
					self.caster.time_walk_damage_taken = self.caster.time_walk_damage_taken - damage_taken
				end
			end)
		end
	end
end

--------------------------------------------------------------------------------

modifier_time_walk_lua_buff_as = class({})
function modifier_time_walk_lua_buff_as:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_time_walk_lua_buff_as:IsPurgable()
	return false
end
function modifier_time_walk_lua_buff_as:IsDebuff()
	return false
end
function modifier_time_walk_lua_buff_as:IsHidden()
	return true
end
function modifier_time_walk_lua_buff_as:DeclareFunctions()
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end
function modifier_time_walk_lua_buff_as:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount()
end

modifier_time_walk_lua_buff_ms = class({})
function modifier_time_walk_lua_buff_ms:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_time_walk_lua_buff_ms:IsPurgable()
	return false
end
function modifier_time_walk_lua_buff_ms:IsDebuff()
	return false
end
function modifier_time_walk_lua_buff_ms:IsHidden()
	return true
end
function modifier_time_walk_lua_buff_ms:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function modifier_time_walk_lua_buff_ms:GetModifierMoveSpeedBonus_Constant()
	return self:GetStackCount()
end

--------------------------------------------------------------------------------

modifier_time_walk_lua_cast = class({})

function modifier_time_walk_lua_cast:IsPurgable()
	return false
end
function modifier_time_walk_lua_cast:IsDebuff()
	return false
end
function modifier_time_walk_lua_cast:IsHidden()
	return true
end
function modifier_time_walk_lua_cast:IgnoreTenacity()
	return true
end

function modifier_time_walk_lua_cast:GetEffectName()
	return "particles/units/heroes/hero_faceless_void/faceless_void_time_walk.vpcf"
end
function modifier_time_walk_lua_cast:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_time_walk_lua_cast:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_time_walk_lua_cast:OnCreated(params)
	if IsServer() then
		self.parent = self:GetParent()
		local ability = self:GetAbility()

		self.pos = Vector(params.x, params.y, params.z)
		local start_pos = self.parent:GetAbsOrigin()

		local range = ability:GetSpecialValueFor("range") + self.parent:GetCastRangeBonus()
		local direction = self.pos - start_pos
		direction.z = 0

		local distance = direction:Length2D()
		if distance > range then
			distance = range
		end

		self.speed = ability:GetSpecialValueFor("speed")
		self.direction = direction:Normalized()
		self.distance_traveled = 0
		self.distance = distance

		self.as_stolen = 0
		self.ms_stolen = 0
		self.slow_radius = ability:GetSpecialValueFor("slow_radius")

		self.obs = Entities:FindAllByClassname("point_simple_obstruction")

		if not self:ApplyHorizontalMotionController() then
			self:Destroy()
			return
		end

		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_faceless_void/faceless_void_time_walk_preimage.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(particle, 0, start_pos)
		ParticleManager:SetParticleControl(particle, 1, start_pos + self.direction * distance)
		ParticleManager:SetParticleControlEnt(
			particle,
			2,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			self.parent:GetForwardVector(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle)

		self:StartIntervalThink(FrameTime())
	end
end

function modifier_time_walk_lua_cast:UpdateHorizontalMotion(me, dt)
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

	local obstraction = false
	if self.obs then
		for i = 1, #self.obs do
			local dist = (my_pos - self.obs[i]:GetAbsOrigin()):Length2D()
			if dist < 150 then
				obstraction = true
			end
		end
	end

	local isTraversable = GridNav:IsTraversable(my_pos)
	if isTraversable == false or obstraction == true then
		self:OnDestroy()
		return
	end

	me:SetOrigin(next_pos)
	me:FaceTowards(self.pos)
end

function modifier_time_walk_lua_cast:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_time_walk_lua_cast:OnIntervalThink()
	if not IsServer() then
		return
	end

	local ability = self:GetAbility()
	local caster = self:GetParent()
	local aoe = self.slow_radius
	local duration = ability:GetSpecialValueFor("duration")
	local as_steal = ability:GetSpecialValueFor("as_steal")
	local ms_steal = ability:GetSpecialValueFor("ms_steal")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		aoe,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if not enemy:HasModifier("modifier_time_walk_lua_slow") then
			self.as_stolen = self.as_stolen + as_steal
			self.ms_stolen = self.ms_stolen + ms_steal

			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_faceless_void/faceless_void_backtrack02.vpcf",
				PATTACH_ABSORIGIN,
				enemy
			)
			ParticleManager:ReleaseParticleIndex(pfx)

			enemy:AddNewModifier(
				caster,
				ability,
				"modifier_time_walk_lua_slow",
				{ duration = duration * (1 - enemy:GetStatusResistance()) }
			)
		end
	end
end

function modifier_time_walk_lua_cast:OnDestroy()
	if not IsServer() then
		return
	end

	self.parent:RemoveHorizontalMotionController(self)
	FindClearSpaceForUnit(self.parent, self.parent:GetOrigin(), true)

	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()

	parent:InterruptMotionControllers(true)

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_faceless_void_5")
	if talent and talent:GetLevel() > 0 then
		local duration = ability:GetSpecialValueFor("duration")
		local as_buff =
			caster:AddNewModifier(caster, ability, "modifier_time_walk_lua_buff_as", { duration = duration })
		local ms_buff =
			caster:AddNewModifier(caster, ability, "modifier_time_walk_lua_buff_ms", { duration = duration })
		if as_buff then
			as_buff:SetStackCount(self.as_stolen)
		end
		if ms_buff then
			ms_buff:SetStackCount(self.ms_stolen)
		end
	end

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_faceless_void_6")
	if talent and talent:GetLevel() > 0 then
		local lock_mod_name = caster:FindModifierByName("modifier_time_lock_lua")
		local lock_ability = caster:FindAbilityByName("time_lock_lua")

		local final_enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			parent:GetAbsOrigin(),
			nil,
			self.slow_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		for _, enemy in pairs(final_enemies) do
			if lock_ability and lock_ability:GetLevel() > 0 then
				lock_mod_name:ApplyTimeLock(lock_ability, enemy)
			end
		end
	end

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_faceless_void/faceless_void_time_walk_slow.vpcf",
		PATTACH_ABSORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(self.slow_radius, self.slow_radius, self.slow_radius))
	ParticleManager:ReleaseParticleIndex(pfx)

	parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
	ResolveNPCPositions(parent:GetAbsOrigin(), 128)
end

--------------------------------------------------------------------------------

modifier_time_walk_lua_slow = class({})

function modifier_time_walk_lua_slow:IsPurgable()
	return true
end
function modifier_time_walk_lua_slow:IsHidden()
	return false
end
function modifier_time_walk_lua_slow:IsDebuff()
	return true
end
function modifier_time_walk_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_faceless_void/faceless_void_time_walk_debuff.vpcf"
end
function modifier_time_walk_lua_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_time_walk_lua_slow:OnCreated()
	self.ms_steal = self:GetAbility():GetSpecialValueFor("ms_steal") * -1
	self.as_steal = self:GetAbility():GetSpecialValueFor("as_steal") * -1
end

function modifier_time_walk_lua_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_time_walk_lua_slow:GetModifierMoveSpeedBonus_Constant()
	return self.ms_steal
end
function modifier_time_walk_lua_slow:GetModifierAttackSpeedBonus_Constant()
	return self.as_steal
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_backtrack_lua", "heroes/hero_faceless_void/hero_faceless_void", LUA_MODIFIER_MOTION_NONE)

backtrack_lua = class({})

function backtrack_lua:GetIntrinsicModifierName()
	return "modifier_backtrack_lua"
end

--------------------------------------------------------------------------------

modifier_backtrack_lua = class({})

function modifier_backtrack_lua:IsHidden()
	return true
end

function modifier_backtrack_lua:IsPurgable()
	return false
end

function modifier_backtrack_lua:RemoveOnDeath()
	return false
end

function modifier_backtrack_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.chance = self.ability:GetSpecialValueFor("chance")
end

function modifier_backtrack_lua:OnRefresh(kv)
	if IsServer() then
		self.chance = self.ability:GetSpecialValueFor("chance")
	end
end

function modifier_backtrack_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_backtrack_lua:GetModifierIncomingDamage_Percentage()
	if RollPercentage(self.chance) then
		local backtrack_fx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf",
			PATTACH_ABSORIGIN,
			self.caster
		)
		ParticleManager:SetParticleControl(backtrack_fx, 0, self.caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(backtrack_fx)
		return -100
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_time_lock_lua", "heroes/hero_faceless_void/hero_faceless_void", LUA_MODIFIER_MOTION_NONE)

time_lock_lua = class({})

function time_lock_lua:GetIntrinsicModifierName()
	return "modifier_time_lock_lua"
end

--------------------------------------------------------------------------------

modifier_time_lock_lua = class({})

function modifier_time_lock_lua:IsHidden()
	return true
end

function modifier_time_lock_lua:IsPurgable()
	return false
end

function modifier_time_lock_lua:RemoveOnDeath()
	return false
end

function modifier_time_lock_lua:OnCreated(kv)
	self.caster = self:GetCaster()
end

function modifier_time_lock_lua:OnRefresh(kv) end

function modifier_time_lock_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_time_lock_lua:OnAttackLanded(event)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local attacker = event.attacker
	local target = event.target

	if not attacker or attacker:IsNull() then
		return
	end
	if attacker ~= parent then
		return
	end
	if parent:PassivesDisabled() or parent:IsIllusion() then
		return
	end
	if not target or target:IsNull() then
		return
	end
	if target:IsOther() or target:IsInvulnerable() then
		return
	end

	if RollPercentage(ability:GetSpecialValueFor("chance")) then
		self:ApplyTimeLock(ability, target)
		self.c = 0
	end
end

function modifier_time_lock_lua:ApplyTimeLock(ability, target)
	if not ability then
		ability = self:GetAbility()
	end
	if not target then
		return
	end
	local parent = self:GetParent()
	local duration = ability:GetSpecialValueFor("duration")

	target:AddNewModifier(parent, ability, "modifier_stunned", { duration = duration })
	target:EmitSound("Hero_FacelessVoid.TimeLockImpact")

	local damage = ability:GetSpecialValueFor("damage")

	local damage_table = {}
	damage_table.attacker = parent
	damage_table.damage_type = ability:GetAbilityDamageType()
	damage_table.ability = ability
	damage_table.damage = damage
	damage_table.victim = target

	ApplyDamage(damage_table)

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		particle,
		2,
		parent,
		PATTACH_CUSTOMORIGIN,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	Timers:CreateTimer(0.3, function()
		if target:IsAlive() and not target:IsNull() and self.c == 0 then
			parent:PerformAttack(target, false, true, true, false, false, false, false)
			target:EmitSound("Hero_FacelessVoid.TimeLockImpact")
			self.c = 1
		end
	end)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_faceless_void_chronosphere_lua_thinker",
	"heroes/hero_faceless_void/hero_faceless_void",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_faceless_void_chronosphere_lua_effect",
	"heroes/hero_faceless_void/hero_faceless_void",
	LUA_MODIFIER_MOTION_NONE
)

faceless_void_chronosphere_lua = class({})

function faceless_void_chronosphere_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function faceless_void_chronosphere_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_faceless_void_1")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 40
	end
	return self.BaseClass.GetCooldown(self, level)
end

function faceless_void_chronosphere_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")

	self.thinker = CreateModifierThinker(
		caster,
		self,
		"modifier_faceless_void_chronosphere_lua_thinker",
		{ duration = duration },
		point,
		caster:GetTeamNumber(),
		false
	)
	-- self.thinker = self.thinker:FindModifierByName("modifier_faceless_void_chronosphere_lua_thinker")

	AddFOWViewer(self:GetCaster():GetTeamNumber(), point, radius, duration, false)
end

--------------------------------------------------------------------------------------------------

modifier_faceless_void_chronosphere_lua_thinker = class({})

function modifier_faceless_void_chronosphere_lua_thinker:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_faceless_void_chronosphere_lua_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove(self:GetParent())
	end
end

function modifier_faceless_void_chronosphere_lua_thinker:CheckState()
	local state = {
		[MODIFIER_STATE_FROZEN] = true,
	}
	return state
end

function modifier_faceless_void_chronosphere_lua_thinker:IsAura()
	return true
end

function modifier_faceless_void_chronosphere_lua_thinker:GetModifierAura()
	return "modifier_faceless_void_chronosphere_lua_effect"
end

function modifier_faceless_void_chronosphere_lua_thinker:GetAuraRadius()
	return self.radius
end

function modifier_faceless_void_chronosphere_lua_thinker:GetAuraDuration()
	return 0.01
end

function modifier_faceless_void_chronosphere_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_faceless_void_chronosphere_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end

function modifier_faceless_void_chronosphere_lua_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_faceless_void_chronosphere_lua_thinker:GetAuraEntityReject(hEntity)
	if IsServer() then
		local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_faceless_void_8")
		if talent and talent:GetLevel() > 0 then
			if hEntity:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
				return true
			end
		end

		if hEntity:GetUnitName() == "npc_dota_faceless_void" then
			return true
		end
	end
	return false
end

function modifier_faceless_void_chronosphere_lua_thinker:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_faceless_void/faceless_void_chronosphere.vpcf"
	local sound_cast = "Hero_FacelessVoid.Chronosphere"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, self.radius, self.radius))

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
	EmitSoundOn(sound_cast, self:GetParent())
end

--------------------------------------------------------------------------------------------------

modifier_faceless_void_chronosphere_lua_effect = class({})

function modifier_faceless_void_chronosphere_lua_effect:IsHidden()
	return false
end

function modifier_faceless_void_chronosphere_lua_effect:IsDebuff()
	return not self:NotAffected()
end

function modifier_faceless_void_chronosphere_lua_effect:IsStunDebuff()
	return not self:NotAffected()
end

function modifier_faceless_void_chronosphere_lua_effect:IsPurgable()
	return false
end

function modifier_faceless_void_chronosphere_lua_effect:GetPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_faceless_void_chronosphere_lua_effect:NotAffected()
	if self:GetParent() == self:GetCaster() then
		return true
	end
	if self:GetParent():GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
		return true
	end
end

function modifier_faceless_void_chronosphere_lua_effect:OnCreated(kv)
	self.speed = 1000

	if IsServer() then
		if not self:NotAffected() then
			self:GetParent():InterruptMotionControllers(false)
		else
			self:PlayEffects()
		end
	end
end

function modifier_faceless_void_chronosphere_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}

	return funcs
end

function modifier_faceless_void_chronosphere_lua_effect:GetModifierMoveSpeed_AbsoluteMin()
	if self:NotAffected() then
		return self.speed
	end
end

function modifier_faceless_void_chronosphere_lua_effect:CheckState()
	local state1 = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	local state2 = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
		[MODIFIER_STATE_INVISIBLE] = false,
	}

	if self:NotAffected() then
		return state1
	else
		return state2
	end
end

function modifier_faceless_void_chronosphere_lua_effect:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_faceless_void/faceless_void_chrono_speed.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)

	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end