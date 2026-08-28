--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bristleback_passive", "heroes/hero_bristleback/hero_bristleback", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_bristleback_passive_armor",
	"heroes/hero_bristleback/hero_bristleback",
	LUA_MODIFIER_MOTION_NONE
)

bristleback_passive = class({})

function bristleback_passive:GetIntrinsicModifierName()
	return "modifier_bristleback_passive"
end

--------------------------------------------------------------------------------

modifier_bristleback_passive = class({})

function modifier_bristleback_passive:IsHidden()
	return true
end

function modifier_bristleback_passive:IsPurgable()
	return false
end

function modifier_bristleback_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
	}
	return funcs
end

function modifier_bristleback_passive:GetModifierConstantHealthRegen()
	if not self:GetParent():PassivesDisabled() then
		return self:GetAbility():GetSpecialValueFor("regen") * self:GetParent():GetStrength()
	end
end

function modifier_bristleback_passive:GetModifierExtraHealthBonus()
	if not self:GetParent():PassivesDisabled() then
		return self:GetAbility():GetSpecialValueFor("bonus_hp") * self:GetParent():GetStrength()
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_bristleback_quill_spray_lua",
	"heroes/hero_bristleback/hero_bristleback",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_bristleback_quill_spray_lua_stack",
	"heroes/hero_bristleback/hero_bristleback",
	LUA_MODIFIER_MOTION_NONE
)

bristleback_quill_spray_lua = class({})

function bristleback_quill_spray_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local stack_damage = self:GetSpecialValueFor("quill_stack_damage")
	local base_damage = self:GetSpecialValueFor("quill_base_damage")
	local max_damage = self:GetSpecialValueFor("max_damage")
	local stack_duration = self:GetSpecialValueFor("quill_stack_duration")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		local modifier = enemy:FindModifierByNameAndCaster("modifier_bristleback_quill_spray_lua", caster)
		local stacks = modifier and modifier:GetStackCount() or 0

		local damage = math.min(base_damage + (stacks * stack_damage), max_damage)

		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			ability = self,
		})

		enemy:AddNewModifier(caster, self, "modifier_bristleback_quill_spray_lua_stack", { duration = stack_duration })
	end
	self:PlayEffects1()
end

function bristleback_quill_spray_lua:PlayEffects1()
	local p = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf",
		PATTACH_ABSORIGIN,
		self:GetCaster()
	)
	ParticleManager:ReleaseParticleIndex(p)
	EmitSoundOn("Hero_Bristleback.QuillSpray.Cast", self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_bristleback_quill_spray_lua = class({})

function modifier_bristleback_quill_spray_lua:IsHidden()
	return false
end
function modifier_bristleback_quill_spray_lua:IsDebuff()
	return true
end
function modifier_bristleback_quill_spray_lua:IsPurgable()
	return false
end

function modifier_bristleback_quill_spray_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_bristleback_quill_spray_lua:GetModifierPhysicalArmorBonus()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_bristleback_8")
	if talent and talent:GetLevel() > 0 then
		return -self:GetStackCount()
	end
	return 0
end

--------------------------------------------------------------------------------

modifier_bristleback_quill_spray_lua_stack = class({})

function modifier_bristleback_quill_spray_lua_stack:IsHidden()
	return true
end
function modifier_bristleback_quill_spray_lua_stack:IsPurgable()
	return false
end
function modifier_bristleback_quill_spray_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_bristleback_quill_spray_lua_stack:OnCreated()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local main_modifier = parent:FindModifierByNameAndCaster("modifier_bristleback_quill_spray_lua", caster)

	if not main_modifier then
		main_modifier = parent:AddNewModifier(caster, self:GetAbility(), "modifier_bristleback_quill_spray_lua", {})
	end

	if main_modifier then
		main_modifier:IncrementStackCount()
	end
end

function modifier_bristleback_quill_spray_lua_stack:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local main_modifier = parent:FindModifierByNameAndCaster("modifier_bristleback_quill_spray_lua", self:GetCaster())

	if main_modifier then
		main_modifier:DecrementStackCount()
		if main_modifier:GetStackCount() <= 0 then
			main_modifier:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_bristleback_bristleback_lua",
	"heroes/hero_bristleback/hero_bristleback",
	LUA_MODIFIER_MOTION_NONE
)

bristleback_bristleback_lua = class({})

function bristleback_bristleback_lua:GetIntrinsicModifierName()
	return "modifier_bristleback_bristleback_lua"
end

-------------------------------------------------------------------------------

modifier_bristleback_bristleback_lua = class({})

function modifier_bristleback_bristleback_lua:IsHidden()
	return true
end

function modifier_bristleback_bristleback_lua:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.side_angle = self.ability:GetSpecialValueFor("side_angle")
	self.back_angle = self.ability:GetSpecialValueFor("back_angle")
	self.threshold = self.ability:GetSpecialValueFor("quill_release_threshold")

	self.last_proc_time = 0
	self.proc_cooldown = 0.1
end

function modifier_bristleback_bristleback_lua:OnRefresh()
	self:OnCreated()
end

function modifier_bristleback_bristleback_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_bristleback_bristleback_lua:GetModifierIncomingDamage_Percentage(keys)
	if self.parent:PassivesDisabled() then
		return 0
	end
	if
		keys.attacker == self.parent
		or bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION
	then
		return 0
	end

	local attacker_vector = (keys.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
	local facing_vector = self.parent:GetForwardVector()
	local angle = math.abs(RotationDelta(VectorToAngles(facing_vector), VectorToAngles(attacker_vector)).y)

	if angle >= (180 - (self.back_angle / 2)) then
		self:PlayEffects(false)
		return self:GetAbility():GetSpecialValueFor("back_damage_reduction") * -1
	elseif angle >= (180 - (self.side_angle / 2)) then
		self:PlayEffects(true)
		return self:GetAbility():GetSpecialValueFor("side_damage_reduction") * -1
	end
	return 0
end

function modifier_bristleback_bristleback_lua:OnTakeDamage(keys)
	if not IsServer() then
		return
	end
	if keys.unit ~= self.parent or self.parent:PassivesDisabled() then
		return
	end

	if bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end

	if not keys.attacker or keys.attacker:IsNull() then
		return
	end

	if self.lock_quills then
		return
	end

	local attacker_vector = (keys.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
	local facing_vector = self.parent:GetForwardVector()
	local angle = math.abs(RotationDelta(VectorToAngles(facing_vector), VectorToAngles(attacker_vector)).y)

	if angle >= (180 - (self.back_angle / 2)) then
		self:SetStackCount(self:GetStackCount() + keys.damage)

		local quill_ability = self.parent:FindAbilityByName("bristleback_quill_spray_lua")

		if quill_ability and quill_ability:GetLevel() > 0 then
			if self:GetStackCount() >= self.threshold then
				local current_time = GameRules:GetGameTime()

				if (current_time - self.last_proc_time) >= self.proc_cooldown then
					self.lock_quills = true
					quill_ability:OnSpellStart()
					self.last_proc_time = current_time
					self:SetStackCount(self:GetStackCount() - self.threshold)
					self.lock_quills = false

					local warpath_ability = self.parent:FindAbilityByName("bristleback_warpath_lua")
					if warpath_ability and warpath_ability:GetLevel() > 0 then
						local warpath_mod = self.parent:FindModifierByName("modifier_bristleback_warpath_lua")
						if warpath_mod then
							warpath_mod:AddStack()
						end
					end
				else
					self:SetStackCount(self.threshold)
				end
			end
		end
	end
end

function modifier_bristleback_bristleback_lua:PlayEffects(bSide)
	local particle_name = "particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf"
	if not bSide then
		particle_name = "particles/units/heroes/hero_bristleback/bristleback_back_lrg_dmg.vpcf"
		self.parent:EmitSound("Hero_Bristleback.Bristleback")
	end

	local p = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(
		p,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(p)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_bristleback_warpath_lua",
	"heroes/hero_bristleback/hero_bristleback",
	LUA_MODIFIER_MOTION_NONE
)

bristleback_warpath_lua = class({})

function bristleback_warpath_lua:GetIntrinsicModifierName()
	return "modifier_bristleback_warpath_lua"
end

-------------------------------------------------------------------------------

modifier_bristleback_warpath_lua = class({})

function modifier_bristleback_warpath_lua:IsHidden()
	if self:GetStackCount() >= 1 then
		return false
	else
		return true
	end
end

function modifier_bristleback_warpath_lua:DestroyOnExpire()
	return false
end

function modifier_bristleback_warpath_lua:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self.move_speed_per_stack = self.ability:GetSpecialValueFor("move_speed_per_stack")
	self.hp_regen_amp_per_stack = self.ability:GetSpecialValueFor("hp_regen_amp_per_stack")
	self.stack_duration = self.ability:GetSpecialValueFor("stack_duration")
	self.counter = self.counter or 0
	self.particle_table = self.particle_table or {}

	if not IsServer() then
		return
	end

	if self.parent:IsIllusion() then
		local owners = Entities:FindAllByNameWithin("npc_dota_hero_bristleback", self.parent:GetAbsOrigin(), 100)
		for _, owner in pairs(owners) do
			if
				not owner:IsIllusion()
				and owner:HasModifier("modifier_bristleback_warpath_lua")
				and owner:GetTeam() == self.parent:GetTeam()
			then
				self:SetStackCount(owner:FindModifierByName("modifier_bristleback_warpath_lua"):GetStackCount())
				self:SetDuration(self.stack_duration, true)

				Timers:CreateTimer(self.stack_duration, function()
					if
						self ~= nil
						and not self:IsNull()
						and not self.ability:IsNull()
						and not self.parent:IsNull()
						and not self.caster:IsNull()
						and self:GetStackCount() > 0
					then
						self:SetStackCount(0)
					end
				end)

				break
			end
		end
	end
end

function modifier_bristleback_warpath_lua:OnRefresh()
	self:OnCreated()
end

function modifier_bristleback_warpath_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_bristleback_warpath_lua:GetModifierPreAttack_BonusDamage(keys)
	return self:GetAbility():GetSpecialValueFor("damage_per_stack") * self:GetStackCount()
end

function modifier_bristleback_warpath_lua:GetModifierMoveSpeedBonus_Constant(keys)
	return self.move_speed_per_stack * self:GetStackCount()
end

function modifier_bristleback_warpath_lua:GetModifierHPRegenAmplify_Percentage()
	return self.hp_regen_amp_per_stack * self:GetStackCount()
end

function modifier_bristleback_warpath_lua:OnAbilityFullyCast(keys)
	if
		keys.ability
		and keys.unit == self.parent
		and not self.parent:PassivesDisabled()
		and not keys.ability:IsItem()
		and keys.ability:GetName() ~= "ability_capture"
	then
		self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")

		self.counter = self.counter + 1

		self:SetStackCount(math.min(self.counter, self.max_stacks))

		if self:GetStackCount() < self.max_stacks then
			local particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_bristleback/bristleback_warpath.vpcf",
				PATTACH_POINT_FOLLOW,
				self:GetParent()
			)
			ParticleManager:SetParticleControlEnt(
				particle,
				3,
				self:GetCaster(),
				PATTACH_POINT_FOLLOW,
				"attach_attack1",
				self:GetCaster():GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				particle,
				4,
				self:GetCaster(),
				PATTACH_POINT_FOLLOW,
				"attach_attack2",
				self:GetCaster():GetAbsOrigin(),
				true
			)
			table.insert(self.particle_table, particle)
		end

		self:SetDuration(self.stack_duration, true)

		Timers:CreateTimer(self.stack_duration, function()
			if
				self ~= nil
				and not self:IsNull()
				and not self.ability:IsNull()
				and not self.parent:IsNull()
				and not self.caster:IsNull()
				and self:GetStackCount() > 0
			then
				self.counter = self.counter - 1

				self:SetStackCount(math.min(self.counter, self.max_stacks))

				if #self.particle_table > 0 then
					ParticleManager:DestroyParticle(self.particle_table[1], false)
					ParticleManager:ReleaseParticleIndex(self.particle_table[1])
					table.remove(self.particle_table, 1)
				end
			end
		end)
	end
end

function modifier_bristleback_warpath_lua:GetModifierModelScale()
	return self:GetStackCount() * 5
end

function modifier_bristleback_warpath_lua:AddStack()
	if not IsServer() then
		return
	end
	if self.parent:PassivesDisabled() then
		return
	end

	self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
	self.counter = self.counter + 1
	self:SetStackCount(math.min(self.counter, self.max_stacks))

	if self:GetStackCount() < self.max_stacks then
		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_bristleback/bristleback_warpath.vpcf",
			PATTACH_POINT_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			3,
			self.caster,
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			self.caster:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			4,
			self.caster,
			PATTACH_POINT_FOLLOW,
			"attach_attack2",
			self.caster:GetAbsOrigin(),
			true
		)
		table.insert(self.particle_table, particle)
	end

	self:SetDuration(self.stack_duration, true)

	Timers:CreateTimer(self.stack_duration, function()
		if
			self ~= nil
			and not self:IsNull()
			and not self.ability:IsNull()
			and not self.parent:IsNull()
			and not self.caster:IsNull()
			and self:GetStackCount() > 0
		then
			self.counter = self.counter - 1
			self:SetStackCount(math.min(self.counter, self.max_stacks))
			if #self.particle_table > 0 then
				ParticleManager:DestroyParticle(self.particle_table[1], false)
				ParticleManager:ReleaseParticleIndex(self.particle_table[1])
				table.remove(self.particle_table, 1)
			end
		end
	end)
end