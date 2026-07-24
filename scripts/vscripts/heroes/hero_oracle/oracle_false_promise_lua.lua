--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


﻿oracle_false_promise_lua = class({}) ---@class oracle_false_promise_lua : CDOTA_Ability_Lua

local MAX_INT = 2147483647

LinkLuaModifier("modifier_oracle_false_promise_lua", "heroes/hero_oracle/oracle_false_promise_lua",
    LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_oracle_false_promise_invis_lua", "heroes/hero_oracle/oracle_false_promise_lua",
    LUA_MODIFIER_MOTION_NONE)

function oracle_false_promise_lua:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    if not target then return end

    local duration = self:GetSpecialValueFor("duration")

    target:Purge(false, true, false, true, true)

    target:AddNewModifier(caster, self, "modifier_oracle_false_promise_lua", { duration = duration })

    local p = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_oracle/oracle_false_promise_cast.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        target
    )
    ParticleManager:ReleaseParticleIndex(p)
    target:EmitSound("Hero_Oracle.FalsePromise.Cast")
end

---------------------------------------------------------------------------------------------------

modifier_oracle_false_promise_lua = class({}) ---@class modifier_oracle_false_promise_lua : CDOTA_Modifier_Lua

function modifier_oracle_false_promise_lua:IsHidden() return false end

function modifier_oracle_false_promise_lua:IsDebuff() return false end

function modifier_oracle_false_promise_lua:IsPurgable() return false end

function modifier_oracle_false_promise_lua:DestroyOnExpire() return false end

function modifier_oracle_false_promise_lua:GetEffectName()
    return "particles/units/heroes/hero_oracle/oracle_false_promise.vpcf"
end

function modifier_oracle_false_promise_lua:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_oracle_false_promise_lua:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_EVENT_ON_HEAL_RECEIVED,
        MODIFIER_PROPERTY_DISABLE_HEALING,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT
    }
end

function modifier_oracle_false_promise_lua:GetModifierBaseAttackTimeConstant()
    return self.bat
end

function modifier_oracle_false_promise_lua:GetDisableHealing()
    return 1
end

function modifier_oracle_false_promise_lua:GetModifierPhysicalArmorBonus()
    return self.bonusArmor or 0
end

function modifier_oracle_false_promise_lua:GetModifierSpellAmplify_Percentage()
    return self.spellAmp or 0
end

function modifier_oracle_false_promise_lua:GetPriority()
    return MODIFIER_PRIORITY_NORMAL
end

function modifier_oracle_false_promise_lua:OnCreated()
    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = self:GetAbility()


    if not ability then return end
    self.spellAmp = ability:GetSpecialValueFor("spell_amp_pct") or 0
    self.hpOnCreated = parent:GetHealth()
    self.rawDamage = 0
    self.rawHeal = 0
    self.bonusArmor = ability:GetSpecialValueFor("bonus_armor") or 0
    self.healMultiplier = (1.0 + (ability:GetSpecialValueFor("heal_amp_pct") / 100)) or 2.0
    self.invisDelay = ability:GetSpecialValueFor("invisible_delay")
    self.isInvisibleActive = (ability:GetSpecialValueFor("invisible") == 1) and true or false
    self:SetHasCustomTransmitterData(true)

    local batReduce = ability:GetSpecialValueFor("bat_bonus") or 0

    local batBase = parent:GetBaseAttackTime(false)
    local modifierDarkMoonShard = parent:FindModifierByName("modifier_item_dark_moon_shard")

    if modifierDarkMoonShard and modifierDarkMoonShard.AttackRate then
        batBase = modifierDarkMoonShard.AttackRate or batBase
    end

    self.bat = math.max(0.01, batBase - batReduce)

    -- logger:Log(string.format("GetBaseAttackTime = %f, calculatedBat = %f", batBase, self.bat))

    self.particleIndicator = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_oracle/oracle_false_promise_indicator.vpcf",
        PATTACH_OVERHEAD_FOLLOW,
        parent
    )

    if self.isInvisibleActive then
        parent:AddNewModifier(ability:GetCaster(), ability, "modifier_oracle_false_promise_invis_lua", {})
    end

    self:AddParticle(self.particleIndicator, false, false, -1, true, true)
    self:StartIntervalThink(0.25)
    EmitSoundOn("Hero_Oracle.FalsePromise.FP", parent)
end

function modifier_oracle_false_promise_lua:HandleCustomTransmitterData(data)
    self.spellAmp = data.spellAmp
    self.hpOnCreated = data.hpOnCreated
    self.rawDamage = data.rawDamage
    self.rawHeal = data.rawHeal
    self.bonusArmor = data.bonusArmor
    self.healMultiplier = data.healMultiplier
    self.invisDelay = data.invisDelay
    self.isInvisibleActive = data.isInvisibleActive
    self.bat = data.bat
end

function modifier_oracle_false_promise_lua:AddCustomTransmitterData()
    return {
        spellAmp = self.spellAmp,
        hpOnCreated = self.hpOnCreated,
        rawDamage = self.rawDamage,
        rawHeal = self.rawHeal,
        bonusArmor = self.bonusArmor,
        healMultiplier = self.healMultiplier,
        invisDelay = self.invisDelay,
        isInvisibleActive = self.isInvisibleActive,
        bat = self.bat
    }
end

function modifier_oracle_false_promise_lua:OnIntervalThink()
    local parent = self:GetParent()
    if not parent or parent:IsNull() then return end

    if IsServer() and self:GetRemainingTime() <= 0 then
        if parent:HasModifier("modifier_hero_refreshing") then
            self.skipFinalResolution = true
            self:Destroy()
            return
        end

        if parent:IsInvulnerable() or parent:IsOutOfGame() then
            return
        end

        self:Destroy()
        return
    end

    local predictedHp = self.hpOnCreated - (self.rawDamage or 0) + ((self.rawHeal or 0) * (self.healMultiplier or 0))
    local danger = 0

    if predictedHp <= 0 then
        danger = math.min(math.abs(predictedHp) + 1, 500)
    end

    ParticleManager:SetParticleControl(
        self.particleIndicator,
        1,
        Vector(danger, 0, 0)
    )
end

function modifier_oracle_false_promise_lua:OnRefresh()
    local ability = self:GetAbility()

    if not ability then return end
    self.bonusArmor = ability:GetSpecialValueFor("bonus_armor")
    self.batReduce = ability:GetSpecialValueFor("bat_bonus")
    self.healMultiplier = (1.0 + (ability:GetSpecialValueFor("heal_amp_pct") / 100)) or self.healMultiplier
    self.hpOnCreated = self:GetParent():GetHealth()
    self.rawDamage = 0
    self.rawHeal = 0
end

---@param event ModifierAttackEvent
---@return integer
function modifier_oracle_false_promise_lua:GetModifierTotal_ConstantBlock(event)
    if not IsServer() then return 0 end

    if event.damage <= 0 then return 0 end

    self.rawDamage = (self.rawDamage or 0) + event.damage
    self.lastHitDamageAttacker = event.attacker
    -- logger:Logf("GetModifierTotal_ConstantBlock Receive dmg. Src = %s. Value = %s", event.inflictor and event.inflictor:GetAbilityName() or "Unknown", tostring(event.damage))
    local parent = self:GetParent()

    local attacked_particle = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_oracle/oracle_false_promise_attacked.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        parent
    )
    ParticleManager:ReleaseParticleIndex(attacked_particle)

    local particle_hit = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_oracle/oracle_false_promise_hit.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        parent
    )
    self:AddParticle(particle_hit, false, false, -1, true, true)

    return event.damage
end

---@param event ModifierHealEvent
function modifier_oracle_false_promise_lua:OnHealReceived(event)
    if not IsServer() then return end
    if event.unit ~= self:GetParent() then return end

    local gain = event.gain or 0
    if gain <= 0 then return end

    self.rawHeal = (self.rawHeal or 0) + gain
end

function modifier_oracle_false_promise_lua:GetFinalNetHpDiff()
    local amplifiedHeal = (self.rawHeal or 0) * (self.healMultiplier or 0)
    return amplifiedHeal - (self.rawDamage or 0)
end

function modifier_oracle_false_promise_lua:OnDestroy()
    if not IsServer() then return end

    local parent = self:GetParent()
    if not parent or parent:IsNull() then return end
    if self.skipFinalResolution then
        parent:RemoveModifierByName("modifier_oracle_false_promise_invis_lua")
        return
    end

    local finalNetDiff = self:GetFinalNetHpDiff()

    if finalNetDiff > 0 then
        self:ApplyHeal(parent)
    else
        self:ApplyDamage(parent)
    end

    parent:RemoveModifierByName("modifier_oracle_false_promise_invis_lua")
end

---@param parent CDOTA_BaseNPC
function modifier_oracle_false_promise_lua:ApplyHeal(parent)
    local healAmount = self:GetFinalNetHpDiff()
    if healAmount <= 0 then return end

    local maxHealth = parent:GetMaxHealth()
    local currentHealth = parent:GetHealth()
    local finalHealth = math.min(maxHealth, currentHealth + healAmount)

    if healAmount >= MAX_INT then
        finalHealth = maxHealth
    end

    parent:SetHealth(finalHealth)

    local p = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        parent
    )
    ParticleManager:ReleaseParticleIndex(p)
    parent:EmitSound("Hero_Oracle.FalsePromise.Healed")
end

---@param parent CDOTA_BaseNPC
function modifier_oracle_false_promise_lua:ApplyDamage(parent)
    local ability = self:GetAbility()
    if not ability then return end

    local caster = ability:GetCaster()
    local damage = math.max(0, -self:GetFinalNetHpDiff())
    if damage <= 0 then return end

    ApplyDamage({
        victim = parent,
        attacker = self.lastHitDamageAttacker or caster or parent,
        damage = math.min(damage, parent:GetMaxHealth() * 2),
        damage_type = DAMAGE_TYPE_PURE,
        ability = nil,
        damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_HPLOSS,
    })

    local p = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_oracle/oracle_false_promise_dmg.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        parent
    )
    ParticleManager:ReleaseParticleIndex(p)
    parent:EmitSound("Hero_Oracle.FalsePromise.Damaged")
end

-----------------------------------------------------------------------------------------

modifier_oracle_false_promise_invis_lua = class({}) ---@class modifier_oracle_false_promise_invis_lua : CDOTA_Modifier_Lua

function modifier_oracle_false_promise_invis_lua:IsHidden() return false end

function modifier_oracle_false_promise_invis_lua:IsDebuff() return false end

function modifier_oracle_false_promise_invis_lua:IsPurgable() return false end

function modifier_oracle_false_promise_invis_lua:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL
    }
end

function modifier_oracle_false_promise_invis_lua:CheckState()
    return {
        [MODIFIER_STATE_INVISIBLE] = self.invisible == true,
    }
end

function modifier_oracle_false_promise_invis_lua:GetModifierInvisibilityLevel()
    return self.invisible and 1 or 0
end

function modifier_oracle_false_promise_invis_lua:OnCreated()
    self.invisible = true
    self.nextInvisTime = nil

    if not IsServer() then return end
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.05)
end

function modifier_oracle_false_promise_invis_lua:AddCustomTransmitterData()
    return {
        invisible = self.invisible and 1 or 0
    }
end

function modifier_oracle_false_promise_invis_lua:HandleCustomTransmitterData(data)
    self.invisible = data.invisible == 1
end

---@param state boolean
function modifier_oracle_false_promise_invis_lua:SetInvisibleState(state)
    self.invisible = state
    self:SendBuffRefreshToClients()
end

function modifier_oracle_false_promise_invis_lua:OnIntervalThink()
    if not IsServer() then return end

    if not self.invisible and self.nextInvisTime and GameRules:GetGameTime() >= self.nextInvisTime then
        self:SetInvisibleState(true)
        self.nextInvisTime = nil
    end
end

function modifier_oracle_false_promise_invis_lua:BreakInvis()
    if not IsServer() then return end
    if not self.invisible then return end

    self:SetInvisibleState(false)
    self.nextInvisTime = GameRules:GetGameTime() + 0.15
end

function modifier_oracle_false_promise_invis_lua:OnAttack(event)
    if event.attacker ~= self:GetParent() then return end
    self:BreakInvis()
end

function modifier_oracle_false_promise_invis_lua:OnAbilityExecuted(event)
    if event.unit ~= self:GetParent() then return end
    self:BreakInvis()
end