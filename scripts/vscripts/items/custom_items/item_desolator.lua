--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_blight_stone_lua", "items/custom_items/item_desolator.lua", LUA_MODIFIER_MOTION_NONE) -- Owner's bonus attributes, stackable
LinkLuaModifier(
	"modifier_item_blight_stone_lua_debuff",
	"items/custom_items/item_desolator.lua",
	LUA_MODIFIER_MOTION_NONE
) -- Armor/vision debuff

item_blight_stone_lua = item_blight_stone_lua or class({})

function item_blight_stone_lua:GetIntrinsicModifierName()
	return "modifier_item_blight_stone_lua"
end

modifier_item_blight_stone_lua = modifier_item_blight_stone_lua or class({})

function modifier_item_blight_stone_lua:IsHidden()
	return true
end
function modifier_item_blight_stone_lua:IsPurgable()
	return false
end
function modifier_item_blight_stone_lua:RemoveOnDeath()
	return false
end
function modifier_item_blight_stone_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_blight_stone_lua:OnCreated()
	if not IsServer() then
		return
	end

	ChangeAttackProjectileImba(self:GetParent())
end

function modifier_item_blight_stone_lua:OnDestroy()
	if not IsServer() then
		return
	end

	self:GetParent():ResetRangedProjectileName()
end

function modifier_item_blight_stone_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_item_blight_stone_lua:OnAttackLanded(keys)
	if not IsServer() then
		return
	end

	local owner = self:GetParent()
	if owner ~= keys.attacker then
		return
	end

	local target = keys.target
	if owner:IsIllusion() then
		return
	end

	if
		target:HasModifier("modifier_item_desolator_lua_debuff")
		or target:HasModifier("modifier_item_desolator_lua_2_debuff")
		or target:HasModifier("modifier_item_desolator_lua_3_debuff")
	then
		return
	end

	local ability = self:GetAbility()
	Desolate(owner, target, ability, "modifier_item_blight_stone_lua_debuff", ability:GetSpecialValueFor("duration"))
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_item_blight_stone_lua_debuff = modifier_item_blight_stone_lua_debuff or class({})

function modifier_item_blight_stone_lua_debuff:IsHidden()
	return false
end
function modifier_item_blight_stone_lua_debuff:IsDebuff()
	return true
end
function modifier_item_blight_stone_lua_debuff:IsPurgable()
	return true
end

function modifier_item_blight_stone_lua_debuff:OnCreated()
	self.armor_reduction = -ability:GetSpecialValueFor("armor_reduction")
end

function modifier_item_blight_stone_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_blight_stone_lua_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_desolator_lua", "items/custom_items/item_desolator.lua", LUA_MODIFIER_MOTION_NONE) -- Owner's bonus attributes, stackable
LinkLuaModifier("modifier_item_desolator_lua_debuff", "items/custom_items/item_desolator.lua", LUA_MODIFIER_MOTION_NONE) -- Armor/vision debuff

item_desolator_lua1 = item_desolator_lua1 or class({})

function item_desolator_lua1:GetIntrinsicModifierName()
	return "modifier_item_desolator_lua"
end

modifier_item_desolator_lua = modifier_item_desolator_lua or class({})

function modifier_item_desolator_lua:IsHidden()
	return true
end
function modifier_item_desolator_lua:IsPurgable()
	return false
end
function modifier_item_desolator_lua:RemoveOnDeath()
	return false
end
function modifier_item_desolator_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_desolator_lua:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")

	if not IsServer() then
		return
	end

	ChangeAttackProjectileImba(self:GetParent())
end

function modifier_item_desolator_lua:OnDestroy()
	if not IsServer() then
		return
	end

	self:GetParent():ResetRangedProjectileName()
end

function modifier_item_desolator_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_item_desolator_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_desolator_lua:OnAttackLanded(keys)
	if self:GetAbility() then
		local owner = self:GetParent()

		if owner ~= keys.attacker then
			return
		end

		local target = keys.target
		if owner:IsIllusion() then
			return
		end

		if
			target:HasModifier("modifier_item_desolator_lua_2_debuff")
			or target:HasModifier("modifier_item_desolator_lua_3_debuff")
		then
			return
		end

		target:RemoveModifierByName("modifier_item_blight_stone_lua_debuff")

		local ability = self:GetAbility()
		Desolate(
			owner,
			target,
			ability,
			"modifier_item_desolator_lua_debuff",
			ability:GetSpecialValueFor("corruption_duration")
		)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_item_desolator_lua_debuff = modifier_item_desolator_lua_debuff or class({})

function modifier_item_desolator_lua_debuff:IsHidden()
	return false
end
function modifier_item_desolator_lua_debuff:IsDebuff()
	return true
end
function modifier_item_desolator_lua_debuff:IsPurgable()
	return true
end

function modifier_item_desolator_lua_debuff:OnCreated()
	self.armor_reduction = -self:GetAbility():GetSpecialValueFor("corruption_armor")
end

function modifier_item_desolator_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_desolator_lua_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_desolator_lua_2", "items/custom_items/item_desolator.lua", LUA_MODIFIER_MOTION_NONE) -- Owner's bonus attributes, stackable
LinkLuaModifier(
	"modifier_item_desolator_lua_2_debuff",
	"items/custom_items/item_desolator.lua",
	LUA_MODIFIER_MOTION_NONE
) -- Armor/vision debuff

item_desolator_lua2 = item_desolator_lua2 or class({})

function item_desolator_lua2:GetIntrinsicModifierName()
	return "modifier_item_desolator_lua_2"
end

modifier_item_desolator_lua_2 = modifier_item_desolator_lua_2 or class({})

function modifier_item_desolator_lua_2:IsHidden()
	return true
end
function modifier_item_desolator_lua_2:IsPurgable()
	return false
end
function modifier_item_desolator_lua_2:RemoveOnDeath()
	return false
end
function modifier_item_desolator_lua_2:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_desolator_lua_2:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")

	if not IsServer() then
		return
	end

	ChangeAttackProjectileImba(self:GetParent())
end

function modifier_item_desolator_lua_2:OnDestroy()
	if not IsServer() then
		return
	end

	self:GetParent():ResetRangedProjectileName()
end

function modifier_item_desolator_lua_2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_item_desolator_lua_2:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_desolator_lua_2:OnAttackLanded(keys)
	if self:GetAbility() then
		local owner = self:GetParent()

		if owner ~= keys.attacker then
			return
		end

		local target = keys.target
		if owner:IsIllusion() then
			return
		end

		if target:HasModifier("modifier_item_desolator_lua_3_debuff") then
			return
		end

		target:RemoveModifierByName("modifier_item_blight_stone_lua_debuff")
		target:RemoveModifierByName("modifier_item_desolator_lua_debuff")

		local ability = self:GetAbility()
		Desolate(
			owner,
			target,
			ability,
			"modifier_item_desolator_lua_2_debuff",
			ability:GetSpecialValueFor("corruption_duration")
		)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_item_desolator_lua_2_debuff = modifier_item_desolator_lua_2_debuff or class({})

function modifier_item_desolator_lua_2_debuff:IsHidden()
	return false
end
function modifier_item_desolator_lua_2_debuff:IsDebuff()
	return true
end
function modifier_item_desolator_lua_2_debuff:IsPurgable()
	return true
end

function modifier_item_desolator_lua_2_debuff:OnCreated()
	self.armor_reduction = -self:GetAbility():GetSpecialValueFor("corruption_armor")
end

function modifier_item_desolator_lua_2_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_desolator_lua_2_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_desolator_lua_3", "items/custom_items/item_desolator.lua", LUA_MODIFIER_MOTION_NONE) -- Owner's bonus attributes, stackable
LinkLuaModifier(
	"modifier_item_desolator_lua_3_debuff",
	"items/custom_items/item_desolator.lua",
	LUA_MODIFIER_MOTION_NONE
) -- Armor/vision debuff

item_desolator_lua3 = item_desolator_lua3 or class({})

function item_desolator_lua3:GetIntrinsicModifierName()
	return "modifier_item_desolator_lua_3"
end

modifier_item_desolator_lua_3 = modifier_item_desolator_lua_3 or class({})

function modifier_item_desolator_lua_3:IsHidden()
	return true
end
function modifier_item_desolator_lua_3:IsPurgable()
	return false
end
function modifier_item_desolator_lua_3:RemoveOnDeath()
	return false
end
function modifier_item_desolator_lua_3:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_desolator_lua_3:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")

	if not IsServer() then
		return
	end

	ChangeAttackProjectileImba(self:GetParent())
end

function modifier_item_desolator_lua_3:OnDestroy()
	if not IsServer() then
		return
	end

	self:GetParent():ResetRangedProjectileName()
end

function modifier_item_desolator_lua_3:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_item_desolator_lua_3:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_desolator_lua_3:OnAttackLanded(keys)
	if self:GetAbility() then
		local owner = self:GetParent()

		if owner ~= keys.attacker then
			return
		end

		local target = keys.target
		if owner:IsIllusion() then
			return
		end

		target:RemoveModifierByName("modifier_item_blight_stone_lua_debuff")
		target:RemoveModifierByName("modifier_item_desolator_lua_debuff")
		target:RemoveModifierByName("modifier_item_desolator_lua_2_debuff")

		local ability = self:GetAbility()
		Desolate(
			owner,
			target,
			ability,
			"modifier_item_desolator_lua_3_debuff",
			ability:GetSpecialValueFor("corruption_duration")
		)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_item_desolator_lua_3_debuff = modifier_item_desolator_lua_3_debuff or class({})

function modifier_item_desolator_lua_3_debuff:IsHidden()
	return false
end
function modifier_item_desolator_lua_3_debuff:IsDebuff()
	return true
end
function modifier_item_desolator_lua_3_debuff:IsPurgable()
	return true
end

function modifier_item_desolator_lua_3_debuff:OnCreated()
	self.armor_reduction = -self:GetAbility():GetSpecialValueFor("corruption_armor")
end

function modifier_item_desolator_lua_3_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_item_desolator_lua_3_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function Desolate(attacker, target, ability, modifier_name, duration)
	if not target:HasModifier(modifier_name) then
		target:EmitSound("Item_Desolator.Target")
	end
	target:AddNewModifier(
		attacker,
		ability,
		modifier_name,
		{ duration = duration * (1 - target:GetStatusResistance()) }
	)
end

function ChangeAttackProjectileImba(unit)
	unit:SetRangedProjectileName("particles/items_fx/desolator_projectile.vpcf")
end