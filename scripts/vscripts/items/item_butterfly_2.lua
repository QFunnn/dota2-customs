--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_butterfly_2", "items/item_butterfly_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_butterfly_2_cooldown_text", "items/item_butterfly_2", LUA_MODIFIER_MOTION_NONE)

item_butterfly_2 = class({})

function item_butterfly_2:GetIntrinsicModifierName()
    return "modifier_item_butterfly_2"
end

modifier_item_butterfly_2 = class({})

function modifier_item_butterfly_2:IsHidden()
    return true
end

function modifier_item_butterfly_2:IsPurgable()
    return false
end

function modifier_item_butterfly_2:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_butterfly_2:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_AVOID_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE
    }

    return funcs
end

function modifier_item_butterfly_2:OnCreated()
    self.ability = self:GetAbility()
    self.bonus_agility = self.ability:GetSpecialValueFor('bonus_agility')
    self.bonus_damage = self.ability:GetSpecialValueFor('bonus_damage')
    self.bonus_evasion = self.ability:GetSpecialValueFor('bonus_evasion')
    self.bonus_attack_speed = self.ability:GetSpecialValueFor('bonus_attack_speed')
    self.bonus_movespeed = self.ability:GetSpecialValueFor('bonus_movespeed')
    self.bonus_universal_evasion = self.ability:GetSpecialValueFor('bonus_universal_evasion')
    self.bonus_attack_speed_pct = self.ability:GetSpecialValueFor("bonus_attack_speed_pct")
    
    -- Инициализируем куллдаун для универсального уклонения
    self.evasion_cooldown = self.ability:GetSpecialValueFor("evasion_cooldown") or 0.6
    self.last_evasion_time = 0
end

function modifier_item_butterfly_2:GetModifierBonusStats_Agility()
    return self.bonus_agility
end

function modifier_item_butterfly_2:GetModifierPreAttack_BonusDamage(params)
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, self.bonus_damage, "item_butterfly_2", DAMAGE_TYPE_PHYSICAL)
    end
    return self.bonus_damage
end

function modifier_item_butterfly_2:GetModifierEvasion_Constant()
    return self.bonus_evasion
end

function modifier_item_butterfly_2:GetModifierAttackSpeedBonus_Constant()
    return self.bonus_attack_speed
end

function modifier_item_butterfly_2:GetModifierMoveSpeedBonus_Constant()
    return self.bonus_movespeed
end

function modifier_item_butterfly_2:GetModifierAttackSpeedPercentage()
    return self.bonus_attack_speed_pct
end

function modifier_item_butterfly_2:GetModifierAvoidDamage(params)
    if not IsServer() then return end
    
    -- Проверяем источник урона
    if not params.attacker then return 0 end
    
    -- Блокируем уворот от самоурона (например, Burning Spear)
    if params.attacker == self:GetParent() then
        return 0
    end
    
    local parent = self:GetParent()

    -- Кулдаун применяется к уворотам от вражеских ГЕРОЕВ И их СУММОНОВ/иллюзий — т.е. от
    -- юнитов с владельцем-игроком на вражеской команде. Обычные крипы волны сюда НЕ попадают
    -- (у них нет владельца-игрока: GetPlayerOwnerID == -1) → от них уворот без кулдауна.
    local ownerPID = params.attacker:GetPlayerOwnerID()
    local is_enemy_owned = params.attacker:GetTeamNumber() ~= parent:GetTeamNumber()
        and ownerPID ~= nil and ownerPID ~= -1

    local current_time = GameRules:GetGameTime()

    -- Проверяем кулдаун только для уворотов от вражеских героев/суммонов
    if is_enemy_owned and (current_time - self.last_evasion_time < self.evasion_cooldown) then
        return 0
    end

    -- Проверяем шанс уклонения
    if RollPercentage(self.bonus_universal_evasion) then
        -- Кулдаун ставим для героев И суммонов врага (не для волновых крипов)
        if is_enemy_owned then
            self.last_evasion_time = current_time

            -- Текстовый индикатор перезарядки
            if parent and not parent:IsNull() then
                parent:AddNewModifier(parent, self:GetAbility(), "modifier_item_butterfly_2_cooldown_text", {duration = self.evasion_cooldown})
            end
        end

        -- Визуальный эффект уворота (партикл Backtrack)
        if parent and not parent:IsNull() then
            local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
            ParticleManager:ReleaseParticleIndex(fx)
        end

        return 1
    end

    return 0
end

-- Функция для получения оставшегося времени куллдауна (для клиента)
function modifier_item_butterfly_2:GetEvasionCooldownRemaining()
    if not IsServer() then return 0 end
    
    local current_time = GameRules:GetGameTime()
    local time_since_last = current_time - self.last_evasion_time
    
    if time_since_last >= self.evasion_cooldown then
        return 0
    else
        return self.evasion_cooldown - time_since_last
    end
end

-- Визуальный модификатор удален - теперь используется только текстовый

-- Модификатор для отображения текстового куллдауна
modifier_item_butterfly_2_cooldown_text = class({})

function modifier_item_butterfly_2_cooldown_text:IsHidden()
    return false
end

function modifier_item_butterfly_2_cooldown_text:IsPurgable()
    return false
end

function modifier_item_butterfly_2_cooldown_text:IsDebuff()
    return false
end

function modifier_item_butterfly_2_cooldown_text:GetTexture()
    return "item_butterfly_2"
end

function modifier_item_butterfly_2_cooldown_text:OnCreated()
    if not IsServer() then return end
    
    self.cooldown_duration = self:GetDuration()
    self.start_time = GameRules:GetGameTime()
    
    -- Добавляем визуальную перезарядку на предмет в инвентаре
    local parent = self:GetParent()
    if parent and not parent:IsNull() then
        local butterfly_modifier = parent:FindModifierByName("modifier_item_butterfly_2")
        if butterfly_modifier then
            local item = butterfly_modifier:GetAbility()
            if item and not item:IsNull() then
                item:StartCooldown(self.cooldown_duration)
            end
        end
    end
    
    -- Запускаем обновление текста каждые 0.1 секунды
    self:StartIntervalThink(0.1)
end

function modifier_item_butterfly_2_cooldown_text:OnIntervalThink()
    if not IsServer() then return end
    
    local current_time = GameRules:GetGameTime()
    local elapsed_time = current_time - self.start_time
    local remaining_time = self.cooldown_duration - elapsed_time
    
    if remaining_time <= 0 then
        self:Destroy()
        return
    end
    
    -- Оставшееся время в СЕКУНДАХ (целое, округляем вверх — как обычные откаты в доте)
    self:SetStackCount(math.ceil(remaining_time))
end

function modifier_item_butterfly_2_cooldown_text:OnDestroy()
    if not IsServer() then return end
    
    -- Сбрасываем куллдаун предмета в инвентаре
    local parent = self:GetParent()
    if parent and not parent:IsNull() then
        local butterfly_modifier = parent:FindModifierByName("modifier_item_butterfly_2")
        if butterfly_modifier then
            local item = butterfly_modifier:GetAbility()
            if item and not item:IsNull() then
                item:EndCooldown()
            end
        end
    end
    
    self:StartIntervalThink(-1)
end

-- Старый код удален