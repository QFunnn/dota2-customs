--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_eternal_ghost", "items/item_eternal_ghost.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_eternal_ghost_active", "items/item_eternal_ghost.lua", LUA_MODIFIER_MOTION_NONE)

item_eternal_ghost = class({})

function item_eternal_ghost:GetIntrinsicModifierName()
	return "modifier_item_eternal_ghost"
end

function item_eternal_ghost:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():EmitSound("DOTA_Item.GhostScepter.Activate")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_eternal_ghost_active", {duration = duration})
end

modifier_item_eternal_ghost = class({})

function modifier_item_eternal_ghost:IsHidden() return true end
function modifier_item_eternal_ghost:IsPurgable() return false end
function modifier_item_eternal_ghost:IsPurgeException() return false end

function modifier_item_eternal_ghost:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MAGICAL_LIFESTEAL
	}
end

function modifier_item_eternal_ghost:GetModifierBonusStats_Strength()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_str_stats")
    end
end

function modifier_item_eternal_ghost:GetModifierBonusStats_Agility()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_agi_stats")
    end
end

function modifier_item_eternal_ghost:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_int_stats")
    end
end

function modifier_item_eternal_ghost:GetModifierMagicalResistanceBonus()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("magical_resistance")
    end
end

function modifier_item_eternal_ghost:GetModifierHealthBonus()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_health")
    end
end

function modifier_item_eternal_ghost:GetModifierProperty_MagicalLifesteal(params)
    if self:GetParent():FindAllModifiersByName("modifier_item_eternal_ghost")[1] ~= self then return end
    return self:GetAbility():GetSpecialValueFor("spell_lifesteal")
end

modifier_item_eternal_ghost_active = class({})

function modifier_item_eternal_ghost_active:GetStatusEffectName()
    return "particles/status_fx/status_effect_ghost.vpcf"
end

function modifier_item_eternal_ghost_active:CheckState()
    if self:GetParent():IsDebuffImmune() then return end
    local state = 
    {
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_DISARMED] = true
    }
    if self:GetCaster():HasModifier("modifier_muerta_supernatural") then
        state = 
        {
            [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        }
    end
    return state
end

function modifier_item_eternal_ghost_active:DeclareFunctions()
    local decFuncs = 
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    }
    return decFuncs
end

function modifier_item_eternal_ghost_active:GetAbsoluteNoDamagePhysical()
    if self:GetParent():IsDebuffImmune() then return end
    return 1
end