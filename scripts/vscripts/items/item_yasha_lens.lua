--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_yasha_lens", "items/item_yasha_lens", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_item_gem_custom_buff", "items/item_gem_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_yasha_lens_active", "items/item_yasha_lens", LUA_MODIFIER_MOTION_NONE)

item_yasha_lens = class({})

function item_yasha_lens:GetIntrinsicModifierName()
    return "modifier_item_yasha_lens"
end

function item_yasha_lens:GetAOERadius()
    return self:GetSpecialValueFor("active_radius")
end

function item_yasha_lens:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():EmitSound("Item.SeerStone")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_gem_custom_buff", {duration = duration})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_yasha_lens_active", {duration = duration})
end

modifier_item_yasha_lens = class({})

function modifier_item_yasha_lens:IsHidden() return true end
function modifier_item_yasha_lens:IsPurgable() return false end
function modifier_item_yasha_lens:IsPurgeException() return false end
function modifier_item_yasha_lens:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_yasha_lens:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE,
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS,
        MODIFIER_PROPERTY_BONUS_DAY_VISION,
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
    } 
end

function modifier_item_yasha_lens:OnCreated(table)
    if not IsServer() then return end
    self.fly_vision_radius = self:GetAbility():GetSpecialValueFor("fly_vision_radius")
    self:StartIntervalThink(FrameTime())
end

function modifier_item_yasha_lens:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.fly_vision_radius, FrameTime(), false)
end

function modifier_item_yasha_lens:GetBonusDayVision()
    return self:GetAbility():GetSpecialValueFor("vision_radius")
end

function modifier_item_yasha_lens:GetBonusNightVision()
    return self:GetAbility():GetSpecialValueFor("vision_radius")
end

function modifier_item_yasha_lens:GetModifierBonusStats_Agility()
    return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_yasha_lens:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_yasha_lens:GetModifierMoveSpeedBonus_Percentage_Unique()
    return self:GetAbility():GetSpecialValueFor("movespeed_bonus")
end

function modifier_item_yasha_lens:GetModifierManaBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_yasha_lens:GetModifierConstantManaRegen()
    return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_yasha_lens:GetModifierCastRangeBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_cast_range")
end


modifier_item_yasha_lens_active = class({})

function modifier_item_yasha_lens_active:IsHidden() return true end
function modifier_item_yasha_lens_active:IsPurgable() return false end
function modifier_item_yasha_lens_active:IsPurgeException() return false end
function modifier_item_yasha_lens_active:IsDebuff() return false end
function modifier_item_yasha_lens_active:OnCreated()
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_hoodwink/hoodwink_scurry_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(self.particle, false, false, -1, true, false)
end

function modifier_item_yasha_lens_active:OnDestroy()
    if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), false)
end

function modifier_item_yasha_lens_active:CheckState()
    return {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end