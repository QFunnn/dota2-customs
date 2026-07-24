--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_giants_ring_custom = class({})
LinkLuaModifier ("modifier_item_giants_ring_custom_buff", "abilities/items/giants_ring", LUA_MODIFIER_MOTION_NONE)

function item_giants_ring_custom:Precache( context )
	PrecacheResource( "particle", "particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", context )
end

function item_giants_ring_custom:GetIntrinsicModifierName()
	return "modifier_item_giants_ring_custom_buff"
end


--------------------------------------------------------------------------------------------------------------------------------------------------


modifier_item_giants_ring_custom_buff = class({})

function modifier_item_giants_ring_custom_buff:IsHidden() return true end
function modifier_item_giants_ring_custom_buff:IsPurgable() return false end
function modifier_item_giants_ring_custom_buff:RemoveOnDeath() return false end
function modifier_item_giants_ring_custom_buff:IsBuff() return true end
function modifier_item_giants_ring_custom_buff:AllowIllusionDuplicate() return true end

function modifier_item_giants_ring_custom_buff:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not self.parent or self.parent:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
	self.movement_speed = self.ability:GetSpecialValueFor("movement_speed")
	self.model_scale = self.ability:GetSpecialValueFor("model_scale")

	if not IsServer() then return end

	self.pct_str_damage_per_second = self.ability:GetSpecialValueFor("pct_str_damage_per_second")
	self.damage_radius = self.ability:GetSpecialValueFor("damage_radius")
	self.interval = 0.5

	self.damage_table = {
		-- victim = target,
		attacker = self.parent,
		-- damage
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	}

	if self.parent:IsIllusion() or self.parent:IsTempestDouble() or self.parent:IsClone() or self.parent:IsMonkeyClone() then return end
	self:StartIntervalThink(self.interval)
end

function modifier_item_giants_ring_custom_buff:OnRefresh()
	self:OnCreated()
end

function modifier_item_giants_ring_custom_buff:CheckState()
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}
end

function modifier_item_giants_ring_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_item_giants_ring_custom_buff:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

function modifier_item_giants_ring_custom_buff:GetModifierMoveSpeedBonus_Constant()
	return self.movement_speed
end

function modifier_item_giants_ring_custom_buff:GetModifierModelScale()
	return self.model_scale
end

function modifier_item_giants_ring_custom_buff:OnIntervalThink()
	local strength = self.parent.GetStrength and self.parent:GetStrength() or 1
	local damage = strength * self.pct_str_damage_per_second * 0.01 * self.interval
	local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
	for _, enemy in pairs(enemies) do
		if enemy and not enemy:IsNull() then
			self.damage_table.victim = enemy
			self.damage_table.damage = damage
			ApplyDamage(self.damage_table)
		end
	end

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( particle, 1, Vector( self.damage_radius, self.damage_radius, self.damage_radius ) )
	ParticleManager:ReleaseParticleIndex( particle )
end