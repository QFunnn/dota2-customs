--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_creep_spawner_cha_ready = class({})
function modifier_creep_spawner_cha_ready:IsHidden() return true end
function modifier_creep_spawner_cha_ready:IsPurgable() return false end
function modifier_creep_spawner_cha_ready:IsPurgeException() return false end
function modifier_creep_spawner_cha_ready:RemoveOnDeath() return false end
function modifier_creep_spawner_cha_ready:OnCreated()
    if not IsServer() then return end
    self:GetParent():AddNoDraw()
end
function modifier_creep_spawner_cha_ready:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveNoDraw()
end
function modifier_creep_spawner_cha_ready:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
    }
end