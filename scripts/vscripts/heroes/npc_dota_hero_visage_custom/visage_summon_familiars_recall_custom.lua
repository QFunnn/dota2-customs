--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_summon_familiars_recall_custom", "heroes/npc_dota_hero_visage_custom/visage_summon_familiars_recall_custom", LUA_MODIFIER_MOTION_NONE)

visage_summon_familiars_recall_custom = class({})

function visage_summon_familiars_recall_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():Stop()
    local recall_duration = self:GetSpecialValueFor("recall_duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_visage_summon_familiars_recall_custom", {duration = recall_duration})
end

modifier_visage_summon_familiars_recall_custom = class({})
function modifier_visage_summon_familiars_recall_custom:IsPurgable() return false end
function modifier_visage_summon_familiars_recall_custom:IsPurgeException() return false end
function modifier_visage_summon_familiars_recall_custom:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("Visage_Familar.Recall.Begin")
end
function modifier_visage_summon_familiars_recall_custom:OnDestroy()
    if not IsServer() then return end
    local owner = self:GetCaster().owner
    if not owner then return end
    if owner:IsNull() then return end
    if not owner:IsAlive() then return end
    if self:GetRemainingTime() > 0.1 then return end
    FindClearSpaceForUnit(self:GetParent(), owner:GetAbsOrigin(), true)
    self:GetParent():EmitSound("Visage_Familar.Recall.End")
end
function modifier_visage_summon_familiars_recall_custom:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    }
end
function modifier_visage_summon_familiars_recall_custom:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_recall.vpcf"
end
function modifier_visage_summon_familiars_recall_custom:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end