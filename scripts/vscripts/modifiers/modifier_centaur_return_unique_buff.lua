--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_centaur_return_unique_buff = class({})
function modifier_centaur_return_unique_buff:IsHidden() return true end
function modifier_centaur_return_unique_buff:IsPurgeException() return false end
function modifier_centaur_return_unique_buff:IsPurgable() return false end
function modifier_centaur_return_unique_buff:RemoveOnDeath() return false end
function modifier_centaur_return_unique_buff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
end
function modifier_centaur_return_unique_buff:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():HasAbility("centaur_return") then
        self:Destroy()
    end
end
function modifier_centaur_return_unique_buff:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
    return funcs
end
function modifier_centaur_return_unique_buff:GetModifierIncomingDamage_Percentage(params)
    -- [NP-16] Под Break (отключение пассивок) снижение урона не работает.
    if self:GetParent():PassivesDisabled() then return 0 end
    return -25
end