--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tiny_grow_custom = class({})
function modifier_tiny_grow_custom:IsHidden() return false end
function modifier_tiny_grow_custom:IsPurgeException() return false end
function modifier_tiny_grow_custom:IsPurgable() return false end
function modifier_tiny_grow_custom:RemoveOnDeath() return false end
function modifier_tiny_grow_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_tiny_grow_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():HasAbility("tiny_grow") then
        self:Destroy()
    end
end
function modifier_tiny_grow_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end
function modifier_tiny_grow_custom:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed_grow")
end