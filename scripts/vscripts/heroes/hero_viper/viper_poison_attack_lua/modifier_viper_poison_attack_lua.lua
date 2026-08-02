--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_viper_poison_attack_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_viper_poison_attack_lua:IsHidden()
	return false
end

function modifier_viper_poison_attack_lua:IsDebuff()
	return true
end

function modifier_viper_poison_attack_lua:IsStunDebuff()
	return false
end

function modifier_viper_poison_attack_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_viper_poison_attack_lua:OnCreated(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")

	if self:GetCaster():FindAbilityByName("special_bonus_viper_int3") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_viper_int3"):GetLevel() > 0 then
			self.damage = self.damage
		else
			self.damage = self.damage * 2
		end
	end

	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	self:StartIntervalThink(1)
end

function modifier_viper_poison_attack_lua:OnRefresh(kv)
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")

	self.damage = self:GetAbility():GetSpecialValueFor("damage")

	if self:GetCaster():FindAbilityByName("special_bonus_viper_int3") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_viper_int3"):GetLevel() > 0 then
			self.damage = self.damage
		else
			self.damage = self.damage * 2
		end
	end
end

function modifier_viper_poison_attack_lua:OnRemoved() end

function modifier_viper_poison_attack_lua:OnDestroy() end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_viper_poison_attack_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_viper_poison_attack_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end
function modifier_viper_poison_attack_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

--------------------------------------------------------------------------------
function modifier_viper_poison_attack_lua:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_viper_poison_attack_lua:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf"
end

function modifier_viper_poison_attack_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end