--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_revenants_brooch_custom_counter", "items/item_revenants_brooch_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_revenants_brooch_custom", "items/item_revenants_brooch_custom", LUA_MODIFIER_MOTION_NONE)
require( "utils/bit" )

item_revenants_brooch_custom = class({})

function item_revenants_brooch_custom:GetIntrinsicModifierName()
    return "modifier_item_revenants_brooch_custom"
end

-- Lua wrapper intrinsic: re-attaches the vanilla modifier_item_revenants_brooch
-- to preserve original C++ behavior (bonus_damage etc.) AND adds manual spell lifesteal hook.
modifier_item_revenants_brooch_custom = class({})

function modifier_item_revenants_brooch_custom:IsHidden() return true end
function modifier_item_revenants_brooch_custom:IsPurgable() return false end
function modifier_item_revenants_brooch_custom:RemoveOnDeath() return false end

function modifier_item_revenants_brooch_custom:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    if not IsServer() then return end
    -- Re-attach vanilla brooch modifier (provides bonus_damage etc.).
    -- Идемпотентность по нашему ability: каждый custom brooch вешает СВОЙ
    -- vanilla mod (как делал бы движок через GetIntrinsicModifierName) —
    -- если у героя ещё и реальная ванильная брошка, оба бонуса сложатся.
    local mine_attached = false
    for _, mod in pairs(self.parent:FindAllModifiersByName("modifier_item_revenants_brooch")) do
        if mod:GetAbility() == self.ability then
            mine_attached = true
            break
        end
    end
    if not mine_attached then
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_revenants_brooch", {})
    end
end

function modifier_item_revenants_brooch_custom:OnDestroy()
    if not IsServer() then return end
    if not self.parent or self.parent:IsNull() then return end
    -- Cleanup только если это последний экземпляр брошки
    local other_count = 0
    for _, mod in pairs(self.parent:FindAllModifiersByName("modifier_item_revenants_brooch_custom")) do
        if mod ~= self then other_count = other_count + 1 end
    end
    if other_count > 0 then return end
    for _, mod in pairs(self.parent:FindAllModifiersByName("modifier_item_revenants_brooch")) do
        if mod:GetAbility() == self.ability then
            mod:Destroy()
            break
        end
    end
end

-- Manual spell lifesteal hook — триггерится через modifier_abilities_optimization_thinker
function modifier_item_revenants_brooch_custom:TakeDamageScriptModifier(keys)
    if not IsServer() then return end
    if not self or self:IsNull() then return end
    if keys.attacker ~= self.parent then return end
    if keys.unit:IsBuilding() or keys.unit:IsOther() then return end
    if self.parent:IsIllusion() then return end
    if keys.inflictor == nil then return end
    if keys.damage_category ~= DOTA_DAMAGE_CATEGORY_SPELL then return end
    if bit:_and(keys.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL) == DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL then return end
    if self.parent:FindAllModifiersByName(self:GetName())[1] ~= self then return end
    local lifesteal = self.ability:GetSpecialValueFor("spell_lifesteal")
    if lifesteal and lifesteal > 0 and keys.damage and keys.damage > 0 then
        keys.attacker:Heal(keys.damage * lifesteal * 0.01, keys.attacker)
    end
end

function item_revenants_brooch_custom:OnSpellStart()
    if not IsServer() then return end
    
    local caster = self:GetCaster()
    caster:EmitSound("Item.Brooch.Cast")
    
    local existing_modifier = caster:FindModifierByName("modifier_item_revenants_brooch_custom_counter")
    if existing_modifier and not existing_modifier:IsNull() then
        existing_modifier:SetStackCount(self:GetSpecialValueFor("number_of_attacks"))
        existing_modifier:SetDuration(self:GetSpecialValueFor("active_duration"), true)
        existing_modifier.should_destroy = false
    else
        caster:AddNewModifier(caster, self, "modifier_item_revenants_brooch_custom_counter", {
            duration = self:GetSpecialValueFor("active_duration"), 
            number_of_attacks = self:GetSpecialValueFor("number_of_attacks")
        })
    end
end

modifier_item_revenants_brooch_custom_counter = class({})

function modifier_item_revenants_brooch_custom_counter:IsHidden()
    return self:GetStackCount() == 0
end

function modifier_item_revenants_brooch_custom_counter:IsPurgable()
    return false
end

function modifier_item_revenants_brooch_custom_counter:OnCreated(params)
    self.parent = self:GetParent()
    if not IsServer() then return end
    
    local number_of_attacks = 5
    if params and params.number_of_attacks and params.number_of_attacks > 0 then
        number_of_attacks = params.number_of_attacks
    else
        local ability = self:GetAbility()
        if ability and not ability:IsNull() then
            number_of_attacks = ability:GetSpecialValueFor("number_of_attacks")
        end
    end
    
    self:SetStackCount(number_of_attacks)
    
    local duration = 0
    if params and params.duration and params.duration > 0 then
        duration = params.duration
    else
        local ability = self:GetAbility()
        if ability and not ability:IsNull() then
            duration = ability:GetSpecialValueFor("active_duration")
        end
    end
    
    if duration > 0 then
        self:SetDuration(duration, true)
    end
    
    self.should_destroy = false
    self:StartIntervalThink(1.0)
end

function modifier_item_revenants_brooch_custom_counter:OnDestroy()
    if not IsServer() then return end
    
    if self and not self:IsNull() then
        self:StartIntervalThink(-1)
    end
end

function modifier_item_revenants_brooch_custom_counter:OnIntervalThink()
    if not IsServer() then return end
    
    if not self or self:IsNull() then 
        return 
    end
    
    local current_stacks = self:GetStackCount()
    local remaining_time = self:GetRemainingTime()
    
    if self.should_destroy then
        if self and not self:IsNull() then
            self:Destroy()
        end
        return
    end
    
    if current_stacks <= 0 or remaining_time <= 0 then
        if self and not self:IsNull() then
            self:Destroy()
        end
    end
end

function modifier_item_revenants_brooch_custom_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_item_revenants_brooch_custom_counter:GetModifierProjectileName()
    if not self or self:IsNull() then return "" end
    if self:GetStackCount() <= 0 then return "" end
    if not self:GetAbility() or self:GetAbility():IsNull() then return "" end
    
    return ""
end

function modifier_item_revenants_brooch_custom_counter:GetOverrideAttackMagical()
    if not self or self:IsNull() then return 0 end
    if self:GetStackCount() <= 0 then return 0 end
    if not self:GetAbility() or self:GetAbility():IsNull() then return 0 end
    
    return 1
end

function modifier_item_revenants_brooch_custom_counter:GetModifierTotalDamageOutgoing_Percentage(event)
    if not IsServer() then return end
    
    if not self or self:IsNull() then 
        return 0 
    end
    
    local parent = self:GetParent()
    if not parent or parent:IsNull() then
        return 0
    end
    
    if not event.target or event.target:IsNull() then
        return 0
    end
    
    if event.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then 
        return 0 
    end
    
    if not self:GetAbility() or self:GetAbility():IsNull() then 
        return 0 
    end
    
    local muerta_ult_modifier = parent:FindModifierByName("modifier_muerta_pierce_the_veil")
    local muerta_ult_buff = parent:FindModifierByName("modifier_muerta_pierce_the_veil_buff")
    
    local is_in_muerta_ult = false
    if muerta_ult_modifier and not muerta_ult_modifier:IsNull() and muerta_ult_modifier:GetRemainingTime() > 0 then
        is_in_muerta_ult = true
    elseif muerta_ult_buff and not muerta_ult_buff:IsNull() and muerta_ult_buff:GetRemainingTime() > 0 then
        is_in_muerta_ult = true
    end
    
    local current_stacks = self:GetStackCount()
    if current_stacks <= 0 then
        return 0
    end
    
    if not event.original_damage or event.original_damage <= 0 then
        return 0
    end
    
    local should_apply_damage = true
    if event.damage_type == DAMAGE_TYPE_MAGICAL then
        should_apply_damage = false
    end
    
    if is_in_muerta_ult then
        -- Рассчитываем урон: максимум в 2 раза больше базового урона
        local base_damage = parent:GetBaseDamageMin()
        local total_damage = parent:GetAverageTrueAttackDamage(event.target)
        local max_allowed_damage = base_damage * 2
        local calculated_damage = math.min(total_damage, max_allowed_damage)
        
        
        local damageTable = 
        {
            attacker = parent,
            damage = calculated_damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            victim = event.target,
            ability = self:GetAbility(),
            damage_flags = DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK
        }
        
        ApplyDamage(damageTable)
        
        if self and not self:IsNull() then
            self:DecrementStackCount()
            
            if self:GetStackCount() <= 0 then
                self.should_destroy = true
            end
        end
        
        return 0
    else
        if should_apply_damage then
            -- Рассчитываем урон: максимум в 2 раза больше базового урона
            local base_damage = parent:GetBaseDamageMin()
            local total_damage = parent:GetAverageTrueAttackDamage(event.target)
            local max_allowed_damage = base_damage * 2
            local calculated_damage = math.min(total_damage, max_allowed_damage)
            
            
            local damageTable = 
            {
                attacker = parent,
                damage = calculated_damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                victim = event.target,
                ability = self:GetAbility(),
                damage_flags = DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK
            }
            
            ApplyDamage(damageTable)
        end
        
        if self and not self:IsNull() then
            self:DecrementStackCount()
            
            if self:GetStackCount() <= 0 then
                self.should_destroy = true
            end
        end
        
        return -200
    end
end

function modifier_item_revenants_brooch_custom_counter:CheckState()
    if not self or self:IsNull() then return {} end
    if not self:GetAbility() or self:GetAbility():IsNull() then return {} end
    if self:GetStackCount() <= 0 then return {} end
    
    return 
    {
        [MODIFIER_STATE_CANNOT_MISS] = true,
        [MODIFIER_STATE_CANNOT_TARGET_BUILDINGS] = true
    }
end

function modifier_item_revenants_brooch_custom_counter:GetEffectName()
    return ""
end

function modifier_item_revenants_brooch_custom_counter:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end