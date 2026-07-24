--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_travel_boots_custom", "items/item_travel_boots_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_travel_boots_2_custom", "items/item_travel_boots_custom", LUA_MODIFIER_MOTION_NONE)

item_travel_boots_custom = class({})

function item_travel_boots_custom:GetIntrinsicModifierName()
	return "modifier_item_travel_boots_custom"
end

item_travel_boots_2_custom = class({})

function item_travel_boots_2_custom:GetIntrinsicModifierName()
	return "modifier_item_travel_boots_2_custom"
end

modifier_item_travel_boots_custom = class({})

function modifier_item_travel_boots_custom:IsHidden() return self:GetStackCount() == 1 end
function modifier_item_travel_boots_custom:IsPurgable() return false end
function modifier_item_travel_boots_custom:IsPurgeException() return false end

function modifier_item_travel_boots_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}
end

function modifier_item_travel_boots_custom:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(FrameTime())
end

function modifier_item_travel_boots_custom:OnIntervalThink()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_item_travel_boots_2_custom") then
		self:SetStackCount(1)
		return
	end
	if self:GetParent():IsMoving() or self:GetParent():HasModifier("modifier_pangolier_gyroshell_custom") then
		self:SetStackCount(0)
	else
		self:SetStackCount(1)
	end
end

function modifier_item_travel_boots_custom:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("movement_bonus_health_regen") * (1 - self:GetStackCount())
end

function modifier_item_travel_boots_custom:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("movement_bonus_mana_regen") * (1 - self:GetStackCount())
end

function modifier_item_travel_boots_custom:GetModifierMoveSpeedBonus_Special_Boots()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end

function modifier_item_travel_boots_custom:GetModifierMoveSpeed_Limit()
    local new_max = self:GetAbility():GetSpecialValueFor("bonus_movespeed_limit")
    if self:GetParent():HasModifier("modifier_windrunner_tailwind_custom") then
        new_max = math.max(new_max, 600)
    end
    if self:GetParent():HasModifier("modifier_spirit_breaker_charge_of_darkness_custom") then return end
    if self:GetParent():HasModifier("modifier_spirit_breaker_charge_of_darkness_custom_bonus") then return end
    if self:GetParent():HasModifier("modifier_abaddon_9") and self:GetParent():HasModifier("modifier_abaddon_jousting_charge") then return end
    if self:GetParent():HasModifier("modifier_roshan_bash_custom_active") then return end
	return new_max
end

function modifier_item_travel_boots_custom:GetModifierIgnoreMovespeedLimit()
    if self:GetParent():HasModifier("modifier_spirit_breaker_charge_of_darkness_custom") then return end
    if self:GetParent():HasModifier("modifier_spirit_breaker_charge_of_darkness_custom_bonus") then return end
    if self:GetParent():HasModifier("modifier_abaddon_9") and self:GetParent():HasModifier("modifier_abaddon_jousting_charge") then return end
    if self:GetParent():HasModifier("modifier_roshan_bash_custom_active") then return end
	return 1
end

modifier_item_travel_boots_2_custom = class({})

function modifier_item_travel_boots_2_custom:IsHidden() return self:GetStackCount() == 1 end
function modifier_item_travel_boots_2_custom:IsPurgable() return false end
function modifier_item_travel_boots_2_custom:IsPurgeException() return false end

function modifier_item_travel_boots_2_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT, 

	}
end

function modifier_item_travel_boots_2_custom:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(FrameTime())
end

function modifier_item_travel_boots_2_custom:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():IsMoving() or self:GetParent():HasModifier("modifier_pangolier_gyroshell_custom") then
		self:SetStackCount(0)
	else
		self:SetStackCount(1)
	end
end

function modifier_item_travel_boots_2_custom:GetModifierMoveSpeedBonus_Special_Boots()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end

function modifier_item_travel_boots_2_custom:GetModifierMoveSpeed_Limit()
    local new_max = self:GetAbility():GetSpecialValueFor("bonus_movespeed_limit")
    if self:GetParent():HasModifier("modifier_windrunner_tailwind_custom") then
        new_max = math.max(new_max, 600)
    end
    if self:GetParent():HasModifier("modifier_spirit_breaker_charge_of_darkness_custom") then return end
    if self:GetParent():HasModifier("modifier_spirit_breaker_charge_of_darkness_custom_bonus") then return end
    if self:GetParent():HasModifier("modifier_abaddon_9") and self:GetParent():HasModifier("modifier_abaddon_jousting_charge") then return end
    if self:GetParent():HasModifier("modifier_roshan_bash_custom_active") then return end
	return new_max
end

function modifier_item_travel_boots_2_custom:GetModifierIgnoreMovespeedLimit()
    if self:GetParent():HasModifier("modifier_spirit_breaker_charge_of_darkness_custom") then return end
    if self:GetParent():HasModifier("modifier_spirit_breaker_charge_of_darkness_custom_bonus") then return end
    if self:GetParent():HasModifier("modifier_abaddon_9") and self:GetParent():HasModifier("modifier_abaddon_jousting_charge") then return end
    if self:GetParent():HasModifier("modifier_roshan_bash_custom_active") then return end
	return 1
end

function modifier_item_travel_boots_2_custom:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("movement_bonus_health_regen") * (1 - self:GetStackCount())
end

function modifier_item_travel_boots_2_custom:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("movement_bonus_mana_regen") * (1 - self:GetStackCount())
end