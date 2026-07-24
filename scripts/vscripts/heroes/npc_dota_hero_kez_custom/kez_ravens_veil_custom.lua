--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_ravens_veil_custom", "heroes/npc_dota_hero_kez_custom/kez_ravens_veil_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_ravens_veil_custom_debuff", "heroes/npc_dota_hero_kez_custom/kez_ravens_veil_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_ring_lua", "modifiers/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_falcon_rush_custom_magic_immune", "heroes/npc_dota_hero_kez_custom/kez_ravens_veil_custom", LUA_MODIFIER_MOTION_NONE)

kez_ravens_veil_custom = class({})
kez_ravens_veil_custom.modifier_kez_20 = {-1,-2,-3}
kez_ravens_veil_custom.modifier_kez_20_damage = {-4,-8,-12}
kez_ravens_veil_custom.modifier_kez_13 = {0.8,1.6,2.4}

function kez_ravens_veil_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_kez_20") then
        bonus = self.modifier_kez_20[self:GetCaster():GetTalentLevel("modifier_kez_20")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function kez_ravens_veil_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_sai_ultimate_wave.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_sai_ultimate_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_vulnerable_marker.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/status_effect_kez_sai_ultimate_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_sai_ultimate_impact.vpcf", context )
end

function kez_ravens_veil_custom:OnSpellStart()
    if not IsServer() then return end
    local blast_radius = self:GetSpecialValueFor("blast_radius")
    local blast_speed = self:GetSpecialValueFor("blast_speed")
    local blind_duration = self:GetSpecialValueFor("blind_duration")
    local buff_duration = self:GetSpecialValueFor("buff_duration")
    self:GetCaster():Purge(false, true, false, false, false)

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_sai_ultimate_wave.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(blast_radius, 0, blast_speed))
    ParticleManager:ReleaseParticleIndex(particle)

    if self:GetCaster():HasModifier("modifier_kez_13") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_falcon_rush_custom_magic_immune", {duration = self.modifier_kez_13[self:GetCaster():GetTalentLevel("modifier_kez_13")]})
    end

    if self:GetCaster():HasModifier("modifier_kez_8") then
        local kez_switch_weapons_custom = self:GetCaster():FindAbilityByName("kez_switch_weapons_custom")
        if kez_switch_weapons_custom then
            self:GetCaster():AddNewModifier(self:GetCaster(), kez_switch_weapons_custom, "modifier_kez_switch_weapons_custom_bonus_movespeed", {duration = kez_switch_weapons_custom:GetSpecialValueFor("sai_swap_duration")})
        end
    end

    local pulse = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_generic_ring_lua", {end_radius = blast_radius, speed = blast_speed, target_team = DOTA_UNIT_TARGET_TEAM_ENEMY, target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC})
    if pulse then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), 775, 3, false)
        pulse:SetCallback( function( enemy )
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_kez_ravens_veil_custom_debuff", {duration = blind_duration * (1-enemy:GetStatusResistance())})
            local kez_shodo_sai_custom = self:GetCaster():FindAbilityByName("kez_shodo_sai_custom")
            if kez_shodo_sai_custom and kez_shodo_sai_custom:GetLevel() > 0 then
                kez_shodo_sai_custom:AddTargetMark(enemy, true, true)
            end
        end)
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_ravens_veil_custom", {duration = buff_duration})
    self:GetCaster():EmitSound("Hero_Kez.RavensVeil.Sai.Cast")
    ---------------------------------------------------------------------------------------------
    if self:GetCaster():HasModifier("modifier_kez_21") then return end
    local kez_raptor_dance_custom = self:GetCaster():FindAbilityByName("kez_raptor_dance_custom")
    if kez_raptor_dance_custom then
        kez_raptor_dance_custom:UseResources(false, false, false, true)
    end
end

modifier_kez_ravens_veil_custom = class({})
function modifier_kez_ravens_veil_custom:IsPurgable() return false end

function modifier_kez_ravens_veil_custom:OnCreated()
    self.bonus_ms = self:GetAbility():GetSpecialValueFor("bonus_ms")
end

function modifier_kez_ravens_veil_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_kez_ravens_veil_custom:GetModifierIncomingDamage_Percentage()
    if self:GetCaster():HasModifier("modifier_kez_20") then
        return self:GetAbility().modifier_kez_20_damage[self:GetCaster():GetTalentLevel("modifier_kez_20")]
    end
end

function modifier_kez_ravens_veil_custom:GetModifierInvisibilityLevel()
    return 1
end

function modifier_kez_ravens_veil_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.bonus_ms
end

function modifier_kez_ravens_veil_custom:OnAttack(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    self:Destroy()
end

function modifier_kez_ravens_veil_custom:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.ability == nil then return end
    if params.ability == self:GetAbility() then return end
    if params.ability:GetAbilityName() == "kez_switch_weapons_custom" then return end
    self:Destroy()
end

modifier_kez_ravens_veil_custom_debuff = class({})
function modifier_kez_ravens_veil_custom_debuff:IsPurgeException() return true end

function modifier_kez_ravens_veil_custom_debuff:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_sai_ultimate_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_kez_ravens_veil_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_kez/kez_sai_ultimate_debuff.vpcf"
end

function modifier_kez_ravens_veil_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_kez_ravens_veil_custom_debuff:GetStatusEffectName()
    return "particles/units/heroes/hero_kez/status_effect_kez_sai_ultimate_debuff.vpcf"
end

function modifier_kez_ravens_veil_custom_debuff:StatusEffectPriority()
    return 10
end

function modifier_kez_ravens_veil_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_FIXED_DAY_VISION,
        MODIFIER_PROPERTY_FIXED_NIGHT_VISION
    }
end

function modifier_kez_ravens_veil_custom_debuff:GetFixedDayVision()
    if self:GetParent():IsDebuffImmune() then return end
    return 50
end

function modifier_kez_ravens_veil_custom_debuff:GetFixedNightVision()
    if self:GetParent():IsDebuffImmune() then return end
    return 50
end


modifier_kez_falcon_rush_custom_magic_immune = class({})
function modifier_kez_falcon_rush_custom_magic_immune:IsPurgable() return false end
function modifier_kez_falcon_rush_custom_magic_immune:GetTexture() return "kez_13" end

function modifier_kez_falcon_rush_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_kez_falcon_rush_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_kez_falcon_rush_custom_magic_immune:CheckState()
    return 
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_kez_falcon_rush_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_kez_falcon_rush_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_kez_falcon_rush_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_kez_falcon_rush_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_kez_falcon_rush_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end