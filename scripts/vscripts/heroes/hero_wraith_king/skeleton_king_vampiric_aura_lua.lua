--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_vampiric_aura_lua", "heroes/hero_wraith_king/skeleton_king_vampiric_aura_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_vampiric_aura_lua_effect", "heroes/hero_wraith_king/skeleton_king_vampiric_aura_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_vampiric_aura_lua_summoned", "heroes/hero_wraith_king/skeleton_king_vampiric_aura_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_vampiric_aura_lua_reincarnate", "heroes/hero_wraith_king/skeleton_king_vampiric_aura_lua.lua", LUA_MODIFIER_MOTION_NONE)

--Abilities
if skeleton_king_vampiric_aura_lua == nil then
    skeleton_king_vampiric_aura_lua = class({})
end
function skeleton_king_vampiric_aura_lua:OnSpellStart()
    local hCaster = self:GetCaster()
    local skeleton_duration = self:GetSpecialValueFor("skeleton_duration")
    local skeleton_damage = self:GetSpecialValueFor("skeleton_damage")
    local skeleton_health = self:GetSpecialValueFor("skeleton_health")
    local fighter_crit = self:GetSpecialValueFor("fighter_crit")
    local crit_bonus_level = self:GetSpecialValueFor("crit_bonus_level")
    local cleave = 0
    local reincarnate = self:GetSpecialValueFor("reincarnate")
    local max_fighter_count = self:GetSpecialValueFor("max_fighter_count")

    if hCaster:FindAbilityByName("special_bonus_cleave_35") ~= nil then
        cleave = hCaster:FindAbilityByName("special_bonus_cleave_35"):GetLevel()
    end

    if self.fighters == nil then
        self.fighters = {}
    end

    if skeleton_duration > 0 then
        CreateUnitByNameAsync("npc_dota_wraith_king_skeleton_fighter", hCaster:GetAbsOrigin() + RandomVector(150), true, hCaster, hCaster, hCaster:GetTeamNumber(), function(unit)
            unit:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), false)
            unit:AddNewModifier(hCaster, self, "modifier_skeleton_king_vampiric_aura_lua_summoned", { duration = skeleton_duration })
            unit:SetBaseDamageMin(skeleton_damage)
            unit:SetBaseDamageMax(skeleton_damage)
            unit:SetBaseMaxHealth(skeleton_health)
            unit:SetMaxHealth(skeleton_health)
            unit:SetHealth(skeleton_health)

            if fighter_crit > 0 then
                unit:FindAbilityByName("skeleton_fighter_mortal_strike"):SetLevel(1 + crit_bonus_level)
            else
                unit:FindAbilityByName("skeleton_fighter_mortal_strike"):SetLevel(0)
            end
            if cleave > 0 then
                unit:FindAbilityByName("skeleton_fighter_plunder_blood").cleave = true
            end
            if reincarnate > 0 then
                unit:AddNewModifier(hCaster, self, "modifier_skeleton_king_vampiric_aura_lua_reincarnate", {})
            end

            table.insert(self.fighters, unit)
            --清除多余的骷髅
            local fighter_count = 0
            for i = #self.fighters, 1, -1 do

                if (not IsValid(self.fighters[i])) or (not self.fighters[i]:IsAlive()) then
                    table.remove(self.fighters, i)
                else
                    fighter_count = fighter_count + 1
                    if fighter_count > max_fighter_count then
                        self.fighters[i]:RemoveModifierByName("modifier_skeleton_king_vampiric_aura_lua_reincarnate")
                        self.fighters[i]:Kill(self, hCaster)
                        table.remove(self.fighters, i)
                    end
                end
            end
        end)
    end

end
function skeleton_king_vampiric_aura_lua:GetIntrinsicModifierName()
    return "modifier_skeleton_king_vampiric_aura_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_skeleton_king_vampiric_aura_lua == nil then
    modifier_skeleton_king_vampiric_aura_lua = class({})
end
function modifier_skeleton_king_vampiric_aura_lua:IsHidden()
    return true
end
function modifier_skeleton_king_vampiric_aura_lua:IsDebuff()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua:IsPurgable()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua:IsPurgeException()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua:IsAura()
    return true
end
function modifier_skeleton_king_vampiric_aura_lua:GetAuraRadius()
    return self.radius
end
function modifier_skeleton_king_vampiric_aura_lua:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_skeleton_king_vampiric_aura_lua:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_skeleton_king_vampiric_aura_lua:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_skeleton_king_vampiric_aura_lua:GetModifierAura()
    return "modifier_skeleton_king_vampiric_aura_lua_effect"
end
function modifier_skeleton_king_vampiric_aura_lua:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua:OnRefresh(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua:OnDestroy()
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua:DeclareFunctions()
    return {
    }
end
---------------------------------------------------------------------
--Modifiers
if modifier_skeleton_king_vampiric_aura_lua_effect == nil then
    modifier_skeleton_king_vampiric_aura_lua_effect = class({})
end
function modifier_skeleton_king_vampiric_aura_lua_effect:IsHidden()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_effect:IsDebuff()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_effect:IsPurgable()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_effect:IsPurgeException()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_effect:OnCreated(params)
    self.vampiric_aura = self:GetAbility():GetSpecialValueFor("vampiric_aura")
    self.max_hp_steal = self:GetAbility():GetSpecialValueFor("max_hp_steal")
    self.max_hp_steal_duration = self:GetAbility():GetSpecialValueFor("max_hp_steal_duration")
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua_effect:OnRefresh(params)
    self.vampiric_aura = self:GetAbility():GetSpecialValueFor("vampiric_aura")
    self.max_hp_steal = self:GetAbility():GetSpecialValueFor("max_hp_steal")
    self.max_hp_steal_duration = self:GetAbility():GetSpecialValueFor("max_hp_steal_duration")
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua_effect:OnDestroy()
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua_effect:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DAMAGE_CALCULATED
    }
end
function modifier_skeleton_king_vampiric_aura_lua_effect:OnDamageCalculated(params)
    local hParent = self:GetParent()
    if hParent == params.attacker then
        if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
            local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
            ParticleManager:SetParticleControlEnt(iParticleID, 1, params.target, PATTACH_ABSORIGIN_FOLLOW, nil, params.target:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(iParticleID)

            hParent:HealWithParams(params.damage * self.vampiric_aura * 0.01, self:GetAbility(), true, true, hParent, false)
        end
    end
end
---------------------------------------------------------------------
--Modifiers
if modifier_skeleton_king_vampiric_aura_lua_summoned == nil then
    modifier_skeleton_king_vampiric_aura_lua_summoned = class({})
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:IsHidden()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:IsDebuff()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:IsPurgable()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:IsPurgeException()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:OnCreated(params)
    self.hero_bonus_damage = self:GetAbility():GetSpecialValueFor("hero_bonus_damage")
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:OnRefresh(params)
    self.hero_bonus_damage = self:GetAbility():GetSpecialValueFor("hero_bonus_damage")
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:OnDestroy()
    local hParent = self:GetParent()
    local hCaster = self:GetCaster()
    if IsServer() then
        hParent:RemoveModifierByName("modifier_skeleton_king_vampiric_aura_lua_reincarnate")
        hParent:Kill(self:GetAbility(), hCaster)
    end
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_LIFETIME_FRACTION,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }

    return funcs
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:GetUnitLifetimeFraction(params)
    return ((self:GetDieTime() - GameRules:GetGameTime()) / self:GetDuration())
end
function modifier_skeleton_king_vampiric_aura_lua_summoned:GetModifierTotalDamageOutgoing_Percentage(params)
    if IsServer() then
        local hParent = self:GetParent()
        local hTarget = params.target
        if IsValid(hTarget) and hTarget:IsRealHero() then
            return self.hero_bonus_damage
        end
    end
end
---------------------------------------------------------------------
--Modifiers
if modifier_skeleton_king_vampiric_aura_lua_reincarnate == nil then
    modifier_skeleton_king_vampiric_aura_lua_reincarnate = class({})
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:IsHidden()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:IsDebuff()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:IsPurgable()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:IsPurgeException()
    return false
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:OnCreated(params)
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:OnRefresh(params)
    if IsServer() then
    end
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:OnDestroy()
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:OnTakeDamage(params)
    local hParent = self:GetParent()
    if params.unit == hParent and params.damage > hParent:GetHealth() then
        hParent:SetHealth(hParent:GetMaxHealth())
        self:Destroy()
    end
end
function modifier_skeleton_king_vampiric_aura_lua_reincarnate:GetTexture()
    return "skeleton_king_reincarnation"
end