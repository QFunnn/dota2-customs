--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_trident_of_eternity",
	"items/custom_items/item_trident_of_eternity",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_trident_of_eternity_stacks",
	"items/custom_items/item_trident_of_eternity",
	LUA_MODIFIER_MOTION_NONE
)

item_trident_of_eternity_1 = item_trident_of_eternity_1 or class({})
item_trident_of_eternity_2 = item_trident_of_eternity_1 or class({})
item_trident_of_eternity_3 = item_trident_of_eternity_1 or class({})

function item_trident_of_eternity_1:GetIntrinsicModifierName()
	return "modifier_item_trident_of_eternity"
end

---------------------------------------------------------------------------------------------------

modifier_item_trident_of_eternity = class({})

function modifier_item_trident_of_eternity:IsHidden()
	return true
end
function modifier_item_trident_of_eternity:IsPurgable()
	return false
end
function modifier_item_trident_of_eternity:RemoveOnDeath()
	return false
end
-- function modifier_item_trident_of_eternity:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_trident_of_eternity:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.bonus_mana = ability:GetSpecialValueFor("bonus_mana")
	self.bonus_mana_regen = ability:GetSpecialValueFor("bonus_mana_regen")
	self.cast_range_bonus = ability:GetSpecialValueFor("cast_range_bonus")
	self.bonus_cooldown = ability:GetSpecialValueFor("bonus_cooldown")

	self.status_resistance = ability:GetSpecialValueFor("status_resistance")
	self.movement_speed_percent_bonus = ability:GetSpecialValueFor("movement_speed_percent_bonus")
	self.spell_amp = ability:GetSpecialValueFor("spell_amp")
	self.mana_regen_multiplier = ability:GetSpecialValueFor("mana_regen_multiplier")
	self.hp_regen_amp = ability:GetSpecialValueFor("hp_regen_amp")
	self.spell_lifesteal_amp = ability:GetSpecialValueFor("spell_lifesteal_amp")
	self.bonus_attack_speed = ability:GetSpecialValueFor("bonus_attack_speed")

	self.max_stacks = ability:GetSpecialValueFor("max_stacks")
	self.regen_amp_per_stack = ability:GetSpecialValueFor("regen_amp_per_stack")
	self._item_level = ability:GetLevel()

	if not IsServer() then
		return
	end
	self.bonus_strength = ability:GetSpecialValueFor("bonus_strength")
	self.bonus_intellect = ability:GetSpecialValueFor("bonus_intellect")
	self.bonus_agility = ability:GetSpecialValueFor("bonus_agility")

	if self:GetStackCount() < 0 then
		self:SetStackCount(0)
	end
end

function modifier_item_trident_of_eternity:OnRefresh()
	self:OnCreated()
end

local function _has_higher_trident(unit, level)
	if not unit.GetItemInSlot then
		return false
	end
	for lvl = level + 1, 3 do
		for i = 0, 5 do
			local item = unit:GetItemInSlot(i)
			if item and item:GetName() == "item_trident_of_eternity_" .. lvl then
				return true
			end
		end
	end
	return false
end

function modifier_item_trident_of_eternity:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,

		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MP_RESTORE_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,

		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end

function modifier_item_trident_of_eternity:GetModifierHealthBonus()
	return self.bonus_health
end
function modifier_item_trident_of_eternity:GetModifierManaBonus()
	return self.bonus_mana
end
function modifier_item_trident_of_eternity:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end
function modifier_item_trident_of_eternity:GetModifierCastRangeBonus()
	return self.cast_range_bonus
end
function modifier_item_trident_of_eternity:GetModifierPercentageCooldown()
	local parent = self:GetParent()
	if parent and not parent:IsNull() and _has_higher_trident(parent, self._item_level or 0) then
		return 0
	end
	return self.bonus_cooldown
end

function modifier_item_trident_of_eternity:GetModifierBonusStats_Strength()
	return self.bonus_strength
end
function modifier_item_trident_of_eternity:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end
function modifier_item_trident_of_eternity:GetModifierBonusStats_Agility()
	return self.bonus_agility
end
function modifier_item_trident_of_eternity:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end
function modifier_item_trident_of_eternity:GetModifierStatusResistanceStacking()
	return self.status_resistance
end
function modifier_item_trident_of_eternity:GetModifierMoveSpeedBonus_Percentage()
	return self.movement_speed_percent_bonus
end

function modifier_item_trident_of_eternity:GetModifierMPRestoreAmplify_Percentage()
	return self.mana_regen_multiplier or 0
end

function modifier_item_trident_of_eternity:GetModifierMPRegenAmplify_Percentage()
	return self.mana_regen_multiplier or 0
end

function modifier_item_trident_of_eternity:GetModifierSpellAmplify_Percentage()
	return self.spell_amp
end

function modifier_item_trident_of_eternity:GetModifierHPRegenAmplify_Percentage()
	return self.hp_regen_amp or 0
end

function modifier_item_trident_of_eternity:GetModifierSpellLifestealRegenAmplify_Percentage()
	return self.spell_lifesteal_amp
end

function modifier_item_trident_of_eternity:OnAbilityExecuted(keys)
	if not IsServer() then
		return
	end
	if not keys or keys.unit ~= self:GetParent() then
		return
	end
	if self:GetParent():IsIllusion() then
		return
	end

	local ability = keys.ability
	if not ability or ability:IsItem() then
		return
	end

	local parent = self:GetParent()
	local stacks_mod = parent:FindModifierByName("modifier_item_trident_of_eternity_stacks")
	if not stacks_mod then
		stacks_mod = parent:AddNewModifier(
			parent,
			self:GetAbility(),
			"modifier_item_trident_of_eternity_stacks",
			{ duration = 5 }
		)
	end
	if not stacks_mod then
		return
	end

	stacks_mod:SetDuration(5, true)
	local stacks = stacks_mod:GetStackCount()
	if stacks >= self.max_stacks then
		return
	end
	stacks_mod:SetStackCount(stacks + 1)
end

---------------------------------------------------------------------------------------------------

modifier_item_trident_of_eternity_stacks = class({})
function modifier_item_trident_of_eternity_stacks:IsHidden()
	return false
end
function modifier_item_trident_of_eternity_stacks:IsPurgable()
	return false
end
function modifier_item_trident_of_eternity_stacks:RemoveOnDeath()
	return false
end

function modifier_item_trident_of_eternity_stacks:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.regen_amp_per_stack = ability:GetSpecialValueFor("regen_amp_per_stack")
end
function modifier_item_trident_of_eternity_stacks:OnRefresh()
	self:OnCreated()
end

function modifier_item_trident_of_eternity_stacks:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MP_RESTORE_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_trident_of_eternity_stacks:GetModifierMPRestoreAmplify_Percentage()
	return (self.regen_amp_per_stack or 0) * self:GetStackCount()
end
function modifier_item_trident_of_eternity_stacks:GetModifierMPRegenAmplify_Percentage()
	return (self.regen_amp_per_stack or 0) * self:GetStackCount()
end
function modifier_item_trident_of_eternity_stacks:GetModifierHPRegenAmplify_Percentage()
	return (self.regen_amp_per_stack or 0) * self:GetStackCount()
end