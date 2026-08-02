--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phantom_assassin_knifes_attack", "heroes/hero_phantom/hero_phantom", LUA_MODIFIER_MOTION_NONE)

phantom_assassin_knifes = class({})

function phantom_assassin_knifes:GetCastRange(location, target)
	return self.BaseClass.GetCastRange(self, location, target)
end

function phantom_assassin_knifes:OnAbilityPhaseStart()
	self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_4)
	return true
end

function phantom_assassin_knifes:OnAbilityPhaseInterrupted()
	self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_4)
end

function phantom_assassin_knifes:OnSpellStart()
	local caster = self:GetCaster()
	local target_point = self:GetCursorPosition()
	local caster_pos = caster:GetAbsOrigin()

	local main_direction = (target_point - caster_pos):Normalized()
	main_direction.z = 0

	local count = self:GetSpecialValueFor("count")
	local angle_step = 15
	local speed = 900

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster_pos,
		bDeleteOnHit = true,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		EffectName = "particles/dzin/ultimate_knife.vpcf",
		fDistance = 800,
		fStartRadius = 115,
		fEndRadius = 115,
		bReplaceExisting = false,
		bProvidesVision = false,
	}

	caster:EmitSound("Hero_PhantomAssassin.Dagger.Cast")

	local start_angle = -(math.floor(count / 2)) * angle_step

	for i = 0, count - 1 do
		local current_angle = start_angle + (i * angle_step)
		local rotation = QAngle(0, current_angle, 0)
		local direction = RotatePosition(Vector(0, 0, 0), rotation, main_direction)

		info.vVelocity = direction * speed
		ProjectileManager:CreateLinearProjectile(info)
	end
end

function phantom_assassin_knifes:OnProjectileHit(target, vLocation)
	if not IsServer() then
		return
	end
	if target ~= nil then
		local modifier = self:GetCaster()
			:AddNewModifier(self:GetCaster(), self, "modifier_phantom_assassin_knifes_attack", {})
		self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
		modifier:Destroy()
		target:EmitSound("Hero_PhantomAssassin.Dagger.Target")
	end
	return true
end

-------------------------------------------------------------------------------

modifier_phantom_assassin_knifes_attack = class({})

function modifier_phantom_assassin_knifes_attack:IsHidden()
	return true
end

function modifier_phantom_assassin_knifes_attack:IsPurgable()
	return false
end

function modifier_phantom_assassin_knifes_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_phantom_assassin_knifes_attack:GetModifierPreAttack_BonusDamage(params)
	if IsServer() then
		return self:GetAbility():GetSpecialValueFor("damage")
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_phantom_assassin_phantom_strike_crit",
	"heroes/hero_phantom/hero_phantom",
	LUA_MODIFIER_MOTION_NONE
)

phantom_assassin_phantom_strike_lua = class({})

function phantom_assassin_phantom_strike_lua:CastFilterResultTarget(hTarget)
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local result = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)

	if result ~= UF_SUCCESS then
		return result
	end

	return UF_SUCCESS
end

function phantom_assassin_phantom_strike_lua:GetCustomCastErrorTarget(hTarget)
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
	return ""
end

function phantom_assassin_phantom_strike_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local origin = caster:GetOrigin()

	if
		target:GetModelName() == "models/items/earthshaker/totem_dragon_wall/fissure_body.vmdl"
		or target:GetModelName() == "models/machinegun_new.vmdl"
	then
		return
	end

	local duration = self:GetSpecialValueFor("duration")
	local blinkDistance = 50
	local blinkDirection = (caster:GetOrigin() - target:GetOrigin()):Normalized() * blinkDistance
	local blinkPosition = target:GetOrigin() + blinkDirection

	caster:SetOrigin(blinkPosition)
	FindClearSpaceForUnit(caster, blinkPosition, true)

	if target:GetTeamNumber() ~= caster:GetTeamNumber() then
		caster:AddNewModifier(caster, self, "modifier_phantom_assassin_phantom_strike_crit", { duration = duration })
		caster:MoveToTargetToAttack(target)
	end

	self:PlayEffects(origin)
end

function phantom_assassin_phantom_strike_lua:PlayEffects(origin)
	local effect_cast_start = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_start.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast_start, 0, origin)
	ParticleManager:ReleaseParticleIndex(effect_cast_start)
	local effect_cast_end = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast_end, 0, self:GetCaster():GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast_end)
	local sound_cast_1 = "Hero_PhantomAssassin.Strike.Start"
	-- EmitSoundOnLocationWithCaster( origin, sound_cast_1, self:GetCaster() )
	EmitSoundOn(sound_cast_1, self:GetCaster())
	local sound_cast_2 = "Hero_PhantomAssassin.Strike.End"
	-- EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast_2, self:GetCaster() )
	EmitSoundOn(sound_cast_2, self:GetCaster())
end

-------------------------------------------------------------------------------

modifier_phantom_assassin_phantom_strike_crit = class({})

function modifier_phantom_assassin_phantom_strike_crit:IsHidden()
	return false
end

function modifier_phantom_assassin_phantom_strike_crit:IsPurgable()
	return false
end

function modifier_phantom_assassin_phantom_strike_crit:OnCreated()
	self.crit_bonus = self:GetAbility():GetSpecialValueFor("crit_bonus")
end

function modifier_phantom_assassin_phantom_strike_crit:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_phantom_assassin_phantom_strike_crit:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() and not self:GetParent():PassivesDisabled() then
		return self.crit_bonus
	end
end

function modifier_phantom_assassin_phantom_strike_crit:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		self:PlayEffects(params.target)
	end
end

function modifier_phantom_assassin_phantom_strike_crit:PlayEffects(target)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(
		effect_cast,
		1,
		(self:GetParent():GetOrigin() - target:GetOrigin()):Normalized()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_blur_aura", "heroes/hero_phantom/hero_phantom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_blur_passive", "heroes/hero_phantom/hero_phantom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_blur_active", "heroes/hero_phantom/hero_phantom", LUA_MODIFIER_MOTION_NONE)

phantom_assassin_blur_lua = class({})

function phantom_assassin_blur_lua:GetCastRange(location, target)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_phantom_assassin_6")
	if talent and talent:GetLevel() > 0 then
		return 600
	end
	return 0
end

function phantom_assassin_blur_lua:GetIntrinsicModifierName()
	return "modifier_blur_aura"
end

function phantom_assassin_blur_lua:OnSpellStart()
	if IsServer() then
		ProjectileManager:ProjectileDodge(self:GetCaster())
		self:GetCaster():AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_blur_active",
			{ duration = self:GetSpecialValueFor("duration") }
		)
		self:GetCaster():Purge(false, true, false, false, false)
	end
end

-------------------------------------------------------------------------------

modifier_blur_active = class({})

function modifier_blur_active:IsHidden()
	return false
end
function modifier_blur_active:IsDebuff()
	return false
end
function modifier_blur_active:IsPurgable()
	return false
end

function modifier_blur_active:GetEffectName()
	return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end

function modifier_blur_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_blur_active:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end
	if IsServer() then
		self:GetParent():EmitSound("Hero_PhantomAssassin.Blur")
	end
end

function modifier_blur_active:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
	}
end

function modifier_blur_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_blur_active:GetModifierInvisibilityLevel()
	return 1
end

function modifier_blur_active:OnAttackLanded(keys)
	if keys.attacker == self:GetParent() then
		self:Destroy()
	end
end

-------------------------------------------------------------------------------

modifier_blur_aura = class({})

function modifier_blur_aura:IsHidden()
	return true
end
function modifier_blur_aura:IsPurgable()
	return false
end

function modifier_blur_aura:GetAuraEntityReject(target)
	if self:GetCaster() == target then
		return false
	end
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_phantom_assassin_6")
	if talent and talent:GetLevel() > 0 then
		return false
	end
	return true
end

function modifier_blur_aura:GetAuraRadius()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_phantom_assassin_6")
	if talent and talent:GetLevel() > 0 then
		return 600
	end
	return 0
end

function modifier_blur_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_blur_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_blur_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_blur_aura:GetModifierAura()
	return "modifier_blur_passive"
end
function modifier_blur_aura:IsAura()
	return true
end

-------------------------------------------------------------------------------

modifier_blur_passive = class({})

function modifier_blur_passive:IsHidden()
	return false
end
function modifier_blur_passive:IsPurgable()
	return false
end

function modifier_blur_passive:OnCreated()
	self.evasion = self:GetAbility():GetSpecialValueFor("bonus_evasion")
end

function modifier_blur_passive:OnRefresh()
	self.evasion = self:GetAbility():GetSpecialValueFor("bonus_evasion")
end

function modifier_blur_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
end

function modifier_blur_passive:GetModifierEvasion_Constant()
	if self:GetParent() == self:GetCaster() then
		return self.evasion
	end
	return self.evasion / 2
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_phantom_assassin_coup_de_grace_lua",
	"heroes/hero_phantom/hero_phantom",
	LUA_MODIFIER_MOTION_NONE
)

phantom_assassin_coup_de_grace_lua = class({})

function phantom_assassin_coup_de_grace_lua:GetIntrinsicModifierName()
	return "modifier_phantom_assassin_coup_de_grace_lua"
end

-------------------------------------------------------------------------------

modifier_phantom_assassin_coup_de_grace_lua = class({})

function modifier_phantom_assassin_coup_de_grace_lua:IsHidden()
	return true
end
function modifier_phantom_assassin_coup_de_grace_lua:IsPurgable()
	return false
end

function modifier_phantom_assassin_coup_de_grace_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_phantom_assassin_coup_de_grace_lua:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() and not self:GetParent():PassivesDisabled() then
		if RollPercentage(self:GetAbility():GetSpecialValueFor("crit_chance")) then
			self.record = params.record
			return self:GetAbility():GetSpecialValueFor("crit_bonus")
		end
	end
end

function modifier_phantom_assassin_coup_de_grace_lua:GetModifierProcAttack_Feedback(params)
	if IsServer() and self.record == params.record then
		self.record = nil
		self:PlayEffects(params.target)
	end
end

function modifier_phantom_assassin_coup_de_grace_lua:PlayEffects(target)
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(pfx, 1, (self:GetParent():GetOrigin() - target:GetOrigin()):Normalized())
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target)
end