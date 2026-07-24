--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_silent_as_the_grave_custom", "heroes/npc_dota_hero_visage_custom/visage_silent_as_the_grave_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_silent_as_the_grave_custom_damage", "heroes/npc_dota_hero_visage_custom/visage_silent_as_the_grave_custom", LUA_MODIFIER_MOTION_NONE)

visage_silent_as_the_grave_custom = class({})

visage_silent_as_the_grave_custom.modifier_visage_20_duration = {1,2}
visage_silent_as_the_grave_custom.modifier_visage_19_damage = {0,0}
visage_silent_as_the_grave_custom.modifier_visage_20_regen = {20,40}

function visage_silent_as_the_grave_custom:GetBonusDuration()
    local bonus_duration = self:GetSpecialValueFor("bonus_duration")
    if self:GetCaster():HasModifier("modifier_visage_20") then
        bonus_duration = bonus_duration + self.modifier_visage_20_duration[self:GetCaster():GetTalentLevel("modifier_visage_20")]
    end
    return bonus_duration
end

function visage_silent_as_the_grave_custom:GetBonusDamage()
    local bonus_damage = self:GetSpecialValueFor("bonus_damage")
    if self:GetCaster():HasModifier("modifier_visage_19") then
        bonus_damage = bonus_damage + self.modifier_visage_19_damage[self:GetCaster():GetTalentLevel("modifier_visage_19")]
    end
    return bonus_damage
end

function visage_silent_as_the_grave_custom:OnSpellStart()
    if not IsServer() then return end
    local flight_duration = self:GetSpecialValueFor("flight_duration")
    self:GetCaster():EmitSound("Hero_Visage.SilentGrave")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_visage_silent_as_the_grave_custom", {duration = flight_duration})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_visage_silent_as_the_grave_custom_damage", {})
    local visage_summon_familiars_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_custom")
    if visage_summon_familiars_custom and visage_summon_familiars_custom.familiar_table and #visage_summon_familiars_custom.familiar_table > 0 then
        for _, familiar in pairs(visage_summon_familiars_custom.familiar_table) do
            if familiar and not familiar:IsNull() and familiar:IsAlive() and familiar:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
                familiar:AddNewModifier(self:GetCaster(), self, "modifier_visage_silent_as_the_grave_custom", {duration = flight_duration})
                familiar:AddNewModifier(self:GetCaster(), self, "modifier_visage_silent_as_the_grave_custom_damage", {})
            end
        end
    end
end

modifier_visage_silent_as_the_grave_custom = class({})

function modifier_visage_silent_as_the_grave_custom:OnCreated()
    self.movespeed_bonus = self:GetAbility():GetSpecialValueFor("movespeed_bonus")
end

function modifier_visage_silent_as_the_grave_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_EVENT_ON_ABILITY_EXECUTED
    }
end

function modifier_visage_silent_as_the_grave_custom:CheckState()
    return
    {
        [MODIFIER_STATE_FLYING] = true
    }
end

function modifier_visage_silent_as_the_grave_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.movespeed_bonus
end

function modifier_visage_silent_as_the_grave_custom:GetModifierConstantHealthRegen()
    if self:GetCaster() and self:GetCaster():HasModifier("modifier_visage_20") then
        return self:GetAbility().modifier_visage_20_regen[self:GetCaster():GetTalentLevel("modifier_visage_20")]
    end
    return 0
end

function modifier_visage_silent_as_the_grave_custom:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    self:Trigger()
end

function modifier_visage_silent_as_the_grave_custom:OnAbilityExecuted( params )
    if params.unit ~= self:GetParent() then return end
    self:Trigger()
end

function modifier_visage_silent_as_the_grave_custom:Trigger()
    if not IsServer() then return end
    if self.triggered then return end
    if self:GetCaster():HasModifier("modifier_visage_20") then
        self.triggered = true
        local bonus_duration = self:GetAbility():GetBonusDuration()
        self:SetDuration(bonus_duration, true)
        local modifier_visage_silent_as_the_grave_custom_damage = self:GetParent():FindModifierByName("modifier_visage_silent_as_the_grave_custom_damage")
        if modifier_visage_silent_as_the_grave_custom_damage then
            modifier_visage_silent_as_the_grave_custom_damage:SetDuration(bonus_duration, true)
        end
    else
        self:Destroy()
    end
end

function modifier_visage_silent_as_the_grave_custom:OnDestroy()
    if not IsServer() then return end
    if self.triggered then return end
    local bonus_duration = self:GetAbility():GetBonusDuration()
    local modifier_visage_silent_as_the_grave_custom_damage = self:GetParent():FindModifierByName("modifier_visage_silent_as_the_grave_custom_damage")
    if modifier_visage_silent_as_the_grave_custom_damage then
        modifier_visage_silent_as_the_grave_custom_damage:SetDuration(bonus_duration, true)
    end
end

modifier_visage_silent_as_the_grave_custom_damage = class({})

function modifier_visage_silent_as_the_grave_custom_damage:OnCreated()
    self.bonus_damage = self:GetAbility():GetBonusDamage()
end

function modifier_visage_silent_as_the_grave_custom_damage:OnRefresh()
    self.bonus_damage = self:GetAbility():GetBonusDamage()
end

function modifier_visage_silent_as_the_grave_custom_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_visage_silent_as_the_grave_custom_damage:GetModifierBaseDamageOutgoing_Percentage()
    return self.bonus_damage
end