--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_flaming_fists_custom", "heroes/npc_dota_hero_warlock_custom/warlock_flaming_fists_custom", LUA_MODIFIER_MOTION_NONE)

warlock_flaming_fists_custom = class({})

function warlock_flaming_fists_custom:GetIntrinsicModifierName()
    return "modifier_warlock_flaming_fists_custom"
end

modifier_warlock_flaming_fists_custom = class({})
function modifier_warlock_flaming_fists_custom:IsHidden() return true end
function modifier_warlock_flaming_fists_custom:IsPurgable() return false end
function modifier_warlock_flaming_fists_custom:IsPurgeException() return false end
function modifier_warlock_flaming_fists_custom:RemoveOnDeath() return false end
function modifier_warlock_flaming_fists_custom:DeclareFunctions()
    return
    {
         
    }
end
function modifier_warlock_flaming_fists_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:IsBuilding() then return end
    if params.target:IsOther() then return end
    if params.target:IsInvulnerable() then return end
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    local agility = 0
    if self:GetCaster():IsHero() then
        agility = self:GetCaster():GetAgility()
    else
        agility = self:GetCaster():GetOwner():GetAgility()
    end
    damage = damage + agility / 100 * self:GetAbility():GetSpecialValueFor("agility_damage")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), params.target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, unit in pairs(units) do
        ApplyDamage({ victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility() })
    end
end

warlock_golem_flaming_fists_custom = class({})

function warlock_golem_flaming_fists_custom:GetIntrinsicModifierName()
    return "modifier_warlock_flaming_fists_custom"
end