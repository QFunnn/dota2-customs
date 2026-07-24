--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_bullwhip_custom", "items/item_bullwhip_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_bullwhip_custom_buff", "items/item_bullwhip_custom", LUA_MODIFIER_MOTION_NONE)

item_bullwhip_custom = class({})

function item_bullwhip_custom:GetIntrinsicModifierName()
	return "modifier_item_bullwhip_custom"
end

function item_bullwhip_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	local particle = ParticleManager:CreateParticle("particles/items4_fx/bull_whip.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * 1400 )
	ParticleManager:SetParticleControlEnt( particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )
	ParticleManager:ReleaseParticleIndex(particle)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_bullwhip_custom_buff", {duration = duration})
	self:GetCaster():EmitSound("Item.Bullwhip.Cast")
	self:GetCaster():EmitSound("Item.Bullwhip.Ally")
end

modifier_item_bullwhip_custom = class({})

function modifier_item_bullwhip_custom:IsHidden() return true end

function modifier_item_bullwhip_custom:IsPurgable() return false end
function modifier_item_bullwhip_custom:IsPurgeException() return false end

function modifier_item_bullwhip_custom:OnCreated()
	self.bonus_health_regen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_bullwhip_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
end

function modifier_item_bullwhip_custom:GetModifierConstantHealthRegen()
	return self.bonus_health_regen
end

function modifier_item_bullwhip_custom:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end

modifier_item_bullwhip_custom_buff = class({})

function modifier_item_bullwhip_custom_buff:OnCreated()
	self.speed = self:GetAbility():GetSpecialValueFor("speed")
end

function modifier_item_bullwhip_custom_buff:IsPurgable() return true end

function modifier_item_bullwhip_custom_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_item_bullwhip_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.speed
end