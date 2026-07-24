--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_spider_legs_custom", "items/item_spider_legs_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_spider_legs_custom_buff", "items/item_spider_legs_custom", LUA_MODIFIER_MOTION_NONE)

item_spider_legs_custom = class({})

function item_spider_legs_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_spider_legs_custom_buff", {duration = duration})
	self:GetCaster():EmitSound("DOTA_Item.SpiderLegs.Cast")
end

function item_spider_legs_custom:GetIntrinsicModifierName()
	return "modifier_item_spider_legs_custom"
end

modifier_item_spider_legs_custom = class({})

function modifier_item_spider_legs_custom:IsHidden() return true end

function modifier_item_spider_legs_custom:IsPurgable() return false end
function modifier_item_spider_legs_custom:IsPurgeException() return false end

function modifier_item_spider_legs_custom:OnCreated()
	self.bonus_movement_speed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
	self.turn_rate = self:GetAbility():GetSpecialValueFor("turn_rate")
end

function modifier_item_spider_legs_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE
	}
end

function modifier_item_spider_legs_custom:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_movement_speed
end

function modifier_item_spider_legs_custom:GetModifierAttackSpeedBonus_Constant()
	return self.turn_rate
end

modifier_item_spider_legs_custom_buff = class({})

function modifier_item_spider_legs_custom_buff:OnCreated()
	self.bonus_movement_speed_active = self:GetAbility():GetSpecialValueFor("bonus_movement_speed_active")
	if not IsServer() then return end
	self.particle = ParticleManager:CreateParticle("particles/items5_fx/spider_legs_buff.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControlEnt( self.particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, nil, self:GetParent():GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, nil, self:GetParent():GetOrigin(), true )
    self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_item_spider_legs_custom_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_spider_legs_custom_buff:CheckState()
	return {
		[MODIFIER_STATE_UNSLOWABLE] = true,
	}
end

function modifier_item_spider_legs_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movement_speed_active
end