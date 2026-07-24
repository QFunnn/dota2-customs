--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_flicker_custom", "items/item_flicker_custom", LUA_MODIFIER_MOTION_NONE)

item_flicker_custom = class({})

function item_flicker_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	if point == self:GetCaster():GetAbsOrigin() then 
		point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()
	end
	local origin = self:GetCaster():GetAbsOrigin()

	local max_range = self:GetSpecialValueFor("max_range")
	local min_range = self:GetSpecialValueFor("min_range")

	local direction = (point - origin)
	direction.z = 0

	self:GetCaster():SetForwardVector(direction:Normalized())
	self:GetCaster():Stop()

	local range = direction:Length2D()

	if range < min_range then
		range = math.max(range, min_range)
	end

	if range > max_range then
		range = math.min(range, max_range)
	end
	
	direction = direction:Normalized() * range
	direction.z = 0

	local effect_cast_a = ParticleManager:CreateParticle( "particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_a, 0, origin )
	ParticleManager:SetParticleControlForward( effect_cast_a, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	EmitSoundOnLocationWithCaster( origin, "DOTA_Item.BlinkDagger.Activate", self:GetCaster() )

	FindClearSpaceForUnit( self:GetCaster(), origin + direction, true )

	local effect_cast_b = ParticleManager:CreateParticle( "particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast_b, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "DOTA_Item.BlinkDagger.Activate", self:GetCaster() )
end

function item_flicker_custom:GetIntrinsicModifierName()
	return "modifier_item_flicker_custom"
end

modifier_item_flicker_custom = class({})

function modifier_item_flicker_custom:IsHidden() return true end

function modifier_item_flicker_custom:IsPurgable() return false end
function modifier_item_flicker_custom:IsPurgeException() return false end

function modifier_item_flicker_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_item_flicker_custom:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed") 
end

function modifier_item_flicker_custom:OnTakeDamage(params)
	if params.unit ~= self:GetParent() then return end

	if params.attacker == self:GetParent() then return end

	if self:GetAbility():GetCooldownTimeRemaining() <= 3 or self:GetAbility():IsCooldownReady() then
		self:GetAbility():EndCooldown()
		self:GetAbility():StartCooldown(self:GetAbility():GetSpecialValueFor("cooldown_attack"))
	end
end