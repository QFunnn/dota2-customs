--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_heartstopper_aura_custom", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_heartstopper_aura_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_heartstopper_aura_custom_damage", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_heartstopper_aura_custom", LUA_MODIFIER_MOTION_NONE)

necrolyte_heartstopper_aura_custom = class({})

necrolyte_heartstopper_aura_custom.modifier_necrolyte_5 = {-10,-20}
necrolyte_heartstopper_aura_custom.modifier_necrolyte_6 = {0.1,0.2,0.3}
necrolyte_heartstopper_aura_custom.modifier_necrolyte_13 = {-3,-6,-9}
necrolyte_heartstopper_aura_custom.modifier_necrolyte_18 = {-10,-20,-30}
necrolyte_heartstopper_aura_custom.modifier_necrolyte_1_creep_damage = 10
necrolyte_heartstopper_aura_custom.modifier_necrolyte_1_strength_count_to_heroes = 300

function necrolyte_heartstopper_aura_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_necrolyte_3") then
        return "necrolyte_3"
    end
    return "necrolyte_heartstopper_aura"
end

function necrolyte_heartstopper_aura_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_necrolyte_3") then
        return DOTA_ABILITY_BEHAVIOR_TOGGLE
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_AURA
end

function necrolyte_heartstopper_aura_custom:OnToggle()
    print("jkek")
end

function necrolyte_heartstopper_aura_custom:GetIntrinsicModifierName()
	return "modifier_necrolyte_heartstopper_aura_custom"
end

modifier_necrolyte_heartstopper_aura_custom = class({})

function modifier_necrolyte_heartstopper_aura_custom:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_necrolyte_heartstopper_aura_custom:OnRefresh()
	self:OnCreated()
end

function modifier_necrolyte_heartstopper_aura_custom:GetAuraRadius()
	return self.radius
end

function modifier_necrolyte_heartstopper_aura_custom:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS
end

function modifier_necrolyte_heartstopper_aura_custom:GetAuraEntityReject(target)
    if target and target:GetTeamNumber() == self:GetCaster():GetTeamNumber() and target ~= self:GetCaster() then
        return true
    end
    return false
end

function modifier_necrolyte_heartstopper_aura_custom:GetAuraSearchTeam()
    if self:GetCaster():HasModifier("modifier_necrolyte_3") and self:GetAbility():GetToggleState() then
        return DOTA_UNIT_TARGET_TEAM_BOTH
    end
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_necrolyte_heartstopper_aura_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_necrolyte_heartstopper_aura_custom:GetModifierAura()
	return "modifier_necrolyte_heartstopper_aura_custom_damage"
end

function modifier_necrolyte_heartstopper_aura_custom:IsAura()
	if self:GetCaster():PassivesDisabled() then
		return false
	end
	return true
end

function modifier_necrolyte_heartstopper_aura_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_necrolyte_heartstopper_aura_custom:IsHidden()
	return true
end

modifier_necrolyte_heartstopper_aura_custom_damage = class({})
function modifier_necrolyte_heartstopper_aura_custom_damage:IsPurgable() return false end

function modifier_necrolyte_heartstopper_aura_custom_damage:OnCreated()
	if not IsServer() then return end
    self.parent = self:GetParent()
    self.aura_damage = self:GetAbility():GetSpecialValueFor("aura_damage")
    self.tick_rate = 0.2
    self:StartIntervalThink(self.tick_rate)
end

function modifier_necrolyte_heartstopper_aura_custom_damage:OnIntervalThink()
	if not IsServer() then return end
    if self:GetParent():PassivesDisabled() then return end
    local aura_damage = self.aura_damage
    if self:GetCaster():HasModifier("modifier_necrolyte_6") then
        aura_damage = aura_damage + self:GetAbility().modifier_necrolyte_6[self:GetCaster():GetTalentLevel("modifier_necrolyte_6")]
    end
	local damage = (self:GetParent():GetMaxHealth() * aura_damage / 100)
    if self:GetCaster():HasModifier("modifier_necrolyte_1") then
        if not self:GetParent():IsHero() or self:GetCaster():GetStrength() >= self:GetAbility().modifier_necrolyte_1_strength_count_to_heroes then
            damage = damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_necrolyte_1_creep_damage)
        end
    end
    if self:GetCaster():HasModifier("modifier_necrolyte_3") and self:GetAbility():GetToggleState() then
        damage = damage + self:GetCaster():GetHealthRegen()
    end
    damage = damage * self.tick_rate
    local damage_type = DAMAGE_TYPE_MAGICAL
    if self:GetCaster():HasModifier("modifier_necrolyte_7") then
        damage_type = DAMAGE_TYPE_PURE
    end
    if self:GetCaster():HasModifier("modifier_necrolyte_13") then
        damage_type = DAMAGE_TYPE_PHYSICAL
    end
    local flag = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK
    if self:GetParent() == self:GetCaster() then
        flag = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NON_LETHAL
    end
	ApplyDamage({attacker = self:GetCaster(), victim = self.parent, ability = self:GetAbility(), damage = damage, damage_type = damage_type, damage_flags = flag})
end

function modifier_necrolyte_heartstopper_aura_custom_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    }
end

function modifier_necrolyte_heartstopper_aura_custom_damage:GetModifierPhysicalArmorBonus()
    if not self:GetCaster():HasModifier("modifier_necrolyte_13") then return end
    if self:GetParent() == self:GetCaster() then return end
    return self:GetAbility().modifier_necrolyte_13[self:GetCaster():GetTalentLevel("modifier_necrolyte_13")]
end

function modifier_necrolyte_heartstopper_aura_custom_damage:GetModifierMagicalResistanceBonus()
    if not self:GetCaster():HasModifier("modifier_necrolyte_18") then return end
    if self:GetParent() == self:GetCaster() then return end
    return self:GetAbility().modifier_necrolyte_18[self:GetCaster():GetTalentLevel("modifier_necrolyte_18")]
end

function modifier_necrolyte_heartstopper_aura_custom_damage:GetModifierPropertyRestorationAmplification()
    if not self:GetCaster():HasModifier("modifier_necrolyte_5") then return end
    if self:GetParent() == self:GetCaster() then return end
    return self:GetAbility().modifier_necrolyte_5[self:GetCaster():GetTalentLevel("modifier_necrolyte_5")]
end