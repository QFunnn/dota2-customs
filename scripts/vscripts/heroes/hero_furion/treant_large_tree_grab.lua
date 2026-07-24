--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_treant_large_tree_grab", "heroes/hero_furion/treant_large_tree_grab.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if treant_large_tree_grab == nil then
    treant_large_tree_grab = class({})
end
function treant_large_tree_grab:GetIntrinsicModifierName()
    return "modifier_treant_large_tree_grab"
end
---------------------------------------------------------------------
--Modifiers
if modifier_treant_large_tree_grab == nil then
    modifier_treant_large_tree_grab = class({})
end
function modifier_treant_large_tree_grab:IsDebuff()
    return false
end
function modifier_treant_large_tree_grab:IsHidden()
    return true
end
function modifier_treant_large_tree_grab:OnCreated(params)
    self.duration = self:GetAbility():GetSpecialValueFor("duration")
    self.cleave_damage_percent = self:GetAbility():GetSpecialValueFor("cleave_damage_percent")
    if IsServer() then
    end
end
function modifier_treant_large_tree_grab:OnRefresh(params)
    self.duration = self:GetAbility():GetSpecialValueFor("duration")
    self.cleave_damage_percent = self:GetAbility():GetSpecialValueFor("cleave_damage_percent")
    if IsServer() then
    end
end
function modifier_treant_large_tree_grab:OnDestroy()
    if IsServer() then
    end
end
function modifier_treant_large_tree_grab:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end
function modifier_treant_large_tree_grab:OnAttackLanded(params)
    local hParent = self:GetParent()
    if params.attacker == hParent then
        DoCleaveAttack(hParent, params.target, self:GetAbility(), params.damage * self.cleave_damage_percent * 0.01, 150, 360, 650, "")
        local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_tiny/tiny_craggy_cleave.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
        ParticleManager:SetParticleControl(particleID, 0, params.target:GetAbsOrigin())
        ParticleManager:SetParticleControl(particleID, 1, hParent:GetAbsOrigin())
        ParticleManager:SetParticleControl(particleID, 2, hParent:GetAbsOrigin())
        ParticleManager:SetParticleControlForward(particleID, 2, (params.target:GetAbsOrigin() - hParent:GetAbsOrigin()):Normalized())
        ParticleManager:ReleaseParticleIndex(particleID)

        EmitSoundOn("Hero_Tiny_Tree.Attack", hParent)
    end
end