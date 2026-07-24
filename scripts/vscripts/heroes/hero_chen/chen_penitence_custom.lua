--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_chen_penitence_custom_debuff", "heroes/hero_chen/chen_penitence_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chen_penitence_custom_buff", "heroes/hero_chen/chen_penitence_custom", LUA_MODIFIER_MOTION_NONE)

chen_penitence_custom = class({})

function chen_penitence_custom:GetAOERadius()
	return self:GetSpecialValueFor("aoe_radius")
end

function chen_penitence_custom:OnSpellStart()
	if not IsServer() then return end

	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local radius = self:GetSpecialValueFor("aoe_radius")

	self:GetCaster():EmitSound("Hero_Chen.PenitenceCast")

	if self:GetCaster():HasTalent("special_bonus_unique_chen_11") then
		local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
		for _, unit in pairs(units) do
			self:CastProjectile(unit)
		end
	else
		self:CastProjectile(target)
	end
end

function chen_penitence_custom:OnProjectileHit(target, point)
	if not IsServer() then return end
	if target == nil then return end
	local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("damage")
	target:AddNewModifier(self:GetCaster(), self, "modifier_chen_penitence_custom_debuff", {duration = duration})
	if self:GetCaster():HasTalent("special_bonus_unique_chen_11") then
		ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self, damage_flags = DOTA_DAMAGE_FLAG_NONE })
	end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_penitence.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	target:EmitSound("Hero_Chen.PenitenceImpact")
end

function chen_penitence_custom:CastProjectile(target)
	ProjectileManager:CreateTrackingProjectile({
		EffectName			= "particles/units/heroes/hero_chen/chen_penitence_proj.vpcf",
		Ability				= self,
		Source				= self:GetCaster(),
		vSourceLoc			= self:GetCaster():GetAbsOrigin(),
		Target				= target,
		iMoveSpeed			= 1400,
		flExpireTime		= nil,
		bDodgeable			= false,
		bIsAttack			= false,
		bReplaceExisting	= false,
		iSourceAttachment	= nil,
		bDrawsOnMinimap		= nil,
		bVisibleToEnemies	= true,
		bProvidesVision		= false,
		iVisionRadius		= nil,
		iVisionTeamNumber	= nil,
		ExtraData			= {}
	})
end

modifier_chen_penitence_custom_debuff = class({})

function modifier_chen_penitence_custom_debuff:OnCreated()
	self.movespeed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end

function modifier_chen_penitence_custom_debuff:OnRefresh()
	self:OnCreated()
end

function modifier_chen_penitence_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_chen_penitence_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_chen_penitence_custom_debuff:AttackStartModifier(params)
	if params.target ~= self:GetParent() then return end
	params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_chen_penitence_custom_buff", {duration = 2})
end

modifier_chen_penitence_custom_buff = class({})

function modifier_chen_penitence_custom_buff:OnCreated()
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.self_attack_range_bonus = self:GetAbility():GetSpecialValueFor("self_attack_range_bonus")
end

function modifier_chen_penitence_custom_buff:OnRefresh()
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.self_attack_range_bonus = self:GetAbility():GetSpecialValueFor("self_attack_range_bonus")
end

function modifier_chen_penitence_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
	}
end

function modifier_chen_penitence_custom_buff:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_chen_penitence_custom_buff:GetModifierAttackRangeBonus(params)
    return self.self_attack_range_bonus
end