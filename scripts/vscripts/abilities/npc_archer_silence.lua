--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_archer_debuff", "abilities/npc_archer_silence", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_archer_passive", "abilities/npc_archer_silence", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_archer_cd", "abilities/npc_archer_silence", LUA_MODIFIER_MOTION_NONE)



npc_archer_silence = class({})

function npc_archer_silence:GetIntrinsicModifierName() return "modifier_archer_passive" end

modifier_archer_passive = class({})

function modifier_archer_passive:IsHidden() return true end

function modifier_archer_passive:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    }
end

function modifier_archer_passive:OnCreated()
self.parent = self:GetParent()
self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackRecordEvent_out(self)
end

function modifier_archer_passive:AttackRecordEvent_out(keys)

    if IsServer() then
        local attacker = keys.attacker
        local target = keys.target

        if self:GetParent() == attacker then
            local frost_attack = true
            if target:IsBuilding() or target:IsMagicImmune() then
                frost_attack = false
            end

            if not self:GetAbility():IsFullyCastable() then
                frost_attack = false
            end

            if frost_attack then
                self.frost_arrow_attack = true
                self:GetParent():SetRangedProjectileName("particles/econ/items/drow/drow_bow_monarch/drow_frost_arrow_monarch.vpcf")
             
            else
                self.frost_arrow_attack = false
                self:GetParent():SetRangedProjectileName("particles/units/heroes/hero_drow/drow_base_attack.vpcf")
            end
        end
    end
end
function modifier_archer_passive:AttackStartEvent_out(keys)
    if IsServer() then
        local attacker = keys.attacker
        local target = keys.target

        if self:GetParent() == keys.attacker then
            if not self.frost_arrow_attack then
                return nil
            end
            self:GetParent():EmitSound("Hero_DrowRanger.FrostArrows")
             self:GetAbility():UseResources(false, false, false, true)
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_archer_cd", {duration = self:GetAbility():GetCooldownTimeRemaining()})
          
        end
    end
end

function modifier_archer_passive:GetModifierProcAttack_Feedback(keys)
    if IsServer() then
        local attacker = keys.attacker
        local target = keys.target

        if self:GetParent() == attacker then
            if self.frost_arrow_attack and not target:IsMagicImmune() then
             if target:TriggerSpellAbsorb( self:GetAbility() ) then return end   
            local duration = self:GetAbility():GetSpecialValueFor("duration")
            target:AddNewModifier(self:GetCaster(), self:GetAbility(),"modifier_archer_debuff", {duration = duration*(1 - target:GetStatusResistance())})
            end
        end
    end
end


modifier_archer_debuff = class({})

function modifier_archer_debuff:IsHidden() return false end

function modifier_archer_debuff:IsPurgable() return true end

function modifier_archer_debuff:OnCreated(table)
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
    if not IsServer() then return end
end


function modifier_archer_debuff:CheckState() return { [MODIFIER_STATE_SILENCED] = true } end


function modifier_archer_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_TOOLTIP
    }
 end

 function modifier_archer_debuff:OnTooltip()
    return self:GetAbility():GetSpecialValueFor("slow")  end

 function modifier_archer_debuff:GetTexture() return "drow_ranger_silence" end

function modifier_archer_debuff:GetModifierMoveSpeedBonus_Percentage() return -self.slow  end

function modifier_archer_debuff:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
 
function modifier_archer_debuff:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end



modifier_archer_cd = class({})

function modifier_archer_cd:IsHidden() return false end
function modifier_archer_cd:IsPurgable() return false end