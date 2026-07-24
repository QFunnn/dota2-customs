--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_black_king_bar_2_lua", "item_ability/item_black_king_bar_2_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_black_king_bar_2_lua_debuff", "item_ability/item_black_king_bar_2_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_black_king_bar_2_lua_buff", "item_ability/item_black_king_bar_2_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_black_king_bar_2_lua == nil then
    item_black_king_bar_2_lua = class({})
end
function item_black_king_bar_2_lua:OnSpellStart()
    local hCaster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local duration_instun = self:GetSpecialValueFor("duration_instun")

    if hCaster:IsStunned() then
        duration = duration_instun
    end

	hCaster:Purge(false, true, false, true, true)
    hCaster:AddNewModifier(hCaster, self, "modifier_item_black_king_bar_2_lua_buff", { duration = duration })
	EmitSoundOn("DOTA_Item.BlackKingBar.Activate", hCaster)
end
function item_black_king_bar_2_lua:GetIntrinsicModifierName()
    return "modifier_item_black_king_bar_2_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_black_king_bar_2_lua == nil then
    modifier_item_black_king_bar_2_lua = class({})
end
function modifier_item_black_king_bar_2_lua:IsHidden()
	return true
end
function modifier_item_black_king_bar_2_lua:IsPurgable()
	return false
end
function modifier_item_black_king_bar_2_lua:OnCreated(params)
    self.bonus_magical_armor = self:GetAbility():GetSpecialValueFor("bonus_magical_armor")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
    self.bonus_intellect = self:GetAbility():GetSpecialValueFor("bonus_intellect")
    self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
    self.debuff_duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua:OnRefresh(params)
    self.bonus_magical_armor = self:GetAbility():GetSpecialValueFor("bonus_magical_armor")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
    self.bonus_intellect = self:GetAbility():GetSpecialValueFor("bonus_intellect")
    self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
    self.debuff_duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua:OnDestroy()
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
end
function modifier_item_black_king_bar_2_lua:RemoveOnDeath()
	return false
end
function modifier_item_black_king_bar_2_lua:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_black_king_bar_2_lua:GetModifierMagicalResistanceBonus()
    return self.bonus_magical_armor
end
function modifier_item_black_king_bar_2_lua:GetModifierAttackSpeedBonus_Constant()
    return self.bonus_attack_speed
end
function modifier_item_black_king_bar_2_lua:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage
end
function modifier_item_black_king_bar_2_lua:GetModifierConstantManaRegen()
    return self.bonus_mana_regen
end
function modifier_item_black_king_bar_2_lua:GetModifierBonusStats_Intellect()
    return self.bonus_intellect
end
function modifier_item_black_king_bar_2_lua:GetModifierBonusStats_Strength()
    return self.bonus_strength
end
function modifier_item_black_king_bar_2_lua:OnAttackLanded(params)
    local hParent = self:GetParent()
    if hParent == params.attacker then
        local hTarget = params.target
        hTarget:AddNewModifier(hParent, self:GetAbility(), "modifier_item_black_king_bar_2_lua_debuff", { duration = self.debuff_duration })
    end
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_black_king_bar_2_lua_debuff == nil then
    modifier_item_black_king_bar_2_lua_debuff = class({})
end
function modifier_item_black_king_bar_2_lua_debuff:OnCreated(params)
    self.spell_amp_debuff = self:GetAbility():GetSpecialValueFor("spell_amp_debuff")
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua_debuff:OnRefresh(params)
    self.spell_amp_debuff = self:GetAbility():GetSpecialValueFor("spell_amp_debuff")
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua_debuff:OnDestroy()
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end
function modifier_item_black_king_bar_2_lua_debuff:GetModifierTotalDamageOutgoing_Percentage(params)
    if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then
        return -self.spell_amp_debuff
    end
end
function modifier_item_black_king_bar_2_lua_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end
function modifier_item_black_king_bar_2_lua_debuff:GetEffectName()
    return "particles/items3_fx/mage_slayer_debuff.vpcf"
end
function modifier_item_black_king_bar_2_lua_debuff:GetStatusEffectName()
    return "particles/items3_fx/status_effect_mage_slayer_debuff.vpcf"
end
function modifier_item_black_king_bar_2_lua_debuff:StatusEffectPriority()
    return MODIFIER_PRIORITY_NORMAL
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_black_king_bar_2_lua_buff == nil then
    modifier_item_black_king_bar_2_lua_buff = class({})
end
function modifier_item_black_king_bar_2_lua_buff:OnCreated(params)
	self.model_scale = self:GetAbility():GetSpecialValueFor("model_scale")
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua_buff:OnRefresh(params)
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua_buff:OnDestroy()
    if IsServer() then
    end
end
function modifier_item_black_king_bar_2_lua_buff:CheckState()
    return {
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
    }
end
function modifier_item_black_king_bar_2_lua_buff:DeclareFunctions()
    return {
		MODIFIER_PROPERTY_MODEL_SCALE,
    }
end
function modifier_item_black_king_bar_2_lua_buff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_black_king_bar_2_lua_buff:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end
function modifier_item_black_king_bar_2_lua_buff:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end
function modifier_item_black_king_bar_2_lua_buff:StatusEffectPriority()
    return MODIFIER_PRIORITY_HIGH
end
function modifier_item_black_king_bar_2_lua_buff:GetModifierModelScale()
	return self.model_scale
end