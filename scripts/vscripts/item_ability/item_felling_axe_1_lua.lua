--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_felling_axe_1_lua", "item_ability/item_felling_axe_1_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_felling_axe_1_lua == nil then
	item_felling_axe_1_lua = class({})
end
function item_felling_axe_1_lua:GetIntrinsicModifierName()
	return "modifier_item_felling_axe_1_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_felling_axe_1_lua == nil then
	modifier_item_felling_axe_1_lua = class({})
end
function modifier_item_felling_axe_1_lua:IsHidden()
	return true
end
function modifier_item_felling_axe_1_lua:IsDebuff()
	return false
end
function modifier_item_felling_axe_1_lua:IsPurgable()
	return false
end
function modifier_item_felling_axe_1_lua:IsPurgeException()
	return false
end
function modifier_item_felling_axe_1_lua:OnCreated(params)
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.neutral_bonus_dmg = self:GetAbility():GetSpecialValueFor("neutral_bonus_dmg")
	if IsServer() then
	end
end
function modifier_item_felling_axe_1_lua:OnRefresh(params)
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.neutral_bonus_dmg = self:GetAbility():GetSpecialValueFor("neutral_bonus_dmg")
	if IsServer() then
	end
end
function modifier_item_felling_axe_1_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_felling_axe_1_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT,
	}
end
function modifier_item_felling_axe_1_lua:RemoveOnDeath()
	return false
end
function modifier_item_felling_axe_1_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_felling_axe_1_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_item_felling_axe_1_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_felling_axe_1_lua:GetModifierPreAttack_BonusDamagePostCrit(params)
	if IsServer() then
		local name = self:GetName()
		local hParent = self:GetParent()
		local buffs = hParent:FindAllModifiersByName(name)
		if self == buffs[1] then
			if IsValid(params.target) and params.target.IsConsideredHero ~= nil then
				if not params.target:IsConsideredHero() then
					return self.neutral_bonus_dmg
				end
			end
		end
	end
end