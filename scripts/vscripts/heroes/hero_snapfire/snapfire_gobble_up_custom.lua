--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_snapfire_gobble_up_custom", "heroes/hero_snapfire/snapfire_gobble_up_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_snapfire_gobble_up_custom_target", "heroes/hero_snapfire/snapfire_gobble_up_custom.lua", LUA_MODIFIER_MOTION_NONE)

snapfire_gobble_up_custom = class({})


function snapfire_gobble_up_custom:GetAssociatedPrimaryAbilities()
    return "snapfire_spit_creep"
end

function snapfire_gobble_up_custom:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor("creep_duration")
    
    -- Проверяем, что цель - крип
    if target:IsCreep() then
        -- Сохраняем оригинальную команду крипа
        target.original_team = target:GetTeamNumber()
        
        -- Наносим урон крипу
        local damageTable = {
            victim = target,
            attacker = caster,
            damage = target:GetMaxHealth(), -- Всегда наносим 100% урона от максимального здоровья
            damage_type = DAMAGE_TYPE_PURE,
            damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
            ability = self
        }
        ApplyDamage(damageTable)
        
        -- Если крип выжил (из-за проклятия или других эффектов)
        if target:IsAlive() then
            -- Добавляем модификатор проглатывания
            caster:AddNewModifier(caster, self, "modifier_snapfire_gobble_up_custom", {
                duration = duration,
                target_entindex = target:entindex()
            })
            
            -- Делаем крипа невидимым и неуязвимым
            target:AddNewModifier(caster, self, "modifier_snapfire_gobble_up_custom_target", {
                duration = duration
            })
        end
    end
    
    -- Звуковой эффект
    EmitSoundOn("Hero_Snapfire.FeedCookie.Cast", caster)
end

function snapfire_gobble_up_custom:OnProjectileHit(target, location)
    if not target then return end
    
    local caster = self:GetCaster()
    
    -- Если цель - крип, восстанавливаем его оригинальную команду
    if target:IsCreep() and target.original_team then
        target:SetTeam(target.original_team)
        
        -- Наносим дополнительный урон, чтобы гарантировать смерть крипа
        local damageTable = {
            victim = target,
            attacker = caster,
            damage = target:GetMaxHealth(), -- Всегда наносим 100% урона от максимального здоровья
            damage_type = DAMAGE_TYPE_PURE,
            damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
            ability = self
        }
        ApplyDamage(damageTable)
    end
    
    return true
end

-- Модификатор для Snapfire (кастера)
modifier_snapfire_gobble_up_custom = class({
    IsHidden = function(self) return false end,
    IsPurgable = function(self) return false end,
    IsDebuff = function(self) return false end,
    GetAttributes = function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
    
    -- Функция вызывается при создании модификатора
    OnCreated = function(self, kv)
        if not IsServer() then return end
        
        self.target_entindex = kv.target_entindex
        self.target = EntIndexToHScript(self.target_entindex)
        
        -- Сохраняем оригинальную команду цели
        if self.target and not self.target:IsNull() then
            self.original_team = self.target.original_team or self.target:GetTeamNumber()
        end
    end,
    
    -- Функция вызывается при уничтожении модификатора
    OnDestroy = function(self)
        if not IsServer() then return end
        
        local caster = self:GetCaster()
        local target = self.target
        
        if target and not target:IsNull() and target:IsAlive() then
            -- Удаляем модификатор цели
            target:RemoveModifierByName("modifier_snapfire_gobble_up_custom_target")
            
            -- Восстанавливаем оригинальную команду
            if self.original_team then
                target:SetTeam(self.original_team)
            end
            
            -- Наносим дополнительный урон, чтобы гарантировать смерть крипа
            local damageTable = {
                victim = target,
                attacker = caster,
                damage = target:GetMaxHealth(), -- Всегда наносим 100% урона от максимального здоровья
                damage_type = DAMAGE_TYPE_PURE,
                damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
                ability = self:GetAbility()
            }
            ApplyDamage(damageTable)
        end
    end
})

-- Модификатор для проглоченной цели
modifier_snapfire_gobble_up_custom_target = class({
    IsHidden = function(self) return true end,
    IsPurgable = function(self) return false end,
    IsDebuff = function(self) return false end,
    
    CheckState = function(self)
        return {
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_OUT_OF_GAME] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
            [MODIFIER_STATE_UNSELECTABLE] = true
        }
    end,
    
    -- Функция вызывается при создании модификатора
    OnCreated = function(self, kv)
        if not IsServer() then return end
        
        -- Сохраняем оригинальную команду
        self.original_team = self:GetParent().original_team or self:GetParent():GetTeamNumber()
        
        -- Скрываем крипа
        self:GetParent():AddNoDraw()
    end,
    
    -- Функция вызывается при уничтожении модификатора
    OnDestroy = function(self)
        if not IsServer() then return end
        
        local parent = self:GetParent()
        
        -- Показываем крипа
        parent:RemoveNoDraw()
        
        -- Восстанавливаем оригинальную команду
        if self.original_team then
            parent:SetTeam(self.original_team)
        end
    end
})