--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spider_passive", "abilities/npc_spider_poison.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spider_debuff", "abilities/npc_spider_poison.lua", LUA_MODIFIER_MOTION_NONE)

npc_spider_poison = class({})


function npc_spider_poison:GetIntrinsicModifierName() return "modifier_spider_passive" end
 
modifier_spider_passive = class ({})

function modifier_spider_passive:IsHidden() return true end

function modifier_spider_passive:DeclareFunctions() return {

    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK

} end



function modifier_spider_passive:GetModifierProcAttack_Feedback( param )
    if not IsServer() then end 
    if self:GetParent() == param.attacker and  not param.target:IsMagicImmune() then
            local duration = self:GetAbility():GetSpecialValueFor("duration")
            param.target:AddNewModifier(param.attacker, self:GetAbility(), "modifier_spider_debuff", { duration = duration*(1 - param.target:GetStatusResistance()) })
           
    end

end


modifier_spider_debuff = class({})

function modifier_spider_debuff:IsHidden() return false end

function modifier_spider_debuff:IsPurgable() return true end

function modifier_spider_debuff:OnCreated(table)
    self.miss = self:GetAbility():GetSpecialValueFor("miss")
end




function modifier_spider_debuff:DeclareFunctions()
    return {
    MODIFIER_PROPERTY_MISS_PERCENTAGE,
    MODIFIER_PROPERTY_TOOLTIP
    }
 end

 function modifier_spider_debuff:GetTexture() return "broodmother_incapacitating_bite" end

function modifier_spider_debuff:GetModifierMiss_Percentage() return self.miss end


function modifier_spider_debuff:GetEffectName() return "particles/units/heroes/hero_broodmother/broodmother_incapacitatingbite_debuff.vpcf" end
 
function modifier_spider_debuff:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end

function modifier_spider_debuff:OnTooltip()
    return self.miss
end