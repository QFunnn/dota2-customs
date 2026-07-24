--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_ghost_shroud_custom", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_ghost_shroud_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_ghost_shroud_custom_aura", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_ghost_shroud_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_ghost_shroud_custom_aura_debuff", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_ghost_shroud_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_ghost_shroud_custom_aura_handler", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_ghost_shroud_custom", LUA_MODIFIER_MOTION_NONE)

necrolyte_ghost_shroud_custom = class({})

necrolyte_ghost_shroud_custom.modifier_necrolyte_2 = {10,20,30}
necrolyte_ghost_shroud_custom.modifier_necrolyte_14 = 1
necrolyte_ghost_shroud_custom.modifier_necrolyte_4 = {8,16,24}

function necrolyte_ghost_shroud_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function necrolyte_ghost_shroud_custom:GetHealthCost(iLevel)
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        return self.BaseClass.GetManaCost(self, iLevel)
    end
    return 0
end

function necrolyte_ghost_shroud_custom:GetIntrinsicModifierName()
    return "modifier_necrolyte_ghost_shroud_custom_aura_handler"
end

function necrolyte_ghost_shroud_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_necrolyte_14") then
        duration = duration + self.modifier_necrolyte_14
    end
    self:GetCaster():EmitSound("Hero_Necrolyte.SpiritForm.Cast")
	self:GetCaster():StartGesture(ACT_DOTA_NECRO_GHOST_SHROUD)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_necrolyte_ghost_shroud_custom", {duration = duration})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_necrolyte_ghost_shroud_custom_aura", {duration = duration})
end

modifier_necrolyte_ghost_shroud_custom = class({})
function modifier_necrolyte_ghost_shroud_custom:IsHidden() return true end
function modifier_necrolyte_ghost_shroud_custom:IsPurgable() return not self:GetCaster():HasModifier("modifier_necrolyte_14") end

function modifier_necrolyte_ghost_shroud_custom:OnDestroy()
    if not IsServer() then return end
    local modifier_necrolyte_ghost_shroud_custom_aura = self:GetParent():FindModifierByName("modifier_necrolyte_ghost_shroud_custom_aura")
    if modifier_necrolyte_ghost_shroud_custom_aura then
        modifier_necrolyte_ghost_shroud_custom_aura:Destroy()
    end
end

function modifier_necrolyte_ghost_shroud_custom:GetEffectName()
	return "particles/units/heroes/hero_pugna/pugna_decrepify.vpcf"
end

function modifier_necrolyte_ghost_shroud_custom:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end

function modifier_necrolyte_ghost_shroud_custom:OnCreated()
    self.heal_bonus = self:GetAbility():GetSpecialValueFor("heal_bonus")
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_necrolyte_ghost_shroud_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MP_RESTORE_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE
    }
end

function modifier_necrolyte_ghost_shroud_custom:GetModifierMagicalResistanceDecrepifyUnique( params )
    if self:GetCaster():HasModifier("modifier_necrolyte_14") then return end
	return self.bonus_damage
end

function modifier_necrolyte_ghost_shroud_custom:GetAbsoluteNoDamagePhysical()
    if self:GetParent():IsDebuffImmune() then return end
	return 1
end

function modifier_necrolyte_ghost_shroud_custom:GetModifierMPRegenAmplify_Percentage()
	return self.heal_bonus
end

function modifier_necrolyte_ghost_shroud_custom:GetModifierMPRestoreAmplify_Percentage()
	return self.heal_bonus
end

function modifier_necrolyte_ghost_shroud_custom:CheckState()
    if self:GetParent():IsDebuffImmune() then return end
    if self:GetCaster():HasModifier("modifier_necrolyte_14") then
        return
        {
            [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        }
    end
	return
    {
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
    }
end

function modifier_necrolyte_ghost_shroud_custom:GetModifierHPRegenAmplify_Percentage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        bonus = self:GetAbility().modifier_necrolyte_2[self:GetCaster():GetTalentLevel("modifier_necrolyte_2")]
    end
    return self.heal_bonus + bonus
end

modifier_necrolyte_ghost_shroud_custom_aura = class({})
function modifier_necrolyte_ghost_shroud_custom_aura:IsHidden() return false end
function modifier_necrolyte_ghost_shroud_custom_aura:IsPurgable() return false end
function modifier_necrolyte_ghost_shroud_custom_aura:IsAura() return true end

function modifier_necrolyte_ghost_shroud_custom_aura:OnCreated( params )
    self.radius = self:GetAbility():GetSpecialValueFor("slow_aoe")
end

function modifier_necrolyte_ghost_shroud_custom_aura:GetEffectName()
	return "particles/units/heroes/hero_necrolyte/necrolyte_spirit.vpcf"
end

function modifier_necrolyte_ghost_shroud_custom_aura:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_necrolyte_ghost_shroud_custom_aura:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end

function modifier_necrolyte_ghost_shroud_custom_aura:GetAuraRadius()
	return self.radius
end

function modifier_necrolyte_ghost_shroud_custom_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_necrolyte_ghost_shroud_custom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_necrolyte_ghost_shroud_custom_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_necrolyte_ghost_shroud_custom_aura:GetModifierAura()
	return "modifier_necrolyte_ghost_shroud_custom_aura_debuff"
end

modifier_necrolyte_ghost_shroud_custom_aura_debuff = class({})
function modifier_necrolyte_ghost_shroud_custom_aura_debuff:IsHidden() return false end
function modifier_necrolyte_ghost_shroud_custom_aura_debuff:IsDebuff() return true end

function modifier_necrolyte_ghost_shroud_custom_aura_debuff:GetEffectName()
	return "particles/units/heroes/hero_necrolyte/necrolyte_spirit_debuff.vpcf"
end

function modifier_necrolyte_ghost_shroud_custom_aura_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_necrolyte_ghost_shroud_custom_aura_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_necrolyte_ghost_shroud_custom_aura_debuff:OnCreated()
    if not IsServer() then return end
    local modifier_necrolyte_ghost_shroud_custom_aura_handler = self:GetCaster():FindModifierByName("modifier_necrolyte_ghost_shroud_custom_aura_handler")
    if modifier_necrolyte_ghost_shroud_custom_aura_handler then
        modifier_necrolyte_ghost_shroud_custom_aura_handler:IncrementStackCount()
    end
end

function modifier_necrolyte_ghost_shroud_custom_aura_debuff:OnDestroy()
    if not IsServer() then return end
    local modifier_necrolyte_ghost_shroud_custom_aura_handler = self:GetCaster():FindModifierByName("modifier_necrolyte_ghost_shroud_custom_aura_handler")
    if modifier_necrolyte_ghost_shroud_custom_aura_handler then
        modifier_necrolyte_ghost_shroud_custom_aura_handler:DecrementStackCount()
    end
end

modifier_necrolyte_ghost_shroud_custom_aura_handler = class({})
function modifier_necrolyte_ghost_shroud_custom_aura_handler:IsHidden() return true end
function modifier_necrolyte_ghost_shroud_custom_aura_handler:IsPurgable() return false end
function modifier_necrolyte_ghost_shroud_custom_aura_handler:IsPurgeException() return false end
function modifier_necrolyte_ghost_shroud_custom_aura_handler:RemoveOnDeath() return false end
function modifier_necrolyte_ghost_shroud_custom_aura_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_necrolyte_ghost_shroud_custom_aura_handler:GetModifierMoveSpeedBonus_Percentage()
    if not self:GetCaster():HasModifier("modifier_necrolyte_4") then return end
    return self:GetStackCount() * self:GetAbility().modifier_necrolyte_4[self:GetCaster():GetTalentLevel("modifier_necrolyte_4")]
end