--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_unity_with_nature", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_unity_with_nature", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lone_druid_unity_with_nature_bear", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_unity_with_nature", LUA_MODIFIER_MOTION_NONE)

lone_druid_unity_with_nature = class({})

function lone_druid_unity_with_nature:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context )
    PrecacheResource( "particle", "particles/items3_fx/blink_swift_start.vpcf", context )
    PrecacheResource( "particle", "particles/items3_fx/blink_swift_end.vpcf", context )
    PrecacheResource( "particle", "particles/lone_druid_infest.vpcf", context )
end

function lone_druid_unity_with_nature:OnAbilityPhaseStart()
    local target = self:GetCursorTarget()
    if target and target:GetUnitName() == "npc_dota_lone_druid_bear_custom" then
        return true
    end
    return false
end

function lone_druid_unity_with_nature:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_unity_with_nature", {bear = target:entindex()})
end

modifier_lone_druid_unity_with_nature = class({})

function modifier_lone_druid_unity_with_nature:IsPurgable() return false end

function modifier_lone_druid_unity_with_nature:OnCreated(kv)
    if not IsServer() then return end

    self:GetParent():EmitSound("Hero_LifeStealer.Infest")

    local particle = ParticleManager:CreateParticle("particles/items3_fx/blink_swift_start.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())

    self.bear = EntIndexToHScript(kv.bear)
    self:GetParent():AddNoDraw()
    self:OnIntervalThink()
    self:StartIntervalThink(FrameTime())
    self:GetParent():SwapAbilities("lone_druid_unity_with_nature", "lone_druid_unity_with_nature_exit", false, true)
    local lone_druid_spirit_bear_custom = self:GetCaster():FindAbilityByName("lone_druid_spirit_bear_custom")
    if lone_druid_spirit_bear_custom then
        lone_druid_spirit_bear_custom:SetActivated(false)
    end
    self.bear:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lone_druid_unity_with_nature_bear", {})
    local particle = ParticleManager:CreateParticle("particles/items3_fx/blink_swift_end.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
end

function modifier_lone_druid_unity_with_nature:OnDestroy()
    if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    self:GetParent():RemoveNoDraw()
    self:GetParent():SwapAbilities("lone_druid_unity_with_nature_exit", "lone_druid_unity_with_nature", false, true)
    local lone_druid_spirit_bear_custom = self:GetCaster():FindAbilityByName("lone_druid_spirit_bear_custom")
    if lone_druid_spirit_bear_custom then
        lone_druid_spirit_bear_custom:SetActivated(true)
    end
    self.bear:RemoveModifierByName("modifier_lone_druid_unity_with_nature_bear")
    local particle = ParticleManager:CreateParticle("particles/items3_fx/blink_swift_end.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
end

function modifier_lone_druid_unity_with_nature:OnIntervalThink()
    if not IsServer() then return end
    if not self.bear:IsAlive() then
        if not self:IsNull() then
            self:Destroy()
        end
    end
    self:GetParent():SetAbsOrigin(self.bear:GetAbsOrigin())
end

function modifier_lone_druid_unity_with_nature:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE]       = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
        [MODIFIER_STATE_NO_HEALTH_BAR]  = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }
end

lone_druid_unity_with_nature_exit = class({})

function lone_druid_unity_with_nature_exit:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_lone_druid_unity_with_nature") then
        local modifier = self:GetCaster():FindModifierByName("modifier_lone_druid_unity_with_nature")
        if modifier and not modifier:IsNull() then
            modifier:Destroy()
        end
    end
end

lone_druid_unity_with_nature_bear_exit = class({})

function lone_druid_unity_with_nature_bear_exit:OnSpellStart()
    if not IsServer() then return end

    local modifier = self:GetCaster():FindModifierByName("modifier_lone_druid_unity_with_nature_bear")

    if modifier and modifier:GetCaster() then
        local modifier2 = modifier:GetCaster():FindModifierByName("modifier_lone_druid_unity_with_nature")
        if modifier2 and not modifier2:IsNull() then
            modifier2:Destroy()
        end
    end
end

modifier_lone_druid_unity_with_nature_bear = class({})

function modifier_lone_druid_unity_with_nature_bear:OnCreated()
    if not IsServer() then return end
    self.health = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("bonus_health")
    self.damage = self:GetCaster():GetAttackDamage() / 100 * self:GetAbility():GetSpecialValueFor("bonus_damage")
    self:StartIntervalThink(0.25)
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
    self.ability = self:GetParent():AddAbility("lone_druid_unity_with_nature_bear_exit")
    if self.ability then
        self.ability:SetLevel(1)
    end
end

function modifier_lone_druid_unity_with_nature_bear:OnDestroy()
    if not IsServer() then return end
    if self.ability and not self.ability:IsNull() then
        self.ability:Destroy()
    end
end

function modifier_lone_druid_unity_with_nature_bear:OnIntervalThink()
    if not IsServer() then return end
    self.health = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("bonus_health")
    self.damage = self:GetCaster():GetAttackDamage() / 100 * self:GetAbility():GetSpecialValueFor("bonus_damage")

    if self:GetParent():GetHealthPercent() > 0 then
        self:GetCaster():SetHealth( self:GetCaster():GetMaxHealth() / 100 * self:GetParent():GetHealthPercent() )
    else
        self:GetCaster():SetHealth(1)
    end

    self:SendBuffRefreshToClients()
end

function modifier_lone_druid_unity_with_nature_bear:GetEffectName()
    return "particles/lone_druid_infest.vpcf"
end

function modifier_lone_druid_unity_with_nature_bear:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

--function modifier_lone_druid_unity_with_nature_bear:AddCustomTransmitterData()
--    return {
--        health = self.health,
--        damage = self.damage,
--    }
--end
--
--function modifier_lone_druid_unity_with_nature_bear:HandleCustomTransmitterData( data )
--    self.health = data.health
--    self.damage = data.damage
--end
--
--function modifier_lone_druid_unity_with_nature_bear:DeclareFunctions()
--    return {
--        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
--        MODIFIER_PROPERTY_HEALTH_BONUS,
--    }
--end
--
--function modifier_lone_druid_unity_with_nature_bear:GetModifierPreAttack_BonusDamage()
--    return self.damage
--end
--
--function modifier_lone_druid_unity_with_nature_bear:GetModifierHealthBonus()
--    return self.health
--end