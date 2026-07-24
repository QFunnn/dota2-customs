--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_activity_animation_custom = class({})
function modifier_activity_animation_custom:IsHidden() return true end
function modifier_activity_animation_custom:IsPurgable() return false end
function modifier_activity_animation_custom:IsPurgeException() return false end
function modifier_activity_animation_custom:RemoveOnDeath() return false end
function modifier_activity_animation_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_activity_animation_custom:OnCreated(params)
    if not IsServer() then return end
    self.activity = params.activity
    self:SetHasCustomTransmitterData(true)
end

function modifier_activity_animation_custom:AddCustomTransmitterData()
    return 
    {
        activity = self.activity,
    }
end

function modifier_activity_animation_custom:HandleCustomTransmitterData( data )
    self.activity = data.activity
end

function modifier_activity_animation_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    }
end

function modifier_activity_animation_custom:GetActivityTranslationModifiers()
    if self.activity == "ti9_weapon" and self:GetParent():HasModifier("modifier_centaur_hoof_stomp_custom_charge") then return end
    return self.activity
end