--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_juggernaut_blade_dance_custom", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_blade_dance_custom", LUA_MODIFIER_MOTION_NONE)

juggernaut_blade_dance_custom = class({})
juggernaut_blade_dance_custom.modifier_juggernaut_12 = {10,20,30}

function juggernaut_blade_dance_custom:GetIntrinsicModifierName() return "modifier_juggernaut_blade_dance_custom" end

modifier_juggernaut_blade_dance_custom = class({})
function modifier_juggernaut_blade_dance_custom:IsHidden() return true end
function modifier_juggernaut_blade_dance_custom:IsPurgable() return false end
function modifier_juggernaut_blade_dance_custom:RemoveOnDeath() return false end

function modifier_juggernaut_blade_dance_custom:GetCritDamage()
    local damage = self:GetAbility():GetSpecialValueFor("blade_dance_crit_mult")
    return damage
end
 
function modifier_juggernaut_blade_dance_custom:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    } 
end

function modifier_juggernaut_blade_dance_custom:OnCreated(table)
    self.target = nil
    self.record = nil
end

function modifier_juggernaut_blade_dance_custom:GetModifierPreAttack_CriticalStrike( params )
    if not IsServer() then return end
    if self:GetParent():PassivesDisabled() then return end
    if params.target:GetTeamNumber()==self:GetParent():GetTeamNumber() then return end
    self.record = nil
    local chance = self:GetAbility():GetSpecialValueFor("blade_dance_crit_chance")
    local damage = self:GetAbility():GetSpecialValueFor("blade_dance_crit_mult")
    if self:GetCaster():HasModifier("modifier_juggernaut_12") then
        damage = damage + self:GetAbility().modifier_juggernaut_12[self:GetCaster():GetTalentLevel("modifier_juggernaut_12")]
    end
    local random = RollPseudoRandomPercentage(chance, 12, self:GetParent())
    if random then
        self.record = params.record
        return damage
    end
end

function modifier_juggernaut_blade_dance_custom:GetModifierProcAttack_Feedback( params )
    if not IsServer() then return end
    if not self.record or self.record ~= params.record then return end
    if params.target and not params.target:IsNull() then 
        params.target:EmitSound("Hero_Juggernaut.BladeDance")
    end
end