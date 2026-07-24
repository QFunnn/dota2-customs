--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_venom_song", "items/item_venom_song", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_venom_song_debuff", "items/item_venom_song", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_venom_song_aura_debuff", "items/item_venom_song", LUA_MODIFIER_MOTION_NONE)

item_venom_song = class({})

function item_venom_song:GetIntrinsicModifierName()
	return "modifier_item_venom_song"
end

modifier_item_venom_song = class({})

function modifier_item_venom_song:IsHidden() return true end
function modifier_item_venom_song:IsPurgable() return false end
function modifier_item_venom_song:IsPurgeException() return false end
function modifier_item_venom_song:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_venom_song:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		 
	}
end

function modifier_item_venom_song:IsAura()
	return true
end

function modifier_item_venom_song:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("aura_radius")
	end
end

function modifier_item_venom_song:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_item_venom_song:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_item_venom_song:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_venom_song:GetModifierAura()
	return "modifier_item_venom_song_aura_debuff"
end

function modifier_item_venom_song:GetModifierBonusStats_Agility()
	return  self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_venom_song:GetModifierBonusStats_Strength()
    return  self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_venom_song:GetModifierBonusStats_Intellect()
    return  self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_venom_song:GetModifierAttackSpeedPercentage()
    return self:GetAbility():GetSpecialValueFor("attack_speed")
end

function modifier_item_venom_song:OnAttackLanded(params)
	if params.attacker == self:GetParent() then
        if params.target:IsOther() then
            return nil
        end

        if self:GetParent():IsIllusion() then
            return nil
        end

        local duration = self:GetAbility():GetSpecialValueFor("duration")
        params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_venom_song_debuff", {duration = duration * (1 - params.target:GetStatusResistance())})
    end
end

modifier_item_venom_song_debuff = class({})

function modifier_item_venom_song_debuff:IsPurgable() return true end

function modifier_item_venom_song_debuff:OnCreated()
    if not IsServer() then return end
    local damage_phys = self:GetAbility():GetSpecialValueFor("damage_phys")
    self.damage = (self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * damage_phys) + self:GetAbility():GetSpecialValueFor("base_damage")
    self:StartIntervalThink(1)
end

function modifier_item_venom_song_debuff:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = self.damage, flags=DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK+DOTA_DAMAGE_FLAG_HPLOSS +DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR +DOTA_DAMAGE_FLAG_IGNORES_BASE_PHYSICAL_ARMOR , damage_type = DAMAGE_TYPE_MAGICAL})
end

function modifier_item_venom_song_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    }
end

function modifier_item_venom_song_debuff:GetEffectName()
    return "particles/econ/items/venomancer/veno_2021_immortal_arms/veno_2021_immortal_poison_debuff.vpcf"
end

function modifier_item_venom_song_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_venom_song_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movespeed_reduce")
end

function modifier_item_venom_song_debuff:GetModifierPropertyRestorationAmplification()
	return self:GetAbility():GetSpecialValueFor("minus_regen")
end

modifier_item_venom_song_aura_debuff = class({})

function modifier_item_venom_song_aura_debuff:DeclareFunctions()
	return 
	{
        MODIFIER_PROPERTY_TOOLTIP
	}
end

function modifier_item_venom_song_aura_debuff:OnTooltip()
    return self:GetAbility():GetSpecialValueFor("mana_regen_reduce")
end

function modifier_item_venom_song_aura_debuff:GetModifierManaRegenPercentDecreaseCustom()
    return self:GetAbility():GetSpecialValueFor("mana_regen_reduce")
end

function modifier_item_venom_song_aura_debuff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
    self:OnIntervalThink()
end

function modifier_item_venom_song_aura_debuff:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():CanEntityBeSeenByMyTeam(self:GetCaster()) then
        self:SetStackCount(0)
    else
        self:SetStackCount(1)
    end
end

function modifier_item_venom_song_aura_debuff:IsHidden()
    return self:GetStackCount() == 1
end