--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_jakiro_ice_embrace", "heroes/npc_dota_hero_jakiro_custom/jakiro_ice_embrace", LUA_MODIFIER_MOTION_NONE)

jakiro_ice_embrace = class({})

jakiro_ice_embrace.modifier_jakiro_17 = {0,10,20}

function jakiro_ice_embrace:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/econ/items/winter_wyvern/winter_wyvern_ti7/wyvern_cold_embrace_ti7buff.vpcf", context)
end

function jakiro_ice_embrace:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_jakiro_ice_embrace", {duration = duration})
    self:GetCaster():EmitSound("Hero_Winter_Wyvern.ColdEmbrace.Cast")
end

modifier_jakiro_ice_embrace = class({})

function modifier_jakiro_ice_embrace:OnCreated()
    self.heal = self:GetAbility():GetSpecialValueFor("heal")
    self.mana = self:GetAbility():GetSpecialValueFor("mana")
end

function modifier_jakiro_ice_embrace:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT
    }
end

function modifier_jakiro_ice_embrace:GetModifierSpellAmplify_Percentage()
    if self:GetCaster():HasModifier("modifier_jakiro_17") then
        return self:GetAbility().modifier_jakiro_17[self:GetCaster():GetTalentLevel("modifier_jakiro_17")]
    end
end

function modifier_jakiro_ice_embrace:GetModifierMoveSpeed_Limit()
    if self:GetCaster():HasModifier("modifier_jakiro_17") then
        return 0.1
    end
end

function modifier_jakiro_ice_embrace:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_jakiro_ice_embrace:GetModifierConstantHealthRegen()
    return self:GetParent():GetMaxHealth() / 100 * self.heal
end

function modifier_jakiro_ice_embrace:GetModifierConstantManaRegen()
    return self:GetParent():GetMaxMana() / 100 * self.mana
end

function modifier_jakiro_ice_embrace:CheckState()
    if self:GetCaster():HasModifier("modifier_jakiro_17") then
        return
        {
            [MODIFIER_STATE_DISARMED] = true,
        }
    end
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_FROZEN] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }
end

function modifier_jakiro_ice_embrace:GetEffectName()
    return "particles/econ/items/winter_wyvern/winter_wyvern_ti7/wyvern_cold_embrace_ti7buff.vpcf"
end

function modifier_jakiro_ice_embrace:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end