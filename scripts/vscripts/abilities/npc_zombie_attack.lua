--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zombie_attack", "abilities/npc_zombie_attack.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zombie_debuff", "abilities/npc_zombie_attack.lua", LUA_MODIFIER_MOTION_NONE)

npc_zombie_attack = class({})


function npc_zombie_attack:GetIntrinsicModifierName() return "modifier_zombie_attack" end
 
modifier_zombie_attack = class ({})

function modifier_zombie_attack:IsHidden() return true end

function modifier_zombie_attack:DeclareFunctions() return {

    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK

} end



function modifier_zombie_attack:GetModifierProcAttack_Feedback( param )
    if not IsServer() then end 
    if self:GetParent() == param.attacker and  not param.target:IsMagicImmune() then
            local duration = self:GetAbility():GetSpecialValueFor("duration")
            param.target:AddNewModifier(param.attacker, self:GetAbility(), "modifier_zombie_debuff", { duration = duration*(1 - param.target:GetStatusResistance()) })
           
    end

end


modifier_zombie_debuff = class({})

function modifier_zombie_debuff:IsHidden() return false end

function modifier_zombie_debuff:IsPurgable() return true end

function modifier_zombie_debuff:OnCreated(table)
    self.slow = -self:GetAbility():GetSpecialValueFor("slow")
    self.max = self:GetAbility():GetSpecialValueFor("max")
    if not IsServer() then return end
    self:SetStackCount(1)
end


function modifier_zombie_debuff:OnRefresh(table)
    if not IsServer() then return end
    if self.max > self:GetStackCount() then 
     self:SetStackCount(self:GetStackCount()+1)
end
end


function modifier_zombie_debuff:DeclareFunctions()
    return {
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_TOOLTIP
    }
 end

 function modifier_zombie_debuff:GetTexture() return "undying_tombstone_zombie_deathstrike" end

function modifier_zombie_debuff:GetModifierMoveSpeedBonus_Percentage() return self.slow*self:GetStackCount() end




function modifier_zombie_debuff:OnTooltip()
    return self.slow*self:GetStackCount()
end