--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_medusa_split_shot_lua", "abilities/bosses/medusa/medusa", LUA_MODIFIER_MOTION_NONE)

boss_medusa_split_shot_lua = class({})

function boss_medusa_split_shot_lua:GetIntrinsicModifierName()
	return "modifier_boss_medusa_split_shot_lua"
end

function boss_medusa_split_shot_lua:OnUpgrade()
	self.OnUpgrade = function() end
	if not IsServer() then
		return
	end
	self:ToggleAutoCast()
end

--------------------------------------------------------------------------------

modifier_boss_medusa_split_shot_lua = class({})

function modifier_boss_medusa_split_shot_lua:IsHidden()
	return true
end

function modifier_boss_medusa_split_shot_lua:IsPurgable()
	return false
end

function modifier_boss_medusa_split_shot_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_boss_medusa_split_shot_lua:OnCreated()
	self.count = self:GetAbility():GetSpecialValueFor("arrow_count")
	self.bonus_range = self:GetAbility():GetSpecialValueFor("split_shot_bonus_range")
end

function modifier_boss_medusa_split_shot_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_boss_medusa_split_shot_lua:GetSplitShotTargets()
	local parent = self:GetParent()

	return FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		parent:Script_GetAttackRange() + self.bonus_range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
			+ DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
			+ DOTA_UNIT_TARGET_FLAG_NO_INVIS
			+ DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_ANY_ORDER,
		false
	)
end

function modifier_boss_medusa_split_shot_lua:OnAttack(keys)
	if not IsServer() then
		return
	end

	if self.split_shot_target then
		return
	end

	local parent = self:GetParent()

	if keys.attacker ~= parent then
		return
	end
	if not keys.target or keys.target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if keys.no_attack_cooldown then
		return
	end
	if parent:PassivesDisabled() then
		return
	end

	local ability = self:GetAbility()
	if not ability:IsTrained() then
		return
	end
	if not ability:GetAutoCastState() then
		return
	end

	local targets = self:GetSplitShotTargets()

	local target_number = 0

	for i = 1, #targets do
		local target = targets[i]

		if target ~= keys.target then
			self.split_shot_target = true

			parent:PerformAttack(target, true, true, true, true, true, false, false)

			self.split_shot_target = false

			target_number = target_number + 1

			if target_number >= self.count then
				break
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_medusa_mystic_snake_lua", "abilities/bosses/medusa/medusa", LUA_MODIFIER_MOTION_NONE)

boss_medusa_mystic_snake_lua = class({})

function boss_medusa_mystic_snake_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_medusa_mystic_snake_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_medusa/medusa_mystic_snake_impact.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context)
end

function boss_medusa_mystic_snake_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local radius = self:GetSpecialValueFor("radius")
	local jump_count = self:GetSpecialValueFor("jump_count")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local speed = self:GetSpecialValueFor("snake_speed")

	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile.vpcf",
		iMoveSpeed = speed,
		bDodgeable = false,
		ExtraData = {
			jump_num = 1,
			max_jumps = jump_count,
			current_damage = damage,
			radius = radius,
			mana_stolen = 0,
		},
	}

	ProjectileManager:CreateTrackingProjectile(info)
	EmitSoundOn("Hero_Medusa.MysticSnake.Cast", caster)
end

function boss_medusa_mystic_snake_lua:OnProjectileHit_ExtraData(target, location, extraData)
	if not target or target:IsMagicImmune() then
		return
	end

	local caster = self:GetCaster()

	local impact_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_medusa/medusa_mystic_snake_impact.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(impact_pfx)
	EmitSoundOn("Hero_Medusa.MysticSnake.Target", target)

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = extraData.current_damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}
	ApplyDamage(damageTable)

	target:AddNewModifier(
		caster,
		self,
		"modifier_boss_medusa_mystic_snake_lua",
		{ duration = self:GetSpecialValueFor("duration") }
	)

	if extraData.jump_num < extraData.max_jumps then
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetAbsOrigin(),
			nil,
			extraData.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)

		local next_target = nil
		for _, enemy in pairs(enemies) do
			if enemy ~= target then
				next_target = enemy
				break
			end
		end

		if next_target then
			extraData.jump_num = extraData.jump_num + 1
			extraData.current_damage = extraData.current_damage

			local info = {
				Target = next_target,
				Source = target,
				Ability = self,
				EffectName = "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile.vpcf",
				iMoveSpeed = self:GetSpecialValueFor("snake_speed"),
				bDodgeable = false,
				ExtraData = extraData,
			}
			ProjectileManager:CreateTrackingProjectile(info)
			return
		end
	end
end

--------------------------------------------------------------------------------

modifier_boss_medusa_mystic_snake_lua = class({})

function modifier_boss_medusa_mystic_snake_lua:IsHidden()
	return false
end
function modifier_boss_medusa_mystic_snake_lua:IsDebuff()
	return true
end
function modifier_boss_medusa_mystic_snake_lua:IsStunDebuff()
	return true
end
function modifier_boss_medusa_mystic_snake_lua:IsPurgable()
	return true
end

function modifier_boss_medusa_mystic_snake_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.pull_speed = self:GetAbility():GetSpecialValueFor("speed")

	ExecuteOrderFromTable({
		UnitIndex = self.parent:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
		TargetIndex = self.caster:entindex(),
	})

	self:StartIntervalThink(0.1)
end

function modifier_boss_medusa_mystic_snake_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:MoveToNPC(self.caster)
end

function modifier_boss_medusa_mystic_snake_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
end

function modifier_boss_medusa_mystic_snake_lua:GetModifierMoveSpeed_Absolute()
	return self.pull_speed
end

function modifier_boss_medusa_mystic_snake_lua:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_boss_medusa_mystic_snake_lua:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:Stop()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

boss_medusa_spawn_minion = class({})

function boss_medusa_spawn_minion:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local unit_count = self:GetSpecialValueFor("unit_count")
	local unit_limit = self:GetSpecialValueFor("unit_limit")
	local radius = self:GetSpecialValueFor("radius")

	EmitSoundOn("Hero_PhantomLancer.Strike.Start", caster)

	local all_entities = Entities:FindAllByClassnameWithin("npc_dota_creature", caster:GetAbsOrigin(), radius * 2)
	local my_ward_count = 0
	for _, ent in pairs(all_entities) do
		if ent:GetUnitName() == "npc_dota_boss_medusa_minion" and ent:IsAlive() then
			my_ward_count = my_ward_count + 1
		end
	end

	for i = 1, unit_count do
		if my_ward_count < unit_limit then
			local spawn_pos = caster:GetAbsOrigin() + RandomVector(RandomFloat(100, radius))
			local ward =
				CreateUnitByName("npc_dota_boss_medusa_minion", spawn_pos, true, caster, caster, caster:GetTeamNumber())
			ward:SetOwner(caster)
			my_ward_count = my_ward_count + 1
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_medusa_minion_lua", "abilities/bosses/medusa/medusa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_medusa_minion_lua_effect", "abilities/bosses/medusa/medusa", LUA_MODIFIER_MOTION_NONE)

boss_medusa_minion_lua = class({})

function boss_medusa_minion_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pugna/pugna_life_drain.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context)
end

function boss_medusa_minion_lua:GetIntrinsicModifierName()
	return "modifier_boss_medusa_minion_lua"
end

--------------------------------------------------------------------------------

modifier_boss_medusa_minion_lua = class({})

function modifier_boss_medusa_minion_lua:IsHidden()
	return false
end
function modifier_boss_medusa_minion_lua:IsPurgable()
	return false
end

function modifier_boss_medusa_minion_lua:OnCreated()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target = caster:GetOwner()

	if not target or target:IsNull() then
		local bosses = Entities:FindAllByName("npc_dota_boss_medusa")
		target = bosses[1]
	end

	if target and target:IsAlive() then
		self.target_boss = target
		target:AddNewModifier(caster, self:GetAbility(), "modifier_boss_medusa_minion_lua_effect", {})

		EmitSoundOn("Hero_OgreMagi.Bloodlust.Target", target)
	end
end

function modifier_boss_medusa_minion_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_boss_medusa_minion_lua:OnDeath(keys)
	if not IsServer() then
		return
	end
	if keys.unit ~= self:GetParent() then
		return
	end

	if self.target_boss and not self.target_boss:IsNull() then
		self.target_boss:RemoveModifierByNameAndCaster("modifier_boss_medusa_minion_lua_effect", self:GetCaster())
	end
end

-----------------------------------------------------------------------------

modifier_boss_medusa_minion_lua_effect = class({})

function modifier_boss_medusa_minion_lua_effect:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_boss_medusa_minion_lua_effect:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
end

function modifier_boss_medusa_minion_lua_effect:OnCreated(kv)
	if not self:GetAbility() then
		return
	end

	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.bonus_hp_regen = self:GetAbility():GetSpecialValueFor("bonus_hp_regen")

	if IsServer() then
		self.nFXIndex = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pugna/pugna_life_drain.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			self.nFXIndex,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			self.nFXIndex,
			1,
			self:GetCaster(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetCaster():GetOrigin(),
			true
		)
		self:AddParticle(self.nFXIndex, true, false, 0, false, false)
	end
end

function modifier_boss_medusa_minion_lua_effect:OnDestroy()
	if not IsServer() then
		return
	end
	ParticleManager:DestroyParticle(self.nFXIndex, false)
	ParticleManager:ReleaseParticleIndex(self.nFXIndex)
end

function modifier_boss_medusa_minion_lua_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_boss_medusa_minion_lua_effect:GetModifierConstantHealthRegen(params)
	return self.bonus_hp_regen
end

function modifier_boss_medusa_minion_lua_effect:GetModifierAttackSpeedBonus_Constant(params)
	return self.bonus_attack_speed
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_medusa_poison_nova_lua", "abilities/bosses/medusa/medusa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_ring_lua", "heroes/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)

boss_medusa_poison_nova_lua = class({})

function boss_medusa_poison_nova_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_medusa_poison_nova_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local speed = self:GetSpecialValueFor("speed")
	local start_radius = self:GetSpecialValueFor("start_radius")
	local end_radius = self:GetSpecialValueFor("radius")

	local ring = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_ring_lua", -- modifier name
		{
			start_radius = start_radius,
			end_radius = end_radius,
			speed = speed,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			IsCircle = 0,
		} -- kv
	)
	ring:SetCallback(function(enemy)
		enemy:AddNewModifier(caster, self, "modifier_boss_medusa_poison_nova_lua", { duration = duration })
		local sound_cast = "Hero_Venomancer.PoisonNovaImpact"
		EmitSoundOn(sound_cast, enemy)
	end)
	self:PlayEffects(ring, speed)
end

function boss_medusa_poison_nova_lua:PlayEffects(modifier, speed)
	local duration = 2
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(speed, duration, speed))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Venomancer.PoisonNova", self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_boss_medusa_poison_nova_lua = class({})

function modifier_boss_medusa_poison_nova_lua:IsHidden()
	return false
end

function modifier_boss_medusa_poison_nova_lua:IsDebuff()
	return true
end

function modifier_boss_medusa_poison_nova_lua:IsStunDebuff()
	return false
end

function modifier_boss_medusa_poison_nova_lua:IsPurgable()
	return false
end

function modifier_boss_medusa_poison_nova_lua:OnCreated(kv)
	self.parent = self:GetParent()
	self.resistance = self:GetAbility():GetSpecialValueFor("resistance")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
	self:OnIntervalThink()
end

function modifier_boss_medusa_poison_nova_lua:OnIntervalThink()
	if self.parent:IsMagicImmune() then
		return
	end
	self:IncrementStackCount()
end

function modifier_boss_medusa_poison_nova_lua:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf"
end

function modifier_boss_medusa_poison_nova_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_boss_medusa_poison_nova_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_venomancer.vpcf"
end

function modifier_boss_medusa_poison_nova_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_boss_medusa_poison_nova_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_boss_medusa_poison_nova_lua:GetModifierPhysicalArmorBonus(params)
	return -self.resistance * self:GetStackCount()
end

function modifier_boss_medusa_poison_nova_lua:GetModifierMagicalResistanceBonus(params)
	return -self.resistance * self:GetStackCount()
end