--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_self_immolation_custom", "heroes/npc_dota_hero_warlock_custom/warlock_self_immolation_custom", LUA_MODIFIER_MOTION_NONE)

warlock_self_immolation_custom = class({})

function warlock_self_immolation_custom:GetIntrinsicModifierName()
    return "modifier_warlock_self_immolation_custom"
end

modifier_warlock_self_immolation_custom = class({})
function modifier_warlock_self_immolation_custom:IsPurgable() return false end
function modifier_warlock_self_immolation_custom:IsPurgeException() return false end
function modifier_warlock_self_immolation_custom:RemoveOnDeath() return false end
function modifier_warlock_self_immolation_custom:IsHidden() return true end
function modifier_warlock_self_immolation_custom:OnCreated()
    if not IsServer() then return end
    self.model = "models/items/warlock/golem/hellsworn_golem/hellsworn_golem.vmdl"
    if self:GetAbility().model_warlock == nil then
        local golem = CreateUnitByName("npc_dota_warlock_golem", Vector(0,0,0), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
        self.model = golem:GetModelName()
        self:GetAbility().model_warlock = golem:GetModelName()
        UTIL_Remove(golem)
    end
    self:GetParent():SetModel(self.model)
    self:GetParent():SetOriginalModel(self.model)
    self:GetCaster():CalculateStatBonus(true)
end
function modifier_warlock_self_immolation_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end
function modifier_warlock_self_immolation_custom:GetModifierSlowResistance_Stacking()
    return self:GetAbility():GetSpecialValueFor("status_resistance")
end
function modifier_warlock_self_immolation_custom:GetModifierExtraHealthPercentage()
    return self:GetAbility():GetSpecialValueFor("bonus_health")
end
function modifier_warlock_self_immolation_custom:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end