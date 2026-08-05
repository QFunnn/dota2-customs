--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_sabre_blade_lua1 = item_sabre_blade_lua1 or class({})
item_sabre_blade_lua2 = item_sabre_blade_lua1 or class({})
item_sabre_blade_lua3 = item_sabre_blade_lua1 or class({})

LinkLuaModifier("modifier_sabre_blade", "items/custom_items/item_sabre_blade.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_sabre_blade_doubleattack",
	"items/custom_items/item_sabre_blade.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_sabre_blade_doubleattack_debuff",
	"items/custom_items/item_sabre_blade.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_sabre_blade_lua1:GetIntrinsicModifierName()
	return "modifier_sabre_blade"
end

modifier_sabre_blade = class({})

function modifier_sabre_blade:IsHidden()
	return true
end

function modifier_sabre_blade:IsPurgable()
	return false
end

function modifier_sabre_blade:RemoveOnDeath()
	return false
end

function modifier_sabre_blade:OnCreated()
	self.parent = self:GetParent()
	self.slow = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_sabre_blade:OnRefresh()
	self.parent = self:GetParent()
	self.slow = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_sabre_blade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_sabre_blade:OnAttack(event)
	if self:GetCaster() ~= event.attacker then
		return
	end
	if not event.attacker:IsIllusion() then
		if not self:GetAbility():IsFullyCastable() then
			return
		end
		event.attacker:AddNewModifier(
			attacker,
			self:GetAbility(),
			"modifier_sabre_blade_doubleattack",
			{ enemyEntIndex = event.target:GetEntityIndex(), duration = 0.3 }
		)
		event.target:AddNewModifier(
			victim,
			self:GetAbility(),
			"modifier_sabre_blade_doubleattack_debuff",
			{ duration = self.slow }
		)
		self:GetAbility():UseResources(false, false, false, true)
	end
end

function modifier_sabre_blade:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

function modifier_sabre_blade:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end

function modifier_sabre_blade:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

-----------------------------------

modifier_sabre_blade_doubleattack = class({})

function modifier_sabre_blade_doubleattack:IsHidden()
	return true
end

function modifier_sabre_blade_doubleattack:IsPurgable()
	return false
end

function modifier_sabre_blade_doubleattack:OnCreated() end

function modifier_sabre_blade_doubleattack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_sabre_blade_doubleattack:OnAttack(keys)
	if keys.attacker ~= self:GetParent() then
		return
	end
	local damage = keys.attacker:GetAverageTrueAttackDamage(nil)

	local multi = self:GetAbility():GetSpecialValueFor("mult")
	local attack = damage * (multi / 100)

	ApplyDamage({
		victim = keys.target,
		attacker = keys.attacker,
		damage = attack,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
			+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
			+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
	})
end

function modifier_sabre_blade_doubleattack:GetModifierAttackSpeedBonus_Constant()
	return 1450
end

-----------------

modifier_sabre_blade_doubleattack_debuff = class({})

function modifier_sabre_blade_doubleattack_debuff:IsHidden()
	return true
end

function modifier_sabre_blade_doubleattack_debuff:IsPurgable()
	return false
end

function modifier_sabre_blade_doubleattack_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_sabre_blade_doubleattack_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -100
end