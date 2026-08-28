--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_terrorblade_reflection_lua", "heroes/hero_terror/hero_terror", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_terrorblade_reflection_lua_illusion",
	"heroes/hero_terror/hero_terror",
	LUA_MODIFIER_MOTION_NONE
)

terrorblade_reflection_lua = class({})

function terrorblade_reflection_lua:GetAOERadius()
	return self:GetSpecialValueFor("range")
end

function terrorblade_reflection_lua:OnSpellStart()
	local caster = self:GetCaster()
	local range = self:GetSpecialValueFor("range")
	local duration = self:GetSpecialValueFor("illusion_duration")
	local talent = caster:FindAbilityByName("special_bonus_unique_terrorblade_5")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	local max_targets = 1
	if talent and talent:GetLevel() > 0 then
		max_targets = 5
	end

	local count = 0
	for _, enemy in pairs(enemies) do
		if count < max_targets then
			enemy:AddNewModifier(caster, self, "modifier_terrorblade_reflection_lua", { duration = duration })
			count = count + 1
		else
			break
		end
	end

	if count > 0 then
		caster:EmitSound("Hero_Terrorblade.Reflection")
	end
end

--------------------------------------------------------------------------------

modifier_terrorblade_reflection_lua = class({})

function modifier_terrorblade_reflection_lua:IsPurgable()
	return true
end

function modifier_terrorblade_reflection_lua:OnCreated()
	local ability = self:GetAbility()
	self.slow = -ability:GetSpecialValueFor("move_slow")

	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local parent = self:GetParent()
	local outgoing = ability:GetSpecialValueFor("illusion_outgoing_damage")

	local illusions = CreateIllusions(caster, caster, {
		outgoing_damage = 0,
		duration = self:GetDuration(),
	}, 1, 64, false, true)

	self.illusion = illusions[1]
	self.illusion:AddNewModifier(caster, ability, "modifier_terrorblade_reflection_lua_illusion", {})

	local average_bonus_damage = caster:GetAverageTrueAttackDamage(nil) / 100 * outgoing
	self.illusion:SetBaseDamageMin(average_bonus_damage - self:GetCaster():GetAgility())
	self.illusion:SetBaseDamageMax(average_bonus_damage - self:GetCaster():GetAgility())

	self:OnIntervalThink()
	self:StartIntervalThink(0.1)
end

function modifier_terrorblade_reflection_lua:OnIntervalThink()
	if not self.illusion or self.illusion:IsNull() or not self.illusion:IsAlive() then
		return
	end

	local parent = self:GetParent()
	if self:GetCaster():CanEntityBeSeenByMyTeam(parent) then
		if self.illusion:GetAggroTarget() ~= parent then
			ExecuteOrderFromTable({
				UnitIndex = self.illusion:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = parent:entindex(),
			})
		end
	else
		self.illusion:MoveToPosition(parent:GetAbsOrigin())
	end
end

function modifier_terrorblade_reflection_lua:OnDestroy()
	if IsServer() and self.illusion and not self.illusion:IsNull() then
		self.illusion:ForceKill(false)
	end
end

function modifier_terrorblade_reflection_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_terrorblade_reflection_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_terrorblade_reflection_lua:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
end

--------------------------------------------------------------------------------

modifier_terrorblade_reflection_lua_illusion = class({})

function modifier_terrorblade_reflection_lua_illusion:IsHidden()
	return true
end

function modifier_terrorblade_reflection_lua_illusion:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end

function modifier_terrorblade_reflection_lua_illusion:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
end

function modifier_terrorblade_reflection_lua_illusion:GetModifierMoveSpeed_Absolute()
	return 550
end

function modifier_terrorblade_reflection_lua_illusion:GetStatusEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_terrorblade_reflection_lua_illusion:StatusEffectPriority()
	return 10001
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_terrorblade_conjure_image_lua", "heroes/hero_terror/hero_terror", LUA_MODIFIER_MOTION_NONE)

terrorblade_conjure_image_lua = class({})

function terrorblade_conjure_image_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_mirror_image.vpcf", context)
end

function terrorblade_conjure_image_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("illusion_duration")
	local outgoing = self:GetSpecialValueFor("illusion_outgoing_damage")
	local incoming = self:GetSpecialValueFor("illusion_incoming_damage")

	count = 1

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_terrorblade_7")
	if talent and talent:GetLevel() > 0 then
		count = 2
	end

	for i = 1, count do
		local illusions = CreateIllusions(caster, caster, {
			outgoing_damage = 0,
			incoming_damage = incoming - 100,
			duration = duration,
		}, 1, 64, false, true)

		self.illusion = illusions[1]
		self.illusion:AddNewModifier(caster, self, "modifier_terrorblade_conjure_image_lua", {})

		local average_bonus_damage = caster:GetAverageTrueAttackDamage(nil) / 100 * outgoing
		self.illusion:SetBaseDamageMin(average_bonus_damage - self:GetCaster():GetAgility())
		self.illusion:SetBaseDamageMax(average_bonus_damage - self:GetCaster():GetAgility())
	end
end

--------------------------------------------------------------------------------

modifier_terrorblade_conjure_image_lua = class({})

function modifier_terrorblade_conjure_image_lua:IsHidden()
	return true
end

function modifier_terrorblade_conjure_image_lua:IsDebuff()
	return false
end

function modifier_terrorblade_conjure_image_lua:IsStunDebuff()
	return false
end

function modifier_terrorblade_conjure_image_lua:IsPurgable()
	return false
end

function modifier_terrorblade_conjure_image_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_terrorblade_conjure_image_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_terrorblade_conjure_image_lua:StatusEffectPriority()
	return 10001
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_terrorblade_metamorphosis_lua", "heroes/hero_terror/hero_terror", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_terrorblade_metamorphosis_lua_aura",
	"heroes/hero_terror/hero_terror",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_fear_thinker", "heroes/hero_terror/hero_terror", LUA_MODIFIER_MOTION_NONE)

terrorblade_metamorphosis_lua = class({})

function terrorblade_metamorphosis_lua:Precache(context)
	PrecacheModel("models/heroes/terrorblade/demon.vmdl", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf",
		context
	)
end

function terrorblade_metamorphosis_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_terrorblade_4")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 40
	end
	return self.BaseClass.GetCooldown(self, level)
end

function terrorblade_metamorphosis_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	caster:AddNewModifier(caster, self, "modifier_terrorblade_metamorphosis_lua_aura", { duration = duration })

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_terrorblade_2")
	if talent and talent:GetLevel() > 0 then
		CreateModifierThinker(
			self:GetCaster(),
			self,
			"modifier_fear_thinker",
			{ duration = 1600 / 1000 },
			self:GetCaster():GetAbsOrigin(),
			self:GetCaster():GetTeamNumber(),
			false
		)
	end
end

--------------------------------------------------------------------------------

modifier_fear_thinker = class({})

function modifier_fear_thinker:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end
	self.fear_duration = 2.5
	self.radius = 1000
	self.speed = 1000
	self.spawn_delay = 0.6
	if not IsServer() then
		return
	end
	self.bLaunched = false
	self.feared_units = {}
	self.fear_modifier = nil
	self:StartIntervalThink(self.spawn_delay)
end

function modifier_fear_thinker:OnIntervalThink()
	if not self.bLaunched then
		self.bLaunched = true
		local wave_particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf",
			PATTACH_WORLDORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(wave_particle, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(wave_particle, 1, Vector(self.speed, self.speed, self.speed))
		ParticleManager:SetParticleControl(wave_particle, 2, Vector(self.speed, self.speed, self.speed))
		ParticleManager:ReleaseParticleIndex(wave_particle)

		self:StartIntervalThink(-1)
		self:StartIntervalThink(FrameTime())
	else
		for _, enemy in
			pairs(
				FindUnitsInRadius(
					self:GetCaster():GetTeamNumber(),
					self:GetParent():GetAbsOrigin(),
					self:GetParent(),
					math.min(self.speed * (self:GetElapsedTime() - self.spawn_delay), self.radius),
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
			)
		do
			if
				not self.feared_units[enemy:entindex()]
				and (enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
					>= math.min(self.speed * (self:GetElapsedTime() - self.spawn_delay), self.radius) - 50
			then
				enemy:EmitSound("Hero_Terrorblade.Metamorphosis.Fear")
				self.fear_modifier = enemy:AddNewModifier(
					self:GetCaster(),
					self:GetAbility(),
					"modifier_terrorblade_fear",
					{ duration = self.fear_duration }
				)
				if self.fear_modifier then
					self.fear_modifier:SetDuration(self.fear_duration * (1 - enemy:GetStatusResistance()), true)
				end
				self.feared_units[enemy:entindex()] = true
			end
		end
	end
end

--------------------------------------------------------------------------------

modifier_terrorblade_metamorphosis_lua_aura = class({})

function modifier_terrorblade_metamorphosis_lua_aura:IsHidden()
	return false
end

function modifier_terrorblade_metamorphosis_lua_aura:IsDebuff()
	return false
end

function modifier_terrorblade_metamorphosis_lua_aura:IsStunDebuff()
	return false
end

function modifier_terrorblade_metamorphosis_lua_aura:IsPurgable()
	return false
end

function modifier_terrorblade_metamorphosis_lua_aura:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("metamorph_aura_tooltip")
end

function modifier_terrorblade_metamorphosis_lua_aura:IsAura()
	return true
end

function modifier_terrorblade_metamorphosis_lua_aura:GetModifierAura()
	return "modifier_terrorblade_metamorphosis_lua"
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraRadius()
	return self.radius
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraDuration()
	return 1
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraSearchFlags()
	return 0
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraEntityReject(hEntity)
	if IsServer() then
		if hEntity:GetPlayerOwnerID() ~= self:GetParent():GetPlayerOwnerID() then
			return true
		end
	end

	return false
end

--------------------------------------------------------------------------------

modifier_terrorblade_metamorphosis_lua = class({})

function modifier_terrorblade_metamorphosis_lua:IsHidden()
	return false
end

function modifier_terrorblade_metamorphosis_lua:IsDebuff()
	return false
end

function modifier_terrorblade_metamorphosis_lua:IsStunDebuff()
	return false
end

function modifier_terrorblade_metamorphosis_lua:IsPurgable()
	return false
end

function modifier_terrorblade_metamorphosis_lua:OnCreated(kv)
	if IsServer() then
		self.bat = self:GetAbility():GetSpecialValueFor("base_attack_time")
		self.range = self:GetAbility():GetSpecialValueFor("bonus_range")
		self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
		local delay = self:GetAbility():GetSpecialValueFor("transformation_time")

		self.projectile = 900

		if not IsServer() then
			return
		end

		self.attack = self:GetParent():GetAttackCapability()
		if self.attack == DOTA_UNIT_CAP_RANGED_ATTACK then
			self.range = 0
			self.projectile = 0
		end
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)

		self:GetAbility():SetContextThink(DoUniqueString("terrorblade_metamorphosis_lua"), function()
			self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_3)
		end, FrameTime())

		self.stun = true
		self:PlayEffects()
	end
end

function modifier_terrorblade_metamorphosis_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_terrorblade_metamorphosis_lua:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():SetAttackCapability(self.attack)
end

function modifier_terrorblade_metamorphosis_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
	}

	return funcs
end

function modifier_terrorblade_metamorphosis_lua:GetModifierBaseAttack_BonusDamage()
	return self.damage
end

function modifier_terrorblade_metamorphosis_lua:GetModifierBaseAttackTimeConstant()
	local bat = self.bat
	local parent = self:GetParent()
	if parent and parent.dms_bat_factor then
		bat = bat * parent.dms_bat_factor
	end
	return bat
end

function modifier_terrorblade_metamorphosis_lua:GetModifierProjectileSpeedBonus()
	return self.projectile
end

function modifier_terrorblade_metamorphosis_lua:GetModifierAttackRangeBonus()
	return self.range
end

function modifier_terrorblade_metamorphosis_lua:GetModifierModelChange()
	return "models/heroes/terrorblade/demon.vmdl"
end

function modifier_terrorblade_metamorphosis_lua:GetModifierModelScale()
	return 20
end

function modifier_terrorblade_metamorphosis_lua:GetModifierProjectileName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf"
end

function modifier_terrorblade_metamorphosis_lua:GetAttackSound()
	return "Hero_Terrorblade_Morphed.Attack"
end

function modifier_terrorblade_metamorphosis_lua:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf"
end

function modifier_terrorblade_metamorphosis_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_terrorblade_metamorphosis_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Terrorblade.Metamorphosis", self:GetParent())
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_terrorblade_sunder_lua", "heroes/hero_terror/hero_terror", LUA_MODIFIER_MOTION_NONE)

terrorblade_sunder_lua = class({})

function terrorblade_sunder_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = caster:GetAbsOrigin()
	local radius = self:GetSpecialValueFor("range")
	local duration = self:GetSpecialValueFor("duration")
	local sunderdamage = self:GetSpecialValueFor("damage")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_CREEP,
		0,
		0,
		false
	)

	local modifier = caster:AddNewModifier(caster, self, "modifier_terrorblade_sunder_lua", { duration = duration })
	if modifier then
		modifier:SetStackCount(#enemies)
	end

	caster:EmitSound("Hero_Terrorblade.Sunder.Cast")

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			ability = self,
			damage = sunderdamage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
				+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		})
	end
end

--------------------------------------------------------------------------------

modifier_terrorblade_sunder_lua = class({})

function modifier_terrorblade_sunder_lua:IsHidden()
	return false
end
function modifier_terrorblade_sunder_lua:IsPurgable()
	return false
end

function modifier_terrorblade_sunder_lua:OnCreated()
	self.hp_per_stack = self:GetAbility():GetSpecialValueFor("damage")
	self.dmg_per_stack = self:GetAbility():GetSpecialValueFor("bonus_damage")

	if IsServer() then
		self:GetParent():CalculateStatBonus(true)
	end
end

function modifier_terrorblade_sunder_lua:OnRefresh()
	self:OnCreated()
end

function modifier_terrorblade_sunder_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}
end

function modifier_terrorblade_sunder_lua:GetModifierBaseAttack_BonusDamage()
	return self:GetStackCount() * (self.dmg_per_stack or 0)
end

function modifier_terrorblade_sunder_lua:GetModifierExtraHealthBonus()
	return self:GetStackCount() * (self.hp_per_stack or 0)
end