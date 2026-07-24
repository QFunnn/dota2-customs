--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_talent_debuff_use_ability", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_buff", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_arcane_aura_custom = class({})
crystal_maiden_arcane_aura_custom.modifier_crystal_maiden_20_duration = {4,6,8}
crystal_maiden_arcane_aura_custom.modifier_crystal_maiden_20_mana_cost = -5
crystal_maiden_arcane_aura_custom.modifier_crystal_maiden_20_mana_regen = 0.5
crystal_maiden_arcane_aura_custom.modifier_crystal_maiden_17 = {10,20}

function crystal_maiden_arcane_aura_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/medusa_mana_shield_2.vpcf', context )
    PrecacheResource( "particle", 'particles/medusa_mana_shield_impact_2.vpcf', context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_crystal_maiden.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_crystal_maiden.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_crystal_maiden.vpcf", context)
end

function crystal_maiden_arcane_aura_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function crystal_maiden_arcane_aura_custom:GetIntrinsicModifierName()
	return "modifier_crystal_maiden_arcane_aura_custom"
end

modifier_crystal_maiden_arcane_aura_custom = class({})
function modifier_crystal_maiden_arcane_aura_custom:IsHidden() return true end
function modifier_crystal_maiden_arcane_aura_custom:IsPurgable() return false end
function modifier_crystal_maiden_arcane_aura_custom:IsPurgeException() return false end
function modifier_crystal_maiden_arcane_aura_custom:RemoveOnDeath() return false end
function modifier_crystal_maiden_arcane_aura_custom:IsAura() return not self:GetCaster():HasModifier("modifier_crystal_maiden_7") end
function modifier_crystal_maiden_arcane_aura_custom:GetModifierAura() return "modifier_crystal_maiden_arcane_aura_custom_buff" end
function modifier_crystal_maiden_arcane_aura_custom:GetAuraRadius() return -1 end
function modifier_crystal_maiden_arcane_aura_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_crystal_maiden_arcane_aura_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_crystal_maiden_arcane_aura_custom:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_crystal_maiden_arcane_aura_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
    }
end
function modifier_crystal_maiden_arcane_aura_custom:GetModifierMPRegenAmplify_Percentage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_crystal_maiden_17") then
        bonus = self:GetAbility().modifier_crystal_maiden_17[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_17")]
    end
	return self:GetAbility():GetSpecialValueFor("mana_regen_amp") + bonus
end

modifier_crystal_maiden_arcane_aura_custom_buff = class({})

function modifier_crystal_maiden_arcane_aura_custom_buff:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    }
end

function modifier_crystal_maiden_arcane_aura_custom_buff:GetModifierConstantManaRegen()
	local bonus = 1
    local distance = (self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()
    if distance <= self:GetAbility():GetSpecialValueFor( "proximity_bonus_radius" ) then 
        return (self:GetAbility():GetSpecialValueFor("base_mana_regen") * self:GetAbility():GetSpecialValueFor("proximity_bonus_factor")) * bonus
    end
	return self:GetAbility():GetSpecialValueFor("base_mana_regen") * bonus
end

modifier_crystal_maiden_arcane_aura_custom_talent_debuff_use_ability = class({})
function modifier_crystal_maiden_arcane_aura_custom_talent_debuff_use_ability:IsPurgable() return false end
function modifier_crystal_maiden_arcane_aura_custom_talent_debuff_use_ability:IsDebuff() return true end

modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind = class({})

function modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind:OnCreated()
	if not IsServer() then return end
	self:IncrementStackCount()
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind:OnRefresh()
	if not IsServer() then return end
    self:OnCreated()
end

function modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
        MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
	}
end

function modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind:GetModifierTotalPercentageManaRegen()
	return self:GetAbility().modifier_crystal_maiden_20_mana_regen * self:GetStackCount()
end

function modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind:GetTexture()
	return "crystal_maiden_20"
end

function modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind:GetModifierPercentageManacostStacking(params)
	return self:GetAbility().modifier_crystal_maiden_20_mana_cost * self:GetStackCount()
end