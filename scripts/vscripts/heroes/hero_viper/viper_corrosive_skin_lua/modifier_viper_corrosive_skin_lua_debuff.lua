--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_viper_corrosive_skin_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_viper_corrosive_skin_lua_debuff:IsHidden()
	return false
end

function modifier_viper_corrosive_skin_lua_debuff:IsDebuff()
	return true
end

function modifier_viper_corrosive_skin_lua_debuff:IsStunDebuff()
	return false
end

function modifier_viper_corrosive_skin_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_viper_corrosive_skin_lua_debuff:OnCreated(kv)
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	local damage = self:GetAbility():GetSpecialValueFor("damage")

	if not IsServer() then
		return
	end
	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN, --Optional.
	}

	-- Start interval
	self:StartIntervalThink(1)
end

function modifier_viper_corrosive_skin_lua_debuff:OnRefresh(kv)
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	local damage = self:GetAbility():GetSpecialValueFor("damage")

	if not IsServer() then
		return
	end
	-- update damage
	self.damageTable.damage = damage
end

function modifier_viper_corrosive_skin_lua_debuff:OnRemoved() end

function modifier_viper_corrosive_skin_lua_debuff:OnDestroy() end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_viper_corrosive_skin_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_viper_corrosive_skin_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_viper_corrosive_skin_lua_debuff:OnIntervalThink()
	-- Apply damage
	ApplyDamage(self.damageTable)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_viper_corrosive_skin_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_corrosive_debuff.vpcf"
end

function modifier_viper_corrosive_skin_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end