--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_primal_beast_rock_throw",
	"heroes/hero_primal_beast/hero_primal_beast",
	LUA_MODIFIER_MOTION_NONE
)

primal_beast_rock_throw_lua = class({})

function primal_beast_rock_throw_lua:OnSpellStart()
	local dummy = CreateModifierThinker(
		self:GetCaster(),
		self,
		nil,
		{},
		self:GetCursorPosition(),
		self:GetCaster():GetTeamNumber(),
		false
	)

	local info = {
		Target = dummy,
		Source = self:GetCaster(),
		Ability = self,
		EffectName = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw.vpcf",
		iMoveSpeed = 1000,
		bDodgeable = false,
	}
	ProjectileManager:CreateTrackingProjectile(info)
	self:GetCaster():EmitSound("Hero_PrimalBeast.RockThrow.Cast")
end

function primal_beast_rock_throw_lua:OnProjectileHit(target, location)
	if not target then
		return
	end

	local caster = self:GetCaster()
	local rock_radius = self:GetSpecialValueFor("impact_radius")
	local attack_damage = self:GetSpecialValueFor("base_damage")
	local hit_pos = target:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		hit_pos,
		target,
		rock_radius,
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
			damage = attack_damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		})
		enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = self:GetSpecialValueFor("stun_duration") })
	end

	self:PlayEffects(target)

	local talent = caster:FindAbilityByName("special_bonus_unique_primal_beast_6")
	if talent and talent:GetLevel() > 0 and not target.is_shrapnel then
		self:SpawnRockShrapnel(hit_pos, target)
	end
end

function primal_beast_rock_throw_lua:SpawnRockShrapnel(position, target)
	local caster = self:GetCaster()
	local shard_count = 2
	local shard_distance = 250

	for i = 1, shard_count do
		local random_vector = RandomVector(shard_distance)
		local shard_target_pos = position + random_vector

		local shard_dummy =
			CreateModifierThinker(caster, self, nil, { duration = 2 }, shard_target_pos, caster:GetTeamNumber(), false)
		shard_dummy.is_shrapnel = true

		local info = {
			Target = shard_dummy,
			Source = target,
			Ability = self,
			EffectName = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw.vpcf",
			iMoveSpeed = 400,
			bDodgeable = false,
			vSourceLoc = position,
		}
		ProjectileManager:CreateTrackingProjectile(info)
	end
end

function primal_beast_rock_throw_lua:PlayEffects(target)
	target:EmitSound("Hero_PrimalBeast.RockThrow.Impact")
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 3, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	if target.Destroy then
		target:ForceKill(false)
	end
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_primal_beast_trample_lua",
	"heroes/hero_primal_beast/hero_primal_beast",
	LUA_MODIFIER_MOTION_NONE
)

primal_beast_trample_lua = class({})

function primal_beast_trample_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_primal_beast_trample_lua", { duration = duration })
end

-----------------------------------------------------------------------------

modifier_primal_beast_trample_lua = class({})

function modifier_primal_beast_trample_lua:IsHidden()
	return false
end

function modifier_primal_beast_trample_lua:IsDebuff()
	return false
end

function modifier_primal_beast_trample_lua:IsPurgable()
	return false
end

function modifier_primal_beast_trample_lua:OnCreated(kv)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.radius = self.ability:GetSpecialValueFor("effect_radius")
	self.step_distance = self.ability:GetSpecialValueFor("step_distance")
	self.base_damage = self.ability:GetSpecialValueFor("base_damage")
	self.attack_damage = self.ability:GetSpecialValueFor("attack_damage") / 100

	if not IsServer() then
		return
	end
	self.abilityDamageType = self.ability:GetAbilityDamageType()
	self.distance = 0
	self.treshold = 500
	self.time_accumulator = 0
	self.tick_interval = 1

	self.currentpos = self.parent:GetOrigin()

	self:StartIntervalThink(0.05)
	self:Trample()
end

function modifier_primal_beast_trample_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	local pos = self.parent:GetOrigin()
	local dist = (pos - self.currentpos):Length2D()
	self.currentpos = pos

	GridNav:DestroyTreesAroundPoint(pos, self.radius, false)

	self.time_accumulator = self.time_accumulator + 0.05

	if dist < self.treshold then
		self.distance = self.distance + dist
	end

	if self.distance >= self.step_distance then
		self:Trample()
		self.distance = 0
		self.time_accumulator = 0
		return
	end

	if self.time_accumulator >= self.tick_interval then
		self:Trample()
		self.time_accumulator = 0
		self.distance = 0
	end
end

function modifier_primal_beast_trample_lua:OnRefresh(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("effect_radius")
	self.distance = self:GetAbility():GetSpecialValueFor("step_distance")
	self.base_damage = self:GetAbility():GetSpecialValueFor("base_damage")
	self.attack_damage = self:GetAbility():GetSpecialValueFor("attack_damage") / 100
end

function modifier_primal_beast_trample_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
	return funcs
end

function modifier_primal_beast_trample_lua:GetActivityTranslationModifiers()
	return "heavy_steps"
end

function modifier_primal_beast_trample_lua:CheckState()
	local state = {
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_primal_beast_trample_lua:Trample()
	local pos = self.parent:GetOrigin()
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		pos,
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	local damage = self.base_damage + self.parent:GetAverageTrueAttackDamage(self.parent) * self.attack_damage
	local damageTable = {
		attacker = self.parent,
		damage = damage,
		damage_type = self.abilityDamageType,
		damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
	}
	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, enemy, damage, nil)
	end
	self:PlayEffects()
end

function modifier_primal_beast_trample_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf"
	local sound_cast = "Hero_PrimalBeast.Trample"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self.parent)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, self.parent)
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_primal_beast_uproar_lua_buff",
	"heroes/hero_primal_beast/hero_primal_beast",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_primal_beast_uproar_lua_debuff",
	"heroes/hero_primal_beast/hero_primal_beast",
	LUA_MODIFIER_MOTION_NONE
)

primal_beast_uproar_lua = class({})

function primal_beast_uproar_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")

	caster:AddNewModifier(caster, self, "modifier_primal_beast_uproar_lua_buff", { duration = duration })

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_primal_beast_uproar_lua_debuff", { duration = duration })
	end
	self:PlayEffects(radius)
	self:PlayEffects2()
end

function primal_beast_uproar_lua:PlayEffects(radius)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_roar_aoe.vpcf",
		PATTACH_ABSORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_PrimalBeast.Uproar.Cast", self:GetCaster())
end

function primal_beast_uproar_lua:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_roar.vpcf",
		PATTACH_POINT_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_jaw_fx",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-----------------------------------------------------------------------------

modifier_primal_beast_uproar_lua_buff = class({})

function modifier_primal_beast_uproar_lua_buff:IsHidden()
	return false
end

function modifier_primal_beast_uproar_lua_buff:IsDebuff()
	return false
end

function modifier_primal_beast_uproar_lua_buff:IsPurgable()
	return true
end

function modifier_primal_beast_uproar_lua_buff:OnCreated(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.armor = self:GetAbility():GetSpecialValueFor("armor")
	self:PlayEffects()
end

function modifier_primal_beast_uproar_lua_buff:OnRefresh(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.armor = self:GetAbility():GetSpecialValueFor("armor")
end

function modifier_primal_beast_uproar_lua_buff:OnRemoved() end

function modifier_primal_beast_uproar_lua_buff:OnDestroy() end

function modifier_primal_beast_uproar_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function modifier_primal_beast_uproar_lua_buff:GetModifierBaseDamageOutgoing_Percentage()
	return self.damage
end

function modifier_primal_beast_uproar_lua_buff:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_primal_beast_uproar_lua_buff:GetModifierMagicalResistanceBonus()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_primal_beast_4")
	if talent and talent:GetLevel() > 0 then
		return self.armor
	end
	return 0
end

function modifier_primal_beast_uproar_lua_buff:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_uproar_magic_resist.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	self:AddParticle(effect_cast, false, false, -1, false, false)
end

-----------------------------------------------------------------------------

modifier_primal_beast_uproar_lua_debuff = class({})

function modifier_primal_beast_uproar_lua_debuff:IsHidden()
	return false
end

function modifier_primal_beast_uproar_lua_debuff:IsDebuff()
	return true
end

function modifier_primal_beast_uproar_lua_debuff:IsPurgable()
	return true
end

function modifier_primal_beast_uproar_lua_debuff:GetTexture()
	return "primal_beast_uproar"
end

function modifier_primal_beast_uproar_lua_debuff:OnCreated(kv)
	self.slow = -self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_primal_beast_uproar_lua_debuff:OnRefresh(kv)
	self.slow = -self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_primal_beast_uproar_lua_debuff:OnRemoved() end

function modifier_primal_beast_uproar_lua_debuff:OnDestroy() end

function modifier_primal_beast_uproar_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_primal_beast_uproar_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_primal_beast_uproar_lua_debuff:GetStatusEffectName()
	return "particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf"
end

function modifier_primal_beast_uproar_lua_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_primal_beast_pulverize_lua",
	"heroes/hero_primal_beast/hero_primal_beast",
	LUA_MODIFIER_MOTION_NONE
)

primal_beast_pulverize_lua = class({})

function primal_beast_pulverize_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	caster:AddNewModifier(caster, self, "modifier_primal_beast_pulverize_lua", { duration = duration })

	EmitSoundOn("Hero_PrimalBeast.RockThrow.Cast", caster)
end

-----------------------------------------------------------------------------

modifier_primal_beast_pulverize_lua = class({})

function modifier_primal_beast_pulverize_lua:IsHidden()
	return false
end
function modifier_primal_beast_pulverize_lua:IsPurgable()
	return false
end

function modifier_primal_beast_pulverize_lua:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.radius = self.ability:GetSpecialValueFor("splash_radius")
	self.ministun = self.ability:GetSpecialValueFor("ministun")
	self.damage = self.ability:GetSpecialValueFor("damage")

	self:GetParent():StartGesture(ACT_DOTA_GENERIC_CHANNEL_1)

	self.first_hit_done = false

	self:StartIntervalThink(0.48)
end

function modifier_primal_beast_pulverize_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	self:Strike()

	if not self.first_hit_done then
		self.first_hit_done = true
		self:StartIntervalThink(0.65)
	end
end

function modifier_primal_beast_pulverize_lua:Strike()
	local front = self.caster:GetForwardVector():Normalized()
	local origin = self.caster:GetOrigin() + front * 150

	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		origin,
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = self.caster,
			damage = self.damage,
			damage_type = self.ability:GetAbilityDamageType(),
			ability = self.ability,
		})
		enemy:AddNewModifier(self.caster, self.ability, "modifier_stunned", { duration = self.ministun })
	end

	self:PlayEffects(origin, self.radius)
	EmitSoundOn("Hero_PrimalBeast.Pulverize.Stun", self.caster)
end

function modifier_primal_beast_pulverize_lua:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
end

function modifier_primal_beast_pulverize_lua:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_primal_beast_pulverize_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
end

function modifier_primal_beast_pulverize_lua:GetModifierDisableTurning()
	return 1
end

function modifier_primal_beast_pulverize_lua:PlayEffects(origin, radius)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, origin)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_PrimalBeast.Pulverize.Impact"
	-- EmitSoundOnLocationWithCaster( origin, sound_cast, self.caster )
	EmitSoundOn(sound_cast, self.caster)
end