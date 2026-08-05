--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_custom_dragon_lance", "items/custom_items/item_dragon_lance", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_custom_dragon_lance2", "items/custom_items/item_dragon_lance", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_custom_dragon_lance3", "items/custom_items/item_dragon_lance", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_item_custom_dragon_lance3_reduced_damage",
	"items/custom_items/item_dragon_lance",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------

item_dragon_lance_lua1 = class({})
function item_dragon_lance_lua1:GetIntrinsicModifierName()
	return "modifier_item_custom_dragon_lance"
end

item_dragon_lance_lua2 = class({})
function item_dragon_lance_lua2:GetIntrinsicModifierName()
	return "modifier_item_custom_dragon_lance2"
end

item_dragon_lance_lua3 = class({})
function item_dragon_lance_lua3:GetIntrinsicModifierName()
	return "modifier_item_custom_dragon_lance3"
end

--------------------------------------------------------------------------------
-- Lance 1
--------------------------------------------------------------------------------

modifier_item_custom_dragon_lance = class({})
function modifier_item_custom_dragon_lance:IsHidden()
	return true
end
function modifier_item_custom_dragon_lance:IsPurgable()
	return false
end

function modifier_item_custom_dragon_lance:OnCreated()
	self.bonus_str = self:GetAbility():GetSpecialValueFor("bonus_str")
	self.bonus_agi = self:GetAbility():GetSpecialValueFor("bonus_agi")
	self.bonus_range = self:GetAbility():GetSpecialValueFor("bonus_range")
end

function modifier_item_custom_dragon_lance:OnRefresh()
	self:OnCreated()
end

function modifier_item_custom_dragon_lance:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
	}
end

function modifier_item_custom_dragon_lance:GetModifierBonusStats_Strength()
	return self.bonus_str
end
function modifier_item_custom_dragon_lance:GetModifierBonusStats_Agility()
	return self.bonus_agi
end

function modifier_item_custom_dragon_lance:GetModifierAttackRangeBonusUnique()
	if not self:GetCaster():IsRangedAttacker() then
		return 0
	end
	-- Если надет lance2 или lance3 — их range уже считается, lance1 не добавляет
	if
		self:GetCaster():HasModifier("modifier_item_custom_dragon_lance2")
		or self:GetCaster():HasModifier("modifier_item_custom_dragon_lance3")
	then
		return 0
	end
	return self.bonus_range
end

--------------------------------------------------------------------------------
-- Lance 2
--------------------------------------------------------------------------------

modifier_item_custom_dragon_lance2 = class({})
function modifier_item_custom_dragon_lance2:IsHidden()
	return true
end
function modifier_item_custom_dragon_lance2:IsPurgable()
	return false
end
function modifier_item_custom_dragon_lance2:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_custom_dragon_lance2:OnCreated()
	self.bonus_str = self:GetAbility():GetSpecialValueFor("bonus_str")
	self.bonus_agi = self:GetAbility():GetSpecialValueFor("bonus_agi")
	self.bonus_as = self:GetAbility():GetSpecialValueFor("bonus_as")
	self.bonus_range = self:GetAbility():GetSpecialValueFor("bonus_range")
end

function modifier_item_custom_dragon_lance2:OnRefresh()
	self:OnCreated()
end

function modifier_item_custom_dragon_lance2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
	}
end

function modifier_item_custom_dragon_lance2:GetModifierBonusStats_Strength()
	return self.bonus_str
end
function modifier_item_custom_dragon_lance2:GetModifierBonusStats_Agility()
	return self.bonus_agi
end
function modifier_item_custom_dragon_lance2:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_as
end

function modifier_item_custom_dragon_lance2:GetModifierAttackRangeBonusUnique()
	if self:GetCaster():IsRangedAttacker() then
		return self.bonus_range
	end
	return 0
end

--------------------------------------------------------------------------------
-- Lance 3
--------------------------------------------------------------------------------

modifier_item_custom_dragon_lance3 = class({})
function modifier_item_custom_dragon_lance3:IsDebuff()
	return false
end
function modifier_item_custom_dragon_lance3:IsHidden()
	return true
end
function modifier_item_custom_dragon_lance3:IsPurgable()
	return false
end
function modifier_item_custom_dragon_lance3:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_item_custom_dragon_lance3:OnCreated()
	self.bonus_str = self:GetAbility():GetSpecialValueFor("bonus_str")
	self.bonus_agi = self:GetAbility():GetSpecialValueFor("bonus_agi")
	self.bonus_as = self:GetAbility():GetSpecialValueFor("bonus_as")
	self.bonus_range = self:GetAbility():GetSpecialValueFor("bonus_range")
end

function modifier_item_custom_dragon_lance3:OnRefresh()
	self:OnCreated()
end

function modifier_item_custom_dragon_lance3:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_item_custom_dragon_lance3:GetModifierBonusStats_Strength()
	return self.bonus_str
end
function modifier_item_custom_dragon_lance3:GetModifierBonusStats_Agility()
	return self.bonus_agi
end
function modifier_item_custom_dragon_lance3:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_as
end

function modifier_item_custom_dragon_lance3:GetModifierAttackRangeBonusUnique()
	if not self:GetCaster():IsRangedAttacker() then
		return 0
	end
	-- Если lance2 тоже надет — range не стакается
	if self:GetCaster():HasModifier("modifier_item_custom_dragon_lance2") then
		return 0
	end
	return self.bonus_range
end

function modifier_item_custom_dragon_lance3:GetModifierDamageOutgoing_Percentage()
	if not IsServer() then
		return
	end
	if self.bSplitShot then
		return self:GetAbility():GetSpecialValueFor("split_shot_damage")
	end
	return 0
end

function modifier_item_custom_dragon_lance3:OnAttack(keys)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if keys.attacker ~= parent then
		return
	end
	if not parent:IsRangedAttacker() then
		return
	end
	if not keys.target then
		return
	end
	if keys.target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if keys.no_attack_cooldown then
		return
	end
	if parent:HasFlyMovementCapability() then
		return
	end
	if parent:IsIllusion() then
		return
	end

	local ability = self:GetAbility()
	local maxTargets = ability:GetSpecialValueFor("max_target")
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		keys.target:GetAbsOrigin(),
		keys.target,
		ability:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
			+ DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES
			+ DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
			+ DOTA_UNIT_TARGET_FLAG_NO_INVIS
			+ DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_ANY_ORDER,
		false
	)

	local nTargets = 0
	for _, hEnemy in pairs(enemies) do
		if hEnemy ~= keys.target then
			parent:AddNewModifier(parent, ability, "modifier_item_custom_dragon_lance3_reduced_damage", {})
			parent:PerformAttack(hEnemy, false, false, true, true, true, false, false)
			parent:RemoveModifierByName("modifier_item_custom_dragon_lance3_reduced_damage")

			nTargets = nTargets + 1
			if nTargets >= maxTargets then
				break
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Reduced damage modifier (split shot)
--------------------------------------------------------------------------------

modifier_item_custom_dragon_lance3_reduced_damage = class({})
function modifier_item_custom_dragon_lance3_reduced_damage:IsDebuff()
	return false
end
function modifier_item_custom_dragon_lance3_reduced_damage:IsHidden()
	return true
end
function modifier_item_custom_dragon_lance3_reduced_damage:IsPurgable()
	return false
end
function modifier_item_custom_dragon_lance3_reduced_damage:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_item_custom_dragon_lance3_reduced_damage:DeclareFunctions()
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE }
end

function modifier_item_custom_dragon_lance3_reduced_damage:GetModifierDamageOutgoing_Percentage()
	return -1 * (100 - self:GetAbility():GetSpecialValueFor("split_shot_damage"))
end