--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abaddon_frostmourne_custom", "heroes/npc_dota_hero_abaddon_custom/abaddon_frostmourne_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abaddon_frostmourne_custom_debuff_stack", "heroes/npc_dota_hero_abaddon_custom/abaddon_frostmourne_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abaddon_frostmourne_custom_debuff", "heroes/npc_dota_hero_abaddon_custom/abaddon_frostmourne_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abaddon_frostmourne_custom_buff", "heroes/npc_dota_hero_abaddon_custom/abaddon_frostmourne_custom", LUA_MODIFIER_MOTION_NONE)

abaddon_frostmourne_custom = class({})

abaddon_frostmourne_custom.modifier_abaddon_1 = 300
abaddon_frostmourne_custom.modifier_abaddon_3 = {20,40,60}

function abaddon_frostmourne_custom:GetIntrinsicModifierName()
    return "modifier_abaddon_frostmourne_custom"
end

modifier_abaddon_frostmourne_custom = class({})
function modifier_abaddon_frostmourne_custom:IsPurgable() return false end
function modifier_abaddon_frostmourne_custom:IsPurgeException() return false end
function modifier_abaddon_frostmourne_custom:IsHidden() return true end
function modifier_abaddon_frostmourne_custom:RemoveOnDeath() return false end
function modifier_abaddon_frostmourne_custom:DeclareFunctions()
    return 
    {
         
    }
end
function modifier_abaddon_frostmourne_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:IsBuilding() then return end
    if params.target:IsOther() then return end
    if params.target:IsInvulnerable() then return end
    if self:GetParent():IsIllusion() then return end
    local slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
    local curse_duration = self:GetAbility():GetSpecialValueFor("curse_duration")
    local hit_count = self:GetAbility():GetSpecialValueFor("hit_count")
    local modifier_abaddon_frostmourne_custom_debuff_stack = params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abaddon_frostmourne_custom_debuff_stack", {duration = slow_duration})
    if modifier_abaddon_frostmourne_custom_debuff_stack and modifier_abaddon_frostmourne_custom_debuff_stack:GetStackCount() >= hit_count then
        modifier_abaddon_frostmourne_custom_debuff_stack:Destroy()
        params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abaddon_frostmourne_custom_debuff", {duration = curse_duration})
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abaddon_frostmourne_custom_buff", {duration = curse_duration})
        if self:GetCaster():HasModifier("modifier_abaddon_1") then
            local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), params.target:GetAbsOrigin(), nil, self:GetAbility().modifier_abaddon_1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
            for _, unit in pairs(units) do
                if unit ~= params.target then
                    unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abaddon_frostmourne_custom_debuff", {duration = curse_duration})
                end
            end
        end
    end
end

modifier_abaddon_frostmourne_custom_debuff_stack = class({})

function modifier_abaddon_frostmourne_custom_debuff_stack:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    --self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    --ParticleManager:SetParticleControl(self.particle, 1, Vector(0,self:GetStackCount(),0))
    --self:AddParticle(self.particle, false, false, -1, false, true)
end

function modifier_abaddon_frostmourne_custom_debuff_stack:GetEffectName()
    return "particles/units/heroes/hero_abaddon/abaddon_frost_slow.vpcf"
end

function modifier_abaddon_frostmourne_custom_debuff_stack:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_abaddon_frostmourne_custom_debuff_stack:GetStatusEffectName()
    return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_abaddon_frostmourne_custom_debuff_stack:StatusEffectPriority()
    return 100
end

function modifier_abaddon_frostmourne_custom_debuff_stack:OnRefresh()
    if not IsServer() then return end
    self:IncrementStackCount()
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(0,self:GetStackCount(),0))
    end
end

function modifier_abaddon_frostmourne_custom_debuff_stack:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_abaddon_frostmourne_custom_debuff_stack:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_speed")
end

modifier_abaddon_frostmourne_custom_debuff = class({})

function modifier_abaddon_frostmourne_custom_debuff:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Abaddon.Curse.Proc")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_curse_frostmourne_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    local curse_interval = self:GetAbility():GetSpecialValueFor("curse_interval")
    self:StartIntervalThink(curse_interval)
end

function modifier_abaddon_frostmourne_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    local curse_dps = self:GetAbility():GetSpecialValueFor("curse_dps")
    if self:GetCaster():HasModifier("modifier_abaddon_3") then
        curse_dps = curse_dps + self:GetAbility().modifier_abaddon_3[self:GetCaster():GetTalentLevel("modifier_abaddon_3")]
    end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = curse_dps * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_abaddon_frostmourne_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
         
    }
end

function modifier_abaddon_frostmourne_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("curse_slow")
end

function modifier_abaddon_frostmourne_custom_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_abaddon_frostmourne.vpcf"
end

function modifier_abaddon_frostmourne_custom_debuff:StatusEffectPriority()
    return 100
end

function modifier_abaddon_frostmourne_custom_debuff:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker == self:GetParent() then return end
    params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abaddon_frostmourne_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("curse_duration"), target = self:GetParent():entindex()})
end

modifier_abaddon_frostmourne_custom_buff = class({})

function modifier_abaddon_frostmourne_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
         
    }
end

function modifier_abaddon_frostmourne_custom_buff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("curse_attack_speed")
end

function modifier_abaddon_frostmourne_custom_buff:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not params.target:HasModifier("modifier_abaddon_frostmourne_custom_debuff") then
        self:Destroy()
    end
end