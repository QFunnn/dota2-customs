--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dazzle_poison_touch_lua", "heroes/hero_dazzle/hero_dazzle", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_poison_touch_lua_effect", "heroes/hero_dazzle/hero_dazzle", LUA_MODIFIER_MOTION_NONE)

dazzle_poison_touch_lua = class({})

function dazzle_poison_touch_lua:GetIntrinsicModifierName()
	return "modifier_dazzle_poison_touch_lua"
end

modifier_dazzle_poison_touch_lua = class({})

function modifier_dazzle_poison_touch_lua:IsHidden()
	return true
end
function modifier_dazzle_poison_touch_lua:IsPurgeException()
	return false
end
function modifier_dazzle_poison_touch_lua:IsPurgable()
	return false
end
function modifier_dazzle_poison_touch_lua:RemoveOnDeath()
	return false
end
function modifier_dazzle_poison_touch_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_dazzle_poison_touch_lua:OnAttack(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() then
		return
	end
	local chance = self:GetAbility():GetSpecialValueFor("chance")
	if RollPercentage(chance) then
		self:PoisonCast(params.attacker, params.target)
	end
end

function modifier_dazzle_poison_touch_lua:PoisonCast(caster, target)
	if not IsServer() then
		return
	end
	local origin = caster:GetOrigin()
	local max_targets = self:GetAbility():GetSpecialValueFor("targets")
	local distance = 600
	local start_radius = 200
	local end_radius = 300
	local projectile_speed = 1300

	local direction = target:GetOrigin() - origin
	direction.z = 0
	direction = direction:Normalized()

	local enemies = self:FindUnitsInCone(
		caster:GetTeamNumber(), -- nTeamNumber
		target:GetOrigin(), -- vCenterPos
		caster:GetOrigin(), -- vStartPos
		caster:GetOrigin() + direction * distance, -- vEndPos
		start_radius, -- fStartRadius
		end_radius, -- fEndRadius
		nil, -- hCacheUnit
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- nTeamFilter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- nTypeFilter
		0, -- nFlagFilter
		FIND_CLOSEST, -- nOrderFilter
		false -- bCanGrowCache
	)

	local projectile_name = "particles/units/heroes/hero_dazzle/dazzle_poison_touch.vpcf"

	local info = {
		Source = caster,
		Ability = self:GetAbility(),
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true, -- Optional
		bVisibleToEnemies = true, -- Optional
		bProvidesVision = false, -- Optional
	}

	local counter = 0
	for _, enemy in pairs(enemies) do
		info.Target = enemy
		ProjectileManager:CreateTrackingProjectile(info)
		counter = counter + 1
		if counter >= max_targets then
			break
		end
	end
	EmitSoundOn("Hero_Dazzle.Poison_Cast", caster)
end

function dazzle_poison_touch_lua:OnProjectileHit(target, location)
	if not target then
		return
	end
	local duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_dazzle_poison_touch_lua_effect", -- modifier name
		{ duration = duration } -- kv
	)
	EmitSoundOn("Hero_Dazzle.Poison_Touch", target)
end

function modifier_dazzle_poison_touch_lua:FindUnitsInCone(
	nTeamNumber,
	vCenterPos,
	vStartPos,
	vEndPos,
	fStartRadius,
	fEndRadius,
	hCacheUnit,
	nTeamFilter,
	nTypeFilter,
	nFlagFilter,
	nOrderFilter,
	bCanGrowCache
)
	local direction = vEndPos - vStartPos
	direction.z = 0
	local distance = direction:Length2D()
	direction = direction:Normalized()
	local big_radius = distance + math.max(fStartRadius, fEndRadius)
	local units = FindUnitsInRadius(
		nTeamNumber, -- int, your team number
		vCenterPos, -- point, center point
		nil, -- handle, cacheUnit. (not known)
		big_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		nTeamFilter, -- int, team filter
		nTypeFilter, -- int, type filter
		nFlagFilter, -- int, flag filter
		nOrderFilter, -- int, order filter
		bCanGrowCache -- bool, can grow cache
	)
	local targets = {}
	for _, unit in pairs(units) do
		local vUnitPos = unit:GetOrigin() - vStartPos
		local fProjection = vUnitPos.x * direction.x + vUnitPos.y * direction.y + vUnitPos.z * direction.z
		fProjection = math.max(math.min(fProjection, distance), 0)
		local vProjection = direction * fProjection
		local fUnitRadius = (vUnitPos - vProjection):Length2D()
		local fInterpRadius = (fProjection / distance) * (fEndRadius - fStartRadius) + fStartRadius
		if fUnitRadius <= fInterpRadius then
			table.insert(targets, unit)
		end
	end
	return targets
end

--------------------------------------------------------------------------------

modifier_dazzle_poison_touch_lua_effect = class({})

function modifier_dazzle_poison_touch_lua_effect:IsHidden()
	return false
end

function modifier_dazzle_poison_touch_lua_effect:IsDebuff()
	return true
end

function modifier_dazzle_poison_touch_lua_effect:IsStunDebuff()
	return false
end

function modifier_dazzle_poison_touch_lua_effect:IsPurgable()
	return true
end

function modifier_dazzle_poison_touch_lua_effect:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_dazzle_poison_touch_lua_effect:OnCreated(kv)
	local damage = self:GetAbility():GetSpecialValueFor("damage")
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	self.duration = kv.duration

	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self,
	}
	self:StartIntervalThink(1)
	self:OnIntervalThink()
end

function modifier_dazzle_poison_touch_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_dazzle_poison_touch_lua_effect:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if params.target ~= self:GetParent() then
		return
	end
	self:SetDuration(self.duration, true)
end

function modifier_dazzle_poison_touch_lua_effect:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_dazzle_poison_touch_lua_effect:OnIntervalThink()
	ApplyDamage(self.damageTable)
	EmitSoundOn("Hero_Dazzle.Poison_Tick", self:GetParent())
end

function modifier_dazzle_poison_touch_lua_effect:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf"
end

function modifier_dazzle_poison_touch_lua_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_dazzle_poison_touch_lua_effect:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_dazzle_copy.vpcf"
end

---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_dazzle_shallow_grave_lua", "heroes/hero_dazzle/hero_dazzle", LUA_MODIFIER_MOTION_NONE)

dazzle_shallow_grave_lua = class({})

function dazzle_shallow_grave_lua:IsHiddenWhenStolen()
	return false
end

function dazzle_shallow_grave_lua:GetAOERadius()
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_dazzle_8")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		return self:GetSpecialValueFor("radius")
	end
	return 0
end

function dazzle_shallow_grave_lua:GetBehavior()
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_dazzle_8")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
		+ DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
		+ DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end

function dazzle_shallow_grave_lua:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local radius = ability:GetSpecialValueFor("radius")
	local duration = ability:GetSpecialValueFor("duration")

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_dazzle_8")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		local target_point = self:GetCursorPosition()

		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target_point,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, unit in pairs(units) do
			unit:AddNewModifier(caster, ability, "modifier_dazzle_shallow_grave_lua", { duration = duration })
		end
	else
		target = self:GetCursorTarget()
		target:AddNewModifier(caster, ability, "modifier_dazzle_shallow_grave_lua", { duration = duration })
	end
end

-----------------------------------------------------------------------------------------

modifier_dazzle_shallow_grave_lua = class({})

function modifier_dazzle_shallow_grave_lua:IsHidden()
	return false
end

function modifier_dazzle_shallow_grave_lua:IsDebuff()
	return false
end

function modifier_dazzle_shallow_grave_lua:IsPurgable()
	return false
end

function modifier_dazzle_shallow_grave_lua:OnCreated(kv)
	local sound_cast = "Hero_Dazzle.Shallow_Grave"
	self.hp = self:GetAbility():GetSpecialValueFor("hp")
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_dazzle_shallow_grave_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
	return funcs
end
function modifier_dazzle_shallow_grave_lua:GetMinHealth()
	return 1
end

function modifier_dazzle_shallow_grave_lua:GetModifierHealthRegenPercentage()
	return self.hp
end

function modifier_dazzle_shallow_grave_lua:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_shallow_grave.vpcf"
end

function modifier_dazzle_shallow_grave_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_dazzle_shadow_wave_lua", "heroes/hero_dazzle/hero_dazzle", LUA_MODIFIER_MOTION_NONE)

dazzle_shadow_wave_lua = class({})

function dazzle_shadow_wave_lua:GetCastRange()
	return 400 + self:GetCaster():GetCastRangeBonus()
end

function dazzle_shadow_wave_lua:OnSpellStart()
	local caster = self:GetCaster()

	local heal = self:GetSpecialValueFor("heal")
	local damage = self:GetSpecialValueFor("damage")
	local duration = self:GetSpecialValueFor("duration")

	if not IsServer() then
		return
	end

	local range = self:GetCastRange(self:GetCaster():GetAbsOrigin(), self:GetCaster())
		+ self:GetCaster():GetCastRangeBonus()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		nil,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self,
		})

		caster:Heal(heal, self)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, caster, heal, nil)

		enemy:AddNewModifier(caster, self, "modifier_dazzle_shadow_wave_lua", { duration = duration })

		self:PlayEffects1(caster, enemy)
	end
	EmitSoundOn("Hero_Dazzle.Shadow_Wave", caster)
end

function dazzle_shadow_wave_lua:PlayEffects1(source, target)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dazzle/dazzle_shadow_wave.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		source
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		source:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function dazzle_shadow_wave_lua:PlayEffects2(target)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dazzle/dazzle_shadow_wave_impact_damage.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-----------------------------------------------------------

modifier_dazzle_shadow_wave_lua = class({})

function modifier_dazzle_shadow_wave_lua:IsHidden()
	return false
end

function modifier_dazzle_shadow_wave_lua:IsDebuff()
	return false
end

function modifier_dazzle_shadow_wave_lua:IsPurgable()
	return false
end

function modifier_dazzle_shadow_wave_lua:OnCreated(kv)
	self.disarm = self:GetAbility():GetSpecialValueFor("disarm")
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_dazzle_shadow_wave_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_dazzle_shadow_wave_lua:GetModifierPhysicalArmorBonus()
	return -self.disarm
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

LinkLuaModifier("modifier_dazzle_custom_badjuju", "heroes/hero_dazzle/hero_dazzle", LUA_MODIFIER_MOTION_NONE)

dazzle_custom_badjuju = class({})

function dazzle_custom_badjuju:GetIntrinsicModifierName()
	return "modifier_dazzle_custom_badjuju"
end

----------------------------------------------------------------------

modifier_dazzle_custom_badjuju = class({})

function modifier_dazzle_custom_badjuju:IsHidden()
	return true
end

function modifier_dazzle_custom_badjuju:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function modifier_dazzle_custom_badjuju:IsPurgable()
	return false
end
function modifier_dazzle_custom_badjuju:RemoveOnDeath()
	return false
end

function modifier_dazzle_custom_badjuju:GetModifierPercentageCooldown()
	return self:GetAbility():GetSpecialValueFor("cooldown_reduc")
end

function modifier_dazzle_custom_badjuju:GetModifierSpellAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("spell_amplify")
end