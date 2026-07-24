--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dragon_knight_dragon_blood_custom", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_blood_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_dragon_blood_custom_poison_blood", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_blood_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_dragon_blood_custom_poison_blood_stack", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_blood_custom", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_dragon_knight_dragon_blood_custom_death_buff_cooldown", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_blood_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_dragon_blood_custom_death_buff", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_blood_custom", LUA_MODIFIER_MOTION_NONE )

dragon_knight_dragon_blood_custom = class({})

dragon_knight_dragon_blood_custom.modifier_dragon_knight_2_str_multiple = {30,40,50}

dragon_knight_dragon_blood_custom.modifier_dragon_knight_12_stack_duration = {1,2,3}
dragon_knight_dragon_blood_custom.modifier_dragon_knight_12_minus_armor = -1
dragon_knight_dragon_blood_custom.modifier_dragon_knight_12_minus_magic_resistance = -2

function dragon_knight_dragon_blood_custom:GetIntrinsicModifierName()
	return "modifier_dragon_knight_dragon_blood_custom"
end

modifier_dragon_knight_dragon_blood_custom = class({})

function modifier_dragon_knight_dragon_blood_custom:IsHidden()
	return true
end

function modifier_dragon_knight_dragon_blood_custom:IsPurgable()
	return false
end

function modifier_dragon_knight_dragon_blood_custom:HasDragonForm()
    if self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_1" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_2" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_3" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_4" ) then
        return true
    end
    return false
end

function modifier_dragon_knight_dragon_blood_custom:OnCreated( kv )
	self.armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
	self.regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
    self.regen_and_armor_multiplier_during_dragon_form = self:GetAbility():GetSpecialValueFor("regen_and_armor_multiplier_during_dragon_form") / 100
end

function modifier_dragon_knight_dragon_blood_custom:OnRefresh( kv )
	self.armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
	self.regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
    self.regen_and_armor_multiplier_during_dragon_form = self:GetAbility():GetSpecialValueFor("regen_and_armor_multiplier_during_dragon_form") / 100	
end

function modifier_dragon_knight_dragon_blood_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		 
	}

	return funcs
end

function modifier_dragon_knight_dragon_blood_custom:GetModifierConstantHealthRegen()
    local mult = 1
    if self:HasDragonForm() then
        mult = 1.5
    end
	if not self:GetParent():PassivesDisabled() then
		return self.regen * mult
	end
end

function modifier_dragon_knight_dragon_blood_custom:GetModifierPhysicalArmorBonus()
    local mult = 1
    if self:HasDragonForm() then
        mult = 1 + self.regen_and_armor_multiplier_during_dragon_form
    end
	if not self:GetParent():PassivesDisabled() then
		return self.armor * mult
	end
end

function modifier_dragon_knight_dragon_blood_custom:OnAttackLanded(params)
	if params.target ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end

	if self:GetParent():HasModifier("modifier_dragon_knight_12") then
		params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_dragon_knight_dragon_blood_custom_poison_blood_stack", {duration = self:GetAbility().modifier_dragon_knight_12_stack_duration[self:GetCaster():GetTalentLevel("modifier_dragon_knight_12")] })
		params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_dragon_knight_dragon_blood_custom_poison_blood", {duration = self:GetAbility().modifier_dragon_knight_12_stack_duration[self:GetCaster():GetTalentLevel("modifier_dragon_knight_12")] })
	end
end

modifier_dragon_knight_dragon_blood_custom_poison_blood = class({})

function modifier_dragon_knight_dragon_blood_custom_poison_blood:IsPurgable() return false end

function modifier_dragon_knight_dragon_blood_custom_poison_blood:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_dragon_knight_dragon_blood_custom_poison_blood:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_dragon_knight_dragon_blood_custom_poison_blood:GetModifierPhysicalArmorBonus()
	return self:GetAbility().modifier_dragon_knight_12_minus_armor * self:GetStackCount()
end

function modifier_dragon_knight_dragon_blood_custom_poison_blood:GetModifierMagicalResistanceBonus()
	return self:GetAbility().modifier_dragon_knight_12_minus_magic_resistance * self:GetStackCount()
end

function modifier_dragon_knight_dragon_blood_custom_poison_blood:OnIntervalThink()
	if not IsServer() then return end
	local stack = self:GetParent():FindAllModifiersByName("modifier_dragon_knight_dragon_blood_custom_poison_blood_stack")
	if #stack > 0 then
		self:SetStackCount(#stack)
	else
		self:Destroy()
	end
end

function modifier_dragon_knight_dragon_blood_custom_poison_blood:GetTexture()
	return "dragon_knight_12"
end

modifier_dragon_knight_dragon_blood_custom_poison_blood_stack = class({})
function modifier_dragon_knight_dragon_blood_custom_poison_blood_stack:IsHidden() return true end
function modifier_dragon_knight_dragon_blood_custom_poison_blood_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end