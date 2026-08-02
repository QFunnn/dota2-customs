--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_des_blade", "items/d_items/item_des_blade", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_des_blade_effect", "items/d_items/item_des_blade", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_des_blade_debuff", "items/d_items/item_des_blade", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_des_blade = item_des_blade or class({})
item_des_blade2 = item_des_blade or class({})
item_des_blade3 = item_des_blade or class({})
item_des_blade4 = item_des_blade or class({})
item_des_blade5 = item_des_blade or class({})

function item_des_blade:GetIntrinsicModifierName()
	return "modifier_item_des_blade"
end

function item_des_blade:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_des_blade:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_des_blade:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

function item_des_blade:OnSpellStart()
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_item_des_blade_effect",
		{ duration = self:GetSpecialValueFor("duration") }
	)
end

--------------------------------------------------------------------------------

modifier_item_des_blade = class({})

function modifier_item_des_blade:IsHidden()
	return true
end

function modifier_item_des_blade:IsPurgable()
	return false
end

function modifier_item_des_blade:OnCreated(kv)
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_des_blade:DeclareFunctions()
	local funcs = {
		MODIFIER_ATTRIBUTE_NONE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_item_des_blade:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_damage
end

--------------------------------------------------------------------------------

modifier_item_des_blade_effect = class({})

function modifier_item_des_blade_effect:IsHidden()
	return true
end
function modifier_item_des_blade_effect:IsPurgable()
	return false
end
function modifier_item_des_blade_effect:RemoveOnDeath()
	return false
end

function modifier_item_des_blade_effect:OnCreated()
	if IsServer() then
		if not self:GetAbility() then
			self:Destroy()
		end
	end
	if IsServer() then
		ChangeAttackProjectileImba(self:GetParent())
	end
end

function modifier_item_des_blade_effect:OnDestroy()
	if IsServer() then
		self:GetParent():ResetRangedProjectileName()
	end
end

function ChangeAttackProjectileImba(unit)
	local particle_deso = "particles/items_fx/desolator_projectile.vpcf"
	unit:SetRangedProjectileName(particle_deso)
end

function modifier_item_des_blade_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_item_des_blade_effect:OnAttackLanded(keys)
	if IsServer() then
		if self:GetParent() ~= keys.attacker then
			return
		end
		if self:GetParent():IsIllusion() then
			return
		end
		local target = keys.target
		target:AddNewModifier(keys.attacker, self:GetAbility(), "modifier_item_des_blade_debuff", {})
	end
end

------------------------------------------------------------------

modifier_item_des_blade_debuff = class({})

function modifier_item_des_blade_debuff:IsHidden()
	return false
end
function modifier_item_des_blade_debuff:IsDebuff()
	return true
end
function modifier_item_des_blade_debuff:IsPurgable()
	return true
end
function modifier_item_des_blade_debuff:GetTexture()
	return "ancient_amulet"
end

function modifier_item_des_blade_debuff:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end
	self.armor_reduction = -1 * self:GetAbility():GetSpecialValueFor("disarm")
	self:StartIntervalThink(3)
end

function modifier_item_des_blade_debuff:OnIntervalThink()
	self:Destroy()
end

function modifier_item_des_blade_debuff:OnRefresh()
	self:IncrementStackCount()
end

function modifier_item_des_blade_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_item_des_blade_debuff:GetModifierMagicalResistanceBonus()
	return self.armor_reduction * self:GetStackCount()
end

function modifier_item_des_blade_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction * self:GetStackCount()
end