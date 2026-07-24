--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_stone_form_self_cast_custom", "heroes/npc_dota_hero_visage_custom/visage_stone_form_self_cast_custom", LUA_MODIFIER_MOTION_NONE)

visage_stone_form_self_cast_custom = class({})
visage_stone_form_self_cast_custom.modifier_visage_5_cd = -5
visage_stone_form_self_cast_custom.modifier_visage_19_cast_range = 900

function visage_stone_form_self_cast_custom:GetIntrinsicModifierName()
    return "modifier_visage_stone_form_self_cast_custom"
end

function visage_stone_form_self_cast_custom:GetAOERadius()
    return self:GetSpecialValueFor("stun_radius")
end

function visage_stone_form_self_cast_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_visage_19") then
        return self.modifier_visage_19_cast_range
    end
end

function visage_stone_form_self_cast_custom:GetTalent19Cooldown()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_visage_5") then
        bonus = self.modifier_visage_5_cd
    end
    return 11 + bonus
end

function visage_stone_form_self_cast_custom:GetTalent19MaxCharges()
    local unit_count = 2
    local visage_summon_familiars_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_custom")
    if visage_summon_familiars_custom then
        unit_count = visage_summon_familiars_custom:GetSpecialValueFor("familiar_count")
    end
    if self:GetCaster():HasModifier("modifier_visage_5") then
        unit_count = math.max(unit_count - 1, 1)
    end
    return unit_count
end

function visage_stone_form_self_cast_custom:GetTalent19RechargeQueue(now, max_charges)
    local pruned = {}
    if self.t19_recharge_queue then
        for _, finish_time in ipairs(self.t19_recharge_queue) do
            if now < finish_time then
                pruned[#pruned + 1] = finish_time
            end
        end
    end
    table.sort(pruned)
    while #pruned > max_charges do
        table.remove(pruned)
    end
    return pruned
end

function visage_stone_form_self_cast_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_visage_19") then
        return 0
    end
end

function visage_stone_form_self_cast_custom:RefreshCustomCharges()
    if not self:GetCaster():HasModifier("modifier_visage_19") then return end
    self.t19_recharge_queue = {}
    self:EndCooldown()
end

function visage_stone_form_self_cast_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_visage_19") then
        return DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    local modifier_visage_stone_form_self_cast_custom = self:GetCaster():GetModifierStackCount("modifier_visage_stone_form_self_cast_custom", self:GetCaster())
    if modifier_visage_stone_form_self_cast_custom == 1 then
        return 
        DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + 
        DOTA_ABILITY_BEHAVIOR_POINT + 
        DOTA_ABILITY_BEHAVIOR_AOE + 
        DOTA_ABILITY_BEHAVIOR_IMMEDIATE + 
        DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + 
        DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE + 
        1099511627776 + 
        137438953472
    end
    return 
    DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + 
    DOTA_ABILITY_BEHAVIOR_NO_TARGET +
    DOTA_ABILITY_BEHAVIOR_IMMEDIATE + 
    DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + 
    DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE + 
    1099511627776 + 
    137438953472
end

function visage_stone_form_self_cast_custom:CreateFamiliarsTalent(point)
    local visage_summon_familiars_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_custom")
    if visage_summon_familiars_custom and visage_summon_familiars_custom:GetLevel() > 0 then
        local familiar = visage_summon_familiars_custom:SpawnFamiliar(1, 1, point)
        if familiar then
            local visage_summon_familiars_stone_form_custom_familiar = familiar:FindAbilityByName("visage_summon_familiars_stone_form_custom")
            if visage_summon_familiars_stone_form_custom_familiar then
                visage_summon_familiars_stone_form_custom_familiar:SetLevel(self:GetLevel())
                familiar:RemoveGesture(ACT_DOTA_SPAWN)
                visage_summon_familiars_stone_form_custom_familiar:OnSpellStart(true)
            end
        end
    end
end

function visage_stone_form_self_cast_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    if self:GetCaster():HasModifier("modifier_visage_19") then
        local max_charges = self:GetTalent19MaxCharges()
        local now = GameRules:GetGameTime()
        self.t19_recharge_queue = self:GetTalent19RechargeQueue(now, max_charges)
        if max_charges - #self.t19_recharge_queue <= 0 then
            return
        end
        local direction = (point - self:GetCaster():GetAbsOrigin())
        direction.z = 0
        local distance = direction:Length2D()
        direction = direction:Normalized()
        self:CreateFamiliarsTalent(point)
        EmitSoundOnLocationWithCaster(point, "Hero_Visage.SummonFamiliars.Cast", self:GetCaster())
        table.insert(self.t19_recharge_queue, now + self:GetTalent19Cooldown())
        return
    end
    if self:GetAltCastState() then
        local nearest_familiar = nil
        local visage_summon_familiars_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_custom")
        if visage_summon_familiars_custom then
            for _, familiar in pairs(visage_summon_familiars_custom.familiar_table) do
                if familiar and not familiar:IsNull() and familiar:IsAlive() and familiar:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
                    local visage_summon_familiars_stone_form_custom = familiar:FindAbilityByName("visage_summon_familiars_stone_form_custom")
                    if visage_summon_familiars_stone_form_custom and visage_summon_familiars_stone_form_custom:IsFullyCastable() and not familiar:HasModifier("modifier_visage_summon_familiars_stone_form_custom_root") and not familiar:HasModifier("modifier_visage_summon_familiars_stone_form_custom_buff") and not (self.flying and self.flying[familiar:entindex()]) and (not nearest_familiar or (familiar:GetAbsOrigin() - point):Length2D() < (nearest_familiar:GetAbsOrigin() - point):Length2D()) then
                        nearest_familiar = familiar
                    end
                end
            end
        end
        if nearest_familiar then
            self.flying = self.flying or {}
            local idx = nearest_familiar:entindex()
            self.flying[idx] = true
            ExecuteOrderFromTable({
                UnitIndex = idx,
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = point,
                Queue = false,
            })
            local tolerance = nearest_familiar:GetHullRadius() + 64
            local timeout = GameRules:GetGameTime() + 5
            local min_dist = (nearest_familiar:GetAbsOrigin() - point):Length2D()
            Timers:CreateTimer(0.1, function()
                if nearest_familiar:IsNull() or not nearest_familiar:IsAlive() or GameRules:GetGameTime() >= timeout then
                    self.flying[idx] = nil
                    return
                end
                local visage_summon_familiars_stone_form_custom = nearest_familiar:FindAbilityByName("visage_summon_familiars_stone_form_custom")
                if not visage_summon_familiars_stone_form_custom or not visage_summon_familiars_stone_form_custom:IsFullyCastable() or nearest_familiar:HasModifier("modifier_visage_summon_familiars_stone_form_custom_root") or nearest_familiar:HasModifier("modifier_visage_summon_familiars_stone_form_custom_buff") then
                    self.flying[idx] = nil
                    return
                end
                local dist = (nearest_familiar:GetAbsOrigin() - point):Length2D()
                if dist <= tolerance then
                    nearest_familiar:CastAbilityImmediately(visage_summon_familiars_stone_form_custom, -1)
                    self.flying[idx] = nil
                    return
                end
                if nearest_familiar:IsIdle() or dist > min_dist + 250 then
                    self.flying[idx] = nil
                    return
                end
                if dist < min_dist then min_dist = dist end
                return 0.1
            end)
        end
        return
    end
    local nearest_familiar = nil
    local visage_summon_familiars_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_custom")
    if visage_summon_familiars_custom then
        for _, familiar in pairs(visage_summon_familiars_custom.familiar_table) do
            if familiar and not familiar:IsNull() and familiar:IsAlive() and familiar:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
                local visage_summon_familiars_stone_form_custom = familiar:FindAbilityByName("visage_summon_familiars_stone_form_custom")
                if visage_summon_familiars_stone_form_custom and visage_summon_familiars_stone_form_custom:IsFullyCastable() and not familiar:HasModifier("modifier_visage_summon_familiars_stone_form_custom_root") and not familiar:HasModifier("modifier_visage_summon_familiars_stone_form_custom_buff") and (not nearest_familiar or (familiar:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D() < (nearest_familiar:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()) then
                    nearest_familiar = familiar
                end
            end
        end
    end
    if nearest_familiar then
        local visage_summon_familiars_stone_form_custom = nearest_familiar:FindAbilityByName("visage_summon_familiars_stone_form_custom")
        if visage_summon_familiars_stone_form_custom then
            self:GetCaster():CastAbilityImmediately(visage_summon_familiars_stone_form_custom, -1)
        end
    end
end

modifier_visage_stone_form_self_cast_custom = class({})
function modifier_visage_stone_form_self_cast_custom:IsHidden() return true end
function modifier_visage_stone_form_self_cast_custom:IsPurgable() return false end
function modifier_visage_stone_form_self_cast_custom:IsPurgeException() return false end
function modifier_visage_stone_form_self_cast_custom:RemoveOnDeath() return false end
function modifier_visage_stone_form_self_cast_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_visage_stone_form_self_cast_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_visage_19") then
        local ability = self:GetAbility()
        ability:SetActivated(true)
        local max_charges = ability:GetTalent19MaxCharges()
        local now = GameRules:GetGameTime()
        ability.t19_recharge_queue = ability:GetTalent19RechargeQueue(now, max_charges)
        local charges = max_charges - #ability.t19_recharge_queue
        if charges <= 0 then
            local remaining = (ability.t19_recharge_queue[1] or now) - now
            if remaining < 0 then remaining = 0 end
            if math.abs(ability:GetCooldownTimeRemaining() - remaining) > 0.2 then
                ability:EndCooldown()
                if remaining > 0 then
                    ability:StartCooldown(remaining)
                end
            end
        elseif ability:GetCooldownTimeRemaining() > 0 then
            ability:EndCooldown()
        end
        return
    end
    if self:GetStackCount() == 0 and self:GetAbility():GetAltCastState() then
        self:SetStackCount(1)
    elseif self:GetStackCount() == 1 and not self:GetAbility():GetAltCastState() then
        self:SetStackCount(0)
    end
    local has_familiar = false
    local min_wait = nil
    local visage_summon_familiars_custom = self:GetParent():FindAbilityByName("visage_summon_familiars_custom")
    if visage_summon_familiars_custom and visage_summon_familiars_custom.familiar_table then
        for _, familiar in pairs(visage_summon_familiars_custom.familiar_table) do
            if familiar and not familiar:IsNull() and familiar:IsAlive() and familiar:GetPlayerOwnerID() == self:GetParent():GetPlayerOwnerID() then
                has_familiar = true
                local stone_form = familiar:FindAbilityByName("visage_summon_familiars_stone_form_custom")
                if stone_form then
                    local wait = stone_form:GetCooldownTimeRemaining()
                    local buff = familiar:FindModifierByName("modifier_visage_summon_familiars_stone_form_custom_buff")
                    if buff then
                        wait = math.max(wait, buff:GetRemainingTime())
                    else
                        local root = familiar:FindModifierByName("modifier_visage_summon_familiars_stone_form_custom_root")
                        if root then
                            wait = math.max(wait, root:GetRemainingTime() + stone_form:GetSpecialValueFor("stone_duration"))
                        end
                    end
                    if not min_wait or wait < min_wait then
                        min_wait = wait
                    end
                end
            end
        end
    end
    if has_familiar ~= self.has_familiar then
        self.has_familiar = has_familiar
        self:GetAbility():SetActivated(has_familiar)
    end
    if has_familiar and min_wait and min_wait > 0 then
        if math.abs(self:GetAbility():GetCooldownTimeRemaining() - min_wait) > 0.2 then
            self:GetAbility():EndCooldown()
            self:GetAbility():StartCooldown(min_wait)
        end
    elseif self:GetAbility():GetCooldownTimeRemaining() > 0 then
        self:GetAbility():EndCooldown()
    end
end