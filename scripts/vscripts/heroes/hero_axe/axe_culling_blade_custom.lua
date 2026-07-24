--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_axe_culling_blade_custom", "heroes/hero_axe/axe_culling_blade_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_culling_blade_custom_armor", "heroes/hero_axe/axe_culling_blade_custom", LUA_MODIFIER_MOTION_NONE )

axe_culling_blade_custom = class({})

axe_culling_blade_custom.bRoundDueled = false

function axe_culling_blade_custom:GetIntrinsicModifierName()
	return "modifier_axe_culling_blade_custom_armor"
end

function axe_culling_blade_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local damage = self:GetSpecialValueFor("damage")
	local threshold = self:GetSpecialValueFor("kill_threshold")
	local radius = self:GetSpecialValueFor("speed_aoe")
	local duration = self:GetSpecialValueFor("speed_duration")

	local success = false

	local get_threshold_damage = target:GetMaxHealth() / 100 * threshold

	local start_damage = ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })

	if target:GetHealth() > get_threshold_damage then
		self:PlayEffects( target, false )
	else
		self:PlayEffects( target, true )
		ApplyDamage({ victim = target, attacker = caster, damage = target:GetHealth()+100, damage_type = DAMAGE_TYPE_PURE, ability = self, damage_flags = DOTA_DAMAGE_FLAG_HPLOSS })
	end

	if not target:IsAlive() then
		self:EndCooldown()

		local allies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

		for _,ally in pairs(allies) do
			ally:AddNewModifier( caster, self, "modifier_axe_culling_blade_custom", { duration = duration } )
		end

		if not target:IsHero() then
			if self.bRoundDueled == true then return end
			self.bRoundDueled = true
		end

		local modifier = self:GetCaster():FindModifierByName("modifier_axe_culling_blade_custom_armor")
		if modifier then
			modifier:IncrementStackCount()
		end
	end
end

function axe_culling_blade_custom:PlayEffects( target, success )
	local particle_cast = ""
	local sound_cast = ""

	if success then
		particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf"
		sound_cast = "Hero_Axe.Culling_Blade_Success"
	else
		particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade.vpcf"
		sound_cast = "Hero_Axe.Culling_Blade_Fail"
	end

	local direction = (target:GetOrigin()-self:GetCaster():GetOrigin()):Normalized()

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 4, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 3, direction )
	ParticleManager:SetParticleControlForward( effect_cast, 4, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	target:EmitSound(sound_cast)
end


modifier_axe_culling_blade_custom = class({})

function modifier_axe_culling_blade_custom:IsDebuff()
	return false
end

function modifier_axe_culling_blade_custom:IsPurgable()
	return true
end

function modifier_axe_culling_blade_custom:OnCreated( kv )
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "atk_speed_bonus" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_axe_culling_blade_custom:OnRefresh( kv )
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "atk_speed_bonus" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_axe_culling_blade_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_axe_culling_blade_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end

function modifier_axe_culling_blade_custom:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

function modifier_axe_culling_blade_custom:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_cullingblade_sprint.vpcf"
end

function modifier_axe_culling_blade_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_axe_culling_blade_custom_armor = class({})

function modifier_axe_culling_blade_custom_armor:IsHidden() return self:GetStackCount() == 0 end
function modifier_axe_culling_blade_custom_armor:IsPurgable() return false end
function modifier_axe_culling_blade_custom_armor:IsPurgeException() return false end
function modifier_axe_culling_blade_custom_armor:RemoveOnDeath() return false end

function modifier_axe_culling_blade_custom_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_axe_culling_blade_custom_armor:OnTooltip()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("armor_per_stack")
end

function modifier_axe_culling_blade_custom_armor:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("armor_per_stack")
end