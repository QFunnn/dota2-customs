--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_raptor_dance_custom", "heroes/npc_dota_hero_kez_custom/kez_raptor_dance_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_raptor_dance_custom_cast", "heroes/npc_dota_hero_kez_custom/kez_raptor_dance_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_raptor_dance_custom_buff", "heroes/npc_dota_hero_kez_custom/kez_raptor_dance_custom", LUA_MODIFIER_MOTION_NONE)

kez_raptor_dance_custom = class({})
kez_raptor_dance_custom.modifier_kez_20 = {-1,-2,-3}
kez_raptor_dance_custom.modifier_kez_6 = {0,1,2}

function kez_raptor_dance_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_kez_20") then
        bonus = self.modifier_kez_20[self:GetCaster():GetTalentLevel("modifier_kez_20")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function kez_raptor_dance_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/status_effect_kez_shield.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_hungering_blades_channel.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_hungering_blades.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/bird_samurai_blood_katana_slash_tgt.vpcf", context )
end

function kez_raptor_dance_custom:OnAbilityPhaseStart()
    if not IsServer() then return end
    self:GetCaster():StartGesture(ACT_DOTA_CHANNEL_ABILITY_4)
    self:GetCaster():EmitSound("Hero_Kez.RaptorDance.Katana.Cast")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_raptor_dance_custom", {})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_raptor_dance_custom_cast", {})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_invulnerable_hidden", {duration = self:GetSpecialValueFor("invuln_period")})
    return true
end

function kez_raptor_dance_custom:OnAbilityPhaseInterrupted()
    if not IsServer() then return end
    self:CastFinish(true)
end

function kez_raptor_dance_custom:OnSpellStart()
    self:CastFinish()
    self:GetCaster():FadeGesture(ACT_DOTA_CHANNEL_ABILITY_4)
    if self:GetCaster():HasModifier("modifier_kez_1") then
        local kez_switch_weapons_custom = self:GetCaster():FindAbilityByName("kez_switch_weapons_custom")
        if kez_switch_weapons_custom then
            self:GetCaster():AddNewModifier(self:GetCaster(), kez_switch_weapons_custom, "modifier_kez_switch_weapons_custom_bonus_damage", {})
        end
    end
    if self:GetCaster():HasModifier("modifier_kez_21") then return end
    local kez_ravens_veil_custom = self:GetCaster():FindAbilityByName("kez_ravens_veil_custom")
    if kez_ravens_veil_custom then
        kez_ravens_veil_custom:UseResources(false, false, false, true)
    end
end

function kez_raptor_dance_custom:CastFinish(bInterrupted)
    local modifier_kez_raptor_dance_custom = self:GetCaster():FindModifierByName("modifier_kez_raptor_dance_custom")
    if modifier_kez_raptor_dance_custom then
        if bInterrupted then
            self:GetCaster():RemoveGesture(ACT_DOTA_CHANNEL_ABILITY_4)
            modifier_kez_raptor_dance_custom.ignore_purge = true
            modifier_kez_raptor_dance_custom:Destroy()
        else
            local strike_interval = self:GetSpecialValueFor("strike_interval")
            local strikes = self:GetSpecialValueFor("strikes")
            if self:GetCaster():HasModifier("modifier_kez_6") then
                strikes = strikes + self.modifier_kez_6[self:GetCaster():GetTalentLevel("modifier_kez_6")]
            end
            local new_duration = strikes * strike_interval
            modifier_kez_raptor_dance_custom:SetDuration(new_duration, true)
        end
    end
    local modifier_kez_raptor_dance_custom_cast = self:GetCaster():FindModifierByName("modifier_kez_raptor_dance_custom_cast")
    if modifier_kez_raptor_dance_custom_cast then
        modifier_kez_raptor_dance_custom_cast:Destroy()
    end
    if not bInterrupted then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_raptor_dance_custom_buff", {})
    end
end

function kez_raptor_dance_custom:StrikeDamage(strikes)
    local animation_number = 0
    self:GetCaster():FadeGesture(ACT_DOTA_KEZ_KATANA_ULT_CHAIN_A)
    self:GetCaster():FadeGesture(ACT_DOTA_KEZ_KATANA_ULT_CHAIN_B)
    
    if strikes % 2 == 0 then
        animation_number = 1
        self:GetCaster():StartGesture(ACT_DOTA_KEZ_KATANA_ULT_CHAIN_A)
    else
        self:GetCaster():StartGesture(ACT_DOTA_KEZ_KATANA_ULT_CHAIN_B)
    end

    self:GetCaster():EmitSound("Hero_Kez.RaptorDance.Katana.Slash")
    local radius = self:GetSpecialValueFor("radius")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_hungering_blades.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, Vector(radius, animation_number, 1))
    ParticleManager:ReleaseParticleIndex(particle)
    local base_damage = self:GetSpecialValueFor("base_damage")
    local lifesteal_pct = self:GetSpecialValueFor("lifesteal_pct")
    local modifier_kez_kazurai_katana_custom = self:GetCaster():FindModifierByName("modifier_kez_kazurai_katana_custom")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
    for _, unit in pairs(units) do
        unit:EmitSound("Hero_Kez.RaptorDance.Katana.Target")
        local damage = base_damage + (unit:GetMaxHealth() / 100 * self:GetSpecialValueFor("max_health_damage_pct"))
        if modifier_kez_kazurai_katana_custom then
            modifier_kez_kazurai_katana_custom:ForceSetBuff(unit, damage)
        end
        local modifier_kez_shodo_sai_custom_mark = unit:FindModifierByName("modifier_kez_shodo_sai_custom_mark")
        if modifier_kez_shodo_sai_custom_mark then
            local critical_damage = modifier_kez_shodo_sai_custom_mark:GetModifierPreAttack_Target_CriticalStrike({attacker = self:GetCaster()})
            if critical_damage > 0 then
                damage = damage * (1 + ((critical_damage-100) / 100))
            end
        end
        local end_damage = ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self})
        if end_damage > 0 then
            self:GetCaster():Heal(end_damage / 100 * lifesteal_pct, self)
            local particle = ParticleManager:CreateParticle( "particles/items3_fx/octarine_core_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
            ParticleManager:ReleaseParticleIndex( particle )
        end
        local particle_target = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/bird_samurai_blood_katana_slash_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
        ParticleManager:SetParticleControlEnt(particle_target, 0, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle_target)
    end
    if #units > 0 then
        local modifier_kez_switch_weapons_custom_bonus_damage = self:GetCaster():FindModifierByName("modifier_kez_switch_weapons_custom_bonus_damage")
        if modifier_kez_switch_weapons_custom_bonus_damage then
            modifier_kez_switch_weapons_custom_bonus_damage:Destroy()
        end
    end
end

modifier_kez_raptor_dance_custom = class({})
function modifier_kez_raptor_dance_custom:IsPurgable() return false end
function modifier_kez_raptor_dance_custom:IsPurgeException() return false end
function modifier_kez_raptor_dance_custom:OnCreated()
    self.magic_resist = self:GetAbility():GetSpecialValueFor("magic_resist")
    if not IsServer() then return end
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_hungering_blades_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 2, Vector(radius,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_kez_raptor_dance_custom:GetStatusEffectName()
    return "particles/units/heroes/hero_kez/status_effect_kez_shield.vpcf"
end

function modifier_kez_raptor_dance_custom:StatusEffectPriority()
    return 10
end

function modifier_kez_raptor_dance_custom:OnDestroy()
    if not IsServer() then return end
    if self.ignore_purge then return end
    print("purge caster")
    self:GetParent():Purge(false, true, false, false, false)
end

function modifier_kez_raptor_dance_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    }
end

function modifier_kez_raptor_dance_custom:GetAbsoluteNoDamageMagical()
    return 1
end

modifier_kez_raptor_dance_custom_cast = class({})
function modifier_kez_raptor_dance_custom_cast:IsHidden() return true end
function modifier_kez_raptor_dance_custom_cast:IsPurgable() return false end
function modifier_kez_raptor_dance_custom_cast:IsPurgeException() return false end
function modifier_kez_raptor_dance_custom_cast:CheckState()
    return
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    }
end

modifier_kez_raptor_dance_custom_buff = class({})
function modifier_kez_raptor_dance_custom_buff:IsHidden() return true end
function modifier_kez_raptor_dance_custom_buff:IsPurgable() return false end
function modifier_kez_raptor_dance_custom_buff:IsPurgeException() return false end
function modifier_kez_raptor_dance_custom_buff:OnCreated()
    if not IsServer() then return end
    local strike_interval = self:GetAbility():GetSpecialValueFor("strike_interval")
    self.strikes = self:GetAbility():GetSpecialValueFor("strikes")
    if self:GetCaster():HasModifier("modifier_kez_6") then
        self.strikes = self.strikes + self:GetAbility().modifier_kez_6[self:GetCaster():GetTalentLevel("modifier_kez_6")]
    end
    self.abilities = 
    {
        "kez_echo_slash_custom",
        "kez_falcon_rush_custom",
        "kez_grappling_claw_custom",
        "kez_talon_toss_custom",
        "kez_kazurai_katana_custom",
        "kez_shodo_sai_custom",
        "kez_raptor_dance_custom",
        "kez_ravens_veil_custom",
    }
    if self:GetCaster():HasModifier("modifier_kez_6") then
        self.abilities = 
        {
            "kez_falcon_rush_custom",
            "kez_grappling_claw_custom",
            "kez_talon_toss_custom",
            "kez_kazurai_katana_custom",
            "kez_shodo_sai_custom",
            "kez_raptor_dance_custom",
            "kez_ravens_veil_custom",
        }
    end
    for _, ability_name in pairs(self.abilities) do
        local ability = self:GetParent():FindAbilityByName(ability_name)
        if ability then
            ability:SetActivated(false)
        end
    end
    self:OnIntervalThink()
    self:StartIntervalThink(strike_interval)
    self:GetCaster():StartGesture(ACT_DOTA_KEZ_KATANA_ULT_START)
end

function modifier_kez_raptor_dance_custom_buff:OnDestroy()
    if not IsServer() then return end
    for _, ability_name in pairs(self.abilities) do
        local ability = self:GetParent():FindAbilityByName(ability_name)
        if ability then
            ability:SetActivated(true)
        end
    end
end

function modifier_kez_raptor_dance_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    self:GetAbility():StrikeDamage(self.strikes)
    self.strikes = self.strikes - 1
    if self.strikes <= 0 then
        self:Destroy()
    end
end

function modifier_kez_raptor_dance_custom_buff:CheckState()
    return
    {
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_kez_raptor_dance_custom_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    }
end

function modifier_kez_raptor_dance_custom_buff:GetAbsoluteNoDamageMagical()
    return 1
end