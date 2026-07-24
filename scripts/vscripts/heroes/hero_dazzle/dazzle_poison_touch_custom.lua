--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dazzle_poison_touch_custom", "heroes/hero_dazzle/dazzle_poison_touch_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_poison_touch_hex", "heroes/hero_dazzle/dazzle_poison_touch_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_poison_touch_custom_passive", "heroes/hero_dazzle/dazzle_poison_touch_custom", LUA_MODIFIER_MOTION_NONE)

dazzle_poison_touch_custom = class({})

function dazzle_poison_touch_custom:GetIntrinsicModifierName()
    return "modifier_dazzle_poison_touch_custom_passive"
end

function dazzle_poison_touch_custom:GetAOERadius()
    local radius = self:GetSpecialValueFor("radius")
    local caster = self:GetCaster()
    
    -- Добавляем бонус от Bloodstone 2
    -- if caster and not caster:IsNull() and caster.FindModifierByName then
    --     local bloodstone_modifier = caster:FindModifierByName("modifier_item_bloodstone")
    --     if bloodstone_modifier and bloodstone_modifier:GetAbility() then
    --         local bonus_aoe = bloodstone_modifier:GetAbility():GetSpecialValueFor("bonus_aoe")
    --         if bonus_aoe then
    --             radius = radius + bonus_aoe
    --         end
    --     end
    -- end
    
    return radius
end

function dazzle_poison_touch_custom:OnSpellStart()
    if not IsServer() then return end
    
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    
    if not target then return end
    
    EmitSoundOn("Hero_Dazzle.Poison_Touch", caster)
    
    local projectile = {
        Target = target,
        Source = caster,
        Ability = self,
        EffectName = "particles/units/heroes/hero_dazzle/dazzle_poison_touch.vpcf",
        iMoveSpeed = self:GetSpecialValueFor("projectile_speed") or 1200,
        bDodgeable = true,
        bProvidesVision = false,
        ExtraData = {
            is_primary = 1  -- Флаг что это основной снаряд
        }
    }
    
    ProjectileManager:CreateTrackingProjectile(projectile)
end

function dazzle_poison_touch_custom:OnProjectileHit_ExtraData(target, location, extraData)
    if not target then return end
    
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("radius")
    
    -- Добавляем бонус от Bloodstone 2
    -- local bloodstone_modifier = caster:FindModifierByName("modifier_item_bloodstone")
    -- if bloodstone_modifier and bloodstone_modifier:GetAbility() then
    --     local bonus_aoe = bloodstone_modifier:GetAbility():GetSpecialValueFor("bonus_aoe")
    --     if bonus_aoe then
    --         radius = radius + bonus_aoe
    --     end
    -- end
    
    local duration = self:GetSpecialValueFor("duration")
    local has_shard = caster:HasModifier("modifier_item_aghanims_shard")
    local is_primary = extraData.is_primary == 1
    
    -- Применяем эффект к цели
    target:AddNewModifier(caster, self, "modifier_dazzle_poison_touch_custom", {
        duration = duration
    })
    
    if has_shard then
        target:AddNewModifier(caster, self, "modifier_dazzle_poison_touch_hex", {duration = 2.0})
        
        EmitSoundOn("DOTA_Item.Sheepstick.Activate", target)
        ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/items_fx/item_sheepstick.vpcf", PATTACH_ABSORIGIN_FOLLOW, target))
    end
    
    -- Создаём снаряды для врагов в радиусе ТОЛЬКО если это основной снаряд
    if is_primary then
        local enemies = FindUnitsInRadius(
            caster:GetTeamNumber(),
            target:GetAbsOrigin(),
            nil,
            radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER,
            false
        )
        
        -- Создаём вторичные снаряды для всех врагов в радиусе (кроме основной цели)
        for _, enemy in pairs(enemies) do
            if enemy ~= target then
                local projectile = {
                    Target = enemy,
                    Source = target,  -- Снаряд летит от основной цели
                    Ability = self,
                    EffectName = "particles/units/heroes/hero_dazzle/dazzle_poison_touch.vpcf",
                    iMoveSpeed = self:GetSpecialValueFor("projectile_speed") or 1200,
                    bDodgeable = true,
                    bProvidesVision = false,
                    ExtraData = {
                        is_primary = 0  -- Вторичный снаряд
                    }
                }
                
                ProjectileManager:CreateTrackingProjectile(projectile)
            end
        end
    end
    
    return true
end

modifier_dazzle_poison_touch_custom_passive = class({
    IsDebuff = function(self) return false end,
    IsPurgable = function(self) return false end,
    IsPurgeException = function(self) return false end,
    IsHidden = function(self) return true end,

    OnCreated = function(self, params)
        local ability = self:GetAbility()
        if ability then
            self.BonusAttackRange = ability:GetSpecialValueFor("bonus_attack_range")
        end
    end,

    OnRefresh = function(self)
        self:OnCreated()
    end,

    DeclareFunctions = function(self)
        return {
            MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
            -- MODIFIER_EVENT_ON_ATTACK_RECORD,
        }
    end,

    GetModifierAttackRangeBonus = function(self, event)
        local parent = self:GetParent()
        local attacker = event.attacker
        local target = event.target
        
        if parent ~= nil and parent == attacker and target and not target:IsNull() then
            if target:HasModifier("modifier_dazzle_poison_touch_custom") then
                return self.BonusAttackRange
            end
        end
        return 0
    end,

    -- OnAttackRecord              = function(self, event)
    --     local parent = self:GetParent()
    --     local attacker = event.attacker
    --     local target = event.target
        
    --     if parent ~= nil and parent == attacker and target and not target:IsNull() then
    --         self:SetStackCount(0)

    --         if target:HasModifier("modifier_dazzle_poison_touch_custom") then
    --             self:SetStackCount(1)
    --         end
    --     end
    -- end
})

modifier_dazzle_poison_touch_custom = class({
    IsDebuff = function(self) return true end,
    IsPurgable = function(self) return true end,
    IsPurgeException = function(self) return false end,
    IsHidden = function(self) return false end,
    IsStunDebuff = function(self) return false end,
    RemoveOnDeath = function(self) return true end,

    OnCreated = function(self, params)
        self.caster = self:GetCaster()
        self.ability = self:GetAbility()
        self.parent = self:GetParent()
        self.damage = self.ability:GetSpecialValueFor("damage")
        self.slow = self.ability:GetSpecialValueFor("slow")
        self.damage_interval = self.ability:GetSpecialValueFor("damage_interval")

        if not IsServer() then return end
        self:StartIntervalThink(self.damage_interval)
    end,

    OnRefresh = function(self, params)
        self.damage = self.ability:GetSpecialValueFor("damage")
        self.slow = self.ability:GetSpecialValueFor("slow")
        self.damage_interval = self.ability:GetSpecialValueFor("damage_interval")
    end,

    OnIntervalThink = function(self)
        if not IsServer() then return end
        ApplyDamage({
            victim = self.parent,
            attacker = self.caster,
            ability = self.ability,
            damage = self.damage,
            damage_type = self.ability:GetAbilityDamageType(),
            damage_flags = DOTA_DAMAGE_FLAG_NONE,
        })
    end,

    DeclareFunctions = function(self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
            MODIFIER_EVENT_ON_TAKEDAMAGE,
        }
    end,

    GetModifierMoveSpeedBonus_Percentage = function(self)
        return self.slow * -1
    end,

    -- A16: любой урон по поражённой цели продлевает/обновляет дебафф Poison Touch.
    OnTakeDamage = function(self, params)
        if not IsServer() then return end
        if params.unit ~= self:GetParent() then return end
        -- Не продлеваем дебафф от его собственного тика DoT (иначе он стал бы вечным).
        if params.inflictor and not params.inflictor:IsNull()
            and params.inflictor:GetAbilityName() == "dazzle_poison_touch_custom" then
            return
        end
        local duration = self.ability:GetSpecialValueFor("duration")
        self:SetDuration(duration, true)
    end,
})

modifier_dazzle_poison_touch_hex = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,
    IsStunDebuff            = function(self) return true end,

    CheckState              = function(self) 
        return {
            [ MODIFIER_STATE_HEXED ]=true,
            [ MODIFIER_STATE_MUTED ] = true,
            [ MODIFIER_STATE_DISARMED ] = true,
            [ MODIFIER_STATE_SILENCED ] = true,
            [ MODIFIER_STATE_BLOCK_DISABLED ] = true,
            [ MODIFIER_STATE_EVADE_DISABLED ] = true,
            [ MODIFIER_STATE_PASSIVES_DISABLED ] = true
        }
    end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MODEL_CHANGE,
            MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE
        }
    end,

    GetModifierModelChange    = function(self) 
        return "models/props_gameplay/pig_blue.vmdl"
    end,
    GetModifierMoveSpeedOverride    = function(self) 
        return 100 -- Скорость движения в хексе
    end,
})

function modifier_dazzle_poison_touch_hex:OnDestroy()
    if not IsServer() then return end
    
    local parent = self:GetParent()
    parent:FadeGesture(ACT_DOTA_FLAIL)
end