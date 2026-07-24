--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warrior_passive", "abilities/npc_warrior_passive.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warrior_debuff", "abilities/npc_warrior_passive.lua", LUA_MODIFIER_MOTION_NONE)

npc_warrior_passive = class({})


function npc_warrior_passive:GetIntrinsicModifierName() return "modifier_warrior_passive" end
 
modifier_warrior_passive = class ({})

function modifier_warrior_passive:IsHidden() return true end

function modifier_warrior_passive:DeclareFunctions() return {

    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK

} end



function modifier_warrior_passive:GetModifierProcAttack_Feedback( param )
    if not IsServer() then end 
    if self:GetParent() == param.attacker and  not param.target:IsMagicImmune() then
            self:GetParent():EmitSound("Phantom_Assassin.LegendaryPosison")
            local duration = self:GetAbility():GetSpecialValueFor("duration")
            param.target:AddNewModifier(param.attacker, self:GetAbility(), "modifier_warrior_debuff", { duration = duration*(1 - param.target:GetStatusResistance()) })
           
        
    end

end


modifier_warrior_debuff = class({})

function modifier_warrior_debuff:IsHidden() return false end

function modifier_warrior_debuff:IsPurgable() return true end

function modifier_warrior_debuff:OnCreated(table)
    self.reduce = self:GetAbility():GetSpecialValueFor("reduce")
    self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
    if not IsServer() then return end
    self:SetStackCount(1)
end

function modifier_warrior_debuff:OnRefresh(table)
    if not IsServer() then return end
    if self:GetStackCount() < self.max_stacks then
    self:SetStackCount(self:GetStackCount() + 1)
end
end




function modifier_warrior_debuff:DeclareFunctions()
    return {
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_TOOLTIP,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
    }
 end

 function modifier_warrior_debuff:GetTexture() return "centaur_double_edge" end

function modifier_warrior_debuff:GetModifierLifestealRegenAmplify_Percentage() return -(self.reduce * self:GetStackCount()) end
function modifier_warrior_debuff:GetModifierHealChange() return -(self.reduce * self:GetStackCount()) end
function modifier_warrior_debuff:GetModifierHPRegenAmplify_Percentage() return -(self.reduce * self:GetStackCount()) end


function modifier_warrior_debuff:GetEffectName() return "particles/items4_fx/spirit_vessel_damage.vpcf" end
 
function modifier_warrior_debuff:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end

function modifier_warrior_debuff:OnTooltip()
    return self:GetAbility():GetSpecialValueFor("reduce")*self:GetStackCount()
end